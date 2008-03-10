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

unit ImportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, VirtualTrees, xmldom, XMLIntf,
  msxmldom, XMLDoc, IniFiles;

type
  TfrmImportList = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lbPathList: TLabel;
    edtPathList: TEdit;
    lbInfoList: TLabel;
    btnBrowse: TButton;
    XMLDocument1: TXMLDocument;
    OpenDialog1: TOpenDialog;
    vstListImp: TVirtualStringTree;
    btnSelectAll: TButton;
    btnDeselectAll: TButton;
    Panel1: TPanel;
    procedure btnDeselectAllClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure vstListImpGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormCreate(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure XML2TreeImp(Tree: TVirtualStringTree;XMLDoc: TXMLDocument);
    procedure Ini2TreeImp(Tree: TVirtualStringTree;IniFile: TIniFile);
    function  TreeImp2Tree(TreeImp, Tree: TVirtualStringTree): Boolean;
    procedure TranslateForm(Lingua:string);
    function  GetNumberNodeImp(Sender: TBaseVirtualTree): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportList : TfrmImportList;
  PathListImp   : String;
  IniFile       : TIniFile;

implementation

{$R *.dfm}

uses Main, CommonUtils;

procedure TfrmImportList.TranslateForm(Lingua:string);
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form6'] do
  begin
    Caption                := ChildNodes['Form6Caption'].Text;
    lbPathList.caption     := ChildNodes['LabelPathList'].Text;
    lbInfoList.caption     := ChildNodes['LabelList'].Text;
    btnSelectAll.caption   := ChildNodes['ButtonSelectAll'].Text;
    btnDeselectAll.caption := ChildNodes['ButtonDeSelectAll'].Text;
    btnBrowse.caption      := ChildNodes['ButtonBrowse'].Text;
    btnOk.caption          := ChildNodes['ButtonOk'].Text;
    btnCancel.caption      := ChildNodes['ButtonCancel'].Text;
  end;
end;

procedure TfrmImportList.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmImportList.btnBrowseClick(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFileDir(edtPathList.text);
  if (OpenDialog1.Execute) then
  begin
    PathListImp          := OpenDialog1.FileName;
    edtPathList.text := PathListImp;
    if FileExists(PathListImp) <> false then
    begin
    if LowerCase(ExtractFileExt(PathListImp)) = '.xml' then
    begin
      XMLDocument1.FileName := PathListImp;
      XMLDocument1.Active := True;
      XML2TreeImp(vstListImp,XMLDocument1);
    end
    else
      if LowerCase(ExtractFileExt(PathListImp)) = '.ini' then
        Ini2TreeImp(vstListImp,IniFile);
    end
    else
      Showmessage(ArrayMessages[1]);
  end;
  SetCurrentDir(ApplicationPath);
end;

procedure TfrmImportList.btnOkClick(Sender: TObject);
begin
  if Not(TreeImp2Tree(vstListImp,frmMain.vstList)) then
    showmessage(ArrayMessages[20]);
  close;
end;

procedure TfrmImportList.btnSelectAllClick(Sender: TObject);
var
  tnImp : pVirtualNode;
begin
  tnImp    := vstListImp.GetFirst;
  while Assigned(tnImp) do
  begin
    vstListImp.CheckState[tnImp] := csCheckedNormal;
    tnImp := tnImp.NextSibling;
  end;
end;

procedure TfrmImportList.btnDeselectAllClick(Sender: TObject);
var
  tnImp : pVirtualNode;
begin
  tnImp := vstListImp.GetFirst;
  while Assigned(tnImp) do
  begin
    vstListImp.CheckState[tnImp] := csUncheckedNormal;
    tnImp := tnImp.NextSibling;
  end;
end;

procedure TfrmImportList.FormCreate(Sender: TObject);
begin
  vstListImp.NodeDataSize := SizeOf(TTreeData);
  TranslateForm(LauncherOptions.LangName);
end;

procedure TfrmImportList.vstListImpGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  NodeData : PTreeData;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData.Name;
  if CellText = '-' then
    CellText := StringReplace(CellText, '-', '---------------------------------', [rfIgnoreCase,rfReplaceAll]);
end;

procedure TfrmImportList.XML2TreeImp(Tree: TVirtualStringTree;XMLDoc: TXMLDocument);
var
  iNode : IXMLNode;
  procedure ProcessNode(Node : IXMLNode;tn : PVirtualNode);
  var
    cNode, xNode : IXMLNode;
    NodeData     : PTreeData;
    ArrayIndex   : Integer; 
    S, S2, S3    : String;
  begin
    if Node = nil then Exit;
    with Node do
    begin
      if (not(Attributes['name'] = null) or (NodeName = 'Separator')) and
         ((NodeName = 'file') or (NodeName = 'files') or
         (NodeName = 'Software') or (NodeName = 'Category') or
         (NodeName = 'GroupSoftware') or (NodeName = 'Separator')) then
      begin
        tn                    := tree.AddChild(tn);
        Tree.CheckType[tn]    := ctTriStateCheckBox;
        NodeData              := Tree.GetNodeData(tn);
        NodeData.pNode        := tn;
        if (NodeName = 'files') or (Node.NodeName = 'Category') then
          NodeData.Tipo       := 0
        else
          if (NodeName = 'file') or (Node.NodeName = 'Software') then
            NodeData.Tipo       := 1
          else
            if NodeName = 'GroupSoftware' then
              NodeData.Tipo       := 2
            else
              if NodeName = 'Separator' then
              begin
                NodeData.Name       := '-';
                NodeData.Tipo       := 4;
                NodeData.ImageIndex := -1;
                Exit;
              end;
        //ASuite 1.x, wPPL 1.x, PStart 2.0x
        NodeData.Name := Attributes['name'];
        //PStart 2.0x
        if ChildNodes['website'].text <> '' then
          NodeData.WebSite    := ChildNodes['website'].Text;
        if ChildNodes['autorun'].text = 'onstartup' then
          NodeData.Autorun    := 1
        else
          if ChildNodes['autorun'].text = 'onexit' then
            NodeData.Autorun := 3;
        if ChildNodes['directory'].text <> '' then
          NodeData.WorkingDir := ChildNodes['directory'].Text;
        if ChildNodes['windowstate'].Text <> '' then
          NodeData.WindowState := StrToInt(ChildNodes['windowstate'].Text)
        else
          NodeData.WindowState := 0;
        if ChildNodes['alarm'].ChildNodes['alarmmode'].Text <> '' then
          case StrToInt(ChildNodes['alarm'].ChildNodes['alarmmode'].Text) of
            0: NodeData.SchMode := 0;
            1: NodeData.SchMode := 1;
            2..4: NodeData.SchMode := 0;
            5: NodeData.SchMode := 3;
            6: NodeData.SchMode := 2;
          end;
        if ChildNodes['alarm'].ChildNodes['alarmtime'].Text <> '' then
        begin
          S := ChildNodes['alarm'].ChildNodes['alarmtime'].Text;
          NodeData.SchTime := Copy(S,Pos(' ',S) + 1,Length(S));
          NodeData.SchTime := StringReplace(NodeData.SchTime,':','.',[rfReplaceAll,rfIgnoreCase]);
          Delete(S,Pos(' ',S),Length(S));
          S2 := Copy(S,0,Pos('/',S) - 1);
          Delete(S,1,Pos('/',S) - 1);
          S3 := Copy(S,Length(S) - 1,Length(S) + 1);
          Delete(S,Length(S) - 1,Length(S) + 1);
          S := S3 + S + S2;
          NodeData.SchDate := S;
        end;
        //StringReplace(NodeData.SchTime,':','.',[rfReplaceAll]);
        //ASuite 1.x
        if ChildNodes['Version'].text <> '' then
          NodeData.Version    := ChildNodes['Version'].Text;
        if ChildNodes['Developer'].text <> '' then
          NodeData.Developer  := ChildNodes['Developer'].Text;
        if ChildNodes['WebSite'].text <> '' then
          NodeData.WebSite    := ChildNodes['WebSite'].Text;
        if ChildNodes['PathExe'].text <> '' then
          NodeData.PathExe[0] := ChildNodes['PathExe'].Text;
        if ChildNodes['Parameters'].text <> '' then
          NodeData.Parameters := ChildNodes['Parameters'].Text;
        if ChildNodes['PathIcon'].text <> '' then
          NodeData.PathIcon   := ChildNodes['PathIcon'].Text;
        if ChildNodes['Description'].text <> '' then
          NodeData.Desc       := ChildNodes['Description'].Text;
        if ChildNodes['Opinion'].text <> '' then
          NodeData.Opinion    := ChildNodes['Opinion'].Text;
        if ChildNodes['Notes'].text <> '' then
          NodeData.Notes      := ChildNodes['Notes'].Text;
        //ASuite 1.x, wPPL 1.x
        if ChildNodes['WorkingDir'].text <> '' then
          NodeData.WorkingDir := ChildNodes['WorkingDir'].Text;
        if ChildNodes['HotKey'].text <> '' then
          NodeData.HotKey     := StrToBool(ChildNodes['HotKey'].Text);
        if ChildNodes['HotKeyModifier'].text <> '' then
          NodeData.HKModifier := StrToInt(ChildNodes['HotKeyModifier'].Text);
        if ChildNodes['HotKeyCode'].text <> '' then
          NodeData.HKCode     := StrToInt(ChildNodes['HotKeyCode'].Text);
        if ChildNodes['Autorun'].Text <> '' then
          NodeData.Autorun    := StrToInt(ChildNodes['Autorun'].Text);
        if (ChildNodes['WindowState'].Text <> '') then
          NodeData.WindowState := StrToInt(ChildNodes['WindowState'].Text);
        if (ChildNodes['DontInsertMRU'].Text <> '') then
          NodeData.DontInsertMRU := StrToBool(ChildNodes['DontInsertMRU'].Text);
        if (ChildNodes['ShortcutDesktop'].Text <> '') then
          NodeData.ShortcutDesktop := StrToBool(ChildNodes['ShortcutDesktop'].Text);
        if (ChildNodes['ActionOnExe'].Text <> '') then
          NodeData.ActionOnExe := StrToInt(ChildNodes['ActionOnExe'].Text);
        xNode := ChildNodes.First;
        while Assigned(xNode) do
        begin
          if (Pos('PathExe', xNode.NodeName) = 1) and (xNode.NodeName <> 'PathExe') then
          begin
            ArrayIndex := GetFirstFreeIndex(NodeData.PathExe);
            NodeData.PathExe[ArrayIndex] := ChildNodes[xNode.NodeName].Text;
          end;
          xNode := xNode.NextSibling;
        end;
        if (ChildNodes['SchedulerMode'].Text <> '') then
          NodeData.SchMode := StrToInt(ChildNodes['SchedulerMode'].Text);
        if (ChildNodes['SchedulerDate'].Text <> '') then
          NodeData.SchDate := ChildNodes['SchedulerDate'].Text;
        if (ChildNodes['SchedulerTime'].Text <> '') then
          NodeData.SchTime := ChildNodes['SchedulerTime'].Text;
        if (ChildNodes['AutorunPosition'].Text <> '') then
          NodeData.AutorunPos := StrToInt(ChildNodes['AutorunPosition'].Text);
        //PStart 2.0x, wPPL 1.x
        if ChildNodes['description'].text <> '' then
          NodeData.Desc       := ChildNodes['description'].Text;
        if ChildNodes['path'].text <> '' then
          NodeData.PathExe[0] := ChildNodes['path'].Text;
        NodeData.PathExe[0]   := StringReplace(NodeData.PathExe[0], '%pdrive%', '$ASuite',[rfIgnoreCase]);
        if ChildNodes['icon'].text <> '' then
          NodeData.PathIcon   := ChildNodes['icon'].Text;
        if ChildNodes['parameters'].text <> '' then
          NodeData.Parameters := ChildNodes['parameters'].Text;
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
  Tree.Clear;
  Tree.BeginUpdate;
  iNode := XMLDoc.DocumentElement.ChildNodes.First;
  while Assigned(iNode) do
  begin
    ProcessNode(iNode,nil);
    iNode := iNode.NextSibling;
  end;
  Tree.EndUpdate;
end;

procedure TfrmImportList.Ini2TreeImp(Tree: TVirtualStringTree;IniFile: TIniFile);
var
  I, NumeroSw : Integer;
  ListaSw     : TStringList;
  tnCat, tnSw : PVirtualNode;
  NodeData    : PTreeData;
begin
  Tree.Clear;
  Tree.BeginUpdate;
  IniFile  := TIniFile.Create(PathListImp);
  ListaSw  := TStringList.Create;
  IniFile.ReadSections(ListaSw);
  NumeroSw := ListaSw.Count;
  ListaSw.Sort;
  for I := 0 to 3 do
  begin
    tnCat := tree.AddChild(nil);
    Tree.CheckType[tnCat] := ctTriStateCheckBox;
    NodeData      := Tree.GetNodeData(tnCat);
    NodeData.Name := 'Cat'+IntToStr(I);
    NodeData.Tipo := 0;
  end;
  for I := 0 to NumeroSw - 1 do
  begin
    tnCat  := GetNodeFromText(vstListImp,'Cat' +
              IntToStr(IniFile.ReadInteger(listasw[I], 'Categoria', 0)),true);
    tnSw := Tree.AddChild(tnCat);
    with IniFile do
    begin
      vstListImp.CheckType[tnSw] := ctTriStateCheckBox;
      NodeData            := tree.GetNodeData(tnSw);
      NodeData.Name       := ListaSw[I];
      NodeData.Tipo       := 1;
      NodeData.Version    := ReadString(listasw[I], 'Versione', '');
      NodeData.Developer  := ReadString(listasw[I], 'Autore', '');
      NodeData.WebSite    := ReadString(listasw[I], 'Sito', '');
      NodeData.Desc       := ReadString(listasw[I], 'Descrizione', '');
      NodeData.Opinion    := ReadString(listasw[I], 'Parere', '');
      NodeData.Notes      := ReadString(listasw[I], 'Note', '');
      NodeData.PathExe[0] := ReadString(listasw[I], 'Eseguibile', '');
    end;
  end;
  IniFile.Free;
  ListaSw.Free;
  Tree.EndUpdate;
end;

function TfrmImportList.TreeImp2Tree(TreeImp, Tree: TVirtualStringTree): Boolean;
var
  tnImp       : PVirtualNode;
  HotKeyID    : Integer;
  ProgressBar : TProgressBar;
  Dialog      : TForm;
  procedure ProcessTreeItem(tn, tnImp: PVirtualNode);
  var
    NodeData, NodeDataImp : PTreeData;
  begin
    if (tnImp = nil) then Exit;
    NodeDataImp := TreeImp.GetNodeData(tnImp);
    if (tnImp.CheckState = csCheckedNormal) or (tnImp.CheckState = csMixedNormal) then
    begin
      ProgressBar.Position := ProgressBar.Position + 1;
      Dialog.Update;
      tn             := Tree.AddChild(tn);
      NodeData       := Tree.GetNodeData(tn);
      NodeData^      := NodeDataImp^;
      NodeData.pNode := tn;
      if (NodeData.Tipo = 4) then
      begin
        NodeData.ImageIndex := -1;
        Exit;
      end;
      if (NodeData.Tipo = 1) or (NodeData.Tipo = 2) then
      begin
        if NodeData.HotKey then
          HotKeyID := AddHotkey(TreeImp,tn,HotKeyID);
        if NodeData.SchMode <> 0 then
        begin
          SetLength(SchedulerApp,Length(SchedulerApp) + 1);
          SchedulerApp[Length(SchedulerApp) - 1] := tn;
        end;
        NodeData.ImageIndex := IconAdd(frmMain.vstList, frmMain.ImageList1, tn);
      end
      else
        NodeData.ImageIndex := 1;
    end;
    tnImp := tnImp.FirstChild;
    while Assigned(tnImp) do
    begin
      ProcessTreeItem(tn, tnImp);
      tnImp := tnImp.NextSibling;
    end;
  end;
begin
  Tree.BeginUpdate;
  Dialog      := CreateDialogProgressBar(ArrayMessages[19],GetNumberNodeImp(vstListImp));
  ProgressBar := TProgressBar(Dialog.FindComponent('Progress'));
  tnImp    := TreeImp.GetFirst;
  HotKeyID := 0;
  while Assigned(tnImp) do
  begin
    ProcessTreeItem(nil, tnImp);
    tnImp := tnImp.NextSibling;
  end;
  result  := true;
  Dialog.Free;
  Tree.EndUpdate;
end;

function TfrmImportList.GetNumberNodeImp(Sender: TBaseVirtualTree): Integer;
var
  tnImp    : PVirtualNode;
  procedure ProcessTreeItem(tnImp: PVirtualNode);
  begin
    if (tnImp = nil) then Exit;
    if (tnImp.CheckState = csCheckedNormal) or (tnImp.CheckState = csMixedNormal) then
      Inc(Result);
    tnImp := tnImp.FirstChild;
    while Assigned(tnImp) do
    begin
      ProcessTreeItem(tnImp);
      tnImp := tnImp.NextSibling;
    end;
  end;
begin
  Result   := 0;
  tnImp    := Sender.GetFirst;
  while Assigned(tnImp) do
  begin
    ProcessTreeItem(tnImp);
    tnImp := tnImp.NextSibling;
  end;
end;

end.
