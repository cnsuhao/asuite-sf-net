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
    tvMenuButtons: TTreeView;
    pnlSettings: TPanel;
    cbActiveButton: TCheckBox;
    edtPathIcon: TEdit;
    lbPathIcon: TLabel;
    edtPathExe: TEdit;
    lbPathExe: TLabel;
    edtName: TEdit;
    lbName: TLabel;
    btnBrowseExe: TButton;
    btnBrowseIcon: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Browse(Sender: TObject);
    procedure tvMenuButtonsClick(Sender: TObject);
  private
    procedure PopulateSettingsComponents;
    procedure TranslateForm(Lingua:string);
    procedure SaveActualButtonSettings;
    { Private declarations }
  public
    { Public declarations }
  end; 

  TMenuButtons = record
    Name     : string;
    PathExe  : string;
    PathIcon : string;
    Enable   : Boolean;
  end;

var
  frmMenuButtons : TfrmMenuButtons;
  varMenuButtons : array[0..7] of TMenuButtons;
  ButtonIndex    : Integer;

implementation

uses Main, CommonUtils;

{$R *.dfm} 

procedure TfrmMenuButtons.TranslateForm(Lingua:string);
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form12'] do
  begin
    Caption                := ChildNodes['Form12Caption'].Text;
    lbName.Caption         := ChildNodes['LabelName'].Text;
    lbPathExe.Caption      := ChildNodes['LabelPathExe'].Text;
    lbPathIcon.Caption     := ChildNodes['LabelPathIcon'].Text;
    cbActiveButton.Caption := ChildNodes['CheckBoxActiveButton'].Text;
    btnBrowseExe.Caption   := ChildNodes['ButtonBrowse'].Text;
    btnBrowseIcon.Caption  := ChildNodes['ButtonBrowse'].Text;
    btnCancel.Caption      := ChildNodes['ButtonCancel'].Text;
    btnOk.Caption          := ChildNodes['ButtonOk'].Text;
  end;
end;

procedure TfrmMenuButtons.PopulateSettingsComponents;
begin
  edtName.Text     := varMenuButtons[ButtonIndex].Name;
  edtPathExe.Text  := varMenuButtons[ButtonIndex].PathExe;
  edtPathIcon.Text := varMenuButtons[ButtonIndex].PathIcon;
  cbActiveButton.Checked := varMenuButtons[ButtonIndex].Enable;
end;

procedure TfrmMenuButtons.SaveActualButtonSettings;
begin
  //Save actual button's settings
  varMenuButtons[ButtonIndex].Name     := edtName.Text;
  varMenuButtons[ButtonIndex].PathExe  := edtPathExe.Text;
  varMenuButtons[ButtonIndex].PathIcon := edtPathIcon.Text;
  varMenuButtons[ButtonIndex].Enable   := cbActiveButton.Checked;
end;

procedure TfrmMenuButtons.tvMenuButtonsClick(Sender: TObject);
var
  I : Integer;
begin
  //Save actual button's settings
  SaveActualButtonSettings;
  //Set new ButtonIndex and populate settings
  ButtonIndex := tvMenuButtons.Selected.Index;
  PopulateSettingsComponents;  
  for I := 0 to Length(varMenuButtons) - 1 do
    tvMenuButtons.Items[I].Text := varMenuButtons[I].Name;
end;

procedure TfrmMenuButtons.Browse(Sender: TObject);
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
    OpenDialog1.Filter     := 'Files supported (*.ico)|*.ico|All files|*.*';
    OpenDialog1.InitialDir := ExtractFileDir(RelativeToAbsolute(edtPathIcon.Text));
  end;
  if (sender = btnBrowseExe) or
     (sender = btnBrowseIcon) then
  begin
    if (OpenDialog1.Execute) then
    begin
      PathTemp := AbsoluteToRelative(OpenDialog1.FileName);
      if (sender = btnBrowseExe) then
        edtPathExe.text    := PathTemp;
      if (sender = btnBrowseIcon) then
        edtPathIcon.text   := PathTemp;
    end;
  end;
  SetCurrentDir(ApplicationPath);
end;

procedure TfrmMenuButtons.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenuButtons.btnOkClick(Sender: TObject);
var
  I : Integer;
begin
  SaveActualButtonSettings;
  for I := 0 to 7 do
    LauncherOptions.TrayMenuButtons[I] := varMenuButtons[I];
  Close;
end;

procedure TfrmMenuButtons.FormCreate(Sender: TObject);
var
  I : Integer;
begin
  TranslateForm(LauncherOptions.LangName);
  for I := 0 to Length(LauncherOptions.TrayMenuButtons) - 1 do
  begin
    varMenuButtons[I] := LauncherOptions.TrayMenuButtons[I];
    tvMenuButtons.Items[I].Text := varMenuButtons[I].Name;
  end;
  ButtonIndex := 0;
  PopulateSettingsComponents;
end;

end.
