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

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ShellApi, StdCtrls, CoolTrayIcon, VirtualTrees,
  ActiveX, xmldom, msxmldom, XMLDoc, ImgList, XMLIntf, ExtCtrls, Sensor, ShlObj, CommonClasses;

type
  TfrmMain = class(TForm)
    ImageList1: TImageList;
    CoolTrayIcon1: TCoolTrayIcon;
    vstList: TVirtualStringTree;
    pcList: TPageControl;
    tbList: TTabSheet;
    tbSearch: TTabSheet;
    edtSearch: TEdit;
    vstSearch: TVirtualStringTree;
    btnSearch: TButton;
    MainMenu: TMainMenu;
    pmTrayicon: TPopupMenu;
    miFile: TMenuItem;
    miHelp: TMenuItem;
    N2: TMenuItem;
    miOptions1: TMenuItem;
    miImportList: TMenuItem;
    miExit1: TMenuItem;
    miReadMe: TMenuItem;
    miInfoASuite: TMenuItem;
    miEdit: TMenuItem;
    miAddCat1: TMenuItem;
    miAddSw1: TMenuItem;
    miDelete1: TMenuItem;
    N8: TMenuItem;
    miProperty1: TMenuItem;
    pmWindow: TPopupMenu;
    miAddCat2: TMenuItem;
    miAddSw2: TMenuItem;
    miDelete2: TMenuItem;
    N6: TMenuItem;
    miProperty2: TMenuItem;
    miAddFolder2: TMenuItem;
    miAddFolder1: TMenuItem;
    xmldTranslate: TXMLDocument;
    miSaveList1: TMenuItem;
    miRunSelectedSw: TMenuItem;
    miOpenFolderSw: TMenuItem;
    miWebSite: TMenuItem;
    tbStats: TTabSheet;
    lbOs: TLabel;
    lbNamePc: TLabel;
    lbUtente: TLabel;
    lbSize: TLabel;
    lbSpaceUsed: TLabel;
    lbSpaceFree: TLabel;
    lbSoftware: TLabel;
    lbCat: TLabel;
    lbTotal: TLabel;
    gbSystem: TGroupBox;
    gbSupport: TGroupBox;
    gbASuite: TGroupBox;
    N9: TMenuItem;
    miScanExecutables: TMenuItem;
    miAddGroupSw2: TMenuItem;
    miAddGroupSw1: TMenuItem;
    tmCheckList: TTimer;
    miAddSeparator2: TMenuItem;
    miAddSeparator1: TMenuItem;
    N3: TMenuItem;
    miSortList: TMenuItem;
    miExportList: TMenuItem;
    N4: TMenuItem;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    tmScheduler: TTimer;
    miSortItems: TMenuItem;
    N5: TMenuItem;
    miCheckUpdates: TMenuItem;
    N7: TMenuItem;
    miRunAs: TMenuItem;
    procedure CoolTrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miOptionsClick(Sender: TObject);
    procedure OpenFolderSw(Sender: TObject);
    procedure pcListChange(Sender: TObject);
    procedure miImportListClick(Sender: TObject);
    procedure miSaveListClick(Sender: TObject);
    procedure vstListDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstListDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure ShowProperty(Sender: TObject);
    procedure DeleteSwCat(Sender: TObject);
    procedure AddFolder(Sender: TObject);
    procedure AddSoftware(Sender: TObject);
    procedure AddCategory(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure vstSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure vstListGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vstListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miReadMeClick(Sender: TObject);
    procedure miInfoASuiteClick(Sender: TObject);
    procedure ShowMainForm(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TranslateForm(Lingua:string);
    procedure LoadListXML(Tree: TBaseVirtualTree;XMLNode: IXMLNode);
    procedure SaveListXML(Tree: TBaseVirtualTree;XMLNode: IXMLNode);
    procedure RunExe(Sender: TObject);
    procedure miWebSiteClick(Sender: TObject);
    procedure miScanExecutablesClick(Sender: TObject);
    procedure RunSingleClick(Sender: TObject);
    procedure vstListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vstListFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ShowCard(Sender: TBaseVirtualTree);
    procedure miAddGroupSw2Click(Sender: TObject);
    procedure vstListGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
    procedure tmCheckListTimer(Sender: TObject);
    procedure pmWindowPopup(Sender: TObject);
    procedure miRunSelectedSwClick(Sender: TObject);
    procedure miAddSeparator2Click(Sender: TObject);
    procedure FindNode(Sender: TBaseVirtualTree; Node: PVirtualNode;
                       Data: Pointer; var Abort: Boolean);
    procedure vstSearchGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vstSearchHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vstSearchCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstListCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure miSortListClick(Sender: TObject);
    procedure miExportListClick(Sender: TObject);
    procedure vstListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure tmSchedulerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miSortItemsClick(Sender: TObject);
    procedure miCheckUpdatesClick(Sender: TObject);
    procedure miRunAsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
  private
    { Private declarations }
    SessionEnding: boolean;
    procedure WMQueryEndSession(var Message: TMessage); message WM_QUERYENDSESSION;
    procedure WMHotKey(Var Msg : TWMHotKey); message WM_HOTKEY;
    procedure WMEndSession(var Msg : TWMEndSession); message WM_ENDSESSION;
    procedure WMMoving(var Msg: TWMMoving); message WM_Moving;
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
  public
    { Public declarations }
  end;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    //Properties generic
    Name       : WideString;
    Tipo       : Integer; //0 Category, 1 Software, 2 Software group,
                          //3 Folder (in reality it's a software type), 4 Separator
    pNode      : PVirtualNode;
    //Card
    Version    : WideString;
    Developer  : WideString;
    WebSite    : WideString;
    Desc       : WideString;
    Opinion    : WideString;
    Notes      : WideString;
    //Advanced
    PathExe    : Array[0..9] of WideString;
    PathIcon   : WideString;
    PathCache  : WideString;
    Parameters : WideString;
    WorkingDir : WideString;
    ActionOnExe     : Integer;
    DontInsertMRU   : Boolean;
    ShortcutDesktop : Boolean;
    HideSoftwareMenu : Boolean;
    //HotKey
    HotKey     : Boolean;
    HKModifier : Integer;
    HKCode     : Integer;
    //Scheduler
    SchMode    : Integer; //0 Disabled, 1 Once, 2 Hourly, 3 Daily, 4 Weekly
    SchDate    : WideString;
    SchTime    : WideString;
    //Misc
    ImageIndex : Integer;
    MenuItem   : TMenuItem;
    MenuNode   : PVirtualNode;
    MRUItem    : TMenuItem;
    Tag        : Integer; //Menu trayicon
    Autorun    : Integer; //0 Never, 1 always on startup, 2 if no previous instances are running
                          //3 Always on shutdown
    AutorunPos : Integer; //Position for ASuiteStartUpApp and ASuiteShutdownApp
    WindowState : Integer;
    PathExeError : Boolean;
  end;

  PTreeDataX = ^TTreeDataX; //X = Search or Menu
  TTreeDataX = record
    pNodeList : PVirtualNode;
    pNodeX    : PVirtualNode;
  end;

  TOptions = record
    //General
    AutoOpClCategories: Boolean; //  Automatic Opening/closing categories
    WindowsStartup   : Boolean;
    StartUpShowPanel : Boolean;
    StartUpShowMenu  : Boolean;
    ActiveFormCard   : Boolean;
    HoldSize         : Boolean;
    MainOnTop        : Boolean;
    LangName         : String;
    CustomTitle      : Boolean;
    CustomTitleString : String;
    //WindowHotkey
    WindowHotkey     : Boolean;
    WindowHotkeyMod  : Integer;
    WindowHotkeyCode : Integer;
    //WindowHotkey
    MenuHotkey     : Boolean;
    MenuHotkeyMod  : Integer;
    MenuHotkeyCode : Integer;
    //Treeview Font
    FontName         : TFontName;
    FontStyle        : TFontStyles;
    FontSize         : Integer;
    FontColor        : TColor;
    FontChanged      : Boolean;
    //Treeview Background
    Background       : Boolean;
    BackgroundPath   : String;
    //Tabs
    HideSearch       : Boolean;
    HideStats        : Boolean;
    //MRU
    MRU              : Boolean;
    SubMenuMRU       : Boolean; //For only classic menu
    MRUNumber        : Integer;
    //Backup
    Backup           : Boolean;
    BackupNumber     : Integer;
    //Check list
    CheckList        : Boolean;
    CheckListTime    : Integer;
    //Various
    //Execution
    ActionOnExe      : Integer;
    RunSingleClick   : Boolean;
    HotKey           : Boolean;
    Autorun          : Boolean;
    Scheduler        : Boolean;
    Cache            : Boolean;
    SaveSecurity     : Boolean;
    //Trayicon
    TrayIcon         : Boolean;
    TrayIconClassicMenu : Boolean; //False Default menu, True Classic menu
    TrayIconPath     : String;
    ActionClickLeft  : Integer;
    ActionClickRight : Integer;
    MenuTheme        : String;  //Only default menu
    RefreshMenuTheme : Boolean; //Only default menu
    MenuFade         : Boolean; //Only default menu
    MenuFolderName : Array[0..3] of String; //Only default menu //0 Documents, 1 Music
    MenuFolderPath : Array[0..3] of String; //Only default menu //2 Pictures, 3 Video
    MenuPersonalPicture : String;
    //Sensors
    SensorLeftClick  : Array[0..3] of Integer; //0 Top, 1 Left, 2 Right, 3 Bottom
    SensorRightClick : Array[0..3] of Integer;
    //Misc
    ReadOnlyMode     : Boolean;
    PathReadme       : String;
  end;

  TTransCompName = record
    //Card
    LabelTitoloSw       : String;
    LabelTitoloSHouse   : String;
    LabelTitoloVersione : String;
    //Menu
    MenuShowWindow  : String;
    MenuSave        : String;
    MenuOption      : String;
    MenuExit        : String;
    MenuMRU         : String;
    //Stats
    LabelSize       : String;
    LabelSpaceFree  : String;
    LabelSpaceUsed  : String;
    GroupBoxSupport : String;
    LabelSoftware   : String;
    LabelCategory   : String;
    LabelTotal      : String;
    //Caption for frmCard
    Card            : String;
    About           : String;
  end;

const
  Launcher      = 'ASuite';
  //PathRoot      = '';
  PathUser      = '';
  PathCache     = PathUser + 'cache\';
  PathIcons     = PathUser + 'icons\';
  PathTheme     = PathUser + 'MenuThemes\';
  ReleaseVersion    = '1.5.1';
  PreReleaseVersion = ' Alpha'; //For Alpha and Beta version
                               //(ReleaseVersion + PreReleaseVersion = Version)
  UpdateUrl     = 'http://www.salvadorsoftware.com/update/';
  UpdateName    = 'update.ini';
  frmMainWidth  = 191;
  frmMainHeight = 442;
  frmMenuID     = 123456789;

var
  frmMain             : TfrmMain;
  ArrayMessages       : Array[1..25] of string;
  FormSensors         : Array[0..3] of TfrmSensor;  
  ApplicationPath     : String;
  ShutdownTime, StartUpTime : Boolean;
  MRUList, MenuList,
  ASuiteStartUpApp,                //Software in ASuite StartUp
  ASuiteShutdownApp   : TNodeList; //Software in ASuite Shutdown
  HotKeyApp,
  SchedulerApp        : TNodeArray;
  LauncherOptions     : TOptions;
  TransCompName       : TTransCompName; 
  LauncherFileNameXML : String;  
  OldPoint : TPoint;

implementation

uses Option, PropertySw, PropertyCat, PropertyGroup, ImportList, VirtualTreeHDrop, Card,
     CommonUtils, ScanFolder, Update, RunAs, Menu;

{$R *.dfm}

procedure TfrmMain.FindNode(Sender: TBaseVirtualTree; Node: PVirtualNode;
                            Data: Pointer; var Abort: Boolean);
var
  CurrentNodeData, FilterData : PTreeData;
  NewNodeData : PTreeDataX;
  NewNode     : PVirtualNode;
begin
  FilterData      := Data;
  CurrentNodeData := Sender.GetNodeData(Node);
  if ((CurrentNodeData.Tipo = 1) or (CurrentNodeData.Tipo = 2)) and
  (Pos(LowerCase(FilterData.Name),LowerCase(CurrentNodeData.Name)) <> 0) then
  begin
    NewNode               := vstSearch.AddChild(nil);
    NewNodeData           := vstSearch.GetNodeData(NewNode);
    NewNodeData.pNodeList := Node;
    NewNodeData.pNodeX    := NewNode;
  end;
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
var
  NodeData: PTreeData;
begin
  vstSearch.Clear;
  if Length(edtSearch.Text) > 0 then
  begin
    New(NodeData);
    NodeData.Name := edtSearch.Text;
    vstList.IterateSubtree(nil, FindNode, NodeData, [], True);
    Dispose(NodeData);
  end;
end;

procedure TfrmMain.CoolTrayIcon1DblClick(Sender: TObject);
begin
  if LauncherOptions.ActionClickLeft = 0 then
    ShowMainForm(Sender);
end;

procedure TfrmMain.CoolTrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if StartUpTime then
    Exit;
  if (Button = mbLeft) then
  begin
    case LauncherOptions.ActionClickLeft of
      1: ShowMainForm(Sender);
      2: ShowTrayiconMenu(vstList, pmTrayicon);
    end;
  end
  else
    if (Button = mbRight) then
    begin
      case LauncherOptions.ActionClickRight of
        1: ShowMainForm(Sender);
        2: ShowTrayiconMenu(vstList, pmTrayicon);
      end;
    end;
end;

procedure TfrmMain.DeleteSwCat(Sender: TObject);
var
  Node, ParentNode : PVirtualNode;
begin
  Node := vstList.GetFirstSelected;
  ParentNode := nil;
  if Assigned(Node) and (MessageDlg(ArrayMessages[8],mtWarning, [mbYes,mbNo], 0) = mrYes) then
  begin
    //Deselect children node, if its parent node is selected, too
    while Assigned(Node) do
    begin
      if (ParentNode = nil) and (vstList.HasChildren[ParentNode]) then
        ParentNode := Node
      else
        if vstList.HasAsParent(Node,ParentNode) then
        begin
          //Deselect node
          vstList.Selected[Node] := false;
          vstList.FocusedNode := nil;
        end;
      Node := vstList.GetNextSelected(Node);
    end;
    //Delete nodes
    Node := vstList.GetFirstSelected;
    while Assigned(Node) do
    begin
      vstList.DeleteNode(Node);
      Node := vstList.GetNextSelected(Node);
    end;
    RefreshList(vstList,pmTrayicon, true);
  end;
end;

procedure TfrmMain.tmCheckListTimer(Sender: TObject);
begin
  if Not((ShutdownTime) or (StartUpTime)) then
    CheckList(vstList,ImageList1);
end;

procedure TfrmMain.tmSchedulerTimer(Sender: TObject);
var
  NodeData : PTreeData;
  I        : Integer;
  DateTime : TDateTime;
  StrDateTime, StrDateTimeSw : String;
  Run      : Boolean;
begin
  if LauncherOptions.Scheduler then
  begin
    DateTime := Now;
    //Check scheduler list to know which software to run by ASuite
    for I := 0 to Length(SchedulerApp) - 1 do
    begin
      Run := False;
      if Assigned(SchedulerApp[I]) then
      begin
        NodeData := vstList.GetNodeData(SchedulerApp[I]);
        case NodeData.SchMode of
          1:
          begin
            //Once
            DateTimeToString(StrDateTime,'c',DateTime);
            if StrDateTime = (NodeData.SchDate + ' ' + NodeData.SchTime) then
              Run := True;
          end;
          2:
          begin
            //Hourly
            DateTimeToString(StrDateTime,'nn:ss',DateTime);
            StrDateTimeSw := NodeData.SchTime;
            Delete(StrDateTimeSw,1,3);
            if (StrDateTime = StrDateTimeSw) then
              Run := True;
          end;
          3:
          begin
            //Daily
            DateTimeToString(StrDateTime,'hh:mm:ss',DateTime);
            if (StrDateTime = NodeData.SchTime) then
              Run := True;
          end;
        end;
        //Run software
        if Run then
          if (NodeData.Tipo <> 0) then
          begin
            RunProcess(vstList, NodeData,false);
            AddMRU(vstList,pmTrayicon,NodeData.pNode,NodeData.DontInsertMRU);
            RunActionOnExe(NodeData);
          end;
      end;
    end;
  end;
end;

procedure TfrmMain.TranslateForm(Lingua: string);
var
  I : Integer;
begin
  xmldTranslate.Active := false;
  if FileExists('Lang\' + Lingua) then
    xmldTranslate.FileName := 'Lang\' + Lingua
  else
    xmldTranslate.FileName := Lingua;
  xmldTranslate.Active := true;
  with xmldTranslate.DocumentElement.ChildNodes['Info'] do
    LauncherOptions.PathReadme := ChildNodes['PathReadme'].Text;
  with xmldTranslate.DocumentElement.ChildNodes['Form1'] do
  begin
    //Section:Form1
    tbList.Caption      := ChildNodes['TabListCaption'].Text;
    tbSearch.Caption    := ChildNodes['TabSearchCaption'].Text;
    tbStats.Caption     := ChildNodes['TabStatsCaption'].Text;
    //tbSearch
    btnSearch.Caption   := ChildNodes['ButtonSearch'].Text;
    with vstSearch.Header do
    begin
      Columns[0].Text   := ChildNodes['ColumnName'].Text;
      Columns[1].Text   := ChildNodes['ColumnCategory'].Text;
    end;
    //Stats
    //System
    gbSystem.caption    := ChildNodes['GroupBoxSystem'].Text;
    lbNamePc.caption    := ChildNodes['LabelPcName'].Text;
    lbUtente.caption    := ChildNodes['LabelCurrentUser'].Text;
    with TransCompName do
    begin
      //Drive
      LabelSize           := ChildNodes['LabelSize'].Text;
      LabelSpaceFree      := ChildNodes['LabelFreeSpace'].Text;
      LabelSpaceUsed      := ChildNodes['LabelUsedSpace'].Text;
      GroupBoxSupport     := ChildNodes['GroupBoxDrive'].Text;
      gbSupport.Caption   := GroupBoxSupport;
      lbSize.caption      := LabelSize;
      lbSpaceFree.caption := LabelSpaceFree;
      lbSpaceUsed.caption := LabelSpaceUsed;
      //Launcher
      LabelSoftware       := ChildNodes['LabelSwInserted'].Text;
      LabelCategory       := ChildNodes['LabelCatInserted'].Text;
      LabelTotal          := ChildNodes['LabelTotal'].Text;
      gbASuite.caption    := ChildNodes['GroupBoxASuite'].Text;
      lbSoftware.caption  := LabelSoftware;
      lbCat.caption       := LabelCategory;
      lbTotal.caption     := LabelTotal;
    end;
    //Menu
    //File
    miFile.Caption          := ChildNodes['MenuFile'].Text;
    miSaveList1.Caption     := ChildNodes['MenuSave'].Text;
    miImportList.Caption    := ChildNodes['MenuImportList'].Text;
    miExportList.Caption    := ChildNodes['MenuExportList'].Text;
    miOptions1.Caption      := ChildNodes['MenuOption'].Text;
    miScanExecutables.Caption := ChildNodes['MenuScanExecutables'].Text;
    miExit1.Caption         := ChildNodes['MenuExit'].Text;
    //Edit
    miSortList.Caption      := ChildNodes['MenuSortList'].Text;
    miEdit.Caption          := ChildNodes['MenuEdit'].Text;
    miSortItems.Caption     := ChildNodes['MenuSortCategoryItems'].Text;
    miAddCat1.Caption       := ChildNodes['MenuAddCat'].Text;
    miAddSw1.Caption        := ChildNodes['MenuAddSw'].Text;
    miAddGroupSw1.Caption   := ChildNodes['MenuAddGroupSw'].Text;
    miAddFolder1.Caption    := ChildNodes['MenuAddFolder'].Text;
    miAddSeparator1.Caption := ChildNodes['MenuAddSeparator'].Text;
    miDelete1.Caption       := ChildNodes['MenuDelete'].Text;
    miProperty1.Caption     := ChildNodes['MenuProperty'].Text;
    //Help
    miCheckUpdates.Caption     := ChildNodes['MenuCheckUpdates'].Text;
    miHelp.Caption          := ChildNodes['MenuHelp'].Text;
    miReadMe.Caption        := ChildNodes['MenuReadme'].Text;
    miInfoASuite.Caption    := ChildNodes['MenuASuiteInfo'].Text;
    //PopUpMenu
    miRunSelectedSw.Caption := ChildNodes['MenuRun'].Text;
    miRunAs.Caption         := ChildNodes['MenuRunAs'].Text;
    miOpenFolderSw.Caption  := ChildNodes['MenuOpenFolder'].Text;
    miWebSite.Caption       := ChildNodes['MenuVisitWebSite'].Text;
    miAddCat2.Caption       := miAddCat1.Caption;
    miAddSw2.Caption        := miAddSw1.Caption;
    miAddGroupSw2.Caption   := miAddGroupSw1.Caption;
    miAddFolder2.Caption    := miAddFolder1.Caption;
    miAddSeparator2.Caption := miAddSeparator1.Caption;
    miDelete2.Caption       := miDelete1.Caption;
    miProperty2.Caption     := miProperty1.Caption;
    //Trayicon menu
    with TransCompName do
    begin
      MenuShowWindow := ChildNodes['TrayiconShowASuite'].Text;
      MenuOption     := ChildNodes['MenuOption'].Text;
      MenuSave       := ChildNodes['MenuSave'].Text;
      MenuExit       := ChildNodes['TrayiconExit'].Text;
      MenuMRU        := ChildNodes['TrayiconMRU'].Text;
    end;
  end;
  with xmldTranslate.DocumentElement.ChildNodes['String'] do
  begin
    //Dialog messages
    for I := 1 to Length(ArrayMessages) do
      if I < 10 then
        ArrayMessages[I]  := ChildNodes['string0' + IntToStr(I)].Text
      else
        ArrayMessages[I]  := ChildNodes['string' + IntToStr(I)].Text;
  end;
end;

procedure TfrmMain.LoadListXML(Tree: TBaseVirtualTree;XMLNode: IXMLNode);
var
  iNode    : IXMLNode;
  HotKeyID : Integer;
  procedure ProcessNode(Node : IXMLNode;tn : PVirtualNode);
  var
    cNode, xNode : IXMLNode;
    NodeData     : PTreeData;
    ArrayIndex   : Integer;
  begin
    if Node = nil then Exit;
    with Node do
    begin
      if (NodeName = 'Separator') then
        Attributes['name']    := '-';
      if (not(Attributes['name'] = null)) and ((NodeName = 'Software')
         or (NodeName = 'Category') or (NodeName = 'GroupSoftware')
         or (NodeName = 'Separator')) then
      begin
        tn                    := tree.AddChild(tn);
        NodeData              := tree.GetNodeData(tn);
        //Properties generic
        NodeData.pNode        := tn;
        NodeData.Name         := StringReplace(Attributes['name'], '&&', '&', [rfIgnoreCase,rfReplaceAll]);
        NodeData.Name         := StringReplace(NodeData.Name, '&', '&&', [rfIgnoreCase,rfReplaceAll]);
        NodeData.PathIcon     := ChildNodes['PathIcon'].Text;
        NodeData.PathCache    := ChildNodes['PathCache'].Text;
        //Type
        if NodeName = 'Category' then
          NodeData.Tipo       := 0
        else
          if NodeName = 'Software' then
            NodeData.Tipo       := 1
          else
            if NodeName = 'GroupSoftware' then
              NodeData.Tipo       := 2
            else
              if NodeName = 'Separator' then
              begin
                NodeData.Tipo       := 4;
                NodeData.ImageIndex := -1;
                Exit;
              end;
        case NodeData.Tipo of
          1: //Software
          begin
            NodeData.Version    := ChildNodes['Version'].Text;
            NodeData.Developer  := ChildNodes['Developer'].Text;
            NodeData.WebSite    := ChildNodes['WebSite'].Text;
            NodeData.Desc       := ChildNodes['Description'].Text;
            NodeData.Opinion    := ChildNodes['Opinion'].Text;
            NodeData.Notes      := ChildNodes['Notes'].Text;
            NodeData.PathExe[0] := ChildNodes['PathExe'].Text;
            NodeData.Parameters := ChildNodes['Parameters'].Text;
            NodeData.WorkingDir := ChildNodes['WorkingDir'].Text;
            NodeData.ShortcutDesktop := StrToBool(ChildNodes['ShortcutDesktop'].Text);
          end;
          2: //Software Group
          begin
            xNode := ChildNodes.First;
            while Assigned(xNode) do
            begin
              if (Pos('PathExe', xNode.NodeName) = 1) then
              begin
                ArrayIndex := GetFirstFreeIndex(NodeData.PathExe);
                NodeData.PathExe[ArrayIndex] := ChildNodes[xNode.NodeName].Text;
              end;
              xNode := xNode.NextSibling;
            end;
          end;
        end;
        //Software and Software Group
        if (NodeData.Tipo = 1) or (NodeData.Tipo = 2) then
        begin
          //Autorun
          NodeData.Autorun    := ReadIntegerXML(ChildNodes['Autorun'],0);
          NodeData.AutorunPos := ReadIntegerXML(ChildNodes['AutorunPosition'],0);
          AddAutorunInList(NodeData);
          //HotKey
          NodeData.HKModifier  := ReadIntegerXML(ChildNodes['HotKeyModifier'],-1);
          NodeData.HKCode      := ReadIntegerXML(ChildNodes['HotKeyCode'],-1);
          NodeData.HotKey      := ReadBooleanXML(ChildNodes['HotKey'],false);
          if NodeData.HotKey then
            HotKeyID := (AddHotkey(Tree,tn,HotKeyID));
          NodeData.WindowState := ReadIntegerXML(ChildNodes['WindowState'],0);
          NodeData.ActionOnExe := ReadIntegerXML(ChildNodes['ActionOnExe'],0);
          NodeData.DontInsertMRU    := StrToBool(ChildNodes['DontInsertMRU'].Text);
          NodeData.HideSoftwareMenu := StrToBool(ChildNodes['HideSoftwareMenu'].Text);
          //Scheduler
          NodeData.SchMode  := ReadIntegerXML(ChildNodes['SchedulerMode'],0);
          NodeData.SchDate  := ReadStringXML(ChildNodes['SchedulerDate'],'');
          NodeData.SchTime  := ReadStringXML(ChildNodes['SchedulerTime'],'');
          if NodeData.SchMode <> 0 then
          begin
            SetLength(SchedulerApp,Length(SchedulerApp) + 1);
            SchedulerApp[Length(SchedulerApp) - 1] := tn;
          end;
        end;
        //Icon
        NodeData.ImageIndex := IconAdd(vstList, ImageList1, tn);
        //Create shorcut on desktop
        if (NodeData.Tipo = 1) and (NodeData.ShortcutDesktop) then
          CreateShortcutOnDesktop('\' + NodeData.Name + '.lnk', NodeData.PathExe[0],NodeData.Parameters,NodeData.WorkingDir);
      end;
    end;
    cNode := Node.ChildNodes.First;
    while Assigned(cNode) do
    begin
      ProcessNode(cNode, tn);
      cNode := cNode.NextSibling;
    end;
  end;
begin
  Tree.BeginUpdate;
  Tree.Clear;
  HotKeyID := 0;
  iNode    := XMLNode;
  while Assigned(iNode) do
  begin
    ProcessNode(iNode,nil);
    iNode := iNode.NextSibling;
  end;
  Tree.EndUpdate;
end;

procedure TfrmMain.SaveListXML(tree: TBaseVirtualTree;XMLNode: IXMLNode);
var
  tn        : PVirtualNode;
  iNode     : IXMLNode;
  procedure ProcessTreeItem(tn: PVirtualNode;iNode: IXMLNode);
  var
    cNode    : IXMLNode;
    NodeData : PTreeData;
    J        : Integer;
  begin
    if (tn = nil) then Exit;
    NodeData := tree.GetNodeData(tn);
    //Type
    case NodeData.Tipo of
      0: cNode := iNode.AddChild('Category');
      1: cNode := iNode.AddChild('Software');
      2: cNode := iNode.AddChild('GroupSoftware');
      4:
      begin
        cNode  := iNode.AddChild('Separator');
        exit;
      end;
    end;
    with cNode do
    begin
      //Properties generic
      Attributes['name']           := NodeData.Name;
      if (NodeData.PathIcon <> '') then
        AddChild('PathIcon').Text  := NodeData.PathIcon;
      if (NodeData.PathCache <> '') then
        AddChild('PathCache').Text := NodeData.PathCache;
      case NodeData.Tipo of
        1: //Software
        begin
          AddChild('PathExe').Text         := NodeData.PathExe[0];
          if (NodeData.Parameters <> '') then
            AddChild('Parameters').Text    := NodeData.Parameters;
          if (NodeData.WorkingDir <> '') then
            AddChild('WorkingDir').Text    := NodeData.WorkingDir;
          if (NodeData.Version <> '') then
            AddChild('Version').Text       := NodeData.Version;
          if (NodeData.Developer <> '') then
            AddChild('Developer').Text     := NodeData.Developer;
          if (NodeData.WebSite <> '') and (NodeData.WebSite <> 'http://') then
            AddChild('WebSite').Text       := NodeData.WebSite;
          if (NodeData.Desc <> '') then
            AddChild('Description').Text   := NodeData.Desc;
          if (NodeData.Notes <> '') then
            AddChild('Notes').Text         := NodeData.Notes;
          if (NodeData.Opinion <> '') then
            AddChild('Opinion').Text       := NodeData.Opinion;
          if (NodeData.WindowState <= 3) and (NodeData.WindowState <> 0) then
            AddChild('WindowState').Text   := IntToStr(NodeData.WindowState);
          if (NodeData.ShortcutDesktop) then
            AddChild('ShortcutDesktop').Text := BoolToStr(NodeData.ShortcutDesktop);
        end;
        2: //Software Group
        begin
          for J := 0 to High(NodeData.PathExe) do
          begin
            if NodeData.PathExe[J] <> '' then
              AddChild('PathExe' + IntToStr(J)).Text := NodeData.PathExe[j];
          end;
        end;
      end;
      //Software and Software Group
      if (NodeData.Tipo = 1) or (NodeData.Tipo = 2) then
      begin
        if (NodeData.Autorun <> 0) then
        begin
          AddChild('Autorun').Text := IntToStr(NodeData.Autorun);    
          AddChild('AutorunPosition').Text := IntToStr(NodeData.AutorunPos);
        end;
        if (NodeData.HotKey) then
          AddChild('HotKey').Text  := BoolToStr(NodeData.HotKey);
        if (NodeData.HKModifier <> -1) and (NodeData.HKModifier >= 0) and
           (NodeData.HotKey) then
          AddChild('HotKeyModifier').Text := IntToStr(NodeData.HKModifier);
        if (NodeData.HKCode <> -1) and (NodeData.HKCode >= 0) and
           (NodeData.HotKey) then
          AddChild('HotKeyCode').Text  := IntToStr(NodeData.HKCode);
        if (NodeData.ActionOnExe <> 0) then
          AddChild('ActionOnExe').Text := IntToStr(NodeData.ActionOnExe);
        if (NodeData.DontInsertMRU) then
          AddChild('DontInsertMRU').Text := BoolToStr(NodeData.DontInsertMRU);
        if (NodeData.HideSoftwareMenu) then
          AddChild('HideSoftwareMenu').Text := BoolToStr(NodeData.HideSoftwareMenu);
        if (NodeData.schMode <> 0) then
        begin
            AddChild('SchedulerMode').Text := IntToStr(NodeData.schMode);
          if (NodeData.schDate <> '') then
            AddChild('SchedulerDate').Text := NodeData.schDate;
          if (NodeData.schTime <> '') then
            AddChild('SchedulerTime').Text := NodeData.schTime;
        end;
      end;
    end;
    tn := tn.FirstChild;
    while Assigned(tn) do
    begin
      ProcessTreeItem(tn, cNode);
      tn := tn.NextSibling;
    end;
  end;
begin
  iNode := XMLNode.AddChild('Category');
  tn    := tree.GetFirst;
  while Assigned(tn) do
  begin
    ProcessTreeItem(tn, iNode);
    tn := tn.NextSibling;
  end;
end;

procedure TfrmMain.miSaveListClick(Sender: TObject);
begin
  if SaveFileXML(vstList, LauncherFileNameXML) then
    showmessage(ArrayMessages[17])
  else
    showmessage(ArrayMessages[18]);
end;

procedure TfrmMain.miScanExecutablesClick(Sender: TObject);
begin
  tmCheckList.Enabled := false;
  try
    Application.CreateForm(TfrmScanFolder, frmScanFolder);
    frmScanFolder.showmodal;
  finally
    frmScanFolder.Free;
    RefreshList(vstList, pmTrayicon, true);
  end;
  EnableTimerCheckList(Sender);
end;

procedure TfrmMain.AddCategory(Sender: TObject);
begin
  AddNode(vstList,TfrmPropertyCat,0);
end;

procedure TfrmMain.AddFolder(Sender: TObject);
begin
  AddNode(vstList,TfrmPropertySw,3);
end;

procedure TfrmMain.AddSoftware(Sender: TObject);
begin
  AddNode(vstList,TfrmPropertySw,1);
end;

procedure TfrmMain.miAddGroupSw2Click(Sender: TObject);
begin
  AddNode(vstList,TfrmPropertyGroup,2);
end;

procedure TfrmMain.miAddSeparator2Click(Sender: TObject);
begin
  AddNode(vstList,TfrmPropertySw,4);
end;

procedure TfrmMain.miCheckUpdatesClick(Sender: TObject);
begin
  tmCheckList.Enabled := false;
  try
    Application.CreateForm(TfrmUpdate, frmUpdate);
    frmUpdate.showmodal;
  finally
    frmUpdate.Free;
  end;
  EnableTimerCheckList(Sender);
end;

procedure TfrmMain.OpenFolderSw(Sender: TObject);
var
  NodeData : PTreeData;
  Node     : PVirtualNode;
  TreeView : TVirtualStringTree;
begin
  if pcList.ActivePageIndex = 0 then
    TreeView := vstList
  else
    TreeView := vstSearch;
  Node := TreeView.GetFirstSelected;
  while Assigned(Node) do
  begin
    if (TreeView = vstList) then
      NodeData := vstList.GetNodeData(Node)
    else
      NodeData := NodeDataXToNodeDataList(Node);
    if NodeData.Tipo = 1 then
      ShellExecute(GetDesktopWindow, 'open', PChar(ExtractFileDir(RelativeToAbsolute(NodeData.PathExe[0]))), nil, nil, SW_NORMAL);
    Node := TreeView.GetNextSelected(node);
  end;
end;

procedure TfrmMain.miRunAsClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmRunAs, frmRunAs);
    frmRunAs.showmodal;
  finally
    frmRunAs.Free;
  end;
  RefreshList(vstList, pmTrayicon, true);
end;

procedure TfrmMain.RunExe(Sender: TObject);
var
  NodeDataList : PTreeData;
  Node         : PVirtualNode;
begin 
  if ClickOnButtonTree(vstList) then
    Exit;
  //From list/search
  if (Sender = vstList) or (Sender = vstSearch) then
  begin
    Node := (Sender as TBaseVirtualTree).GetFirstSelected;
    while Assigned(Node) do
    begin
      if (Sender = vstList) then
        NodeDataList := vstList.GetNodeData(Node)
      else
        NodeDataList := NodeDataXToNodeDataList(Node);
      if Assigned(NodeDataList) then
      begin
        //Run file
        if (NodeDataList.Tipo = 1) or (NodeDataList.Tipo = 2) then
        begin
          RunProcess(vstList,NodeDataList,false);
          AddMRU(vstList,pmTrayicon,NodeDataList.pNode,NodeDataList.DontInsertMRU);
          RunActionOnExe(NodeDataList);
        end;
      end;
      if Node <> (Sender as TBaseVirtualTree).GetNextSelected(node) then
        Node := (Sender as TBaseVirtualTree).GetNextSelected(node)
      else
        Node := nil;
    end;
  end
  else //From menu
    if (Sender is TMenuItem) then
    begin
      NodeDataList := vstList.GetNodeData(MenuList[(Sender as TMenuItem).tag]);
      if Assigned(NodeDataList) then
      begin
        //Run file
        RunProcess(vstList,NodeDataList,false);
        AddMRU(vstList,pmTrayicon,NodeDataList.pNode,NodeDataList.DontInsertMRU);
        RunActionOnExe(NodeDataList);
      end
      else begin
        ShowMessageFmt(ArrayMessages[9],[StringReplace((Sender as TMenuItem).Caption,'&','',[])]);
        exit;
      end;
    end;
end;

procedure TfrmMain.miImportListClick(Sender: TObject);
begin
  tmCheckList.Enabled := false;
  try
    Application.CreateForm(TfrmImportList, frmImportList);
    frmImportList.showmodal;
  finally
    frmImportList.Free;
    RefreshList(vstList, pmTrayicon, true);
  end;
  EnableTimerCheckList(Sender);
end;

procedure TfrmMain.miInfoASuiteClick(Sender: TObject);
begin
  if not IsFormOpen('frmCard') then
    Application.CreateForm(TfrmCard, frmCard);
  frmCard.show;
  frmCard.pcCard.ActivePageIndex := 0;
  frmCard.Caption := TransCompName.About;
end;

procedure TfrmMain.miReadMeClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow, 'open', PChar(LauncherOptions.PathReadme), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.miRunSelectedSwClick(Sender: TObject);
begin
  if pcList.ActivePageIndex = 0 then
    RunExe(vstList)
  else
    RunExe(vstSearch);
end;

procedure TfrmMain.miOptionsClick(Sender: TObject);
begin
  tmCheckList.Enabled := false;
  if not IsFormOpen('frmOption') then
    try
      Application.CreateForm(TfrmOption, frmOption);
      frmOption.showmodal;
    finally
      frmOption.Free;
    end
  else
    frmOption.show;
  //Language
  if IsFormOpen('frmCard') then
    frmCard.TranslateForm(LauncherOptions.LangName);
  EnableTimerCheckList(Sender);
  RefreshList(vstList, pmTrayicon, true);
end;

procedure TfrmMain.ShowMainForm(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
  ShowWindow(Application.Handle, SW_RESTORE);
end;

procedure TfrmMain.miSortItemsClick(Sender: TObject);
begin
  with vstList do
    Sort(GetFirstSelected,0,sdAscending,True);
end;

procedure TfrmMain.miSortListClick(Sender: TObject);
begin
  vstList.SortTree(0,sdAscending,True);
end;

procedure TfrmMain.miWebSiteClick(Sender: TObject);
var
  NodeData : PTreeData;
  Node     : PVirtualNode;
  TreeView : TVirtualStringTree;
begin
  if pcList.ActivePageIndex = 0 then
    TreeView := vstList
  else
    TreeView := vstSearch;
  Node := TreeView.GetFirstSelected;
  while Assigned(Node) do
  begin
    if (TreeView = vstList) then
      NodeData := vstList.GetNodeData(Node)
    else
      NodeData := NodeDataXToNodeDataList(Node);
    if NodeData.Tipo = 1 then
      ShellExecute(GetDesktopWindow, 'open', PChar(String(NodeData.WebSite)), nil, nil, SW_SHOWNORMAL);
    Node := TreeView.GetNextSelected(node);
  end;
end;

procedure TfrmMain.pcListChange(Sender: TObject);
var
  Enable : Boolean;
begin
  if pcList.ActivePageIndex = 1 then
    Enable := false
  else
    Enable := true;
  if pcList.ActivePageIndex = 2 then
    GetStats(false);
  miEdit.visible         := Enable;
  miSortItems.Visible    := Enable;
  miAddCat2.visible      := Enable;
  miAddSw2.visible       := Enable;
  miAddFolder2.visible   := Enable;
  miAddSeparator2.visible := Enable;
  miAddGroupSw2.visible  := Enable;
  miDelete2.visible      := Enable;
end;

procedure TfrmMain.pmWindowPopup(Sender: TObject);
var
  NodeData: PTreeData;
  Point   : TPoint;
  HitInfo : ThitInfo;
begin
  GetCursorPos(Point);
  Point    := vstList.ScreenToClient(Point);
  vstList.GetHitTestInfoAt(Point.X,Point.Y,true,HitInfo);
  //If user clicks on empty area of vstList
  if Not(hiOnItem in hitinfo.HitPositions) then
  begin
    //Set nil vstList.FocusedNode
    vstList.Selected[vstList.FocusedNode] := False;
    vstList.FocusedNode := nil;
  end;
  //Enable/disable item window menu
  if (Assigned(vstList.FocusedNode) and (pcList.ActivePageIndex = 0)) or
     (Assigned(vstSearch.FocusedNode) and (pcList.ActivePageIndex = 1)) then
  begin
    if pcList.ActivePageIndex = 0 then
      NodeData := vstList.GetNodeData(vstList.FocusedNode)
    else
      NodeData := NodeDataXToNodeDataList(vstSearch.FocusedNode);
    if (NodeData.Tipo <> 0) then
    begin
      miRunSelectedSw.Enabled := true;
      miRunAs.Enabled         := true;
    end;
    if (NodeData.Tipo <> 1) then
    begin
      miOpenFolderSw.Enabled := false;
      miWebSite.Enabled      := false;
    end;
    if (NodeData.Tipo <> 4) then
    begin
      miProperty2.Enabled     := true;
      miRunSelectedSw.Enabled := true;
      miRunAs.Enabled         := true;
    end;
    case NodeData.Tipo of
      0:
      begin
        miRunSelectedSw.Enabled := false;
        miRunAs.Enabled         := false;
      end;
      1:
      begin
        miOpenFolderSw.Enabled := true;
        miWebSite.Enabled      := true;
      end;
      4:
      begin
        miProperty2.Enabled     := false;
        miRunSelectedSw.Enabled := false;
        miRunAs.Enabled         := false;
      end;
    end;
  end
  else begin
    miRunSelectedSw.Enabled := false;
    miRunAs.Enabled         := false;
    miOpenFolderSw.Enabled  := false;
    miWebSite.Enabled       := false;
    miProperty2.Enabled     := false;
  end;
end;

procedure TfrmMain.vstSearchCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2, CatData1, CatData2: PTreeData;
  CatName1, CatName2 : String;
begin
  Data1 := NodeDataXToNodeDataList(Node1);
  Data2 := NodeDataXToNodeDataList(Node2);
  if (Not Assigned(Data1)) or (Not Assigned(Data2)) then
    Result := 0
  else
    if Column = 0 then
      Result := CompareText(Data1.Name, Data2.Name)
    else begin
      CatData1 := vstList.GetNodeData(Data1.pNode.Parent);
      CatData2 := vstList.GetNodeData(Data2.pNode.Parent);
      if Assigned(CatData1) then
        CatName1 := CatData1.Name
      else
        CatName1 := '';
      if Assigned(CatData2) then
        CatName2 := CatData2.Name
      else
        CatName2 := '';
      Result  := CompareText(CatName1, CatName2)
    end;
end;

procedure TfrmMain.vstSearchGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeDataList : PTreeData;
begin
  NodeDataList := NodeDataXToNodeDataList(Node);
  ImageIndex   := NodeDataList.ImageIndex;
  if Column = 1 then
    ImageIndex := -1;
end;

procedure TfrmMain.vstSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  NodeDataList, CatData : PTreeData;
begin
  NodeDataList := NodeDataXToNodeDataList(Node);
  if Column = 0 then
    CellText   := NodeDataList.Name;
  if Column = 1 then
    if (NodeDataList.pNode.Parent <> vstList.RootNode) then
    begin
      CatData  := vstList.GetNodeData(NodeDataList.pNode.Parent);
      CellText := CatData.Name;
    end
    else
      CellText := '';
end;

procedure TfrmMain.vstSearchHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  vstSearch.SortTree(Column,Sender.SortDirection,True);
  if Sender.SortDirection = sdAscending then
    Sender.SortDirection := sdDescending
  else
    Sender.SortDirection := sdAscending
end;

procedure TfrmMain.vstListGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
  var HintText: WideString);
var
  NodeData: PTreeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if NodeData.PathExeError then
    HintText := ArrayMessages[1]
end;

procedure TfrmMain.vstListGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData : PTreeData;
begin
  NodeData   := Sender.GetNodeData(Node); 
  ImageIndex := NodeData.ImageIndex;
  if Column = 1 then
    ImageIndex := -1;
end;

procedure TfrmMain.vstListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  NodeData : PTreeData;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := StringReplace(NodeData.Name, '&&', '&', [rfIgnoreCase,rfReplaceAll]);
  if CellText = '-' then
    CellText := StringReplace(CellText, '-', '---------------------------------', [rfIgnoreCase,rfReplaceAll]);
end;

procedure TfrmMain.vstListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ShowCard(Sender as TVirtualStringTree);
  if Key = VK_RETURN then
    RunExe(Sender);
end;

procedure TfrmMain.vstListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  with TargetCanvas do
  begin
    if (LauncherOptions.FontChanged) then
    begin
      Sender.InvalidateNode(Node);
      if Sender.GetLastVisible(Sender.RootNode) = Node then
        LauncherOptions.FontChanged := False;
    end;
    Font.Name  := LauncherOptions.FontName;
    Font.Style := LauncherOptions.FontStyle;
    Font.Size  := LauncherOptions.FontSize;
    if Not(Sender.Selected[Node]) then
      Font.Color := LauncherOptions.FontColor;
  end;
end;

procedure TfrmMain.RunSingleClick(Sender: TObject);
begin 
  if Not(ClickOnButtonTree(vstList)) then
  begin
    if (LauncherOptions.RunSingleClick) then
      RunExe(Sender);
    ShowCard(Sender as TVirtualStringTree);
  end;
end;

procedure TfrmMain.vstListCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PTreeData;
begin
  Data1 := vstList.GetNodeData(Node1);
  Data2 := vstList.GetNodeData(Node2);
  if (Not Assigned(Data1)) or (Not Assigned(Data2)) then
    Result := 0
  else
    if (Data1.Tipo = 0) <> (Data2.Tipo = 0) then
    begin
      if Data1.Tipo = 0 then
        Result := -1
      else
        Result := 1
    end
    else
      Result := CompareText(Data1.Name, Data2.Name);
end;

procedure TfrmMain.vstListDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
  Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  I          : integer;
  PathTemp   : string;
  HDrop      : THDrop;
  Node       : pVirtualNode;
  NodeData   : PTreeData;
  AttachMode : TVTNodeAttachMode;
begin
  tmCheckList.Enabled := false;
  case Mode of
    dmAbove  : AttachMode := amInsertBefore;
    dmOnNode : AttachMode := amAddChildLast;
    dmBelow  : AttachMode := amInsertAfter;
  else
    AttachMode := amNowhere;
  end;
  if Assigned(DataObject) then
  begin
    NodeData := Sender.GetNodeData(Sender.DropTargetNode);
    HDrop    := THDrop.Create;
    try
      if HDrop.LoadFromDataObject(DataObject) then
        for I := 0 to HDrop.FileCount - 1 do
        begin
          PathTemp := HDrop.FileName(I);
          if (PathTemp <> '') then
            if (Mode = dmOnNode) then
            begin
              if (NodeData.tipo = 0) then
              begin
                Node := Sender.InsertNode(Sender.DropTargetNode, AttachMode);
                DragDropFile(Sender,ImageList1,Node,PathTemp);
              end;
            end
            else begin
              if Sender.DropTargetNode = nil then
                Node := Sender.AddChild(nil)
              else
                Node := Sender.InsertNode(Sender.DropTargetNode, AttachMode);
              DragDropFile(Sender,ImageList1,Node,PathTemp);
            end;
        end;
    finally
      HDrop.Free;
    end;
    if Mode = dmOnNode then
    begin
      if NodeData.tipo = 0 then
        for I := 0 to High(Formats) do
          if Formats[I] = CF_VIRTUALTREE then
            Sender.ProcessDrop(DataObject, Sender.DropTargetNode, Effect, AttachMode);
    end
    else begin
      for I := 0 to High(Formats) do
        if Formats[I] = CF_VIRTUALTREE then
          Sender.ProcessDrop(DataObject, Sender.DropTargetNode, Effect, AttachMode);
    end;
    RefreshList(vstList,pmTrayicon, true);
  end;
  EnableTimerCheckList(Sender);
end;

procedure TfrmMain.vstListDragOver(Sender: TBaseVirtualTree; Source: TObject;
  Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
  var Effect: Integer; var Accept: Boolean);
begin
  accept := true;
end;

procedure TfrmMain.vstListFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData : PTreeData;
  I        : Integer;
begin
  NodeData := Sender.GetNodeData(Node);
  //Hotkey
  if Not(ShutdownTime) then
  begin
    for I := 1 to Length(HotKeyApp) do
      if (HotKeyApp[I] = Node) then
        UnregisterHotKey(Handle,I);
    if (NodeData.Tipo = 1) and FileExists(NodeData.PathCache) then
      DeleteFile(NodeData.PathCache);
    if (Nodedata.ShortcutDesktop) then
      DeleteShortcutOnDesktop('\' + Nodedata.Name + '.lnk');
    MRUList.Remove(Node);
  end;
end;

procedure TfrmMain.ShowProperty(Sender: TObject);
begin
  if (pcList.ActivePageIndex = 0) and Assigned(vstList.FocusedNode) then
  begin
    GetProperty(vstList,nil,true);
    ShowCard(vstList);
  end
  else
    if (pcList.ActivePageIndex = 1) and Assigned(vstSearch.FocusedNode) then
    begin
      GetProperty(vstList,vstSearch,false);
      ShowCard(vstSearch);
    end;
  RefreshList(vstList,pmTrayicon, true);
end;

procedure TfrmMain.miExitClick(Sender: TObject);
begin
  Hide;
  ShutdownTime := True;
  if IsFormOpen('frmCard') then
    frmCard.Close;
  Close;
end;

procedure TfrmMain.miExportListClick(Sender: TObject);
begin
  if (SaveDialog1.Execute) then
    SaveFileXML(vstList, SaveDialog1.FileName);
  SetCurrentDir(ApplicationPath);
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if IsFormOpen('frmMenu') then
    frmMenu.CloseMenu;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I        : Integer;
  NodeData : PTreeData;
begin
  ShutdownTime := True;
  if Not(SaveFileXML(vstList, LauncherFileNameXML)) then
    showmessage(ArrayMessages[18]);
  if LauncherOptions.HotKey then
    for I := 1 to Length(HotKeyApp) do
      UnregisterHotKey(Handle,I);
  DeleteFile('ASuiteTemp.xml');
  //Autorun - Execute software
  for I := 0 to ASuiteShutdownApp.Count - 1 do
  begin
    NodeData := vstList.GetNodeData(ASuiteShutdownApp[I]);
    if (LauncherOptions.Autorun) then
      RunProcess(vstList, NodeData, False);
  end;         
  //Execute actions on asuite's shutdown (inside vstList)
  ActionsOnShutdownInsideTree(vstList);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Not(LauncherOptions.TrayIcon) then
    CanClose := True
  else
    CanClose := (ShutdownTime or SessionEnding);
  if not (CanClose) then
  begin
    CoolTrayIcon1.HideMainForm;
    CoolTrayIcon1.IconVisible := True;
    if IsFormOpen('frmCard') then
      frmCard.Close;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Icon         : TIcon;
  I            : Integer;
  BackupSearch : TSearchRec;
  BackupList   : TStringList;
  cTempo1,cTempo2 : Cardinal;
  myTextFile   : TextFile;
  XMLLoad      : TXMLDocument;
  NodeData     : PTreeData;
begin
  cTempo1      := GetTickCount;
  StartUpTime  := True;
  ShutdownTime := False;
  pcList.ActivePageIndex := 0;
  ApplicationPath := ExtractFileDir(Application.ExeName) + '\';
  SetCurrentDir(ApplicationPath);     
  MenuList     := TNodeList.Create(-1);
  LauncherOptions.RefreshMenuTheme := True;
  //Create TNodeLists for autorun and set NodeDataSize
  ASuiteStartUpApp  := TNodeList.Create(-1);
  ASuiteShutdownApp := TNodeList.Create(-1);
  vstList.NodeDataSize   := SizeOf(TTreeData);
  vstSearch.NodeDataSize := SizeOf(TTreeDataX);
  //File ASuite.xml (or custom name)
  if (ExtractFileExt(ParamStr(1)) = '.xml') and FileExists(ParamStr(1)) then
    LauncherFileNameXML := ParamStr(1)
  else
    LauncherFileNameXML := 'ASuite.xml';
  //Create xml parser for list
  XMLLoad := TXMLDocument.Create(self);
  with XMLLoad do
  begin
    if FileExists(LauncherFileNameXML) then
    begin
      try
        FileName := LauncherFileNameXML;
        Active   := True;
      except
        ShowMessage(ArrayMessages[10]);
      end;
    end
    else begin
      Active := True;
      AddChild('ASuite');
      DocumentElement.AddChild('category');
    end;
  end;
  //Load/update Options and load scan settings
  LoadOptionsXML(XMLLoad.DocumentElement.ChildNodes['Option']);
  UpdateOptions;
  LoadScanSettingsXML(XMLLoad.DocumentElement.ChildNodes['Option'].ChildNodes['ScanFolder']);
  //Translate form in <LangName>
  TranslateForm(LauncherOptions.LangName);
  //Read Only Mode
  with LauncherOptions do
  begin
    ReadOnlyMode := GetDriveType(PChar(ExtractFileDrive(ParamStr(0)))) = DRIVE_CDROM;
    if (ReadOnlyMode) then
    begin
      Cache  := false;
      Backup := false;
      MRU    := false;
      miOptions1.Enabled  := false;
      miSaveList1.Enabled := false;
    end;
  end;
  //Fix Icon32Bit
  ConvertTo32BitImageList(ImageList1);
  //Loading icons
  for I := 1 to 14 do
    try
      Icon := TIcon.Create;
      Icon.LoadFromFile(PathIcons + IntToStr(I) + '.ico');
      ImageList1.addicon(Icon);
      Icon.Free;
    except
      ShowMessageFmt(ArrayMessages[16], [IntToStr(I) + '.ico']);
    end;
  //Backup
  if (LauncherOptions.Backup) then
  begin
    if not(DirectoryExists('Backup')) then
      CreateDir('Backup');
    CopyFile(PChar(LauncherFileNameXML),PChar('Backup\ASuite_' + GetDateTime + '.bck'),
      false);
    BackupList := TStringList.Create;
    if FindFirst(ApplicationPath + 'Backup\ASuite_*.bck', faAnyFile, BackupSearch) = 0 then
    begin
      repeat
        BackupList.Add(BackupSearch.Name);
      until
        FindNext(BackupSearch) <> 0;
      FindClose(BackupSearch);
    end;
    //Delete old file backup
    BackupList.Sort;
    if BackupList.count > LauncherOptions.BackupNumber then
      DeleteFile('Backup\' + BackupList[0]);
    BackupList.Free;
  end;
  //Save security
  if (LauncherOptions.SaveSecurity) then
    if (FileExists('ASuiteTemp.xml')) and (MessageDlg(ArrayMessages[21],mtWarning, [mbYes,mbNo], 0) = mrYes) then
    begin
      XMLLoad.Active   := False;
      XMLLoad.FileName := 'ASuiteTemp.xml';
      XMLLoad.Active   := True;
    end
    else begin
      CopyFile(PChar(LauncherFileNameXML),PChar('ASuiteTemp.xml'),false)
    end;
  //List
  LoadListXML(vstList,XMLLoad.DocumentElement.ChildNodes.First);
  //Autorun - Execute software
  for I := 0 to ASuiteStartUpApp.Count - 1 do
  begin
    NodeData := vstList.GetNodeData(ASuiteStartUpApp[I]);
    if (LauncherOptions.Autorun) then
      RunProcess(vstList, NodeData, True);
  end;
  //Load MRU
  LoadMRUXML(XMLLoad.DocumentElement.ChildNodes['MRU'],vstList);
  RefreshList(vstList, pmTrayicon, false);
  XMLLoad.Active := false;
  XMLLoad.Free;
  //Timers
  StartUpTime := false;
  EnableTimerCheckList(Sender);
  tmScheduler.Enabled := true;

  //Timing startup
  if ParamStr(1) = 'debug' then
  begin
    cTempo2 := GetTickCount;
//    ShowMessageFmt('Caricato in %d ms',[cTempo2 - cTempo1]);
    AssignFile(myTextFile, 'Debug.txt');
    if Not(FileExists('Debug.txt')) then
      ReWrite(myTextFile)
    else
      Append(myTextFile);
    WriteLn(myTextFile, IntToStr(cTempo2 - cTempo1));
    CloseFile(myTextFile);
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  //Fix memory leaks
  FreeAndNil(MRUList);    
  FreeAndNil(MenuList);
  FreeAndNil(ASuiteStartUpApp);
  FreeAndNil(ASuiteShutdownApp);
  FreeAndNil(ScanSettings.FileTypes);
  FreeAndNil(ScanSettings.ExcludeFiles);
end;

procedure TfrmMain.WMQueryEndSession(var Message: TMessage);
begin
  SessionEnding  := True;
  Message.Result := 1;
end;

procedure TfrmMain.WMEndSession(var Msg : TWMEndSession);
begin
  //Close ASuite on Windows shutdown
  if Msg.EndSession = True then
  begin
    Hide;
    ShutdownTime := True;
    if IsFormOpen('frmCard') then
      frmCard.Close;
    Close;
  end;
end;   

procedure TfrmMain.WMMoving(var Msg: TWMMoving);
var
  Point : TPoint;
begin
  GetCursorPos(Point);
  if IsFormOpen('frmCard') and (Card.SideMagnet <> smNone) then
  begin
    frmCard.ScreenSnap := False;
    case SideMagnet of
    smLeft:
      begin
        frmCard.Left := Left + frmMain.Width;
        frmCard.Top  := frmCard.Top - (OldPoint.Y - Point.Y);
      end;
    smTop:
      begin
        frmCard.Left := frmCard.Left - (OldPoint.X - Point.X);
        frmCard.Top  := Top + frmMain.Height;
      end;
    smRight:
      begin
        frmCard.Left := Left - frmCard.Width;
        frmCard.Top  := frmCard.Top - (OldPoint.Y - Point.Y);
      end;
    smBottom:
      begin
        frmCard.Left := frmCard.Left - (OldPoint.X - Point.X);
        frmCard.Top  := Top - frmCard.Height;
      end;
    end;
    frmCard.ScreenSnap := True;
  end;
  OldPoint := Point;
end;

procedure TfrmMain.WMEnterSizeMove(var Message: TMessage);
begin
  GetCursorPos(OldPoint);
end;

Procedure TfrmMain.WMHotKey(Var Msg : TWMHotKey);
var
  NodeData : PTreeData;
begin
  if LauncherOptions.HotKey then
  begin
    //Show frmMain or execute a software (or group)
    if Msg.HotKey = Integer(frmMain.Handle) then
    begin
      if frmMain.Showing then
        CoolTrayIcon1.HideMainForm
      else
        ShowMainForm(self);
    end
    else begin
      if Msg.HotKey = frmMenuID then
      begin
        ShowTrayiconMenu(vstList, pmTrayicon);
      end
      else begin
        NodeData := vstList.GetNodeData(HotKeyApp[Msg.HotKey]);
        if Assigned(NodeData) then
        begin
          if (NodeData.Tipo <> 0) then
          begin
            RunProcess(vstList, NodeData,false);
            AddMRU(vstList,pmTrayicon,NodeData.pNode,NodeData.DontInsertMRU);
            RunActionOnExe(NodeData);
          end;
        end
        else begin
          showmessage(ArrayMessages[9]);
          exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ShowCard(Sender: TBaseVirtualTree);
var
  NodeDataList   : PTreeData;
begin
  if (pcList.ActivePageIndex = 1) and Assigned(vstSearch.FocusedNode) then
    NodeDataList := NodeDataXToNodeDataList(vstSearch.FocusedNode)
  else
    NodeDataList := vstList.GetNodeData(vstList.FocusedNode);
  if (LauncherOptions.ActiveFormCard) and Assigned(NodeDataList) then
  begin
    if (NodeDataList.Tipo = 1) and Not(LauncherOptions.RunSingleClick) then
    begin
      if not IsFormOpen('frmCard') then
        Application.CreateForm(TfrmCard, frmCard);
      frmCard.show;
      frmCard.GetInfoCard(vstList,NodeDataList.pNode);
      Application.MainForm.FocusControl(Sender);
    end
    else
      if IsFormOpen('frmCard') then
        frmCard.close;
  end;
end;

end.
