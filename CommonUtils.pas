{
Copyright (C) 2006-2008 Matteo Salvi of SalvadorSoftware

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
}

unit CommonUtils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs, Menus,
  ShellApi, VirtualTrees, ActiveX, ShlObj, TlHelp32, Registry, Controls, Consts,
  CommCtrl, ComCtrls, XMLIntf, Main, XMLDoc, ComObj, jpeg, CommonClasses, Variants;

  Type
    TGetShortcutType = (gstPathExe,gstParameter,gstWorkingDir);

{ Icons, ImageList }
function  SHSmallIcon(xpath : string; getopen : boolean): hicon;
function  IconAdd(Sender: TBaseVirtualTree;ImageList: TImageList;Node: PVirtualNode): integer;
procedure ConvertTo32BitImageList(const ImageList: TImageList);
function  ExtractAndCompareIcons(PathIcon1, PathIcon2: String): Boolean;

{ Processes, execution }
procedure ActionOnExe(Action: Integer);
function  ProcessExists(exeFileName: string): Boolean;
procedure RunActionOnExe(NodeData: PTreeData);
procedure RunProcess(Sender: TBaseVirtualTree;NodeData: PTreeData;
                     RunIfNoInstancesRunning: Boolean);  
procedure RunProcessAsUser(Sender: TBaseVirtualTree;NodeData: PTreeData;Username,
                           Password:WideString);
procedure SetDeleteASuiteWindowsStartup(Make:Boolean);

{ Files and folders }
function  BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer; stdcall;
function  BrowseForFolder(const Caption, InitialDir: String): String;
procedure CreateShortcutOnDesktop(FileName: WideString;TargetFilePath, Params, WorkingDir: String);
procedure DeleteFiles(PathDir, FileName: String);
procedure DeleteShortcutOnDesktop(FileName: WideString);
function  FileFolderPageWebNotExists(Sender: TBaseVirtualTree;Node: PVirtualNode): Boolean;
function  GetNumberSubFolders(FolderPath: String): Integer;
function  GetParametersFromPath(Path: String): String;
function  GetShortcutTarget(const LinkFileName:String;ShortcutType: TGetShortcutType):String;
procedure RunScanFolder(Sender: TBaseVirtualTree;ImageList: TImageList;PathExe: string;
                        ParentNode: PVirtualNode;Dialog: TForm);

{ Forms }
procedure CloseFormSensors;
function  CreateDialogProgressBar(DialogMsg: String;NumberFolders: Integer): TForm;
procedure CreateFormSensors;
function  IsFormOpen(const FormName : string): Boolean;

{ List, Menu, MRU }
procedure ActionsOnShutdownInsideTree(Sender: TBaseVirtualTree);
function  AddNode(Sender: TBaseVirtualTree;Form: TComponentClass;Tipo: Integer): PTreeData;
procedure CheckList(Sender: TBaseVirtualTree;ImageList: TImageList);
function  ClickOnButtonTree(Sender: TBaseVirtualTree): Boolean;
procedure DragDropFile(Sender: TBaseVirtualTree;ImageList: TImageList;
                       Node: pVirtualNode;PathTemp: string);
function  NodeDataXToNodeDataList(NodeX: PVirtualNode): PTreeData;
function  GetNodeFromText(Tree: TBaseVirtualTree; Text: String; Cat: Boolean): PVirtualNode;
procedure GetProperty(List,Search: TBaseVirtualTree;IsNodeList: Boolean);
procedure RefreshList(Tree: TBaseVirtualTree;Menu: TPopUpMenu;Save: Boolean);
procedure ShowTrayiconMenu(Tree: TBaseVirtualTree;Menu: TPopUpMenu);
procedure UpdateClassicMenu(Tree: TBaseVirtualTree;Menu: TPopUpMenu);

{ Load/Save FileXML }
function  SaveFileXML(Tree: TBaseVirtualTree;Filename: String): Boolean;
//LoadFileXML is frmMain.FormCreate

{ MRU }
procedure AddMRU(Sender: TBaseVirtualTree;PopupMenu: TPopupMenu;Software: PVirtualNode;
                 DontAdd: Boolean);
procedure LoadMRUXML(XMLNode: IXMLNode;Tree: TBaseVirtualTree);
procedure SaveMRUXML(XMLNode: IXMLNode;Tree: TBaseVirtualTree);
procedure UpdateMRU(Sender: TBaseVirtualTree;PopupMenu: TMenuItem);

{ Options }
procedure LoadOptionsXML(XMLNode: IXMLNode);
procedure SaveOptionsXML(XMLNode: IXMLNode);
procedure UpdateOptions;

{ Conversions }
function  BoolToStr(Bool: Boolean):String;
function  StrToBool(Str: string): boolean;
function  AbsoluteToRelative(PathFile: String): string;
function  RelativeToAbsolute(PathFile: String): string;
procedure StrToStrings(Str, Sep: string; const List: TStrings);
function  StringToWideString(Str: string): WideString;

{ Stats }
function  GetCurrentUserName: string;
function  GetComputerName: string;
function  DiskFloatToString(Number: double;Units: Boolean): string;
procedure GetStats(GetSystem: boolean);
function  GetWindowsLanguage(TypeLocalInfo: LCTYPE): string;
function  GetWindowsVersion: string;
function  DiskFreeString(Drive: Char;Units: Boolean): string;
function  DiskSizeString(Drive: Char;Units: Boolean): string;
function  DiskUsedString(Drive: Char;Units: Boolean): string;
function  DiskFreePercentual(Drive: Char): double;

{ HotKey }
function  AddHotkey(Sender: TBaseVirtualTree;Node: PVirtualNode;HKId: integer): integer;
function  GetHotKeyCode(KeyCode: Integer) : Integer;
function  GetHotKeyMod(KeyMod: Integer) : Integer;

{ XML }
function  ReadIntegerXML(XMLNode: IXMLNode;Default: Integer): Integer;
function  ReadStringXML(XMLNode: IXMLNode;Default: String): String;
function  ReadBooleanXML(XMLNode: IXMLNode;Default: Boolean): Boolean;

{ Scan File }
procedure LoadScanSettingsXML(XMLNode: IXMLNode);
procedure SaveScanSettingsXML(XMLNode: IXMLNode);

{ Autorun }
procedure AddAutorunInList(NodeData: PTreeData);
procedure RemoveAutorunFromList(NodeData: PTreeData);

{ Misc }
procedure EnableTimerCheckList(Sender: TObject);
function  ExtractDirectoryName(const Filename: string): string;
function  GetDateTime: String;
function  GetEnvVarValue(VarName: string): string;
function  GetFirstFreeIndex(ArrayWString: Array of WideString): Integer;

{ Windows Api }
function CreateProcessWithLogonW(
  Username          : LPCWSTR;
  Domain            : LPCWSTR;
  Password          : LPCWSTR;
  LogonFlags        : DWORD;
  ApplicationName   : LPCWSTR;
  CommandLine       : LPWSTR;
  CreationFlags     : DWORD;
  Environment       : Pointer;
  CurrentDirectory  : LPCWSTR;
  const StartupInfo : TStartupInfoW;
  var ProcessInfo   : TProcessInformation ): BOOL; stdcall;
  external 'advapi32.dll' name 'CreateProcessWithLogonW';

const
  LOGON_WITH_PROFILE          = $00000001;

type
  TFileVersionInfo = record
    CompanyName    : string;
    ProductName    : string;
    ProductVersion : string;
    procedure FileVersionInfo(const sAppNamePath: TFileName);
  end;

type
  TScanFolderSettings = record
    LastFolderPath   : String;
    SubFolders       : Boolean;
    FileTypes        : TStringList;
    ExcludeFiles     : TStringList;
    RetrieveInfo     : Boolean;
  end;

type
  TIterateSubtreeProcs = class //Class for IterateSubtree
    procedure UpdateListItemCount(Sender: TBaseVirtualTree; Node: PVirtualNode;
                                  Data: Pointer; var Abort: Boolean);
    procedure PopulateClassicTrayMenu(Sender: TBaseVirtualTree; Node: PVirtualNode;
                                      Data: Pointer; var Abort: Boolean);
  end;

var
  NewNode : Boolean;
  VNDataCat, VNDataSoft, VNDataGroup : PTreeData;  //Property
  SwCount, CatCount : Integer;     //Stats
  ScanSettings      : TScanFolderSettings;
  IterateSubtreeProcs : TIterateSubtreeProcs;

const
  MAX_PROFILE_PATH = 255;

implementation

uses Sensor, PropertySw, PropertyCat, PropertyGroup, Menu
{$ifdef ASuite}
,Card
{$endif};

function SHSmallIcon(xpath: string; getopen: boolean) : hicon;
var
  fili : TSHFileInfo;
  aka  : Integer;
begin
  if Pos('..',xpath) <> 0 then
    xpath := StringReplace(xpath,ApplicationPath,'',[rfReplaceAll,rfIgnoreCase]);
  aka := SHGFI_ICON or SHGFI_SMALLICON;
  if getopen then
    aka := aka or SHGFI_OPENICON;
  SHGetFileInfo(Pchar(xpath), 0, fili, sizeof(TSHFileInfo), aka);
  Result := fili.hIcon;
end;

function IconAdd(Sender: TBaseVirtualTree;ImageList: TImageList;Node: PVirtualNode): integer;
var
  Icon     : TIcon;
  NodeData : PTreeData;
  TempCache, TempIcon, TempExe, TempPath : String;
  I        : Integer;
begin
  NodeData  := Sender.GetNodeData(Node);
  Icon      := TIcon.Create;
  //Three pathes
  TempCache := NodeData.PathCache;
  TempIcon  := RelativeToAbsolute(NodeData.PathIcon);
  TempExe   := RelativeToAbsolute(NodeData.PathExe[0]);
  if Not(FileExists(NodeData.PathCache)) then
    NodeData.PathCache := '';
  //Control file
  if (FileExists(TempCache)) or (FileExists(TempIcon)) or
     (FileExists(TempExe)) then
  begin
    try
      //Priority icon->exe
      if FileExists(TempIcon) then
        TempPath := TempIcon
      else
        if FileExists(TempExe) then
          TempPath := TempExe;
      //Load path cache-icon if exists it
      if (LauncherOptions.Cache) and FileExists(TempCache) then
      begin
        //Compare cache-icon and exe's icon
        //If cache-icon is not equal to exe's icon, ASuite recreated it
        if Not(StartUpTime) and (Not(ExtractAndCompareIcons(TempPath,TempCache)) or
           (LowerCase(ExtractFileExt(TempPath)) = '.ico')) then
        begin
          DeleteFile(TempCache);
          NodeData.PathCache := '';
        end
        else
          TempPath := TempCache;
      end;
      //Check TempPath
      if FileExists(TempPath) then
        if LowerCase(ExtractFileExt(TempPath)) = '.ico' then
          Icon.LoadFromFile(TempPath)
        else
          Icon.Handle := SHSmallIcon(TempPath, True)
      else
        ImageList.GetIcon(0,Icon);
      //Add icon in ImageList
      if (NodeData.ImageIndex = -1) or (NodeData.ImageIndex = 1) or
         (NodeData.ImageIndex = 0) or (NodeData.ImageIndex = 13) then
        Result := ImageList.AddIcon(Icon)
      else begin
        ImageList.ReplaceIcon(NodeData.ImageIndex, Icon);
        Result := NodeData.ImageIndex;
      end;
      //Save file cache-icon
      if ((NodeData.PathCache = '') or (Not FileExists(TempCache))) and (FileExists(TempPath))  then
        if (LowerCase(ExtractFileExt(TempPath)) <> '.ico') and (LauncherOptions.Cache) then
        begin
          I := 0;
          while (FileExists(PathCache + IntToStr(I) + '.ico')) do
            Inc(I);
          if Icon.HandleAllocated then
          begin
            Icon.SaveToFile(PathCache + IntToStr(I) + '.ico');
            NodeData.PathCache := PathCache + IntToStr(I) +'.ico';
          end;
        end
        else
          NodeData.PathCache := '';
    except
      {$ifdef ASuite}
      ShowMessageFmt(ArrayMessages[15],[NodeData.Name]);
      {$else}
      ShowMessageFmt(ArrayMessages[13],[NodeData.Name]);
      {$endif}
      Result := 0;
    end;
  end
  else begin
    //If node is category, set result to 1 (category icon)
    //else to 0 (launcher icon)
    if (NodeData.Tipo = 0) then
      Result    := 1
    else
      Result    := 0;
  end;
  Icon.Free;
