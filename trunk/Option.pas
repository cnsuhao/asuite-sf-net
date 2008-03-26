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

unit Option;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Main;

type
  TfrmOption = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    gbWindow: TGroupBox;
    lbLanguage: TLabel;
    cxLanguage: TComboBox;
    cxWindowHotKeyCode: TComboBox;
    cxWindowHotKeyMod: TComboBox;
    cbWindowHotKey: TCheckBox;
    cbWindowOnTop: TCheckBox;
    cbFormCard: TCheckBox;
    cbHoldSize: TCheckBox;
    gbTreeView: TGroupBox;
    gbStartup: TGroupBox;
    cbWindowsStartup: TCheckBox;
    cbShowStartup: TCheckBox;
    cbAutorun: TCheckBox;
    TabSheet2: TTabSheet;
    gbRecents: TGroupBox;
    lbMaxMRU: TLabel;
    lbNumbMRU: TLabel;
    cbMRU: TCheckBox;
    cbSubMenuMRU: TCheckBox;
    tbMRU: TTrackBar;
    gbBackup: TGroupBox;
    lbMaxBackup: TLabel;
    lbNumbBackup: TLabel;
    cbBackup: TCheckBox;
    tbBackup: TTrackBar;
    gbOtherFunctions: TGroupBox;
    cbSaveSecurity: TCheckBox;
    cbCache: TCheckBox;
    cbHotKey: TCheckBox;
    TabSheet3: TTabSheet;
    gbExecution: TGroupBox;
    lbActionOnExe: TLabel;
    cbRunSingleClick: TCheckBox;
    cxActionOnExe: TComboBox;
    gbTrayicon: TGroupBox;
    lbTrayLeftClick: TLabel;
    cxLeftClick: TComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    gbMouse: TGroupBox;
    lbSide: TLabel;
    lbLeftClick: TLabel;
    lbRightClick: TLabel;
    lbTop: TLabel;
    lbLeft: TLabel;
    lbRight: TLabel;
    lbBottom: TLabel;
    cxLCTop: TComboBox;
    cxLCLeft: TComboBox;
    cxLCRight: TComboBox;
    cxLCBottom: TComboBox;
    cxRCTop: TComboBox;
    cxRCBottom: TComboBox;
    cxRCRight: TComboBox;
    cxRCLeft: TComboBox;
    OpenDialog1: TOpenDialog;
    cbBackground: TCheckBox;
    FontDialog1: TFontDialog;
    btnFontSettings: TButton;
    btnCustomTrayIcon: TButton;
    cbScheduler: TCheckBox;
    gbCheckList: TGroupBox;
    lbCheckList: TLabel;
    lbNumbCheckList: TLabel;
    cbCheckList: TCheckBox;
    tbCheckList: TTrackBar;
    edtBackground: TEdit;
    btnBrowseBackground: TButton;
    cbCustomTitle: TCheckBox;
    edtCustomTitle: TEdit;
    cbMenuFade: TCheckBox;
    lbMenuTheme: TLabel;
    cxTheme: TComboBox;
    cbTrayicon: TCheckBox;
    cbHideSearch: TCheckBox;
    cbHideStats: TCheckBox;
    cbClassicMenu: TCheckBox;
    btnMenuFolders: TButton;
    cxRightClick: TComboBox;
    lbTrayRightClick: TLabel;
    cbMenuHotKey: TCheckBox;
    cxMenuHotKeyCode: TComboBox;
    cxMenuHotKeyMod: TComboBox;
    cbMenuStartup: TCheckBox;
    cbAutoOpClCat: TCheckBox;
    gbClearElements: TGroupBox;
    lbClearElements: TLabel;
    btnClearElements: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tbMRUChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TranslateForm(Lingua:string);
    procedure tbBackupChange(Sender: TObject);
    procedure cbWindowHotKeyClick(Sender: TObject);
    procedure cbHotKeyClick(Sender: TObject);
    procedure Browse(Sender: TObject);
    procedure cbBackgroundClick(Sender: TObject);
    procedure btnFontSettingsClick(Sender: TObject);
    procedure cbTrayiconClick(Sender: TObject);
    procedure tbCheckListChange(Sender: TObject);
    procedure cbCustomTitleClick(Sender: TObject);
    procedure btnClearElementsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbClassicMenuClick(Sender: TObject);
    procedure cxThemeExit(Sender: TObject);
    procedure btnMenuFoldersClick(Sender: TObject);
    procedure cbMenuHotKeyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOption: TfrmOption;

