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

unit MenuFolders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmMenuFolders = class(TForm)
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    lbRoot: TLabel;
    edtFolderName0: TEdit;
    edtFolderPath0: TEdit;
    edtFolderName1: TEdit;
    edtFolderPath1: TEdit;
    edtFolderName2: TEdit;
    edtFolderPath2: TEdit;
    lbFolderName: TLabel;
    lbFolderPath: TLabel;
    edtFolderName3: TEdit;
    edtFolderPath3: TEdit;
    btnBrowse0: TButton;
    btnBrowse1: TButton;
    btnBrowse2: TButton;
    btnBrowse3: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Browse(Sender: TObject);
  private
    procedure TranslateForm(Lingua:string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuFolders: TfrmMenuFolders;
  edtsFolderName : Array[0..3] of TEdit; //0 Documents, 1 Music
  edtsFolderPath : Array[0..3] of TEdit; //2 Pictures, 3 Video

implementation

uses Main, CommonUtils;

{$R *.dfm} 

procedure TfrmMenuFolders.TranslateForm(Lingua:string);
var
  TempString : String;
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form12'] do
  begin
    Caption                := ChildNodes['Form12Caption'].Text; 
    lbFolderName.caption   := ChildNodes['LabelFolderName'].Text;
    lbFolderPath.caption   := ChildNodes['LabelFolderPath'].Text;
    TempString             := ChildNodes['ButtonBrowse'].Text;
    btnBrowse0.caption     := TempString;
    btnBrowse1.caption     := TempString;
    btnBrowse2.caption     := TempString;
    btnBrowse3.caption     := TempString;
    btnOk.caption          := ChildNodes['ButtonOk'].Text;
    btnCancel.caption      := ChildNodes['ButtonCancel'].Text;
  end;
end;

procedure TfrmMenuFolders.Browse(Sender: TObject);
var
  PathTemp : String;
begin
  PathTemp := BrowseForFolder('',ApplicationPath);
  if Sender = btnBrowse0 then
    edtFolderPath0.Text := AbsoluteToRelative(PathTemp)
  else
    if Sender = btnBrowse1 then
      edtFolderPath1.Text := AbsoluteToRelative(PathTemp)
    else
      if Sender = btnBrowse2 then
        edtFolderPath2.Text := AbsoluteToRelative(PathTemp)
      else
        if Sender = btnBrowse3 then
          edtFolderPath3.Text := AbsoluteToRelative(PathTemp);
  SetCurrentDir(ApplicationPath);
end;

procedure TfrmMenuFolders.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenuFolders.btnOkClick(Sender: TObject);  
var
  I : Integer;
begin 
  for I := 0 to 3 do
  begin
    LauncherOptions.MenuFolderName[I] := edtsFolderName[I].Text;
    LauncherOptions.MenuFolderPath[I] := edtsFolderPath[I].Text;
  end;
  Close;
end;

procedure TfrmMenuFolders.FormCreate(Sender: TObject);
var
  I : Integer;
begin   
  TranslateForm(LauncherOptions.LangName);
  edtsFolderName[0] := edtFolderName0;
  edtsFolderPath[0] := edtFolderPath0;
  edtsFolderName[1] := edtFolderName1;
  edtsFolderPath[1] := edtFolderPath1;
  edtsFolderName[2] := edtFolderName2;
  edtsFolderPath[2] := edtFolderPath2;
  edtsFolderName[3] := edtFolderName3;
  edtsFolderPath[3] := edtFolderPath3;
  for I := 0 to 3 do
  begin
    edtsFolderName[I].Text := LauncherOptions.MenuFolderName[I];   
    edtsFolderPath[I].Text := LauncherOptions.MenuFolderPath[I];
  end;
  lbRoot.Caption := Format(lbRoot.Caption,[ExtractFileDrive(ApplicationPath)[1] + ':']);
end;

end.
