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

unit ClearElements;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VirtualTrees;

type
  TfrmClearElements = class(TForm)
    lbClearElements: TLabel;
    cbBackup: TCheckBox;
    cbCache: TCheckBox;
    cbRecents: TCheckBox;
    btnClear: TButton;
    btnCancel: TButton;
    Panel1: TPanel;       
    procedure TranslateForm(Lingua:string);
    procedure btnCancelClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure ClearCache(Sender: TBaseVirtualTree; Node: PVirtualNode;
                         Data: Pointer; var Abort: Boolean);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClearElements: TfrmClearElements;

implementation   

uses Main, Option, CommonUtils;

{$R *.dfm}      

procedure TfrmClearElements.TranslateForm(Lingua:string);
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form9'] do
  begin
    Caption           := ChildNodes['Form9Caption'].Text;
    lbClearElements.Caption := ChildNodes['LabelClearElements'].Text;
    cbRecents.Caption := ChildNodes['CheckBoxMRU'].Text;
    cbBackup.Caption  := ChildNodes['CheckBoxBackup'].Text;
    cbCache.Caption   := ChildNodes['CheckBoxCache'].Text;
    btnClear.Caption  := ChildNodes['ButtonClear'].Text;
    btnCancel.Caption := ChildNodes['ButtonCancel'].Text;
  end;
end;

procedure TfrmClearElements.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmClearElements.btnClearClick(Sender: TObject);
begin
  //Clear MRU
  if cbRecents.Checked then
    MRUList.Clear;
  //Clear Backup
  if cbBackup.Checked then
    DeleteFiles('Backup\','ASuite_*.bck');
  //Clear Cache
  if cbCache.Checked then
    frmMain.vstList.IterateSubtree(nil, ClearCache, nil, [], True);
  RefreshList(frmMain.vstList, frmMain.pmTrayicon, true);
  Close;
end;

procedure TfrmClearElements.ClearCache(Sender: TBaseVirtualTree; Node: PVirtualNode;
                            Data: Pointer; var Abort: Boolean);
var
  CurrentNodeData : PTreeData;
begin
  CurrentNodeData := Sender.GetNodeData(Node);
  with CurrentNodeData^ do
  begin
    if (Tipo <> 4) and (PathCache <> '') then
    begin
      DeleteFile(PathCache);
      PathCache := '';
    end;
  end;
end;

procedure TfrmClearElements.FormCreate(Sender: TObject);
begin
  TranslateForm(LauncherOptions.LangName);
end;

end.
