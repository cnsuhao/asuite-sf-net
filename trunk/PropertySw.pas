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

unit PropertySw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, ShellApi, ComObj, ShlObj;

type
  TfrmPropertySw = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    tsInfo1: TTabSheet;
    lbInfo1: TLabel;
    lbVersion: TLabel;
    lbName: TLabel;
    lbAuthor: TLabel;
    lbWebSite: TLabel;
    edtName: TEdit;
    edtVersion: TEdit;
    edtAuthor: TEdit;
    btnRetrieve: TButton;
    edtWebSite: TEdit;
    tsInfo2: TTabSheet;
    lbPathIcon: TLabel;
    lbAutoExecute: TLabel;
    lbWindowState: TLabel;
    lbWorkingDir: TLabel;
    edtPathIcon: TEdit;
    btnBrowseIcon: TButton;
    cxAutoExecute: TComboBox;
    cxWindowState: TComboBox;
    cbHotKey: TCheckBox;
    cxHotkey1: TComboBox;
    cxHotKey2: TComboBox;
    edtWorkingDir: TEdit;
    btnBrowseWorkingDir: TButton;
    tsInfo3: TTabSheet;
    lbDesc: TLabel;
    lbOpinion: TLabel;
    lbNotes: TLabel;
    memDesc: TMemo;
    memOpinion: TMemo;
    memNotes: TMemo;
    lbPathExe: TLabel;
    edtPathExe: TEdit;
    edtParameters: TEdit;
    lbParameters: TLabel;
    btnBrowseExe: TButton;
    lbInfo2: TLabel;
    lbActionOnExe: TLabel;
    cxActionOnExe: TComboBox;
    cbDontInsertMRU: TCheckBox;
    cbShortcutDesktop: TCheckBox;
    dtpSchDate: TDateTimePicker;
    dtpSchTime: TDateTimePicker;
    lbScheduler: TLabel;
    cxScheduler: TComboBox;
    cbHideSoftware: TCheckBox;
    btnChangeOrder: TButton;
    procedure Browse(Sender: TObject);
    procedure btnRetrieveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TranslateForm(Lingua: string);
    procedure cbHotKeyClick(Sender: TObject);
    procedure edtPathExeExit(Sender: TObject);
    procedure cxSchedulerChange(Sender: TObject);
    procedure btnChangeOrderClick(Sender: TObject);
    procedure cxAutoExecuteChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPropertySw :   TfrmPropertySw;

implementation

{$R *.dfm}

uses Main, CommonUtils, OrderSoftware;

