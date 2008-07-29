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

unit MenuButtons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmMenuButtons = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    OpenDialog1: TOpenDialog;
    pgcMenuFolders: TPageControl;
    tsButton1: TTabSheet;
    tsButton2: TTabSheet;
    tsButton3: TTabSheet;
    tsButton4: TTabSheet;
    tsButton5: TTabSheet;
    tsButton6: TTabSheet;
    tsButton7: TTabSheet;
    lbName1: TLabel;
    edtName1: TEdit;
    lbPathExe: TLabel;
    edtPathExe1: TEdit;
    lbPathIcon1: TLabel;
    edtPathIcon1: TEdit;
    btnBrowseB1: TButton;
    btnBrowseA1: TButton;
    cbActiveButton1: TCheckBox;
    lbName2: TLabel;
    edtName2: TEdit;
    lbPathExe2: TLabel;
    edtPathExe2: TEdit;
    btnBrowseA2: TButton;
    lbPathIcon2: TLabel;
    edtPathIcon2: TEdit;
    cbActiveButton2: TCheckBox;
    btnBrowseB2: TButton;
    lbName3: TLabel;
    edtName3: TEdit;
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
  frmMenuButtons: TfrmMenuButtons;

implementation

uses Main, CommonUtils;

{$R *.dfm} 

procedure TfrmMenuButtons.TranslateForm(Lingua:string);
var
  TempString : String;
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form12'] do
  begin
    //ToDo
  end;
end;

procedure TfrmMenuButtons.Browse(Sender: TObject);
var
  PathTemp : String;
begin
  //ToDo
end;

procedure TfrmMenuButtons.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenuButtons.btnOkClick(Sender: TObject);
begin   
  //ToDo
end;

procedure TfrmMenuButtons.FormCreate(Sender: TObject);
var
  I : Integer;
begin
  TranslateForm(LauncherOptions.LangName);
  //ToDo
end;

end.