end;

procedure ConvertTo32BitImageList(const ImageList: TImageList);
const
  Mask: array[Boolean] of Longint = (0, ILC_MASK);
var
  TemporyImageList: TImageList;
begin
  if Assigned(ImageList) then
  begin
    TemporyImageList := TImageList.Create(nil);
    try
      TemporyImageList.Assign(ImageList);
      with ImageList do
      begin
        ImageList.Handle := ImageList_Create(Width, Height, ILC_COLOR32 or Mask[Masked], 0, AllocBy);
        if not ImageList.HandleAllocated then
        begin
          raise EInvalidOperation.Create(SInvalidImageList);
        end;
      end;
      ImageList.AddImages(TemporyImageList);
    finally
      TemporyImageList.Free;
    end;
  end;
end;

function ExtractAndCompareIcons(PathIcon1, PathIcon2: String): Boolean;
var
  Icon1, Icon2 : TIcon;
  MS1, MS2     : TMemoryStream;
begin
  Result := False;
  if (FileExists(PathIcon1)) and (FileExists(PathIcon2)) then
  begin
    //Extract Icon1
    Icon1  := TIcon.Create;
    MS1    := TMemoryStream.Create;
    try
      if LowerCase(ExtractFileExt(PathIcon1)) = '.ico' then
        Icon1.LoadFromFile(PathIcon1)
      else
        Icon1.Handle := SHSmallIcon(PathIcon1,True);
      Icon1.SaveToStream(MS1);
      //Extract Icon2
      Icon2 := TIcon.Create;
      MS2   := TMemoryStream.Create;
      try
        if LowerCase(ExtractFileExt(PathIcon2)) = '.ico' then
          Icon2.LoadFromFile(PathIcon2)
        else
          Icon2.Handle := SHSmallIcon(PathIcon2,True);
        Icon2.SaveToStream(MS2);
        //Compare memory size
        if MS1.Size = MS2.Size then
          Result := CompareMem(MS1.Memory, MS2.Memory, MS1.Size)
      finally
        MS2.Free;
        Icon2.Free;
      end;
    finally
      MS1.Free;
      Icon1.Free;
    end;
  end;
end;

procedure ActionOnExe(Action: Integer);
begin
  case Action of
    2:
    begin
      //Hide frmMain
      frmMain.Hide;
      {$ifdef ASuite}
      if IsFormOpen('frmCard') then
        frmCard.Hide;
      {$endif}
    end;
    3:
    begin
      //Close application
      ShutdownTime := True;
      {$ifdef ASuite}
      if IsFormOpen('frmCard') then
        frmCard.Close;
      {$endif}
      frmMain.Close;
    end;
  end;
end;

function ProcessExists(exeFileName: string): Boolean;
var
  hSnapShot: THandle;
  ProcInfo: TProcessEntry32;
begin
  hSnapShot   := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  exeFileName := UpperCase(ExeFileName);
  Result := False;
  if (hSnapShot <> THandle(-1)) then
  begin
    ProcInfo.dwSize := SizeOf(ProcInfo);
    //Check processes
    if (Process32First(hSnapshot, ProcInfo)) then
    begin
      if (UpperCase(ExtractFileName(ProcInfo.szExeFile)) = ExeFileName) then
        Result := True;
    while (Process32Next(hSnapShot, ProcInfo)) do
      if (UpperCase(ExtractFileName(ProcInfo.szExeFile)) = ExeFileName) then
        Result := True;
    end;
  end;
  CloseHandle(hSnapShot);
end;

procedure RunActionOnExe(NodeData: PTreeData);
var
  ActionTemp : Integer;
begin
  if NodeData.ActionOnExe = 0 then
  begin
    ActionTemp := LauncherOptions.ActionOnExe + 1;
    ActionOnExe(ActionTemp);
  end
  else
    ActionOnExe(NodeData.ActionOnExe);
end;

procedure RunProcess(Sender: TBaseVirtualTree;NodeData: PTreeData;RunIfNoInstancesRunning: Boolean);
var
  WorkingDir, PathTemp, Parameters: String;
  WindowState, ErrorCode, I: Integer;
begin
  for I := 0 to High(NodeData.PathExe) do
  begin
    if NodeData.PathExe[I] = '' then
      Continue;
    PathTemp := RelativeToAbsolute(NodeData.PathExe[I]);
    if (RunIfNoInstancesRunning) and (NodeData.Autorun = 2) then
      if ProcessExists(ExtractFileName((NodeData.PathExe[I]))) then
        Continue;
    //Working directory
    if NodeData.WorkingDir = '' then
      WorkingDir := ExtractFileDir(PathTemp)
    else
      WorkingDir := NodeData.WorkingDir;
    //Window state
    case NodeData.WindowState of
      1: WindowState := 7;
      2: WindowState := 3;
    else
      WindowState := 1;
    end;
    //Parameters
    if NodeData.Tipo = 2 then
    begin
      //Software Group
      Parameters := GetParametersFromPath(PathTemp);
      //Get Path
      if Parameters <> '' then
      begin
        //Delete first "
        Delete(PathTemp,1,1);
        //Delete parameters from Path
        PathTemp := StringReplace(PathTemp,'"' + Parameters,'',[rfIgnoreCase])
      end;
    end
    else begin
      //Software
      Parameters := NodeData.Parameters;
    end;
    //Check variables in parameters to use RelativeToAbsolute
    if (pos('$',Parameters) <> 0) then
      Parameters := RelativeToAbsolute(Parameters);
    //Execution
    ErrorCode := ShellExecute(GetDesktopWindow, 'open', PChar(PathTemp),
                              PChar(Parameters),
                              PChar(RelativeToAbsolute(WorkingDir)), WindowState);
    if ErrorCode <= 32 then
    begin
      //Show error message
      {$IfDef ASuite}
      ShowMessageFmt(ArrayMessages[9],[NodeData.Name]);
      {$else}
      ShowMessageFmt(ArrayMessages[6],[NodeData.Name]);
      {$EndIf}
    end;
  end;
end;

procedure RunProcessAsUser(Sender: TBaseVirtualTree;NodeData: PTreeData;Username, Password:WideString);
var        
  WindowState, I       : Integer;
  StartupInfo          : TStartupInfoW;
  ProcInfo             : TProcessInformation;
  WorkingDir, PathTemp : WideString;
begin
  for I := 0 to High(NodeData.PathExe) do
  begin     
    if NodeData.PathExe[I] = '' then
      Continue;
    PathTemp := RelativeToAbsolute(NodeData.PathExe[I]);
    //Working directory
    if NodeData.WorkingDir = '' then
      WorkingDir := StringToWideString(ExtractFileDir(PathTemp))
    else
      WorkingDir := NodeData.WorkingDir;
    //Window state
    case NodeData.WindowState of
      1: WindowState := 7;
      2: WindowState := 3;
    else
      WindowState := 1;
    end;
    //Execution
    FillMemory(@StartupInfo, sizeof(StartupInfo), 0);
    FillMemory(@ProcInfo, sizeof(ProcInfo), 0);
    StartupInfo.cb := sizeof(TStartupInfoW);
    StartupInfo.wShowWindow := WindowState;
    if CreateProcessWithLogonW(LPCWSTR(Username),nil,LPCWSTR(Password),
                              LOGON_WITH_PROFILE,LPCWSTR(PathTemp),nil,
                              CREATE_UNICODE_ENVIRONMENT,nil,LPCWSTR(WorkingDir),
                              StartupInfo,ProcInfo) then
    begin
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
    end
    else
      ShowMessage(SysErrorMessage(GetLastError));
  end;
end;

procedure SetDeleteASuiteWindowsStartup(Make:Boolean);
var
  Registry : TRegistry;
begin
  Registry := TRegistry.Create;
  try
    with Registry do
    begin
      RootKey:=HKEY_LOCAL_MACHINE;
      if OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',False) then
      begin
        if (Make) then
        begin
          if Not(ValueExists(Launcher)) then
            WriteString(Launcher,(Application.ExeName));
        end
        else
          DeleteValue(Launcher)
      end;
    end
  finally
    Registry.Free;
  end;
end;

function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer; stdcall;
begin
  //Set initial directory
  if uMsg = BFFM_INITIALIZED then
    SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  Result := 0;
end;

function BrowseForFolder(const Caption, InitialDir: String): String;
var
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  Windows: Pointer;
  Path: string;

begin
  Result := '';
  Path  := InitialDir;
  //Delete \ in last char. Example c:\xyz\ to c:\xyz
  if (Length(Path) > 0) and (Path[Length(Path)] = '\') then
    Delete(Path, Length(Path), 1);
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and Assigned(ShellMalloc) then
  begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      //Set browseinfo's properties
      with BrowseInfo do
      begin
        hwndOwner := Application.Handle;
        pidlRoot  := nil;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags   := BIF_RETURNONLYFSDIRS;
        lParam    := Integer(PChar(Path));
        lpfn      := BrowseCallbackProc;
      end;
      //Show browse for folder
      Windows := DisableTaskWindows(Application.Handle);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(Windows);
      end;
      //Get directory
      if Assigned(ItemIDList) then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Result := Buffer;
      end
      else
        Result := '';
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

procedure CreateShortcutOnDesktop(FileName: WideString;TargetFilePath, Params, WorkingDir: String);
var
   IObject : IUnknown;
   ISLink  : IShellLink;
   IPFile  : IPersistFile;
   PIDL    : PItemIDList;
   InFolder   : array[0..MAX_PATH] of Char;
   TargetName : String;
begin
  //Relative path to Absolute path
  TargetName := RelativeToAbsolute(TargetFilePath);
  if pos(':',TargetName) = 0 then
    TargetName := ApplicationPath + TargetName;
  IObject := CreateComObject(CLSID_ShellLink);
  ISLink  := IObject as IShellLink;
  IPFile  := IObject as IPersistFile;
  //Create link
  with ISLink do
  begin
    SetPath(pChar(TargetName)); 
    SetArguments(pChar(Params));
    if WorkingDir = '' then
      SetWorkingDirectory(pChar(ExtractFilePath(TargetName)))
    else
      SetWorkingDirectory(pChar(RelativeToAbsolute(WorkingDir)));
  end;
  //DesktopPath
  SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL);
  SHGetPathFromIDList(PIDL, InFolder);
  //Save link
  IPFile.Save(PWChar(InFolder + FileName), false);
end;

procedure DeleteFiles(PathDir, FileName: String);
var
  Search : TSearchRec;
begin
  //Delete file with FileName in folder PathDir (path relative)
  if FindFirst(ApplicationPath + PathDir + FileName, faAnyFile, Search) = 0 then
  begin
    repeat
      DeleteFile(PathDir + Search.Name);
    until
      FindNext(Search) <> 0;
    FindClose(Search);
  end;
end;

procedure DeleteShortcutOnDesktop(FileName: WideString);
var
  PIDL        : PItemIDList;
  DesktopPath : array[0..MAX_PATH] of Char;
begin
  SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL);
  SHGetPathFromIDList(PIDL, DesktopPath);
  if (FileExists(DesktopPath + FileName)) then
    DeleteFile(DesktopPath + FileName);
end;

function FileFolderPageWebNotExists(Sender: TBaseVirtualTree;Node: PVirtualNode): Boolean;
var
  NodeData: PTreeData;
  PathTemp : String;
  I        : Integer;
  MaxIndex : Integer;
