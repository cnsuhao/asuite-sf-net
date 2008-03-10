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

unit OrderSoftware;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, CommonClasses, VirtualTrees;

type
  TfrmOrderSoftware = class(TForm)
    lxOrderSoftware: TListBox;
    bbtnUp: TBitBtn;
    bbtnDown: TBitBtn;
    lbInfoOrder: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    Panel1: TPanel;       
    procedure TranslateForm(Lingua: string);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbtnUpClick(Sender: TObject);
    procedure bbtnDownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOrderSoftware : TfrmOrderSoftware;
  StartupMode      : Boolean; //True Startup, False Shutdown

implementation    

uses Main, PropertySw, PropertyGroup;

{$R *.dfm}    

procedure TfrmOrderSoftware.TranslateForm(Lingua:string);
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form10'] do
  begin
    Caption            := ChildNodes['Form10Caption'].Text;  
    if StartupMode then 
      lbInfoOrder.Caption := ChildNodes['LabelInfoStartupOrder'].Text 
    else
      lbInfoOrder.Caption := ChildNodes['LabelInfoShutdownOrder'].Text;  
    //Buttons
    btnOk.Caption      := ChildNodes['ButtonOk'].Text;
    btnCancel.Caption  := ChildNodes['ButtonCancel'].Text;
  end;
end;

procedure TfrmOrderSoftware.bbtnDownClick(Sender: TObject);  
var
  CurrIndex: Integer;
begin
  with lxOrderSoftware do  
  begin
    CurrIndex := ItemIndex;
    if (CurrIndex <> (-1 and (Count - 1))) and (Count <> 0)  then
    begin
      Items.Move(CurrIndex,CurrIndex + 1);
      Selected[CurrIndex + 1] := True;
    end;       
  end;
end;

procedure TfrmOrderSoftware.bbtnUpClick(Sender: TObject);
var
  CurrIndex: Integer;
begin
  with lxOrderSoftware do
  begin
    CurrIndex := ItemIndex;
    if (CurrIndex <> (-1 and 0)) and (Count <> 0)  then
    begin
      Items.Move(CurrIndex,CurrIndex - 1);
      Selected[CurrIndex - 1] := True;
    end;
  end;
end;

procedure TfrmOrderSoftware.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOrderSoftware.btnOkClick(Sender: TObject);
var
  I        : Integer;
  NodeData : PTreeData;
begin
  if StartupMode then
  begin
    ASuiteStartupApp.Clear;
    for I := 0 to lxOrderSoftware.Count - 1 do
    begin    
      NodeData := frmMain.vstList.GetNodeData(PVirtualNode(lxOrderSoftware.Items.Objects[I]));
      NodeData.AutorunPos := ASuiteStartupApp.Add(NodeData.pNode);
    end;
  end
  else begin              
    ASuiteShutdownApp.Clear;
    for I := 0 to lxOrderSoftware.Count - 1 do
    begin
      NodeData := frmMain.vstList.GetNodeData(PVirtualNode(lxOrderSoftware.Items.Objects[I]));
      NodeData.AutorunPos := ASuiteShutdownApp.Add(NodeData.pNode);
    end;
  end;
  Close;
end;

procedure TfrmOrderSoftware.FormCreate(Sender: TObject);
begin
  TranslateForm(LauncherOptions.LangName);
end;

procedure TfrmOrderSoftware.FormShow(Sender: TObject);  
var
  I        : Integer;
  NodeData : PTreeData;
begin
  lxOrderSoftware.Clear;
  lxOrderSoftware.Items.BeginUpdate;
  if StartupMode then
  begin  
    for I := 0 to ASuiteStartupApp.Count - 1 do
    begin
      NodeData := frmMain.vstList.GetNodeData(ASuiteStartupApp[I]);
      if Assigned(NodeData) then
        lxOrderSoftware.Items.AddObject(NodeData.Name, ASuiteStartupApp[I]);
    end;
  end
  else begin  
    for I := 0 to ASuiteShutdownApp.Count - 1 do
    begin
      NodeData := frmMain.vstList.GetNodeData(ASuiteShutdownApp[I]);
      if Assigned(NodeData) then
        lxOrderSoftware.Items.AddObject(NodeData.Name, ASuiteShutdownApp[I]);
    end;
  end;
  lxOrderSoftware.Items.EndUpdate;
end;

end.
