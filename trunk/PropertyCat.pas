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

unit PropertyCat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ExtCtrls;

type
  TfrmPropertyCat = class(TForm)
    edtName: TEdit;
    lbName: TLabel;
    btnCancel: TButton;
    btnOk: TButton;
    Panel1: TPanel;
    lbPathIcon: TLabel;
    edtPathIcon: TEdit;
    btnBrowseIcon: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnBrowseIconClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure TranslateForm(Lingua: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPropertyCat : TfrmPropertyCat;

implementation

uses Main, CommonUtils;

{$R *.dfm}

procedure TfrmPropertyCat.TranslateForm(Lingua:string);
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form45'] do
  begin
    Caption            := ChildNodes['Form45Caption'].Text;
    lbName.Caption     := ChildNodes['LabelName'].Text;
    lbPathIcon.Caption := ChildNodes['LabelPathIcon'].Text;
    btnBrowseIcon.Caption := ChildNodes['ButtonBrowse'].Text;
    //Buttons
    btnOk.Caption      := ChildNodes['ButtonOk'].Text;
    btnCancel.Caption  := ChildNodes['ButtonCancel'].Text;
  end;
end;

procedure TfrmPropertyCat.btnBrowseIconClick(Sender: TObject);
begin
  OpenDialog1.Filter     := 'Files supported (*.ico;*.exe)|*.ico;*.exe|All files|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(RelativeToAbsolute(edtPathIcon.Text));
  if (OpenDialog1.Execute) then
    edtPathIcon.text := AbsoluteToRelative(OpenDialog1.FileName);
  SetCurrentDir(ApplicationPath);
end;

procedure TfrmPropertyCat.btnOkClick(Sender: TObject);
begin
  try
    if edtName.Text = '' then
    begin
      ShowMessage(ArrayMessages[12]);
      exit;
    end;
    VNDataCat.Name     := StringReplace(edtName.Text, '&&', '&', [rfIgnoreCase,rfReplaceAll]);
    VNDataCat.Name     := StringReplace(VNDataCat.Name, '&', '&&', [rfIgnoreCase,rfReplaceAll]);
    VNDataCat.PathIcon := edtPathIcon.Text;
    //Update file icon-cache
    if FileExists(VNDataCat.PathCache) then
    begin
      DeleteFile(VNDataCat.PathCache);
      VNDataCat.PathCache := '';
    end;
    VNDataCat.ImageIndex  := IconAdd(frmMain.vstList, frmMain.ImageList1, 
      VNDataCat.pNode);
    NewNode               := true;
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

procedure TfrmPropertyCat.btnCancelClick(Sender: TObject);
begin
  close;
  NewNode := false;
end;

procedure TfrmPropertyCat.FormCreate(Sender: TObject);
begin
  TranslateForm(LauncherOptions.LangName);
  try
    edtName.Text     := VNDataCat.name;
    edtPathIcon.Text := VNDataCat.PathIcon;
  except
    on E : Exception do
      ShowMessageFmt(ArrayMessages[11],[E.ClassName,E.Message]);
  end;
end;

end.
