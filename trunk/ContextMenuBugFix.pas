{******************************************************************************}
{*                                                                            *}
{* TWinControls.DefaultHandler-WM_CONTEXTMENU bugfix                          *}
{* Version 1.1 (2007-12-11)                                                   *}
{*                                                                            *}
{* (C) 2007 Andreas Hausladen (Andreas.Hausladen@gmx.de)                      *}
{*                                                                            *}
{******************************************************************************}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}

{ Usage:
    Add the unit to the .dpr file's uses-list.

    Example:
      uses
        FastMM4, // optional memory manager
        ContextMenuBugFix,
        Forms,
        Unit1 in 'Unit1.pas';

  History:
    2007-12-11 (Version 1.1):
      Added special handling for TCustomGrid to keep the odd behavior.
    2007-10-10 (Version 1.0):
      Added default compiler options
}
unit ContextMenuBugFix;

{
history:
}

{$IFDEF CONDITIONALEXPRESSIONS}
 {$IF (CompilerVersion >= 14.0) } //AND (CompilerVersion < 19.0)}
  {$DEFINE DELPHI_NEEDS_FIX}
 {$IFEND}
{$ELSE}
 {$IFDEF VER130}
  {$DEFINE DELPHI_NEEDS_FIX}
 {$ENDIF}
{$ENDIF}

interface

implementation

{$IFDEF DELPHI_NEEDS_FIX}

uses
  Windows, Messages, SysUtils, Graphics, Controls, Grids;

type
  TFixWinControl = class(TWinControl)
  public
    procedure DefaultHandler(var Message); override;
  end;

var
  RM_GetObjectInstance: DWORD;

procedure TFixWinControl.DefaultHandler(var Message);
type
  TDefHandler = procedure(Self: TControl; var Message);
begin
  if HandleAllocated then
  begin
    with TMessage(Message) do
    begin
      { Here was the WM_CONTEXTMENU Code that is not necessary because
        DefWndProc will send this message to the parent control. }

      { Keep the odd bahavior for grids because everybody seems to be used to it. }
      if (Msg = WM_CONTEXTMENU) and (Parent <> nil) and (Parent is TCustomGrid) then
      begin
        Result := Parent.Perform(Msg, WParam, LParam);
        if Result <> 0 then Exit;
      end;

      case Msg of
        WM_CTLCOLORMSGBOX..WM_CTLCOLORSTATIC:
          Result := SendMessage(LParam, CN_BASE + Msg, WParam, LParam);
        CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
          begin
            SetTextColor(WParam, ColorToRGB(Font.Color));
            SetBkColor(WParam, ColorToRGB(Brush.Color));
            Result := Brush.Handle;
          end;
      else
        if Msg = RM_GetObjectInstance then
          Result := Integer(Self)
        else
          Result := CallWindowProc(DefWndProc, Handle, Msg, WParam, LParam);
      end;
      if Msg = WM_SETTEXT then
        SendDockNotification(Msg, WParam, LParam);
    end;
  end
  else
    //inherited DefaultHandler(Message);
    TDefHandler(@TControl.DefaultHandler)(Self, Message);
end;

{---------------------------------------------------------------------------}

type
  TInjectRec = packed record
    Jump: Byte;
    Offset: Integer;
  end;

  PWin9xDebugThunk = ^TWin9xDebugThunk;
  TWin9xDebugThunk = packed record
    PUSH: Byte;
    Addr: Pointer;
    JMP: Byte;
    Offset: Integer;
  end;

  PAbsoluteIndirectJmp = ^TAbsoluteIndirectJmp;
  TAbsoluteIndirectJmp = packed record
    OpCode: Word;   //$FF25(Jmp, FF /4)
    Addr: ^Pointer;
  end;

function GetActualAddr(Proc: Pointer): Pointer;

  function IsWin9xDebugThunk(AAddr: Pointer): Boolean;
  begin
    Result := (AAddr <> nil) and
              (PWin9xDebugThunk(AAddr).PUSH = $68) and
              (PWin9xDebugThunk(AAddr).JMP = $E9);
  end;

begin
  if Proc <> nil then
  begin
    if (Win32Platform <> VER_PLATFORM_WIN32_NT) and IsWin9xDebugThunk(Proc) then
      Proc := PWin9xDebugThunk(Proc).Addr;
    if (PAbsoluteIndirectJmp(Proc).OpCode = $25FF) then
      Result := PAbsoluteIndirectJmp(Proc).Addr^
    else
      Result := Proc;
  end
  else
    Result := nil;
end;

function CodeRedirect(Proc: Pointer; NewProc: Pointer): TInjectRec;
var
  OldProtect: Cardinal;
begin
  if Proc = nil then
    Exit;
  Proc := GetActualAddr(Proc);
  if VirtualProtect(Proc, SizeOf(TInjectRec), PAGE_EXECUTE_READWRITE, OldProtect) then
  begin
    Result := TInjectRec(Proc^);
    TInjectRec(Proc^).Jump := $E9;
    TInjectRec(Proc^).Offset := Integer(NewProc) - (Integer(Proc) + SizeOf(TInjectRec));
    VirtualProtect(Proc, SizeOf(TInjectRec), OldProtect, @OldProtect);
    FlushInstructionCache(GetCurrentProcess, Proc, SizeOf(TInjectRec));
  end;
end;

{---------------------------------------------------------------------------}

var
  BackupDefaultHandler: TInjectRec;

procedure Init;
var
  HInst: HMODULE;
begin
  HInst := FindHInstance(Pointer(TWinControl)); // get the HInstance of the module that contains Controls.pas
  RM_GetObjectInstance := RegisterWindowMessage(PChar(Format('ControlOfs%.8X%.8X', [HInst, GetCurrentThreadId])));

  { Redirect the original function to the bug fixed version }
  BackupDefaultHandler := CodeRedirect(@TWinControl.DefaultHandler, @TFixWinControl.DefaultHandler);
end;

procedure Fini;
var
  n: DWORD;
begin
  if BackupDefaultHandler.Jump <> 0 then
  begin
    { Restore the original function }
    WriteProcessMemory(GetCurrentProcess, GetActualAddr(@TWinControl.DefaultHandler),
                       @BackupDefaultHandler, SizeOf(BackupDefaultHandler), n);
  end;
end;

initialization
  Init;

finalization
  Fini;

{$ENDIF DELPHI_NEEDS_FIX}

end.