begin
  Result   := False;
  NodeData := Sender.GetNodeData(Node);
  case NodeData.Tipo of
    0, 4: exit;
    1: MaxIndex := 0;
    2: MaxIndex := High(NodeData.PathExe);
  else
    MaxIndex := -1;
  end;
  for I := 0 to MaxIndex do
  begin
    PathTemp := RelativeToAbsolute(NodeData.PathExe[I]);
    if ((NodeData.Tipo = 1) or (NodeData.Tipo = 2)) and
       Not((FileExists(PathTemp)) or (DirectoryExists(PathTemp)) or
          (pos('http://',PathTemp) = 1) or (pos('https://',PathTemp) = 1) or
          (pos('ftp://',PathTemp) = 1) or (pos('www.',PathTemp) = 1) or
          (pos('%',PathTemp) = 1)) then
    begin
      if ((NodeData.Tipo = 4) and (PathTemp = '')) or
         (NodeData.Tipo = 1) then
        Result := true;
    end;
  end;
end;

function GetNumberSubFolders(FolderPath: String): Integer;
var
  SearchRec     : TSearchRec;
begin
  Result := 0;
  //Count subfolders in FolderPath
  if FindFirst(FolderPath + '*.*', faAnyFile, SearchRec) = 0 then
  repeat
    if ((SearchRec.Name <> '.') and (SearchRec.Name <> '..')) and
       ((SearchRec.Attr and faDirectory) = (faDirectory)) then
    begin
      //Increment result
      Inc(Result);
      Result := Result + GetNumberSubFolders(FolderPath + SearchRec.Name + '\');
    end;
  until FindNext(SearchRec) <> 0;
  FindClose(SearchRec);
end; 

function GetParametersFromPath(Path: String): String;
var
  J : Integer;
begin
  Result := '';
  if Pos('"',Path) = 1 then
  begin
    //Delete first "
    Delete(Path,1,1);
    J := Pos('"',Path);
    //Get parameters
    Result := Copy(Path,J + 1,Length(Path) - J);
  end;
end;

function GetShortcutTarget(const LinkFileName:String;ShortcutType: TGetShortcutType):String;
var
  psl  : IShellLink;
  ppf  : IPersistFile;
  WidePath  : Array[0..260] of WideChar;
  Info      : Array[0..MAX_PATH] of Char;
  wfs       : TWin32FindData;
begin
  if UpperCase(ExtractFileExt(LinkFileName)) <> '.LNK' Then
  begin
    Result := LinkFileName;
    Exit;
  end;
  CoCreateInstance(CLSID_ShellLink,nil,CLSCTX_INPROC_SERVER,IShellLink,psl);
  if psl.QueryInterface(IPersistFile, ppf) = 0 then
  begin
    MultiByteToWideChar(CP_ACP,MB_PRECOMPOSED,PChar(LinkFileName),-1,@WidePath,MAX_PATH);
    ppf.Load(WidePath, STGM_READ);
    case ShortcutType of
      gstPathExe    : psl.GetPath(@info,MAX_PATH,wfs,SLGP_UNCPRIORITY);
      gstParameter  : psl.GetArguments(@info,MAX_PATH);
      gstWorkingDir : psl.GetWorkingDirectory(@info,MAX_PATH);
    end;
    Result := info;
  end
  else
    Result := LinkFileName;
end;

procedure RunScanFolder(Sender: TBaseVirtualTree;ImageList: TImageList;PathExe: string;
                        ParentNode: PVirtualNode;Dialog: TForm);
var
  SearchRec     : TSearchRec;
  ChildNode     : PVirtualNode;
  ChildNodeData : PTreeData;
  PathTemp, TempName : String;
  FvI           : TFileVersionInfo;
  ProgressBar   : TProgressBar;
begin
  ProgressBar := TProgressBar(Dialog.FindComponent('Progress'));
  Sender.BeginUpdate;
  if FindFirst(PathExe + '*.*', faAnyFile, SearchRec) = 0 then
  repeat
    //Absolute path->relative path
    PathTemp := AbsoluteToRelative(PathExe + SearchRec.Name);
    //Add node in vstlist
    if ((SearchRec.Name <> '.') and (SearchRec.Name <> '..')) and
       (((SearchRec.Attr and faDirectory) = (faDirectory)) or ((ScanSettings.FileTypes.IndexOf(LowerCase(ExtractFileExt(SearchRec.Name))) <> -1))) then
    begin
      TempName:=SearchRec.Name;
      Delete(TempName,pos(ExtractFileExt(SearchRec.Name),SearchRec.Name),Length(SearchRec.Name));
      if (ScanSettings.ExcludeFiles.IndexOf(LowerCase(TempName)) = -1) then
      begin
        ChildNode                := Sender.AddChild(ParentNode);
        ChildNodeData            := Sender.GetNodeData(ChildNode);
        ChildNodeData.pNode      := ChildNode;
        ChildNodeData.Name       := TempName;
        if ((SearchRec.Attr and faDirectory) = (faDirectory)) and (ScanSettings.SubFolders) then
        begin
          ChildNodeData.Tipo       := 0;
          ChildNodeData.ImageIndex := 1;
          //Dialog
          ProgressBar.Position := ProgressBar.Position + 1;
          Dialog.Update;
          RunScanFolder(Sender, ImageList, PathExe + SearchRec.Name + '\',ChildNode,Dialog);
        end
        else
          if (SearchRec.Attr <> faDirectory) and (ScanSettings.FileTypes.IndexOf(LowerCase(ExtractFileExt(SearchRec.Name))) <> -1) and
             (ScanSettings.ExcludeFiles.IndexOf(LowerCase(TempName)) = -1) then
          begin
            ChildNodeData.PathExe[0] := PathTemp;
            //Retrieve some software's info from EXE (name, developer and version)
            if ScanSettings.RetrieveInfo then
            begin
              FvI.FileVersionInfo(PathTemp);
              if (FvI.ProductName <> '') then
                ChildNodeData.Name      := FvI.ProductName;
              {$IfDef ASuite}
              if (FvI.CompanyName <> '') then
                ChildNodeData.Developer := FvI.CompanyName;
              if (FvI.ProductVersion <> '') then
                ChildNodeData.Version   := StringReplace(FvI.ProductVersion,', ','.',[rfReplaceAll]);
              {$EndIf}
            end;
            ChildNodeData.Tipo       := 1;
            ChildNodeData.ImageIndex := IconAdd(Sender, ImageList, ChildNode);
          end;
        if (ChildNode.ChildCount = 0) And ((SearchRec.Attr and faDirectory) = (faDirectory)) then
          Sender.DeleteNode(ChildNode);
      end;
    end;
  until FindNext(SearchRec) <> 0;
  FindClose(SearchRec);
  Sender.EndUpdate;
end;

procedure CloseFormSensors;
var
  I : Integer;
begin
  //If assigned, close and free FormSensors
  for I := 0 to 3 do
    if Assigned(FormSensors[I]) then
    begin
      FormSensors[I].Close;
      FormSensors[I] := nil;
    end;
end;

function CreateDialogProgressBar(DialogMsg: String;NumberFolders: Integer): TForm;
var
   ProgressBar : TProgressBar;
begin
   //Create Dialog and ProgressBar (in Dialog)
   Result      := CreateMessageDialog(DialogMsg, mtInformation, []) ;
   ProgressBar := TProgressBar.Create(Result) ;
   Result.Caption := DialogMsg;
   Result.Height  := 100;
   //Set some progressbar's property
   with ProgressBar do
   begin
     Name  := 'Progress';
     Parent := Result;
     Max   := NumberFolders;
     Step  := 1;
     Top   := 50;
     Left  := 8;
     Width := Result.ClientWidth - 16;
   end;
   Result.Show;
end;

procedure CreateFormSensors;
var
  I : Integer;
begin
  //Create FormSensors and set its height and width
  for I := 0 to 3 do
  begin
    frmSensor := nil;
    case I of
      0: //Top
      begin
        if (LauncherOptions.SensorLeftClick[I] <> 0) or (LauncherOptions.SensorRightClick[I] <> 0) then
        begin
          Application.CreateForm(TfrmSensor,frmSensor);
          frmSensor.Height := 1;
          frmSensor.Width  := GetDeviceCaps(GetDC(frmMain.Handle), HORZRES);
        end
      end;
      1: //Left
      begin
        if (LauncherOptions.SensorLeftClick[I] <> 0) or (LauncherOptions.SensorRightClick[I] <> 0) then
        begin
          Application.CreateForm(TfrmSensor,frmSensor);
          frmSensor.Height := GetDeviceCaps(GetDC(frmMain.Handle), VERTRES);
          frmSensor.Width  := 1;
        end
      end;
      2: //Right
      begin
        if (LauncherOptions.SensorLeftClick[I] <> 0) or (LauncherOptions.SensorRightClick[I] <> 0) then
        begin
          Application.CreateForm(TfrmSensor,frmSensor);
          frmSensor.Left   := GetDeviceCaps(GetDC(frmMain.Handle), HORZRES) - 1;
          frmSensor.Height := GetDeviceCaps(GetDC(frmMain.Handle), VERTRES);
          frmSensor.Width  := 1;
        end
      end;
      3: //Bottom
      begin
        if (LauncherOptions.SensorLeftClick[I] <> 0) or (LauncherOptions.SensorRightClick[I] <> 0) then
        begin
          Application.CreateForm(TfrmSensor,frmSensor);
          frmSensor.Top    := GetDeviceCaps(GetDC(frmMain.Handle), VERTRES) - 1;
          frmSensor.Height := 1;
          frmSensor.Width  := GetDeviceCaps(GetDC(frmMain.Handle), HORZRES);
        end
      end;
    end;
    //If assigned, show current frmSensor and set Side (to I)
    //and FormSensors[I] (to current frmSensor)
    if Assigned(frmSensor) then
    begin
      frmSensor.Show;
      frmSensor.Side := I;
      FormSensors[I] := frmSensor;
    end;
  end;
end;

function IsFormOpen(const FormName : string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for i := Screen.FormCount - 1 DownTo 0 do
    if (Screen.Forms[i].Name = FormName) then
    begin
      Result := True;
      Break;
    end;
end;

procedure ActionsOnShutdownInsideTree(Sender: TBaseVirtualTree);
var
  NodeParent : PVirtualNode;
  procedure ProcessTreeItem(NodeChild: PVirtualNode);
  var
    NodeData    : PTreeData;
  begin
    if (NodeChild = nil) then Exit;
    NodeData     := Sender.GetNodeData(NodeChild);
    //Delete shortcut on shutdown
    if (Nodedata.ShortcutDesktop) then
      DeleteShortcutOnDesktop('\' + NodeData.Name + '.lnk');
    NodeChild := NodeChild.FirstChild;
    while Assigned(NodeChild) do
    begin
      ProcessTreeItem(NodeChild);
      NodeChild := NodeChild.NextSibling;
    end;
  end;
begin
  NodeParent := Sender.GetFirst;
  while Assigned(NodeParent) do
  begin
    ProcessTreeItem(NodeParent);
    NodeParent := NodeParent.NextSibling;
  end;
end;

function AddNode(Sender: TBaseVirtualTree;Form: TComponentClass;Tipo: Integer): PTreeData;
var
  ChildNode   : PVirtualNode;
  ChildNodeData, ParentNodeData : PTreeData;
  frmProperty : TForm;
  FolderPath  : String;
begin
  frmMain.tmCheckList.Enabled := false;
  FolderPath := '';
  //Create ChildNode
  if Assigned(Sender.FocusedNode) then
  begin
    ParentNodeData := Sender.GetNodeData(Sender.FocusedNode);
    if (ParentNodeData.Tipo = 0) then
    begin
      ChildNode  := Sender.AddChild(Sender.FocusedNode);
      Sender.Expanded[Sender.FocusedNode] := true;
    end
    else
      ChildNode  := Sender.AddChild(Sender.NodeParent[Sender.FocusedNode]);
  end
  else
    ChildNode := Sender.AddChild(nil);
  //Set ChildNode's pNode and name (temporary)
  ChildNodeData            := Sender.GetNodeData(ChildNode);
  ChildNodeData.pNode      := ChildNode;
  ChildNodeData.Name       := ArrayMessages[4] + IntToStr(Sender.TotalCount);
  //Set some its variables depending on its type
  case Tipo of
    0:
    begin
      //Category
      ChildNodeData.Tipo       := 0;
      ChildNodeData.ImageIndex := 1;
      VNDataCat                := Sender.GetNodeData(ChildNode);
    end;
    1:
    begin
      //Software
      ChildNodeData.Tipo       := 1;
      VNDataSoft               := Sender.GetNodeData(ChildNode);
    end;
    2:
    begin
      //Software group
      ChildNodeData.PathIcon   := PathIcons + '12.ico';
      ChildNodeData.Tipo       := 2;
      ChildNodeData.ImageIndex := -1;
      VNDataGroup              := Sender.GetNodeData(ChildNode);
    end;
    3:
    begin
      //Folder
      {$IfDef ASuite}
      ChildNodeData.PathIcon   := PathIcons + '10.ico';
      {$Else}
      ChildNodeData.PathIcon   := PathIcons + '6.ico';
      {$EndIf}
      ChildNodeData.Tipo       := 1;
      ChildNodeData.ImageIndex := -1;
      FolderPath               := BrowseForFolder('',ApplicationPath);
      if FolderPath <> '' then
      begin
        ChildNodeData.PathExe[0] := AbsoluteToRelative(FolderPath + '\');
        ChildNodeData.Name       := ExtractDirectoryName(FolderPath + '\');
        VNDataSoft               := Sender.GetNodeData(ChildNode);
      end
      else
        NewNode := false;
    end;
    4:
    begin
      //Separator
      ChildNodeData.Name       := '-';
      ChildNodeData.Tipo       := 4;
      ChildNodeData.ImageIndex := -1;
      ChildNodeData.PathExe[0] := '';  
      NewNode                  := True;
    end;
  end;
  if Assigned(Form) then
  begin
    //Open Property window depending on its type
    if (((FolderPath <> '') or (Tipo <> 3)) and (Tipo <> 4)) then
      try
        Application.CreateForm(Form, frmProperty);
        frmProperty.showmodal;
      finally
        frmProperty.Free;
      end;
    //If NewNode failed, DeleteNode else RefreshList
    if Not(NewNode) then
      Sender.DeleteNode(ChildNode)
    else
      RefreshList(Sender,frmMain.pmTrayicon, true);
    EnableTimerCheckList(Sender);
  end;
  Result := ChildNodeData;
end;

procedure CheckList(Sender: TBaseVirtualTree;ImageList: TImageList);
var
  tn        : PVirtualNode;
  procedure ProcessTreeItem(tn: PVirtualNode);
  var
    NodeData : PTreeData;
  begin
    if (tn = nil) then Exit;
    NodeData     := Sender.GetNodeData(tn);
    //Check pathes
    if FileFolderPageWebNotExists(Sender,tn) And (NodeData.Tipo <> 0) then
        NodeData.PathExeError := true
    else
      if (NodeData.PathExeError) then
      begin
        //If PathExeError was true, add node's icon
        NodeData.ImageIndex   := IconAdd(Sender, ImageList, tn);
        NodeData.PathExeError := false;
      end;
    //Set error icon
    if NodeData.PathExeError then
      NodeData.ImageIndex := 13;
    tn := tn.FirstChild;
    while Assigned(tn) do
    begin
      ProcessTreeItem(tn);
      tn := tn.NextSibling;
    end;
  end;
begin
  tn    := Sender.GetFirst;
  while Assigned(tn) do
  begin
    ProcessTreeItem(tn);
    tn := tn.NextSibling;
  end;
end; 

function ClickOnButtonTree(Sender: TBaseVirtualTree): Boolean;
var
  Point   : TPoint;
  HitInfo : ThitInfo;
begin
  Result   := false;
  GetCursorPos(Point);
  Point    := Sender.ScreenToClient(Point);
  Sender.GetHitTestInfoAt(Point.X,Point.Y,true,HitInfo);
  if hiOnItemButton in hitinfo.HitPositions then
    Result := True;
end;

procedure DragDropFile(Sender: TBaseVirtualTree;ImageList: TImageList;Node: pVirtualNode;PathTemp: string);
var
  NodeData : PTreeData;
  Name     : string;
begin
  NodeData            := Sender.GetNodeData(Node);
  Name                := ExtractFileName(PathTemp);
  if DirectoryExists(PathTemp) then
    {$IfDef ASuite}
    NodeData.PathIcon := PathIcons + '10.ico'
    {$Else}
    NodeData.PathIcon := PathIcons + '6.ico'
    {$EndIf}
  else
    Delete(Name,pos(ExtractFileExt(PathTemp),name),Length(name));
  //Set some node record's variables
  NodeData.Name       := Name;
  if ExtractFileExt(PathTemp) = '.lnk' then
  begin
    //Shortcut
    NodeData.PathExe[0] := AbsoluteToRelative(GetShortcutTarget(PathTemp,gstPathExe));
    NodeData.Parameters := AbsoluteToRelative(GetShortcutTarget(PathTemp,gstParameter));
    NodeData.WorkingDir := AbsoluteToRelative(GetShortcutTarget(PathTemp,gstWorkingDir));
  end
  else begin
    //Normal file
    NodeData.PathExe[0] := AbsoluteToRelative(PathTemp);
  end;
  NodeData.Tipo       := 1;
  NodeData.ImageIndex := IconAdd(Sender, ImageList, Node);
  NodeData.pNode      := Node;
end;

function NodeDataXToNodeDataList(NodeX: PVirtualNode): PTreeData;
var
  NodeDataX : PTreeDataX;
begin
  Result := nil;
  with frmMain do
  begin
    NodeDataX := vstSearch.GetNodeData(NodeX);
    if Assigned(NodeDataX) then
      Result  := vstList.GetNodeData(NodeDataX.pNodeList);
  end;
end;

function GetNodeFromText(tree: TBaseVirtualTree; Text: String; Cat: Boolean): PVirtualNode;
var
  tn : PVirtualNode;
  procedure ProcessTreeItem(tn: PVirtualNode);
  var
    NodeData : PTreeData;
  begin
    if (tn = nil) then Exit;
    NodeData := tree.GetNodeData(tn);
    //Check if current NodeData's name is equal to Text
    if ((NodeData.Tipo = 1) or (NodeData.Tipo = 2) or (Cat)) and
       ((LowerCase(NodeData.name)) = (LowerCase(Text))) then
    begin
      //Found, end search
      result := tn;
      exit;
    end
    else begin
      //Don't found, continue search
      tn := tn.FirstChild;
      while Assigned(tn) do
      begin
        ProcessTreeItem(tn);
        tn := tn.NextSibling;
      end;
    end;
  end;
begin
  tn     := tree.GetFirst;
  result := nil;
  //Begin search
  while Assigned(tn) do
  begin
    ProcessTreeItem(tn);
    tn := tn.NextSibling;
  end;
end;

procedure GetProperty(List,Search: TBaseVirtualTree;IsNodeList: Boolean);
var
  NodeDataList   : PTreeData;
  NodeDataSearch : PTreeDataX;
  frmProperty    : TForm;
  Form           : TComponentClass;
begin
  frmMain.tmCheckList.Enabled := false;
  Form := Nil;
  //From Search or List
  if Not(IsNodeList) then
  begin
    //Search Node
    NodeDataSearch := Search.GetNodeData(Search.FocusedNode);
    NodeDataList   := List.GetNodeData(NodeDataSearch.pNodeList);
  end
  else begin
    //List Node
    NodeDataList   := List.GetNodeData(List.FocusedNode);
  end;
  //Set VNDataX and Form depending on its type
  case NodeDataList.Tipo of
    0:
    begin
      VNDataCat  := NodeDataList;
      Form       := TfrmPropertyCat;
    end;
    1:
    begin
      VNDataSoft := NodeDataList;
      Form       := TfrmPropertySw;
    end;
    2:
    begin
      VNDataGroup := NodeDataList;
      Form        := TfrmPropertyGroup;
    end;
  end;
  //Open Property window
  if NodeDataList.Tipo <> 4 then
  begin
    try
      Application.CreateForm(Form, frmProperty);
      frmProperty.showmodal;
    finally
      frmProperty.Free;
    end;
  end;
  EnableTimerCheckList(List);
end;

procedure RefreshList(Tree: TBaseVirtualTree;Menu: TPopUpMenu;Save: Boolean);
begin
  //Refresh Stats
  GetStats(Not(Save));
  //Save security
  if (LauncherOptions.SaveSecurity) and (Save) then
    SaveFileXML(Tree, PathUser + Launcher + 'Temp.xml')
end;

procedure ShowTrayiconMenu(Tree: TBaseVirtualTree;Menu: TPopUpMenu);
var
  Point: TPoint;
begin
  if LauncherOptions.TrayIconClassicMenu then
  begin
    //Get Mouse coordinates
    GetCursorPos(Point);
    //Classic Menu
    SetForegroundWindow(frmMain.Handle);
    //Populate classic menu at runtime
    UpdateClassicMenu(Tree, Menu);
    //Show classic menu
    Menu.Popup(Point.X, Point.Y);
  end
  else begin      
    //Default Menu
    if frmMenu.Visible then
      frmMenu.CloseMenu
    else
      frmMenu.OpenMenu;
  end;
end;

procedure UpdateClassicMenu(Tree: TBaseVirtualTree;Menu: TPopUpMenu);
var
  I        : Integer;
  MenuItem : TMenuItem;
begin
  Menu.Items.Clear;
  //Create menu items and set its properties
  //Menu Items: Show Window, wpp's HomePage (if in wppL), Options and Save List
  for I := 0 to 3 do
  begin
    MenuItem := TMenuItem.Create(Application.MainForm);
    Menu.Items.Add(MenuItem);
    case I of
      0:
      begin
        MenuItem.Caption    := TransCompName.MenuShowWindow;
        MenuItem.ImageIndex := 0;
        MenuItem.OnClick    := frmMain.ShowMainForm;
        MenuItem.Default    := true;
      end;
      1:
      begin
        {$IfDef winPenPack}
        MenuItem.Caption    := 'winPenPack';
        MenuItem.ImageIndex := 2;
        MenuItem.OnClick    := frmMain.miHomePageClick;
        Menu.Items.InsertNewLineAfter(MenuItem);
        {$Else}
        MenuItem.free;
        {$EndIf}
      end;
      2:
      begin
        MenuItem.Caption    := TransCompName.MenuOption;
        MenuItem.ImageIndex := 3;
        MenuItem.OnClick    := frmMain.miOptionsClick;
        MenuItem.Enabled    := Not(LauncherOptions.ReadOnlyMode);
      end;
      3:
      begin
        MenuItem.Caption    := TransCompName.MenuSave;
        MenuItem.ImageIndex := 9;
        MenuItem.OnClick    := frmMain.miSaveListClick;
        MenuItem.Enabled    := Not(LauncherOptions.ReadOnlyMode);
      end;
    end;
  end;
  Menu.Items.InsertNewLineAfter(MenuItem);
  //Populate Menu with list items
  MenuList.Clear;
  frmMain.vstList.IterateSubtree(nil, IterateSubtreeProcs.PopulateClassicTrayMenu, nil, [], False);
  //Create menu items and set its properties
  //MRU items and Exit
  for I := 0 to 1 do
  begin
    MenuItem := TMenuItem.Create(Application.MainForm);
    Menu.Items.Add(MenuItem);
    case I of
      0:
      begin
        Menu.Items.InsertNewLineBefore(MenuItem);
        if LauncherOptions.SubMenuMRU then
        begin
          UpdateMRU(Tree,MenuItem);
          MenuItem.Caption    := TransCompName.MenuMRU;
          {$IfDef winPenPack}
          MenuItem.ImageIndex := 15;
          {$EndIf}
        end
        else begin
          UpdateMRU(Tree,Menu.Items[0].parent);
          MenuItem.free;
        end;
      end;
      1:
      begin
        Menu.Items.InsertNewLineBefore(MenuItem);
        MenuItem.Caption    := TransCompName.MenuExit;
        MenuItem.OnClick    := frmMain.miExitClick;
        {$IfDef winPenPack}
        MenuItem.ImageIndex := 16;
        {$EndIf}
      end;
    end;
  end;
end;

function SaveFileXML(Tree: TBaseVirtualTree;Filename: String): Boolean;
var
  XMLDoc3 : TXMLDocument;
begin
  //If launcher is in ReadOnlyMode, exit from this function
  if (LauncherOptions.ReadOnlyMode) then
  begin
    Result := True;
    Exit;
  end;
  //Create XMLDoc3
  XMLDoc3 := TXMLDocument.Create(Application.MainForm);
  XMLDoc3.Active  := True;
  XMLDoc3.Options := XMLDoc3.Options + [doNodeAutoIndent];
  with XMLDoc3  do
  begin
    //List
    {$IfDef ASuite}        
      frmMain.SaveListXML(Tree, AddChild('ASuite'));
      XMLDoc3.ChildNodes['ASuite'].Attributes['Version'] := ReleaseVersion;
    {$Else}
      frmMain.SaveListXML(Tree, AddChild('start'));
    XMLDoc3.ChildNodes['start'].Attributes['Version'] := ReleaseVersion;
    {$EndIf}
    //MRU
    SaveMRUXML(DocumentElement.AddChild('MRU'),Tree);
    //Options
    SaveOptionsXML(DocumentElement.AddChild('Option'));
    //Scan settings
    SaveScanSettingsXML(DocumentElement.ChildNodes['Option'].AddChild('ScanFolder'));
  end;
  //Save
  XMLDoc3.SaveToFile(Filename);
  //Release XMLDoc3
  XMLDoc3.Active := false;
  XMLDoc3.Free;
  Result := True;
end;

procedure AddMRU(Sender: TBaseVirtualTree;PopupMenu: TPopupMenu;Software: PVirtualNode;
                 DontAdd: Boolean);
begin
  if (LauncherOptions.MRU) and Not(DontAdd) then
  begin
    MRUList.Insert(0, Software);
    RefreshList(Sender, PopupMenu, true);
  end;
end;

procedure LoadMRUXML(XMLNode: IXMLNode;Tree: TBaseVirtualTree);
var
  I : Integer;
begin
  MRUList   := TNodeList.Create(LauncherOptions.MRUNumber);
  if LauncherOptions.MRU then
    with XMLNode do
      for I := 0 to LauncherOptions.MRUNumber - 1 do
        if ChildNodes['MRUItem' + IntToStr(I)].text <> '' then
          MRUList.Add(GetNodeFromText(Tree,
                                      ChildNodes['MRUItem' + IntToStr(I)].text,
                                      False));
end;

procedure SaveMRUXML(XMLNode: IXMLNode;Tree: TBaseVirtualTree);
var
  I           : Integer;
  MRUNodeData : PTreeData;
begin
  if LauncherOptions.MRU then
  begin
    for I := 0 to MRUList.Count - 1 do
    begin
      if Assigned(MRUList[I]) then
      begin
        MRUNodeData := Tree.GetNodeData(MRUList[I]);
        XMLNode.AddChild('MRUItem' + IntToStr(I)).Text := MRUNodeData.Name;
      end;
    end;
  end;
end;

procedure UpdateMRU(Sender: TBaseVirtualTree;PopupMenu: TMenuItem);
var
  NodeData  : PTreeData;
  I         : Integer;
  MRUItem   : TMenuItem;
begin
  if LauncherOptions.MRU then
  begin
    for I := 0 to MRUList.Count - 1 do
    begin
      if Assigned(MRUList[I]) then
      begin
        //Create MRUItem
        MRUItem            := TMenuItem.Create(Application.MainForm);
        NodeData           := Sender.GetNodeData(MRUList[I]);
        MRUItem.Caption    := NodeData.Name;
        if Assigned(NodeData) then
        begin
          //Set some properties
          MRUItem.Tag      := NodeData.Tag;
          MRUItem.ImageIndex := NodeData.ImageIndex;
          NodeData.MRUItem := MRUItem;
          MRUItem.OnClick  := frmMain.RunExe;
          PopupMenu.Add(MRUItem);
        end
        else begin
          //Delete MRUItem and MRUList[I]
          MRUItem.Free;
          MRUList.Delete(I);
        end;
      end;
    end;
  end;
end;

procedure LoadOptionsXML(XMLNode: IXMLNode);
var
  I: Integer;
begin
  with XMLNode do
  begin
    //StartUp
    LauncherOptions.WindowsStartup   := ReadBooleanXML(ChildNodes['StartOnWindowsStartup'],false);
    LauncherOptions.StartUpShowPanel := ReadBooleanXML(ChildNodes['StartUpShowPanel'],true);
    LauncherOptions.StartUpShowMenu  := ReadBooleanXML(ChildNodes['StartUpShowMenu'],false);
    LauncherOptions.MainOnTop        := ReadBooleanXML(ChildNodes['MainOnTop'],false);
    //Window Hotkey
    LauncherOptions.WindowHotkeyMod  := ReadIntegerXML(ChildNodes['HotKeyModifier'],-1);
    LauncherOptions.WindowHotkeyCode := ReadIntegerXML(ChildNodes['HotKeyCode'],-1);
    LauncherOptions.WindowHotkey     := ReadBooleanXML(ChildNodes['HotKey'],false);
    //Menu Hotkey
    LauncherOptions.MenuHotkeyMod  := ReadIntegerXML(ChildNodes['MenuHotKeyModifier'],-1);
    LauncherOptions.MenuHotkeyCode := ReadIntegerXML(ChildNodes['MenuHotKeyCode'],-1);
    LauncherOptions.MenuHotkey     := ReadBooleanXML(ChildNodes['MenuHotKey'],false);
    //Language
    if (ChildNodes['Language'].Text = '') or
       Not((FileExists(PathUser + 'Lang\' + ChildNodes['Language'].Text)) or
           (FileExists(PathUser + ChildNodes['Language'].Text))) then
    begin
      LauncherOptions.LangName := 'english.xml';
      if Not((FileExists(PathUser + 'Lang\' + LauncherOptions.LangName)) or
             (FileExists(PathUser + LauncherOptions.LangName))) then
      begin
        ShowMessage('File lang not found');
        Application.Terminate;
      end;
    end
    else
      LauncherOptions.LangName := ChildNodes['Language'].Text;
    //Custom Title
    LauncherOptions.CustomTitle       := ReadBooleanXML(ChildNodes['CustomTitle'],false);
    LauncherOptions.CustomTitleString := ReadStringXML(ChildNodes['CustomTitleString'],'ASuite');
    LauncherOptions.HoldSize   := ReadBooleanXML(ChildNodes['HoldSize'],false);
    //Background
    LauncherOptions.BackgroundPath := ReadStringXML(ChildNodes['BackgroundPath'],'');
    LauncherOptions.Background := ReadBooleanXML(ChildNodes['Background'],false);
    //frmMain's size
    frmMain.Width      := ReadIntegerXML(ChildNodes['ListFormWidth'],frmMainWidth);
    frmMain.Height     := ReadIntegerXML(ChildNodes['ListFormHeight'],frmMainHeight);
    {$ifdef ASuite}
    LauncherOptions.ActiveFormCard := ReadBooleanXML(ChildNodes['ActiveFormCard'], true);
    {$endif}
    //Treeview Font
    LauncherOptions.FontName   := ReadStringXML(ChildNodes['TreeViewFontName'],'MS Sans Serif');
    with ChildNodes['TreeViewFontStyle'] do
    begin
      if StrToBool(ChildNodes['fsBold'].Text) then
        Include(LauncherOptions.FontStyle,fsBold);
      if StrToBool(ChildNodes['fsItalic'].Text) then
        Include(LauncherOptions.FontStyle,fsItalic);
      if StrToBool(ChildNodes['fsUnderline'].Text) then
        Include(LauncherOptions.FontStyle,fsUnderline);
      if StrToBool(ChildNodes['fsStrikeOut'].Text) then
        Include(LauncherOptions.FontStyle,fsStrikeOut);
    end;
    LauncherOptions.FontSize     := ReadIntegerXML(ChildNodes['TreeViewFontSize'],8);
    LauncherOptions.FontColor    := ReadIntegerXML(ChildNodes['TreeViewFontColor'],clWindowText);
    //Tabs
    LauncherOptions.HideSearch   := ReadBooleanXML(ChildNodes['HideSearch'],false);
    LauncherOptions.HideStats    := ReadBooleanXML(ChildNodes['HideStats'],false);
    //MRU
    LauncherOptions.MRU := ReadBooleanXML(ChildNodes['ActiveMRU'],true);
    LauncherOptions.SubMenuMRU   := ReadBooleanXML(ChildNodes['ActiveSubMenuMRU'],false);
    LauncherOptions.MRUNumber    := ReadIntegerXML(ChildNodes['MRUNumber'],5);
    //Backup
    LauncherOptions.Backup       := ReadBooleanXML(ChildNodes['ActiveBackup'],true);
    LauncherOptions.BackupNumber := ReadIntegerXML(ChildNodes['BackupNumber'],5);
    //Check List
    LauncherOptions.CheckList     := ReadBooleanXML(ChildNodes['ActiveCheckList'],true);
    LauncherOptions.CheckListTime := ReadIntegerXML(ChildNodes['CheckListTimeInterval'],5);
    //Hotkey
    LauncherOptions.HotKey       := ReadBooleanXML(ChildNodes['ActiveHotKey'],true);
    //Autorun, Cache, Save Security and Scheduler
    LauncherOptions.Autorun      := ReadBooleanXML(ChildNodes['ActiveAutorun'],true);
    LauncherOptions.Cache        := ReadBooleanXML(ChildNodes['ActiveCache'],true);
    LauncherOptions.SaveSecurity := ReadBooleanXML(ChildNodes['ActiveSaveSecurity'],true);
    LauncherOptions.Scheduler    := ReadBooleanXML(ChildNodes['ActiveScheduler'],true);
    //Trayicon
    LauncherOptions.TrayIcon     := ReadBooleanXML(ChildNodes['ActiveTrayIcon'],true);
    LauncherOptions.TrayIconPath := ReadStringXML(ChildNodes['TrayIconPath'],'');
    LauncherOptions.ActionClickLeft := ReadIntegerXML(ChildNodes['ActionClickLeft'],0);
    LauncherOptions.ActionClickRight := ReadIntegerXML(ChildNodes['ActionClickRight'],2);
    LauncherOptions.TrayIconClassicMenu := ReadBooleanXML(ChildNodes['ClassicMenu'],false);
    //Only default menu
    LauncherOptions.MenuTheme    := ReadStringXML(ChildNodes['MenuTheme'],'Default');
    LauncherOptions.MenuFade     := ReadBooleanXML(ChildNodes['MenuFade'],true);
    LauncherOptions.MenuPersonalPicture := ReadStringXML(ChildNodes['MenuPersonalPicture'],'Default');
    LauncherOptions.ActionOnExe  := ReadIntegerXML(ChildNodes['ActionOnExe'],0);
    LauncherOptions.RunSingleClick := ReadBooleanXML(ChildNodes['RunSingleClick'],false);
    for I := 0 to 3 do
      with XMLNode.ChildNodes['MenuFolders'] do
      begin
        if ChildNodes['Folder' + IntToStr(I)].Attributes['name'] <> null then
          LauncherOptions.MenuFolderName[I] := ChildNodes['Folder' + IntToStr(I)].Attributes['name'];
        LauncherOptions.MenuFolderPath[I] := ReadStringXML(ChildNodes['Folder' + IntToStr(I)],'');
      end;
    {$IfDef ASuite}
    //FrmMain's position
    if (LauncherOptions.ActiveFormCard) and Not(FileExists(LauncherFileNameXML)) then
      frmMain.Position := poDesigned
    else
      frmMain.Position := poDesktopCenter;
    {$Else}
      frmMain.Position := poDesktopCenter;
    {$EndIf}
    //Mouse sensors
    for I := 0 to 3 do
      with XMLNode.ChildNodes['Mouse'] do
      begin
        LauncherOptions.SensorLeftClick[I]  := ReadIntegerXML(ChildNodes['SensorLeftClick' + IntToStr(I)], 0);
        LauncherOptions.SensorRightClick[I] := ReadIntegerXML(ChildNodes['SensorRightClick' + IntToStr(I)], 0);
      end;
    //frmMain position
    if ((ChildNodes['ListFormTop'].Text <> '') and
       (ChildNodes['ListFormLeft'].Text <> '')) then
    begin
      if ((StrToInt(ChildNodes['ListFormTop'].Text) + frmMainHeight) <= GetDeviceCaps(GetDC(frmMain.Handle), VERTRES)) then
        frmMain.Top  := StrToInt(ChildNodes['ListFormTop'].Text)
      else
        frmMain.Top  := GetDeviceCaps(GetDC(frmMain.Handle), VERTRES) - frmMain.Height - 30;
      if ((StrToInt(ChildNodes['ListFormLeft'].Text) + frmMainWidth) <= GetDeviceCaps(GetDC(frmMain.Handle), HORZRES)) then
        frmMain.Left := StrToInt(ChildNodes['ListFormLeft'].Text)
      else
        frmMain.Left := GetDeviceCaps(GetDC(frmMain.Handle), HORZRES) - frmMain.Width;
      frmMain.Position := poDesigned;
    end;
    //Window Hotkey
    if (LauncherOptions.HotKey) and (LauncherOptions.WindowHotkey) then
      RegisterHotKey(frmMain.Handle, frmMain.Handle, GetHotKeyMod(LauncherOptions.WindowHotKeyMod),GetHotKeyCode(LauncherOptions.WindowHotKeyCode));
    //Menu Hotkey
    if (LauncherOptions.HotKey) and (LauncherOptions.MenuHotkey) then
      RegisterHotKey(frmMain.Handle, frmMenuID, GetHotKeyMod(LauncherOptions.MenuHotKeyMod),GetHotKeyCode(LauncherOptions.menuHotKeyCode));
  end;
end;

procedure SaveOptionsXML(XMLNode: IXMLNode);
var
  I: Integer;
begin
  with XMLNode do
  begin
    //General
    //Startup
    AddChild('StartOnWindowsStartup').Text := BoolToStr(LauncherOptions.WindowsStartup);
    AddChild('StartUpShowPanel').Text := BoolToStr(LauncherOptions.StartUpShowPanel);
    AddChild('StartUpShowMenu').Text  := BoolToStr(LauncherOptions.StartUpShowMenu);
    AddChild('HoldSize').Text         := BoolToStr(LauncherOptions.HoldSize);
    AddChild('MainOnTop').Text        := BoolToStr(LauncherOptions.MainOnTop);
    //Hotkey
    if (LauncherOptions.WindowHotkey <> false) then
      AddChild('HotKey').Text         := BoolToStr(LauncherOptions.WindowHotkey);
    if (LauncherOptions.WindowHotkeyMod <> -1) and (LauncherOptions.WindowHotkeyMod >= 0) and
       (LauncherOptions.WindowHotkey) then
      AddChild('HotKeyModifier').Text := IntToStr(LauncherOptions.WindowHotkeyMod);
    if (LauncherOptions.WindowHotkeyCode <> -1) and (LauncherOptions.WindowHotkeyCode >= 0) and
       (LauncherOptions.WindowHotkey) then
      AddChild('HotKeyCode').Text     := IntToStr(LauncherOptions.WindowHotkeyCode);
    //Menu Hotkey
    if (LauncherOptions.MenuHotkey <> false) then
      AddChild('MenuHotKey').Text         := BoolToStr(LauncherOptions.MenuHotkey);
    if (LauncherOptions.MenuHotkeyMod <> -1) and (LauncherOptions.MenuHotkeyMod >= 0) and
       (LauncherOptions.MenuHotkey) then
      AddChild('MenuHotKeyModifier').Text := IntToStr(LauncherOptions.MenuHotkeyMod);
    if (LauncherOptions.MenuHotkeyCode <> -1) and (LauncherOptions.MenuHotkeyCode >= 0) and
       (LauncherOptions.MenuHotkey) then
      AddChild('MenuHotKeyCode').Text     := IntToStr(LauncherOptions.MenuHotkeyCode);
       AddChild('Language').Text         := LauncherOptions.LangName;
    //Custom Title
    AddChild('CustomTitle').Text      := BoolToStr(LauncherOptions.CustomTitle);
    AddChild('CustomTitleString').Text := LauncherOptions.CustomTitleString;
    //frmMain size
    AddChild('ListFormWidth').Text    := IntToStr(frmMain.Width);
    AddChild('ListFormHeight').Text   := IntToStr(frmMain.Height);
    {$ifdef ASuite}
    AddChild('ActiveFormCard').Text   := BoolToStr(LauncherOptions.ActiveFormCard);
    {$else}
    AddChild('AutorunInf').Text       := BoolToStr(LauncherOptions.AutorunInf);
    {$endif}
    //Background
    AddChild('Background').Text       := BoolToStr(LauncherOptions.Background);
    if LauncherOptions.BackgroundPath <> '' then
      AddChild('BackgroundPath').Text := LauncherOptions.BackgroundPath;
    //Treeview Font
    AddChild('TreeViewFontName').Text := LauncherOptions.FontName;
    if LauncherOptions.FontStyle <> [] then
      with ChildNodes['TreeViewFontStyle'] do
      begin
        if fsBold in LauncherOptions.FontStyle then
          AddChild('fsBold').Text      := '1';
        if fsItalic in LauncherOptions.FontStyle then
          AddChild('fsItalic').Text    := '1';
        if fsUnderline in LauncherOptions.FontStyle then
          AddChild('fsUnderline').Text := '1';
        if fsStrikeOut in LauncherOptions.FontStyle then
          AddChild('fsStrikeOut').Text := '1';
      end;
    AddChild('TreeViewFontSize').Text  := IntToStr(LauncherOptions.FontSize);
    AddChild('TreeViewFontColor').Text := IntToStr(LauncherOptions.FontColor);
    //Tabs
    AddChild('HideSearch').Text       := BoolToStr(LauncherOptions.HideSearch);
    AddChild('HideStats').Text        := BoolToStr(LauncherOptions.HideStats);
    //Recents
    AddChild('ActiveMRU').Text        := BoolToStr(LauncherOptions.MRU);
    AddChild('ActiveSubMenuMRU').Text := BoolToStr(LauncherOptions.SubMenuMRU);
    AddChild('MRUNumber').Text        := IntToStr(LauncherOptions.MRUNumber);
    //Backup
    AddChild('ActiveBackup').Text     := BoolToStr(LauncherOptions.Backup);
    AddChild('BackupNumber').Text     := IntToStr(LauncherOptions.BackupNumber);
    //Check list
    AddChild('ActiveCheckList').Text  := BoolToStr(LauncherOptions.CheckList);
    AddChild('CheckListTimeInterval').Text := IntToStr(LauncherOptions.CheckListTime);
    //Various
    AddChild('ActiveHotKey').Text     := BoolToStr(LauncherOptions.HotKey);
    AddChild('ActiveCache').Text      := BoolToStr(LauncherOptions.Cache);
    AddChild('ActiveSaveSecurity').Text := BoolToStr(LauncherOptions.SaveSecurity);
    AddChild('ActiveAutorun').Text    := BoolToStr(LauncherOptions.Autorun);
    AddChild('ActiveScheduler').Text  := BoolToStr(LauncherOptions.Scheduler);
    //Trayicon
    AddChild('ActiveTrayIcon').Text   := BoolToStr(LauncherOptions.TrayIcon);
    AddChild('TrayIconPath').Text     := LauncherOptions.TrayIconPath;
    AddChild('ActionClickLeft').Text  := IntToStr(LauncherOptions.ActionClickLeft);
    AddChild('ActionClickRight').Text  := IntToStr(LauncherOptions.ActionClickRight);
    AddChild('ClassicMenu').Text      := BoolToStr(LauncherOptions.TrayIconClassicMenu);
    //Only default menu
    AddChild('MenuTheme').Text  := LauncherOptions.MenuTheme;
    AddChild('MenuFade').Text   := BoolToStr(LauncherOptions.MenuFade);
    for I := 0 to 3 do
      with XMLNode.ChildNodes['MenuFolders'] do
      begin
        AddChild('Folder' + IntToStr(I)).Text := LauncherOptions.MenuFolderPath[I];
        ChildNodes['Folder' + IntToStr(I)].Attributes['name'] := LauncherOptions.MenuFolderName[I];
      end;
    AddChild('MenuPersonalPicture').Text := LauncherOptions.MenuPersonalPicture;
    AddChild('ActionOnExe').Text      := IntToStr(LauncherOptions.ActionOnExe);
    AddChild('RunSingleClick').Text   := BoolToStr(LauncherOptions.RunSingleClick);
    //Mouse sensors
    for I := 0 to 3 do
      with XMLNode.ChildNodes['Mouse'] do
      begin
        AddChild('SensorLeftClick' + IntToStr(I)).Text  := IntToStr(LauncherOptions.SensorLeftClick[I]);
        AddChild('SensorRightClick' + IntToStr(I)).Text := IntToStr(LauncherOptions.SensorRightClick[I]);
      end;
    //frmMain's position
    AddChild('ListFormTop').Text      := IntToStr(frmMain.Top);
    AddChild('ListFormLeft').Text     := IntToStr(frmMain.Left);
  end;
end;

procedure UpdateOptions;
var
  BackgroundBMP  : TBitmap;
  BackgroundJPEG : TJPEGImage;
  I : Integer;
begin
  with frmMain do
  begin
    //Hold frmMain's size
    if LauncherOptions.HoldSize then
    begin
      BorderStyle := bsSingle;
      BorderIcons := [biSystemMenu,biMinimize];
    end
    else begin
      BorderStyle := bsSizeable;
      BorderIcons := [biSystemMenu,biMinimize,biMaximize];
    end;
    //Show frmMain on startup
    if (not(LauncherOptions.StartUpShowPanel)) and (not(LauncherOptions.Trayicon)) then
      LauncherOptions.StartUpShowPanel := true;
    //Trayicon
    with CoolTrayIcon1 do
    begin
      Enabled        := LauncherOptions.Trayicon;
      IconVisible    := LauncherOptions.Trayicon;
      MinimizeToTray := LauncherOptions.Trayicon;
      if FileExists(RelativeToAbsolute(LauncherOptions.TrayiconPath)) then
        Icon.LoadFromFile(RelativeToAbsolute(LauncherOptions.TrayiconPath))
      else begin
        {$ifdef ASuite}
        Icon.LoadFromFile(RelativeToAbsolute(PathIcons + Launcher + '.ico'))
        {$else}
        Icon.LoadFromFile(RelativeToAbsolute(PathUser + 'icons\0.ico'))
        {$endif}
      end;
    end;
    //Default menu folders
    for I := 0 to 3 do
    begin
      if LauncherOptions.MenuFolderPath[I] = '' then
      begin
        case I of
          0:
          begin
            LauncherOptions.MenuFolderName[I] := 'Documents';
            LauncherOptions.MenuFolderPath[I] := '$Drive\Documents';
          end;
          1:
          begin
            LauncherOptions.MenuFolderName[I] := 'Music';
            LauncherOptions.MenuFolderPath[I] := '$Drive\Documents\Music';
          end;
          2:
          begin
            LauncherOptions.MenuFolderName[I] := 'Pictures';
            LauncherOptions.MenuFolderPath[I] := '$Drive\Documents\Pictures';
          end;
          3:
          begin
            LauncherOptions.MenuFolderName[I] := 'Video';
            LauncherOptions.MenuFolderPath[I] := '$Drive\Documents\Video';
          end;
        end;
      end;
    end;
    //frmMain on top
    if LauncherOptions.MainOnTop then
      SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
    else
      SetWindowPos(Handle,HWND_NOTOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    //Language
    frmMain.TranslateForm(LauncherOptions.LangName);
    //Custom Window Title
    if (LauncherOptions.CustomTitle) and (LauncherOptions.CustomTitleString <> '') then
      frmMain.Caption := LauncherOptions.CustomTitleString
    else
      frmMain.Caption := Launcher;
    //Stats
    if Not(StartUpTime) then
      GetStats(true);
    //Cache and save security
    if Not(LauncherOptions.Cache) then
    begin
      //Delete all file icon-cache and folder cache
      DeleteFiles(PathCache,'*.*');
      RemoveDir(PathCache);
    end
    else begin
      //Create folder cache, if it doesn't exist
      if (not DirectoryExists(PathCache)) then
        CreateDir(PathCache);
    end;
    //Save security
    if Not(LauncherOptions.SaveSecurity) then
      DeleteFile(Launcher + 'Temp.xml');
    {$IfDef ASuite}
    //Close frmCard
    if (Not(LauncherOptions.ActiveFormCard)) And (IsFormOpen('frmCard')) then
      frmCard.Close;
    {$EndIf}
    //Background
    if (LauncherOptions.Background) and (LauncherOptions.BackgroundPath <> '') and
       (FileExists(RelativeToAbsolute(LauncherOptions.BackgroundPath))) then
    begin
      if LowerCase(ExtractFileExt(RelativeToAbsolute(LauncherOptions.BackgroundPath))) <> '.bmp' then
      begin
        BackgroundBMP  := TBitmap.Create;
        BackgroundJPEG := TJPEGImage.Create;
        try
          BackgroundJPEG.LoadFromFile(RelativeToAbsolute(LauncherOptions.BackgroundPath));
          BackgroundBMP.Assign(BackgroundJPEG);
          vstList.Background.Bitmap := BackgroundBMP;
        finally
          BackgroundBMP.Free;
          BackgroundJPEG.Free;
        end;
      end
      else
        vstList.Background.LoadFromFile(RelativeToAbsolute(LauncherOptions.BackgroundPath));
      vstList.TreeOptions.PaintOptions := vstList.TreeOptions.PaintOptions + [toShowBackground];
    end
    else
      vstList.TreeOptions.PaintOptions := vstList.TreeOptions.PaintOptions - [toShowBackground];
    SetDeleteASuiteWindowsStartup(LauncherOptions.WindowsStartup);
    //Close (to avoid double sensors) and create FormSensors
    if Not(StartUpTime) then
    begin
      CloseFormSensors;
      CreateFormSensors;
    end;
    vstList.Update;
    //Hide tabs
    tbSearch.TabVisible := Not(LauncherOptions.HideSearch);
    tbStats.TabVisible  := Not(LauncherOptions.HideStats);
    {$IfDef ASuite}
    tbList.TabVisible   := Not(LauncherOptions.HideSearch and LauncherOptions.HideStats);
    {$EndIf}
    pcList.ActivePageIndex := 0;
    //Check list
    tmCheckList.Enabled  := LauncherOptions.CheckList;
    tmCheckList.Interval := (LauncherOptions.CheckListTime * 1000);
  end;
end;

function BoolToStr(Bool: Boolean):String;
begin
  if Bool = true then
    result := '1'
  else
    result := '0';
end;

function StrToBool(Str: string): boolean;
begin
  if (Str = '1') then
    result := True
  else
    result := false;
end;

function AbsoluteToRelative(PathFile: String): string;
begin
  if (pos(ApplicationPath,PathFile) <> 0) then
    Delete(PathFile,(pos(ApplicationPath,PathFile)),Length(ApplicationPath))
  else
    if pos(ExtractFileDrive(Application.ExeName),PathFile) <> 0 then
      PathFile := StringReplace(PathFile, ExtractFileDrive(Application.ExeName), '$Drive', [rfIgnoreCase]);
  Result := PathFile;
end;

function RelativeToAbsolute(PathFile: String): string;
var
  EnvVar: String;
begin
  //$ASuite = Launcher's path
  PathFile := StringReplace(PathFile, '$asuite', ExtractFileDir(Application.ExeName), [rfIgnoreCase,rfReplaceAll]);
  //$Drive = Launcher's Drive (ex. ASuite in H:\Software\asuite.exe, $Drive is H: )
  PathFile := StringReplace(PathFile, '$drive', ExtractFileDrive(Application.ExeName), [rfIgnoreCase,rfReplaceAll]);
  //Replace environment variable
  if (pos('%',PathFile) <> 0) then
  begin
    EnvVar := PathFile;
    Delete(EnvVar,1,pos('%',EnvVar));
    EnvVar := Copy(EnvVar,1,pos('%',EnvVar) - 1);
    PathFile := StringReplace(PathFile, '%' + EnvVar + '%', GetEnvVarValue(
      EnvVar), [rfIgnoreCase]);
  end;
  if (pos(':',PathFile) = 0) and (pos('www.',PathFile) <> 1) and
     (pos('\\',PathFile) <> 1) and (pos('%',PathFile) = 0)  and
     (pos('-',PathFile) <> 1) and (pos('/',PathFile) = 0) then
  begin
    PathFile := ApplicationPath + PathFile;
  end;
  Result := PathFile;
end;

procedure StrToStrings(Str, Sep: string; const List: TStrings);
var
  I        : Integer;
  PieceStr : string;
begin
  Assert(Assigned(List));
  List.BeginUpdate;
  try
    List.Clear;
    I := Pos(Sep, Str);
    while I > 0 do
    begin
      //Copy first part of Str and add it in List
      PieceStr := Copy(Str, 1, I - 1);
      if (PieceStr <> '') then
        List.Add(PieceStr);
      //Delete first part in Str and begin again
      Delete(Str, 1, I);
      I := Pos(Sep, Str);
    end;
    //Last piece of string
    if Str <> '' then
      List.Add(Str);
  finally
    List.EndUpdate;
  end;
end;  

function StringToWideString(Str: string): WideString;
var
  res:integer;
begin
  Result := '';
  if Str <> '' then
  begin
    SetLength (Result, length(Str));
    res:=MultiByteToWideChar(CP_ACP, 0, PChar(Str), length(Str), PWideChar(Result),length(Str));
    if res = 0 then
      raise Exception.Create('Cannot convert String to widestring with specified codepage.');
    SetLength(Result, res);
  end;
end;

function GetCurrentUserName: string;
const
  cnMaxUserNameLen = 254;
var
  sUserName: string;
  dwUserNameLen: DWORD;
begin
  dwUserNameLen := cnMaxUserNameLen - 1;
  SetLength(sUserName, cnMaxUserNameLen);
  GetUserName(PChar(sUserName), dwUserNameLen);
  SetLength(sUserName, dwUserNameLen);
  Result := sUserName;
end;

function GetComputerName: string;
var
  buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: Cardinal;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  Windows.GetComputerName(@buffer, Size);
  Result := StrPas(buffer);
end;

function DiskFloatToString(Number: Double;Units: Boolean): string;
var
  TypeSpace : String;
begin
  if Number >= 1024 then
  begin
    //KiloBytes
    Number    := Number / (1024);
    TypeSpace := ' KB';
    if Number >= 1024 then
    begin                          
      //MegaBytes
      Number    := Number / (1024);
      TypeSpace := ' MB';
      if Number >= 1024 then
      begin                           
        //GigaBytes
        Number    := Number / (1024);
        TypeSpace := ' GB';
      end;
    end;
  end;
  Result := FormatFloat('0.00',Number);
  if Units then
    Result := Result + TypeSpace;
end;

procedure GetStats(GetSystem: boolean);
var
  Drive : Char;
  FreeSpacePercentual : Double;
begin
  with frmMain do
  begin
    //System
    if GetSystem then
    begin
      lbOs.caption      := GetWindowsVersion;
      lbNamePc.caption  := lbNamePc.caption + GetComputerName;
      lbUtente.caption  := lbUtente.caption + GetCurrentUserName;
    end;
    //Drive
    Drive               := StringReplace(ExtractFileDrive(ApplicationPath),':','',[])[1];
    gbSupport.Caption   := Format(TransCompName.GroupBoxSupport,[Drive]);
    with TransCompName do
    begin
      lbSize.caption      := LabelSize      + DiskSizeString(Drive,true);
      lbSpaceFree.caption := LabelSpaceFree + DiskFreeString(Drive,true);
      lbSpaceUsed.caption := LabelSpaceUsed + DiskUsedString(Drive,true);
      //Launcher
      SwCount  := 0;
      CatCount := 0;
      frmMain.vstList.IterateSubtree(nil, IterateSubtreeProcs.UpdateListItemCount, nil, [], False);
      lbSoftware.caption  := LabelSoftware + IntToStr(SwCount);
      lbCat.caption       := LabelCategory + IntToStr(CatCount);
      lbTotal.caption     := LabelTotal    + IntToStr(SwCount + CatCount);
    end;
    FreeSpacePercentual := DiskFreePercentual(Drive);
    {$IfDef ASuite}
    CoolTrayIcon1.Hint  := Launcher + ' ' + ReleaseVersion + PreReleaseVersion + ' (' + ExtractFileDrive(ApplicationPath) + ')' + #13#10;
    {$Else}
    CoolTrayIcon1.Hint  := Launcher + #13#10;
    {$EndIf}
    with TransCompName do
      CoolTrayIcon1.Hint  := CoolTrayIcon1.Hint +
                             LabelSoftware  + IntToStr(SwCount) + #13#10 +
                             LabelSpaceFree + Format('%.2f%%',[FreeSpacePercentual * 100]);
  end;
end;

function GetWindowsLanguage(TypeLocalInfo: LCTYPE): string;
var
  Buffer : PChar;
  Size   : integer;
begin
  Size := GetLocaleInfo(LOCALE_USER_DEFAULT, TypeLocalInfo, nil, 0);
  GetMem(Buffer, Size);
  try
    GetLocaleInfo(LOCALE_USER_DEFAULT, TypeLocalInfo, Buffer, Size);
    Result := String(Buffer);
  finally
    FreeMem(Buffer);
  end;
end;

function GetWindowsVersion: string;
var
  VerInfo : TOsversionInfo;
  PlatformId, ServicePack : string;
  Reg     : TRegistry;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(VerInfo);
  GetVersionEx(VerInfo);
  Reg         := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  case VerInfo.dwPlatformId of
    VER_PLATFORM_WIN32_WINDOWS:
      begin
        //Windows 9x
        Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion', False);
        PlatformId  := Reg.ReadString('ProductName');
        ServicePack := Reg.ReadString('CSDVersion');
      end;
    VER_PLATFORM_WIN32_NT:
      begin
        //Windows NT (2000/XP/2003/Vista)
        Reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion', False);
        PlatformId  := Reg.ReadString('ProductName');
        ServicePack := StringReplace(Reg.ReadString('CSDVersion'),'Service Pack','SP',[]);
      end;
  end;
  Reg.Free;
  Result := PlatformId + ' (' + ServicePack + ')';
end;

function DiskFreeString(Drive: Char;Units: Boolean): string;
var
  Free : Double;
begin
  Free   := DiskFree(Ord(Drive) - 64);
  Result := DiskFloatToString(Free,Units);
end;

function DiskSizeString(Drive: Char;Units: Boolean): string;
var
  Size : Double;
begin
  Size   := DiskSize(Ord(Drive) - 64);
  Result := DiskFloatToString(Size,Units);
end;

function DiskUsedString(Drive: Char;Units: Boolean): string;
var
  Free : Double;
  Size : Double;
begin
  Free   := (DiskFree(Ord(Drive) - 64));
  Size   := (DiskSize(Ord(Drive) - 64));
  Result := DiskFloatToString(Size - Free,Units);
end;   

function DiskFreePercentual(Drive: Char): double;
var
  Free : Double;
  Size : Double;
begin
  Free   := (DiskFree(Ord(Drive) - 64));
  Size   := (DiskSize(Ord(Drive) - 64));
  Result := (Free) / (Size);
end;

function AddHotkey(Sender: TBaseVirtualTree;Node: PVirtualNode;HKId: integer): integer;
var
  NodeData : PTreeData;
begin
  Result   := HKID;
  NodeData := Sender.GetNodeData(Node);
  if (NodeData.HKModifier <> -1) and (NodeData.HKCode <> -1) then
  begin
    Result          := HKID + 1;
    //Register Hotkey with HKModifier and HKCode
    if RegisterHotKey(frmMain.Handle, HKId, GetHotKeyMod(NodeData.HKModifier),
                      GetHotKeyCode(NodeData.HKCode)) then
    begin
      SetLength(HotKeyApp, Result);
      HotKeyApp[HKID] := Node;
    end
    else
      Result := 0;
  end;
end;

Function GetHotKeyCode(KeyCode: Integer) : Integer;
begin
  Result := -1;
  case KeyCode of
    0: Result := VkKeyScan('a');
    1: Result := VkKeyScan('b');
    2: Result := VkKeyScan('c');
    3: Result := VkKeyScan('d');
    4: Result := VkKeyScan('e');
    5: Result := VkKeyScan('f');
    6: Result := VkKeyScan('g');
    7: Result := VkKeyScan('h');
    8: Result := VkKeyScan('i');
    9: Result := VkKeyScan('j');
    10: Result := VkKeyScan('k');
    11: Result := VkKeyScan('l');
    12: Result := VkKeyScan('m');
    13: Result := VkKeyScan('n');
    14: Result := VkKeyScan('o');
    15: Result := VkKeyScan('p');
    16: Result := VkKeyScan('q');
    17: Result := VkKeyScan('r');
    18: Result := VkKeyScan('s');
    19: Result := VkKeyScan('t');
    20: Result := VkKeyScan('u');
    21: Result := VkKeyScan('v');
    22: Result := VkKeyScan('w');
    23: Result := VkKeyScan('x');
    24: Result := VkKeyScan('y');
    25: Result := VkKeyScan('z');
    26: Result := Vk_F1;
    27: Result := Vk_F2;
    28: Result := Vk_F3;
    29: Result := Vk_F4;
    30: Result := Vk_F5;
    31: Result := Vk_F6;
    32: Result := Vk_F7;
    33: Result := Vk_F8;
    34: Result := Vk_F9;
    35: Result := Vk_F10;
    36: Result := Vk_F11;
    37: Result := Vk_F12;
    38: Result := VkKeyScan('1');
    39: Result := VkKeyScan('2');
    40: Result := VkKeyScan('3');
    41: Result := VkKeyScan('4');
    42: Result := VkKeyScan('5');
    43: Result := VkKeyScan('6');
    44: Result := VkKeyScan('7');
    45: Result := VkKeyScan('8');
    46: Result := VkKeyScan('9');
    47: Result := VkKeyScan('0');
  end;
end;

Function GetHotKeyMod(KeyMod: Integer) : Integer;
begin
  Result := -1;
  case KeyMod of
    0:  Result := MOD_ALT;
    1:  Result := MOD_CONTROL;
    2:  Result := MOD_SHIFT;
    3:  Result := MOD_CONTROL or MOD_ALT;
    4:  Result := MOD_SHIFT or MOD_ALT;
    5:  Result := MOD_SHIFT or MOD_CONTROL;
    6:  Result := MOD_SHIFT or MOD_CONTROL or MOD_ALT;
   	7:  Result := MOD_WIN;
    8:  Result := MOD_WIN or MOD_ALT;
    9:  Result := MOD_WIN or MOD_CONTROL;
    10: Result := MOD_WIN or MOD_SHIFT;
    11: Result := MOD_WIN or MOD_CONTROL or MOD_ALT;
    12: Result := MOD_WIN or MOD_SHIFT or MOD_ALT;
    13: Result := MOD_WIN or MOD_SHIFT or MOD_CONTROL;
    14: Result := MOD_WIN or MOD_SHIFT or MOD_CONTROL or MOD_ALT;
  end;
end;

function ReadIntegerXML(XMLNode: IXMLNode;Default: Integer): Integer;
begin
  if (XMLNode.Text <> '') then
    Result := StrToInt(XMLNode.Text)
  else
    Result := Default;
end;

function ReadStringXML(XMLNode: IXMLNode;Default: String): String;
begin
  if (XMLNode.Text <> '') then
    Result := XMLNode.Text
  else
    Result := Default;
end;

function ReadBooleanXML(XMLNode: IXMLNode;Default: Boolean): Boolean;
begin
  if (XMLNode.Text <> '') then
    Result := StrToBool(XMLNode.Text)
  else
    Result := Default;
end;

procedure LoadScanSettingsXML(XMLNode: IXMLNode);
var
  xNode : IXMLNode;
begin
  with XMLNode do
  begin
    ScanSettings.LastFolderPath := ReadStringXML(ChildNodes['LastFolderPath'],ApplicationPath);
    ScanSettings.SubFolders     := ReadBooleanXML(ChildNodes['SubFolders'],true);
    ScanSettings.FileTypes      := TStringList.Create;
    ScanSettings.ExcludeFiles   := TStringList.Create;
    //File types
    xNode := ChildNodes.First;
    while Assigned(xNode) do
    begin
      if (Pos('FileTypes', xNode.NodeName) = 1) then
        ScanSettings.FileTypes.Add(ReadStringXML(ChildNodes[xNode.NodeName],''));
      xNode := xNode.NextSibling;
    end;
    //Exclude files
    xNode := ChildNodes.First;
    while Assigned(xNode) do
    begin
      if (Pos('ExcludeFiles', xNode.NodeName) = 1) then
        ScanSettings.ExcludeFiles.Add(ReadStringXML(ChildNodes[xNode.NodeName],''));
      xNode := xNode.NextSibling;
    end;
    ScanSettings.RetrieveInfo := ReadBooleanXML(ChildNodes['RetrieveInfo'],true);
  end;
end;

procedure SaveScanSettingsXML(XMLNode: IXMLNode);
var
  I: Integer;
begin
  with XMLNode do
  begin
    AddChild('LastFolderPath').Text := ScanSettings.LastFolderPath;
    AddChild('SubFolders').Text := BoolToStr(ScanSettings.SubFolders);
    for I := 0 to ScanSettings.FileTypes.Count - 1 do
      if ScanSettings.FileTypes[I] <> '' then
        AddChild('FileTypes' + IntToStr(I)).Text := ScanSettings.FileTypes[I];
    for I := 0 to ScanSettings.ExcludeFiles.Count - 1 do
      if ScanSettings.ExcludeFiles[I] <> '' then
        AddChild('ExcludeFiles' + IntToStr(I)).Text := ScanSettings.ExcludeFiles[I];
    AddChild('RetrieveInfo').Text := BoolToStr(ScanSettings.RetrieveInfo);
  end;
end;

procedure AddAutorunInList(NodeData: PTreeData);
begin
  with NodeData^ do
  begin
    if (Autorun = 1) or (Autorun = 2) then
    begin
      if (AutorunPos > ASuiteStartUpApp.Count) then
        AutorunPos := ASuiteStartUpApp.Count;
      ASuiteStartUpApp.Insert(AutorunPos, NodeData.pNode)
    end
    else begin
      if (NodeData.Autorun = 3) then
      begin
        if (AutorunPos > ASuiteShutdownApp.Count) then
          AutorunPos := ASuiteShutdownApp.Count;
        ASuiteShutdownApp.Insert(AutorunPos, pNode);
      end;
    end;
  end;
end;

procedure RemoveAutorunFromList(NodeData: PTreeData);
begin
 if (NodeData.Autorun = 1) or (NodeData.Autorun = 2) then
   ASuiteStartUpApp.Remove(NodeData.pNode)
 else
   if (NodeData.Autorun = 3) then
     ASuiteShutdownApp.Remove(NodeData.pNode);
end;

procedure EnableTimerCheckList(Sender: TObject);
begin
  with frmMain do
  begin
    tmCheckList.Enabled := LauncherOptions.CheckList;
    if LauncherOptions.CheckList then
      tmCheckListTimer(Sender);
    //Simulate a mouse click
    PostMessage(Handle, WM_LBUTTONDOWN, MK_LBUTTON, MAKELPARAM(1,0));
    PostMessage(Handle, WM_LBUTTONUP, 0, MAKELPARAM(1,0));
  end;
end;

function ExtractDirectoryName(const Filename: string): string;
var
  AList : TStringList;
begin
	AList := TStringList.create;
	try
    StrToStrings(Filename,'\',AList);
		if AList.Count > 1 then
			result := AList[AList.Count - 1]
		else
			result := '';
	finally
		AList.Free;
	end;
end;

function GetDateTime: String;
begin
  DateTimeToString(Result, 'yyyy-mm-dd-hh-mm-ss',now);
end;

function GetEnvVarValue(VarName: string): string;
var
  BufSize: Integer;
begin
  Result   := VarName;
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName),PChar(Result), BufSize);
  end;
end;

function GetFirstFreeIndex(ArrayWString: Array of WideString): Integer;
begin
  Result := 0;
  while (ArrayWString[Result] <> '') do
    Inc(Result);
end;

//------------------------------------------------------------------------------

procedure TFileVersionInfo.FileVersionInfo(const sAppNamePath: TFileName);
var
  rSHFI: TSHFileInfo;
  iRet: Integer;
  VerSize: Integer;
  VerBuf: PChar;
  VerBufValue: Pointer;
  VerHandle: Cardinal;
  VerBufLen: Cardinal;
  VerKey: string;

  function GetInfo(const aKey: string): string;
  begin
    Result := '';
    VerKey := Format('\StringFileInfo\%.4x%.4x\%s',
              [LoWord(Integer(VerBufValue^)),
               HiWord(Integer(VerBufValue^)), aKey]);
    if VerQueryValue(VerBuf, PChar(VerKey),VerBufValue,VerBufLen) then
      Result := StrPas(VerBufValue);
  end;

  function QueryValue(const aValue: string): string;
  begin
    Result := '';
    if GetFileVersionInfo(PChar(sAppNamePath), VerHandle, VerSize, VerBuf) and
       VerQueryValue(VerBuf, '\VarFileInfo\Translation', VerBufValue, VerBufLen) then
    Result := GetInfo(aValue);
  end;

begin
  with Self do
  begin
    CompanyName := '';
    ProductName := '';
    ProductVersion := '';
  end;
  iRet := SHGetFileInfo(PChar(sAppNamePath), 0, rSHFI, SizeOf(rSHFI), SHGFI_EXETYPE);
  if iRet <> 0 then
  begin
    VerSize := GetFileVersionInfoSize(PChar(sAppNamePath), VerHandle);
    if VerSize > 0 then
    begin
      VerBuf := AllocMem(VerSize);
      try
        with Self do
        begin
          CompanyName      := QueryValue('CompanyName');
          ProductName      := QueryValue('ProductName');
          ProductVersion   := QueryValue('ProductVersion');
        end;
      finally
        FreeMem(VerBuf, VerSize);
      end
    end;
  end
end;

//------------------------------------------------------------------------------

procedure TIterateSubtreeProcs.UpdateListItemCount(Sender: TBaseVirtualTree; Node: PVirtualNode;
                                                   Data: Pointer; var Abort: Boolean);
var
  NodeData : PTreeData;
begin
  if Assigned(Node) then
  begin
    NodeData := frmMain.vstList.GetNodeData(Node);
    //Count Softwares and Categories
    case NodeData.Tipo of
      0 : Inc(CatCount);
      1 : Inc(SwCount);
      2 : Inc(SwCount);
    end;
  end;
end;

procedure TIterateSubtreeProcs.PopulateClassicTrayMenu(Sender: TBaseVirtualTree; Node: PVirtualNode;
                                                       Data: Pointer; var Abort: Boolean);
var
  NewItem : TMenuItem;
  NodeData, ParentNodeData : PTreeData;
  ItemTag : Integer;
begin
  if Assigned(Node) then
  begin
    NodeData    := frmMain.vstList.GetNodeData(Node);
    if Not(NodeData.HideSoftwareMenu) then
    begin
      ItemTag := MenuList.Add(Node);
      //Create a menu item and add it in trayicon menu
      NewItem := TMenuItem.Create(Application.MainForm);
      if (Node.Parent <> frmMain.vstList.RootNode) then
      begin
        ParentNodeData := frmMain.vstList.GetNodeData(Node.Parent);
        ParentNodeData.MenuItem.Add(NewItem);
      end
      else
        frmMain.pmTrayicon.Items.Add(NewItem);
      //Set NewItem properties
      NewItem.Caption    := NodeData.name;
      if (NodeData.Tipo = 1) or (NodeData.Tipo = 2) then
        NewItem.OnClick  := frmMain.RunExe;
      NewItem.ImageIndex := NodeData.ImageIndex;
      NewItem.Tag        := ItemTag;
      //References
      NodeData.Tag       := ItemTag;
      NodeData.MenuItem  := NewItem;
    end;
  end;
end;

//------------------------------------------------------------------------------

end.
