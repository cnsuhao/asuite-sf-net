program ASuite;

uses
  FastMM4,
  ContextMenuBugFix,
  Forms,
  SysUtils,
  Main in 'Main.pas' {frmMain},
  PropertySw in 'PropertySw.pas' {frmPropertySw},
  PropertyCat in 'PropertyCat.pas' {frmPropertyCat},
  CheckPrevious in 'CheckPrevious.pas',
  ImportList in 'ImportList.pas' {frmImportList},
  Option in 'Option.pas' {frmOption},
  VirtualTreeHDrop in 'VirtualTreeHDrop.pas',
  Card in 'Card.pas' {frmCard},
  CommonUtils in 'CommonUtils.pas',
  PropertyGroup in 'PropertyGroup.pas' {frmPropertyGroup},
  Sensor in 'Sensor.pas' {frmSensor},
  ScanFolder in 'ScanFolder.pas' {frmScanFolder},
  Update in 'Update.pas' {frmUpdate},
  webthread in 'webthread.pas',
  ClearElements in 'ClearElements.pas' {frmClearElements},
  CommonClasses in 'CommonClasses.pas',
  OrderSoftware in 'OrderSoftware.pas' {frmOrderSoftware},
  RunAs in 'RunAs.pas' {frmRunAs},
  Menu in 'Menu.pas' {frmMenu},
  MenuButtons in 'MenuButtons.pas' {frmMenuButtons},
  Stats in 'Stats.pas' {frmStats};

{$R *.res}

begin
  if not CheckPrevious.RestoreIfRunning(Application.Handle, 1) then
  begin
    Application.Initialize;
    Application.Title := 'ASuite';
    Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.ShowMainForm := false;
    CreateFormSensors;
    if (not(LauncherOptions.StartUpShowPanel)) then
      frmMain.close
    else begin
      frmMain.Visible := true;
       if (LauncherOptions.ActiveFormCard) and Not(FileExists(LauncherFileNameXML)) then
      begin
        Application.CreateForm(TfrmCard, frmCard);
        frmCard.show;
        frmCard.pcCard.ActivePageIndex := 0;
      end;
    end;
    if (LauncherOptions.StartUpShowMenu) then
      ShowTrayiconMenu(frmMain.vstList, frmMain.pmTrayicon);
    Application.Run;
  end;
end.