implementation

uses CommonUtils, ClearElements, Menu, MenuFolders;

{$R *.dfm}

procedure TfrmOption.TranslateForm(Lingua:string);
var
  I : Integer;
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form3'] do
  begin
    Caption                 := ChildNodes['Form3Caption'].Text;
    //General
    TabSheet1.caption       := ChildNodes['TabGeneralCaption'].Text;
    //Startup
    gbStartup.caption       := ChildNodes['GroupBoxStartup'].Text;
    cbWindowsStartup.caption := ChildNodes['CheckBoxWindowsStartup'].Text;
    cbShowStartup.caption   := ChildNodes['CheckBoxStartUp'].Text;
    cbMenuStartup.caption   := ChildNodes['CheckBoxMenuStartUp'].Text;
    cbAutorun.caption       := ChildNodes['CheckBoxAutorun'].Text;
    //Window
    gbWindow.caption        := ChildNodes['GroupBoxWindow'].Text;
    cbHoldSize.caption      := ChildNodes['CheckBoxHoldSize'].Text;
    cbFormCard.caption      := ChildNodes['CheckBoxFormCard'].Text;
    cbWindowOnTop.caption   := ChildNodes['CheckBoxWindowOnTop'].Text;
    cbWindowHotKey.caption  := ChildNodes['CheckBoxWindowHotkey'].Text;
    cbMenuHotKey.caption    := ChildNodes['CheckBoxMenuHotkey'].Text;
    cbCustomTitle.caption   := ChildNodes['CheckBoxCustomTitle'].Text;
    lbLanguage.caption      := ChildNodes['LabelLanguage'].Text;
    cbHideSearch.caption    := ChildNodes['CheckBoxHideSearch'].Text;
    cbHideStats.caption     := ChildNodes['CheckBoxHideStats'].Text;
    //Treeview
    gbTreeView.caption      := ChildNodes['GroupBoxTreeView'].Text;
    cbAutoOpClCat.caption   := ChildNodes['CheckBoxAutoOpClCat'].Text;
    btnFontSettings.caption := ChildNodes['ButtonFontSettings'].Text;
    cbBackground.caption    := ChildNodes['CheckBoxBackground'].Text;
    btnBrowseBackground.caption := ChildNodes['ButtonBrowseBackground'].Text;

    //Advanced
    TabSheet2.caption       := ChildNodes['TabAdvancedCaption'].Text;
    //MRU
    gbRecents.caption       := ChildNodes['GroupBoxMRU'].Text;
    cbMRU.caption           := ChildNodes['CheckBoxMRU'].Text;
    cbSubMenuMRU.caption    := ChildNodes['CheckBoxSubMenuMRU'].Text;
    lbMaxMRU.caption        := ChildNodes['LabelMRUMax'].Text;
    //Backup
    gbBackup.caption        := ChildNodes['GroupBoxBackup'].Text;
    cbBackup.caption        := ChildNodes['CheckBoxBackup'].Text;
    lbMaxBackup.caption     := ChildNodes['LabelBackupMax'].Text;
    //Clear elements
    gbClearElements.caption := ChildNodes['GroupBoxClearElements'].Text;
    lbClearElements.caption := ChildNodes['LabelClearElements'].Text;
    btnClearElements.caption := ChildNodes['ButtonClearElements'].Text;
    //Check list
    gbCheckList.caption     := ChildNodes['GroupBoxCheckList'].Text;
    cbCheckList.caption     := ChildNodes['CheckBoxCheckList'].Text;
    lbCheckList.caption     := ChildNodes['LabelCheckListTime'].Text;
    //Other functions
    gbOtherFunctions.caption := ChildNodes['GroupBoxOtherFunctions'].Text;
    cbHotKey.caption        := ChildNodes['CheckBoxHotKey'].Text;
    cbCache.caption         := ChildNodes['CheckBoxCache'].Text;
    cbSaveSecurity.caption  := ChildNodes['CheckBoxSaveSecurity'].Text;
    cbScheduler.caption     := ChildNodes['CheckBoxScheduler'].Text;

    //Various
    TabSheet3.caption       := ChildNodes['TabVariousCaption'].Text;
    //Execution
    gbExecution.caption     := ChildNodes['GroupBoxExecution'].Text;
    cbRunSingleClick.caption := ChildNodes['CheckBoxSingleClick'].Text;
    lbActionOnExe.caption   := ChildNodes['LabelActionOnExe'].Text;
    cxActionOnExe.Items.Clear;
    for I := 1 to 3 do
      cxActionOnExe.Items.Add(ChildNodes['ListActionOnExe' + IntToStr(I)].Text);
    //System Tray
    gbTrayicon.caption      := ChildNodes['GroupBoxTrayicon'].Text;
    cbTrayicon.caption      := ChildNodes['CheckBoxTrayicon'].Text;
    btnCustomTrayIcon.caption := ChildNodes['ButtonCustomTrayicon'].Text;
    lbTrayRightClick.caption := ChildNodes['LabelRightClick'].Text;
    lbTrayLeftClick.caption := ChildNodes['LabelLeftClick'].Text;
    cxLeftClick.Items.Clear;
    cxRightClick.Items.Clear;
    for I := 1 to 3 do
    Begin
      cxLeftClick.Items.Add(ChildNodes['ListActionTrayicon' + IntToStr(I)].Text);
      cxRightClick.Items.Add(ChildNodes['ListActionTrayicon' + IntToStr(I)].Text);
    end;
    cbClassicMenu.Caption  := ChildNodes['CheckBoxClassicMenu'].Text;
    //Only default menu
    lbMenuTheme.Caption    := ChildNodes['LabelMenuTheme'].Text;
    cbMenuFade.Caption     := ChildNodes['CheckBoxMenuFade'].Text;
    btnMenuFolders.Caption := ChildNodes['ButtonMenuFolders'].Text;
    //Mouse
    gbMouse.caption      := ChildNodes['GroupBoxMouse'].Text;
    //Side
    lbSide.caption       := ChildNodes['LabelSide'].Text;
    lbTop.caption        := ChildNodes['LabelTop'].Text;
    lbLeft.caption       := ChildNodes['LabelLeft'].Text;
    lbRight.caption      := ChildNodes['LabelRight'].Text;
    lbBottom.caption     := ChildNodes['LabelBottom'].Text;
    lbLeftClick.caption  := ChildNodes['LabelLeftClick'].Text;
    lbRightClick.caption := ChildNodes['LabelRightClick'].Text;
    for I := 1 to 4 do
    begin
      //Left Click
      cxLCTop.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
      cxLCLeft.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
      cxLCRight.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
      cxLCBottom.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
      //Right Click
      cxRCTop.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
      cxRCLeft.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
      cxRCRight.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
      cxRCBottom.Items.Add(ChildNodes['ListActionMouse' + IntToStr(I)].Text);
    end;
    
    btnOk.caption           := ChildNodes['ButtonOk'].Text;
    btnCancel.caption       := ChildNodes['ButtonCancel'].Text;
  end;