procedure TfrmPropertySw.TranslateForm(Lingua:string);
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form45'] do
  begin
    Caption                := ChildNodes['Form45Caption'].Text;
    tsInfo1.Caption        := ChildNodes['TabGeneralCaption'].Text;
    tsInfo2.Caption        := ChildNodes['TabAdvancedCaption'].Text;
    tsInfo3.Caption        := ChildNodes['TabInfoCaption'].Text;
    //General
    lbInfo1.Caption        := ChildNodes['LabelInformation1'].Text;
    lbName.Caption         := ChildNodes['LabelName'].Text;
    lbVersion.Caption      := ChildNodes['LabelVersion'].Text;
    lbAuthor.Caption       := ChildNodes['LabelDeveloper'].Text;
    lbWebSite.Caption      := ChildNodes['LabelWebSite'].Text;
    btnRetrieve.Caption    := ChildNodes['ButtonRetrieve'].Text;
    lbPathExe.Caption      := ChildNodes['LabelPathExeA'].Text;
    btnBrowseExe.Caption   := ChildNodes['ButtonBrowse'].Text;
    lbParameters.Caption   := ChildNodes['LabelParameters'].Text;
    lbInfo2.Caption        := ChildNodes['LabelInformation3'].Text;
    //Execution
    lbWorkingDir.Caption   := ChildNodes['LabelWorkingDir'].Text;
    lbPathIcon.Caption     := ChildNodes['LabelPathIcon'].Text;
    btnBrowseWorkingDir.Caption  := ChildNodes['ButtonBrowse'].Text;
    btnBrowseIcon.Caption  := ChildNodes['ButtonBrowse'].Text;
    //AutoExecute
    lbAutoExecute.Caption  := ChildNodes['LabelAutoExecute'].Text;
    cxAutoExecute.Items.Add(ChildNodes['ComboBoxAutoExecute0'].Text);
    cxAutoExecute.Items.Add(ChildNodes['ComboBoxAutoExecute1'].Text);
    cxAutoExecute.Items.Add(ChildNodes['ComboBoxAutoExecute2A'].Text);
    cxAutoExecute.Items.Add(ChildNodes['ComboBoxAutoExecute3'].Text);
    btnChangeOrder.Caption := ChildNodes['ButtonChangeOrder'].Text;
    //Window State
    lbWindowState.Caption  := ChildNodes['LabelWindowState'].Text;
    cxWindowState.Items.Add(ChildNodes['ComboBoxWSNormal'].Text);
    cxWindowState.Items.Add(ChildNodes['ComboBoxWSMinimized'].Text);
    cxWindowState.Items.Add(ChildNodes['ComboBoxWSMaximized'].Text);
    cbHotKey.Caption       := ChildNodes['CheckBoxHotKey'].Text;
    //On execution
    lbActionOnExe.Caption  := ChildNodes['LabelOnExecution'].Text;
    cxActionOnExe.Items.Add(ChildNodes['ComboBoxActionOnExe0'].Text);
    cxActionOnExe.Items.Add(ChildNodes['ComboBoxActionOnExe1A'].Text);
    cxActionOnExe.Items.Add(ChildNodes['ComboBoxActionOnExe2'].Text);
    cxActionOnExe.Items.Add(ChildNodes['ComboBoxActionOnExe3'].Text);
    cbDontInsertMRU.Caption   := ChildNodes['LabelDontInsertMRUA'].Text;
    cbShortcutDesktop.Caption := ChildNodes['LabelShortcutDesktop'].Text;
    cbHideSoftware.Caption    := ChildNodes['LabelHideSoftwareMenuA'].Text;
    //Scheduler
    lbScheduler.Caption  := ChildNodes['LabelScheduler'].Text;
    cxScheduler.Items.Add(ChildNodes['ComboBoxSchedulerMode0'].Text);
    cxScheduler.Items.Add(ChildNodes['ComboBoxSchedulerMode1'].Text);
    cxScheduler.Items.Add(ChildNodes['ComboBoxSchedulerMode2'].Text);
    cxScheduler.Items.Add(ChildNodes['ComboBoxSchedulerMode3'].Text);
    //Info
    lbDesc.Caption         := ChildNodes['LabelDescription'].Text;
    lbOpinion.Caption      := ChildNodes['LabelOpinion'].Text;
    lbNotes.Caption        := ChildNodes['LabelNote'].Text;
    //Buttons
    btnOk.Caption          := ChildNodes['ButtonOk'].Text;
    btnCancel.Caption      := ChildNodes['ButtonCancel'].Text;
  end;
end;

procedure TfrmPropertySw.Browse(Sender: TObject);
var
  PathTemp : String;
begin
  if (sender = btnBrowseExe) then
  begin
    OpenDialog1.Filter     := 'Executables (*.exe)|*.exe|All files|*.*';
    OpenDialog1.InitialDir := ExtractFileDir(RelativeToAbsolute(edtPathExe.Text));
  end;
  if (sender = btnBrowseIcon) then
  begin
    OpenDialog1.Filter     := 'Files supported (*.ico;*.exe)|*.ico;*.exe|All files|*.*';
    OpenDialog1.InitialDir := ExtractFileDir(RelativeToAbsolute(edtPathIcon.Text));
  end;
  if (sender = btnBrowseExe) or
     (sender = btnBrowseIcon) then
  begin
    if (OpenDialog1.Execute) then
    begin
      PathTemp := AbsoluteToRelative(OpenDialog1.FileName);
      if (sender = btnBrowseExe) then
      begin
        edtPathExe.text    := PathTemp;
        edtPathExe.Font.Color  := clWindowText;
        edtPathExe.Hint    := '';
      end;
      if (sender = btnBrowseIcon) then
        edtPathIcon.text   := PathTemp;
    end;
  end;
  if sender = btnBrowseWorkingDir then
  begin
    PathTemp := BrowseForFolder('', RelativeToAbsolute(edtWorkingDir.Text));
    if (PathTemp <> '') then
      edtWorkingDir.Text := AbsoluteToRelative(PathTemp);
  end;
  SetCurrentDir(ApplicationPath);