end;

procedure TfrmOption.Browse(Sender: TObject);  
var
  PathTemp : String;
begin
  if (Sender = btnBrowseBackground) then
  begin
    OpenDialog1.Filter     := 'Files supported (*.png;*.jpg;*.jpeg;*.bmp)|*.jpg;*.jpeg;*.bmp|All files|*.*';
    OpenDialog1.InitialDir := ExtractFileDir(RelativeToAbsolute(edtBackground.Text));
  end;  
  if (Sender = btnCustomTrayIcon) then
  begin
    OpenDialog1.Filter     := 'Files supported (*.ico)|*.ico';
    OpenDialog1.InitialDir := ExtractFileDir(RelativeToAbsolute(LauncherOptions.TrayIconPath));
  end;
  if (OpenDialog1.Execute) then
  begin
    PathTemp := AbsoluteToRelative(OpenDialog1.FileName);
    if (Sender = btnBrowseBackground) then
    begin
      LauncherOptions.BackgroundPath := PathTemp;
      edtBackground.Text     := PathTemp;
    end;
    if (Sender = btnCustomTrayIcon) then
      LauncherOptions.TrayIconPath   := PathTemp;
  end;
  SetCurrentDir(ApplicationPath);
end;

procedure TfrmOption.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmOption.btnMenuFoldersClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmMenuFolders, frmMenuFolders);
    frmMenuFolders.showmodal;
  finally
    frmMenuFolders.Free;
  end;
end;

procedure TfrmOption.btnOkClick(Sender: TObject);
var
  BackupSearch : TSearchRec;
  BackupList   : TStringList;
  I            : Integer;
begin
  //General
  LauncherOptions.AutoOpClCats     := cbAutoOpClCat.Checked;
  LauncherOptions.WindowsStartup   := cbWindowsStartup.Checked;
  LauncherOptions.StartUpShowPanel := cbShowStartup.Checked;
  LauncherOptions.StartUpShowMenu  := cbMenuStartup.Checked;
  LauncherOptions.ActiveFormCard   := cbFormCard.Checked;
  LauncherOptions.HoldSize         := cbHoldSize.Checked;
  LauncherOptions.MainOnTop        := cbWindowOnTop.Checked;
  LauncherOptions.CustomTitle      := cbCustomTitle.Checked;
  LauncherOptions.CustomTitleString := edtCustomTitle.Text;
  if LauncherOptions.HotKey then
  begin
    //Unregister hotkey (if actived)
    if (LauncherOptions.HotKey) then
    begin
      UnregisterHotKey(frmMain.Handle, frmMain.Handle);
      UnregisterHotKey(frmMain.Handle, frmMenuID);
    end;
    //Register hotkey
    LauncherOptions.WindowHotkeyMod  := cxWindowHotKeyMod.ItemIndex;
    LauncherOptions.WindowHotkeyCode := cxWindowHotKeyCode.ItemIndex;
    if (cbWindowHotKey.Checked) then
    begin
      if Not(RegisterHotKey(frmMain.Handle, frmMain.Handle,
                            GetHotKeyMod(LauncherOptions.WindowHotKeyMod),
                            GetHotKeyCode(LauncherOptions.WindowHotKeyCode))) then
      begin
        ShowMessage(ArrayMessages[22]);
        cbWindowHotKey.Checked := false;
        exit;
      end;
    end;
    //Register Menuhotkey
    LauncherOptions.MenuHotkeyMod  := cxMenuHotKeyMod.ItemIndex;
    LauncherOptions.MenuHotkeyCode := cxMenuHotKeyCode.ItemIndex;
    if (cbMenuHotKey.Checked) then
    begin
      if Not(RegisterHotKey(frmMain.Handle, frmMenuID,
                            GetHotKeyMod(LauncherOptions.MenuHotKeyMod),
                            GetHotKeyCode(LauncherOptions.MenuHotKeyCode))) then
      begin
        ShowMessage(ArrayMessages[22]);
        cbWindowHotKey.Checked := false;
        exit;
      end;
    end;
  end;
  LauncherOptions.WindowHotkey     := cbWindowHotKey.Checked;
  LauncherOptions.WindowHotKeyMod  := cxWindowHotKeyMod.ItemIndex;
  LauncherOptions.WindowHotKeyCode := cxWindowHotKeyCode.ItemIndex;
  LauncherOptions.MenuHotkey     := cbMenuHotKey.Checked;
  LauncherOptions.MenuHotKeyMod  := cxMenuHotKeyMod.ItemIndex;
  LauncherOptions.MenuHotKeyCode := cxMenuHotKeyCode.ItemIndex;

  LauncherOptions.LangName         := cxLanguage.Items[cxLanguage.ItemIndex];
  //Hide tabs
  LauncherOptions.HideSearch  := cbHideSearch.Checked;
  LauncherOptions.HideStats   := cbHideStats.Checked;
  //Treeview Font
  with FontDialog1.Font do
  begin
    LauncherOptions.FontName  := Name;
    LauncherOptions.FontStyle := Style;
    LauncherOptions.FontSize  := Size;
    LauncherOptions.FontColor := Color;
  end;
  LauncherOptions.FontChanged := True;
  LauncherOptions.Background  := cbBackground.Checked;
  LauncherOptions.BackgroundPath := edtBackground.Text;
  //MRU
  LauncherOptions.MRU        := cbMRU.Checked;
  LauncherOptions.SubMenuMRU := cbSubMenuMRU.Checked;
  LauncherOptions.MRUNumber  := tbMRU.Position;
  MRUList.SetMaxItems(LauncherOptions.MRUNumber);
  //Backup
  LauncherOptions.Backup      := cbBackup.Checked;
  //Delete backup useless
  BackupList := TStringList.Create;
  if tbBackup.Position < LauncherOptions.BackupNumber then
  begin
    if FindFirst(ApplicationPath + 'Backup\ASuite_*.bck', faAnyFile, BackupSearch) = 0 then
    begin
      repeat
        BackupList.Add(BackupSearch.Name);
      until
        FindNext(BackupSearch) <> 0;
      FindClose(BackupSearch);
    end;
    for I := 1 to BackupList.Count - tbBackup.Position do
      DeleteFile('Backup\' + BackupList[I]);
  end;
  BackupList.Free;
  LauncherOptions.BackupNumber    := tbBackup.Position;
  //Check list
  LauncherOptions.CheckList       := cbCheckList.Checked;
  LauncherOptions.CheckListTime   := tbCheckList.Position;
  //Various
  LauncherOptions.ActionOnExe     := cxActionOnExe.ItemIndex;
  LauncherOptions.RunSingleClick  := cbRunSingleClick.Checked;
  LauncherOptions.HotKey          := cbHotKey.Checked;
  LauncherOptions.Autorun         := cbAutorun.Checked;
  LauncherOptions.Cache           := cbCache.Checked;
  LauncherOptions.SaveSecurity    := cbSaveSecurity.Checked;
  LauncherOptions.Scheduler       := cbScheduler.Checked;
  //Trayicon
  LauncherOptions.TrayIcon        := cbTrayicon.Checked;
  LauncherOptions.ActionClickLeft := cxLeftClick.ItemIndex;
  LauncherOptions.ActionClickRight := cxRightClick.ItemIndex;
  LauncherOptions.TrayIconClassicMenu := cbClassicMenu.Checked;
  //Only default menu
  LauncherOptions.MenuTheme        := cxTheme.Items[cxTheme.ItemIndex];
  LauncherOptions.MenuFade         := cbMenuFade.Checked;
  //Sensor
  //Left
  LauncherOptions.SensorLeftClick[0]  := cxLCTop.ItemIndex;
  LauncherOptions.SensorLeftClick[1]  := cxLCLeft.ItemIndex;
  LauncherOptions.SensorLeftClick[2]  := cxLCRight.ItemIndex;
  LauncherOptions.SensorLeftClick[3]  := cxLCBottom.ItemIndex;
  //Right
  LauncherOptions.SensorRightClick[0] := cxRCTop.ItemIndex;
  LauncherOptions.SensorRightClick[1] := cxRCLeft.ItemIndex;
  LauncherOptions.SensorRightClick[2] := cxRCRight.ItemIndex;
  LauncherOptions.SensorRightClick[3] := cxRCBottom.ItemIndex;
  UpdateOptions;
  Close;
end;

procedure TfrmOption.btnFontSettingsClick(Sender: TObject);
begin
  FontDialog1.Execute;
end;

procedure TfrmOption.cbBackgroundClick(Sender: TObject);
begin
  edtBackground.Enabled       := cbBackground.Checked;
  btnBrowseBackground.Enabled := cbBackground.Checked;
end;

procedure TfrmOption.cbClassicMenuClick(Sender: TObject);
begin
  if cbMenuStartup.Checked then
    cbMenuStartup.Checked := Not(cbClassicMenu.Checked);
  cbMenuStartup.Enabled  := Not(cbClassicMenu.Checked);
  cxTheme.Enabled        := Not(cbClassicMenu.Checked);
  btnMenuFolders.Enabled := Not(cbClassicMenu.Checked);
  cbMenuFade.Enabled     := Not(cbClassicMenu.Checked);
  cbSubMenuMRU.Enabled   := cbClassicMenu.Checked;
  if Not(cbClassicMenu.Checked) then
    LauncherOptions.RefreshMenuTheme := True;
end;

procedure TfrmOption.cbCustomTitleClick(Sender: TObject);
begin
  edtCustomTitle.Enabled := cbCustomTitle.Checked;
end;

procedure TfrmOption.cbHotKeyClick(Sender: TObject);
begin
  cbWindowHotKey.Enabled     := cbHotkey.Checked;
  if cbWindowHotKey.Checked then
  begin
    cxWindowHotKeyMod.Enabled  := cbHotkey.Checked;
    cxWindowHotKeyCode.Enabled := cbHotkey.Checked;
  end;
end;

procedure TfrmOption.cbMenuHotKeyClick(Sender: TObject);
begin
cxMenuHotKeyMod.Enabled  := cbMenuHotKey.Checked;
  cxMenuHotKeyCode.Enabled := cbMenuHotKey.Checked;
end;

procedure TfrmOption.cbTrayiconClick(Sender: TObject);
begin
  btnCustomTrayIcon.Enabled := cbTrayicon.Checked;
  cxLeftClick.Enabled       := cbTrayicon.Checked;
  cxRightClick.Enabled      := cbTrayicon.Checked;
end;

procedure TfrmOption.cbWindowHotKeyClick(Sender: TObject);
begin
  cxWindowHotKeyMod.Enabled  := cbWindowHotKey.Checked;
  cxWindowHotKeyCode.Enabled := cbWindowHotKey.Checked;
end;

procedure TfrmOption.cxThemeExit(Sender: TObject);
begin
  LauncherOptions.RefreshMenuTheme := LauncherOptions.MenuTheme <> cxTheme.Items[cxTheme.ItemIndex];
end;

procedure TfrmOption.btnClearElementsClick(Sender: TObject);
begin   
  try
    Application.CreateForm(TfrmClearElements, frmClearElements);
    frmClearElements.showmodal;
  finally
    frmClearElements.Free;
  end;
end;

procedure TfrmOption.FormActivate(Sender: TObject);
begin
  if IsFormOpen('frmMenu') then
    frmMenu.CloseMenu;
end;

procedure TfrmOption.FormCreate(Sender: TObject);
var
  searchResult : TSearchRec;
begin
  TranslateForm(LauncherOptions.LangName);
  PageControl1.TabIndex      := 0;
  //General
  cbAutoOpClCat.Checked      := LauncherOptions.AutoOpClCats;
  cbWindowsStartup.Checked   := LauncherOptions.WindowsStartup;
  cbShowStartup.Checked      := LauncherOptions.StartUpShowPanel;
  cbMenuStartup.Checked      := LauncherOptions.StartUpShowMenu;
  cbFormCard.Checked         := LauncherOptions.ActiveFormCard;
  cbHoldSize.Checked         := LauncherOptions.HoldSize;
  cbWindowOnTop.Checked      := LauncherOptions.MainOnTop;
  cbCustomTitle.Checked      := LauncherOptions.CustomTitle;
  edtCustomTitle.Text        := LauncherOptions.CustomTitleString;
  edtCustomTitle.Enabled     := LauncherOptions.CustomTitle;
  //Window's Hotkey
  cbWindowHotKey.Checked     := LauncherOptions.WindowHotkey;
  cbWindowHotKey.Enabled     := LauncherOptions.HotKey;
  cxWindowHotKeyMod.Enabled  := (cbWindowHotKey.Checked) And (LauncherOptions.WindowHotkey);
  cxWindowHotKeyCode.Enabled := (cbWindowHotKey.Checked) And (LauncherOptions.WindowHotkey);
  if LauncherOptions.WindowHotKeyMod <> -1 then
    cxWindowHotKeyMod.ItemIndex := LauncherOptions.WindowHotKeyMod
  else
    cxWindowHotKeyMod.ItemIndex := 0;
  if LauncherOptions.WindowHotKeyCode <> -1 then
    cxWindowHotKeyCode.ItemIndex := LauncherOptions.WindowHotKeyCode
  else
    cxWindowHotKeyCode.ItemIndex := 0;
   //Window's menu Hotkey
  cbMenuHotKey.Checked     := LauncherOptions.MenuHotkey;
  cbMenuHotKey.Enabled     := LauncherOptions.HotKey;
  cxMenuHotKeyMod.Enabled  := (cbMenuHotKey.Checked) And (LauncherOptions.MenuHotkey);
  cxMenuHotKeyCode.Enabled := (cbMenuHotKey.Checked) And (LauncherOptions.MenuHotkey);
  if LauncherOptions.MenuHotKeyMod <> -1 then
    cxMenuHotKeyMod.ItemIndex := LauncherOptions.MenuHotKeyMod
  else
    cxMenuHotKeyMod.ItemIndex := 0;
  if LauncherOptions.MenuHotKeyCode <> -1 then
    cxMenuHotKeyCode.ItemIndex := LauncherOptions.MenuHotKeyCode
  else
    cxMenuHotKeyCode.ItemIndex := 0;

  //Languages
  if FindFirst(ApplicationPath + 'Lang\*.xml', faAnyFile, searchResult) = 0 then
  begin
    repeat
      cxLanguage.AddItem(SearchResult.Name,sender);
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
  if FindFirst(ApplicationPath + '*.xml', faAnyFile, searchResult) = 0 then
  begin
    repeat
      if (SearchResult.Name <> LauncherFileNameXML) and ((SearchResult.Name <> 'ASuiteTemp.xml')) then
        cxLanguage.AddItem(SearchResult.Name,sender);
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
  cxLanguage.ItemIndex   := cxLanguage.Items.IndexOf(LauncherOptions.LangName);
  //Hide tabs
  cbHideSearch.Checked   := LauncherOptions.HideSearch;
  cbHideStats.Checked    := LauncherOptions.HideStats;
  //Treeview Font
  with FontDialog1.Font do
  begin
    Name   := LauncherOptions.FontName;
    Style  := LauncherOptions.FontStyle;
    Size   := LauncherOptions.FontSize;
    Color  := LauncherOptions.FontColor;
  end;
  cbBackground.Checked   := LauncherOptions.Background; 
  edtBackground.Enabled  := LauncherOptions.Background;
  btnBrowseBackground.Enabled := LauncherOptions.Background;
  edtBackground.Text     := LauncherOptions.BackgroundPath;
  //MRU
  cbMRU.Checked          := LauncherOptions.MRU;
  cbSubMenuMRU.Checked   := LauncherOptions.SubMenuMRU;
  tbMRU.position         := LauncherOptions.MRUNumber;
  lbNumbMRU.Caption      := IntToStr(LauncherOptions.MRUNumber);
  //Backup
  cbBackup.Checked       := LauncherOptions.Backup;
  tbBackup.position      := LauncherOptions.BackupNumber;
  lbNumbBackup.Caption   := IntToStr(LauncherOptions.BackupNumber);
  //Check list
  cbCheckList.Checked    := LauncherOptions.CheckList;
  tbCheckList.Position   := LauncherOptions.CheckListTime;
  lbNumbCheckList.Caption  := IntToStr(LauncherOptions.CheckListTime);
  //Various
  cxActionOnExe.ItemIndex  := LauncherOptions.ActionOnExe;
  cbRunSingleClick.Checked := LauncherOptions.RunSingleClick;
  cbHotKey.Checked       := LauncherOptions.HotKey;
  cbAutorun.Checked      := LauncherOptions.Autorun;
  cbCache.Checked        := LauncherOptions.Cache;
  cbSaveSecurity.Checked := LauncherOptions.SaveSecurity;
  cbScheduler.Checked    := LauncherOptions.Scheduler;
  //Trayicon
  cbTrayicon.Checked     := LauncherOptions.TrayIcon;
  cxLeftClick.ItemIndex  := LauncherOptions.ActionClickLeft;
  cxRightClick.ItemIndex := LauncherOptions.ActionClickRight;
  cxLeftClick.Enabled    := cbTrayicon.Checked;
  cxRightClick.Enabled   := cbTrayicon.Checked;
  cbClassicMenu.Checked  := LauncherOptions.TrayIconClassicMenu;
  //Only default menu
  if FindFirst(ApplicationPath + 'MenuThemes\*.*', faDirectory, searchResult) = 0 then
  begin
    repeat
      if ((searchResult.Name <> '.') and (searchResult.Name <> '..')) and
         ((searchResult.Attr and faDirectory) = (faDirectory)) then
        cxTheme.AddItem(SearchResult.Name,sender);
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
  cxTheme.ItemIndex      := cxTheme.Items.IndexOf(LauncherOptions.MenuTheme);
  cbMenuFade.Checked     := LauncherOptions.MenuFade;
  btnCustomTrayIcon.Enabled := cbTrayicon.Checked;
  //Sensor
  //Left
  cxLCTop.ItemIndex    := LauncherOptions.SensorLeftClick[0];
  cxLCLeft.ItemIndex   := LauncherOptions.SensorLeftClick[1];
  cxLCRight.ItemIndex  := LauncherOptions.SensorLeftClick[2];
  cxLCBottom.ItemIndex := LauncherOptions.SensorLeftClick[3];
  //Right
  cxRCTop.ItemIndex    := LauncherOptions.SensorRightClick[0];
  cxRCLeft.ItemIndex   := LauncherOptions.SensorRightClick[1];
  cxRCRight.ItemIndex  := LauncherOptions.SensorRightClick[2];
  cxRCBottom.ItemIndex := LauncherOptions.SensorRightClick[3];
end;

procedure TfrmOption.tbBackupChange(Sender: TObject);
begin
  lbNumbBackup.Caption := IntToStr(tbBackup.position);
end;

procedure TfrmOption.tbCheckListChange(Sender: TObject);
begin
  lbNumbCheckList.Caption := IntToStr(tbCheckList.position);
end;

procedure TfrmOption.tbMRUChange(Sender: TObject);
begin
  lbNumbMRU.Caption := IntToStr(tbMRU.position);
end;

end.