end;

procedure TfrmPropertySw.btnCancelClick(Sender: TObject);
begin
  close;
  NewNode := false;
end;

procedure TfrmPropertySw.btnChangeOrderClick(Sender: TObject);
begin  
  //Autorun - Remove app and add app
  RemoveAutorunFromList(VNDataSoft);
  VNDataSoft.Autorun := cxAutoExecute.ItemIndex;
  AddAutorunInList(VNDataSoft);
  try
    //Set AutorunMode
    if (VNDataSoft.Autorun = 1) or (VNDataSoft.Autorun = 2) then
      OrderSoftware.AutorunMode := True //Startup
    else
      if (VNDataSoft.Autorun = 3) then
        OrderSoftware.AutorunMode := False; //Shutdown
    Application.CreateForm(TfrmOrderSoftware, frmOrderSoftware);
    frmOrderSoftware.showmodal;
  finally
    frmOrderSoftware.Free;
  end;
end;

procedure TfrmPropertySw.btnOkClick(Sender: TObject);
var
  I : Integer;
begin
  try
    //General
    if edtName.Text = '' then
    begin
      ShowMessage(ArrayMessages[12]);
      exit;
    end;
    if (edtPathExe.Text = '') then
      edtPathExe.Text     := '$ASuite';
    VNDataSoft.Name       := StringReplace(edtName.Text, '&&', '&', [rfIgnoreCase,rfReplaceAll]);
    VNDataSoft.Name       := StringReplace(VNDataSoft.Name, '&', '&&', [rfIgnoreCase,rfReplaceAll]);
    VNDataSoft.Version    := edtVersion.Text;
    VNDataSoft.WebSite    := edtWebSite.Text;
    VNDataSoft.Developer  := edtAuthor.Text;
    VNDataSoft.PathExe[0] := edtPathExe.Text;
    VNDataSoft.Parameters := edtParameters.Text;
    //Advanced
    VNDataSoft.WorkingDir := edtWorkingDir.Text;
    VNDataSoft.PathIcon   := edtPathIcon.Text;
    //Autorun - Remove app and add app
    RemoveAutorunFromList(VNDataSoft);
    VNDataSoft.Autorun     := cxAutoExecute.ItemIndex;
    AddAutorunInList(VNDataSoft);
    VNDataSoft.ActionOnExe := cxActionOnExe.ItemIndex;
    //Others
    VNDataSoft.DontInsertMRU := cbDontInsertMRU.Checked;
    VNDataSoft.HideSoftwareMenu := cbHideSoftware.Checked;
    //Delete MRU entry if DontInsertMRU = true
    if (VNDataSoft.DontInsertMRU) then
      MRUList.Remove(VNDataSoft.pNode);
    if LauncherOptions.HotKey then
    begin
      //Unregister hotkey (if actived)
      if (VNDataSoft.HotKey) then
      begin
        for I := 0 to Length(HotKeyApp) - 1 do
          if HotKeyApp[I] = VNDataSoft.pNode then
            UnRegisterHotKey(frmMain.Handle, I)
      end;
      //Register hotkey
      VNDataSoft.HKModifier := cxHotKey1.ItemIndex;
      VNDataSoft.HKCode     := cxHotKey2.ItemIndex;
      if (cbHotKey.Checked) then
      begin
        if AddHotkey(frmMain.vstList,VNDataSoft.pNode,length(HotKeyApp)) = 0 then
        begin
          ShowMessage(ArrayMessages[22]);
          cbHotKey.Checked := false;
          exit;
        end;
      end;
    end;
    VNDataSoft.HotKey      := cbHotKey.Checked;
    VNDataSoft.WindowState := cxWindowState.ItemIndex;
    //Scheduler
    //Add software in SchedulerApp
    if (cxScheduler.ItemIndex <> 0) and (VNDataSoft.SchMode = 0) then
    begin
      SetLength(SchedulerApp,Length(SchedulerApp) + 1);
      SchedulerApp[Length(SchedulerApp) - 1] := VNDataSoft.pNode;
    end;
    //Remove software from SchedulerApp
    if (cxScheduler.ItemIndex = 0) and (VNDataSoft.SchMode <> 0) then
    begin
      for I := 0 to Length(SchedulerApp) do
        if (SchedulerApp[I] = VNDataSoft.pNode) then
          SchedulerApp[I] := nil;
    end;
    VNDataSoft.SchMode := cxScheduler.ItemIndex;
    VNDataSoft.SchDate := FormatDateTime('dd/mm/yyyy',dtpSchDate.Date);
    VNDataSoft.SchTime := FormatDateTime(LongTimeFormat,dtpSchTime.Time);
    //Info
    VNDataSoft.Desc    := StringReplace(memDesc.Text,#13#10,'[br]',[rfReplaceAll]);
    VNDataSoft.Opinion := StringReplace(memOpinion.Text,#13#10,'[br]',[rfReplaceAll]);
    VNDataSoft.Notes   := StringReplace(memNotes.Text,#13#10,'[br]',[rfReplaceAll]);
    //Create shortcut on desktop
    if Not(VNDataSoft.ShortcutDesktop = cbShortcutDesktop.Checked) then
      if (cbShortcutDesktop.Checked) then
        CreateShortcutOnDesktop('\' + VNDataSoft.Name + '.lnk', VNDataSoft.PathExe[0],VNDataSoft.Parameters,VNDataSoft.WorkingDir)
      else
        DeleteShortcutOnDesktop('\' + VNDataSoft.Name + '.lnk');
    VNDataSoft.ShortcutDesktop := cbShortcutDesktop.Checked;
    if Not(FileFolderPageWebNotExists(frmmain.vstList,VNDataSoft.pNode)) then
      VNDataSoft.ImageIndex    := IconAdd(frmMain.vstList, frmMain.ImageList1, VNDataSoft.pNode);
    NewNode := true;
  except                           
    on E : Exception do
    begin
      ShowMessageFmt(ArrayMessages[11],[E.ClassName,E.Message]);
      NewNode := false;
      close;
    end;
  end;
  close;
end;

procedure TfrmPropertySw.btnRetrieveClick(Sender: TObject);
var
  FvI     : TFileVersionInfo;
  PathExe : String;
begin
  PathExe := RelativeToAbsolute(edtPathExe.text);
  if Not((PathExe = '') and Not(FileExists(PathExe))) then
  begin
    FvI.FileVersionInfo(PathExe);
    if (FvI.ProductName <> '') then
      edtName.Text     := FvI.ProductName;
    if (FvI.CompanyName <> '') then
      edtAuthor.Text   := FvI.CompanyName;
    if (FvI.ProductVersion <> '') then
      edtVersion.Text := StringReplace(FvI.ProductVersion,', ','.',[rfReplaceAll]);
  end
  else
    showmessage(ArrayMessages[01]);
end;

procedure TfrmPropertySw.cbHotKeyClick(Sender: TObject);
begin
  cxHotKey1.Enabled := cbHotKey.Checked;
  cxHotKey2.Enabled := cbHotKey.Checked;
end;

procedure TfrmPropertySw.cxAutoExecuteChange(Sender: TObject);
begin
  btnChangeOrder.Enabled := (cxAutoExecute.ItemIndex <> 0);
end;

procedure TfrmPropertySw.cxSchedulerChange(Sender: TObject);
begin
  if cxScheduler.ItemIndex <> 0 then
    dtpSchTime.Enabled := True;
  if cxScheduler.ItemIndex <> 1 then
    dtpSchDate.Enabled := False;
  if cxScheduler.ItemIndex <> 2 then
    dtpSchTime.Format  := 'HH.mm.ss';
  case cxScheduler.ItemIndex of
    0: dtpSchTime.Enabled := False;
    1: dtpSchDate.Enabled := True;
    2: dtpSchTime.Format  := 'mm.ss';
  end;
end;

procedure TfrmPropertySw.edtPathExeExit(Sender: TObject);
var
  PathTemp : String;
begin
  PathTemp := RelativeToAbsolute(edtPathExe.Text);
  if Not((FileExists(PathTemp)) or (DirectoryExists(PathTemp)) or
   (pos('http://',PathTemp) = 1) or (pos('https://',PathTemp) = 1) or
   (pos('ftp://',PathTemp) = 1) or (pos('www.',PathTemp) = 1)) then
  begin
    edtPathExe.Font.Color  := clRed;
    edtPathExe.Hint        := ArrayMessages[1];
  end
  else begin
    edtPathExe.Font.Color  := clBlack;
    edtPathExe.Hint        := '';
  end;
end;

procedure TfrmPropertySw.FormCreate(Sender: TObject);
begin
  TranslateForm(LauncherOptions.LangName);
  PageControl1.ActivePageIndex := 0;
  try
    //Card: General
    edtName.Text       := VNDataSoft.name;
    edtVersion.Text    := VNDataSoft.Version;
    if VNDataSoft.WebSite = '' then
      edtWebSite.Text  := 'http://'
    else
      edtWebSite.Text  := VNDataSoft.WebSite;
    edtAuthor.Text     := VNDataSoft.Developer;
    edtPathExe.Text    := VNDataSoft.PathExe[0];
    if FileFolderPageWebNotExists(frmMain.vstList,VNDataSoft.pNode) then
    begin
       edtPathExe.Font.Color  := clRed;
       edtPathExe.Hint        := ArrayMessages[1];
    end;
    edtParameters.Text := VNDataSoft.Parameters;
    //Card: Esecuzione
    edtWorkingDir.Text := VNDataSoft.WorkingDir;
    edtPathIcon.Text   := VNDataSoft.PathIcon;
    cxActionOnExe.ItemIndex   := VNDataSoft.ActionOnExe;
    cxAutoExecute.ItemIndex   := VNDataSoft.Autorun;
    btnChangeOrder.Enabled := (cxAutoExecute.ItemIndex <> 0);
    //Hotkey
    cbHotKey.Checked  := VNDataSoft.HotKey;
    cbHotKey.Enabled  := LauncherOptions.HotKey;
    cxHotKey1.Enabled := (cbHotKey.Checked) And (LauncherOptions.HotKey);
    cxHotKey2.Enabled := (cbHotKey.Checked) And (LauncherOptions.HotKey);
    if VNDataSoft.HKModifier <> -1 then
      cxHotKey1.ItemIndex := VNDataSoft.HKModifier
    else
      cxHotKey1.ItemIndex := 0;
    if VNDataSoft.HKCode <> -1 then
      cxHotKey2.ItemIndex := VNDataSoft.HKCode
    else
      cxHotKey2.ItemIndex := 0;
    //Window State
    if (VNDataSoft.WindowState <> -1) and Not(VNDataSoft.WindowState >= 4) then
      cxWindowState.ItemIndex := VNDataSoft.WindowState
    else
      cxWindowState.ItemIndex := 0;
    //Scheduler
    cxScheduler.ItemIndex  := VNDataSoft.SchMode;
    if VNDataSoft.SchDate <> '' then
      dtpSchDate.Date := StrToDate(VNDataSoft.SchDate)
    else
      dtpSchDate.Date := Date;
    if VNDataSoft.SchTime <> '' then
      dtpSchTime.Time := StrToTime(VNDataSoft.SchTime)
    else
      dtpSchTime.Time := Time;
    cxSchedulerChange(Sender);
    //Others
    cbDontInsertMRU.Checked   := VNDataSoft.DontInsertMRU;
    cbShortcutDesktop.Checked := VNDataSoft.ShortcutDesktop;
    cbHideSoftware.Checked    := VNDataSoft.HideSoftwareMenu;
    //Card: Info
    memDesc.Text    := VNDataSoft.Desc;
    memOpinion.Text := VNDataSoft.Opinion;
    memNotes.Text   := VNDataSoft.Notes;
  except
    on E : Exception do
      ShowMessageFmt(ArrayMessages[11],[E.ClassName,E.Message]);
  end;
end;

end.
