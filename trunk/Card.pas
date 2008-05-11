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

unit Card;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ShellApi, VirtualTrees, CommonClasses;

type
  TfrmCard = class(TForm)
    pcCard: TPageControl;
    tbHome: TTabSheet;
    GroupBox3: TGroupBox;
    lbASuiteWebSite: TLabel;
    imASuiteLogo: TImage;
    lbASuiteTitle: TLabel;
    lbASuiteVersion: TLabel;
    memIntro: TMemo;
    tbCard: TTabSheet;
    lbDesc: TLabel;
    lbOpinion: TLabel;
    lbNotes: TLabel;
    gbSoftware: TGroupBox;
    lbxSHouse: TLabel;
    lbWebSite: TLabel;
    lbxName: TLabel;
    lbxVersion: TLabel;
    memOpinion: TMemo;
    memNotes: TMemo;
    memDesc: TMemo;
    lbName: TLabel;
    lbSHouse: TLabel;
    lbVersion: TLabel;
    procedure GetInfoCard(Sender: TBaseVirtualTree;Node: PVirtualNode);
    procedure lbASuiteWebSiteClick(Sender: TObject);
    procedure TranslateForm(Lingua: string);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbWebSiteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FArea: Cardinal;
    UnMagnet: Boolean;
    OldPoint: TPoint;
    procedure WMMoving(var Msg: TWMMoving); message WM_Moving;
  public
    { Public declarations }
  end;

  TSideMagnet = (smNone, smLeft, smTop, smRight, smBottom); //None, Left, Top, Right, Bottom

var
  frmCard    : TfrmCard;
  SideMagnet : TSideMagnet;

implementation

uses Main, Menu, CommonUtils, Types;

{$R *.dfm}

procedure TfrmCard.FormActivate(Sender: TObject);
begin
  if IsFormOpen('frmMenu') then
    frmMenu.CloseMenu;
end;

procedure TfrmCard.FormCreate(Sender: TObject);
begin     
  FArea := 15;
  TranslateForm(LauncherOptions.LangName);
end;

procedure TfrmCard.FormShow(Sender: TObject);
begin
  if (frmMain.Left + frmMain.Width + Width) <= (GetDeviceCaps(GetDC(frmCard.Handle), HORZRES)) then
  begin
    Left := frmMain.Left + frmMain.Width;
    SideMagnet := smLeft;
  end
  else begin
    Left := frmMain.Left - Width;
    SideMagnet := smRight;
  end;
  Top    := frmMain.Top;
  if pcCard.ActivePageIndex = 1 then
    Caption := TransCompName.Card
  else
    Caption := TransCompName.About;
end;

procedure TfrmCard.GetInfoCard(Sender: TBaseVirtualTree;Node: PVirtualNode);
var
  NodeData : PTreeData;
begin
  if Assigned(Node) then
  begin
    NodeData  := Sender.GetNodeData(Node);
    if NodeData.Tipo = 1 then
    begin
      pcCard.ActivePageIndex := 1;
      Caption                := TransCompName.Card;
      //Components position
      if lbxName.Width < lbxSHouse.Width then
      begin
        lbName.Left     := lbxSHouse.Left  + lbxSHouse.Width  + 4;
        lbSHouse.Left   := lbxSHouse.Left  + lbxSHouse.Width  + 4;
      end
      else begin
        lbName.Left     := lbxName.Left    + lbxName.Width    + 4;
        lbSHouse.Left   := lbxName.Left    + lbxName.Width    + 4;
      end;
      lbVersion.Left    := lbxVersion.Left + lbxVersion.Width + 4;
      //Get infos
      with NodeData^ do
      begin
        lbName.Caption    := Name;
        lbSHouse.Caption  := Developer;
        lbVersion.Caption := Version;
        lbWebSite.Enabled := Not((WebSite = '') or (WebSite = 'http://'));
        memDesc.Text      := StringReplace(Desc,'[br]',#13#10,[rfReplaceAll]);
        memOpinion.Text   := StringReplace(Opinion,'[br]',#13#10,[rfReplaceAll]);
        memNotes.Text     := StringReplace(Notes,'[br]',#13#10,[rfReplaceAll]);
      end;
    end;
  end;
end;

procedure TfrmCard.lbASuiteWebSiteClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow, 'open', PChar(lbASuiteWebSite.Caption), nil, nil, SW_SHOWDEFAULT);
end;

procedure TfrmCard.lbWebSiteClick(Sender: TObject);
var
  NodeData : PTreeData;
begin
  with frmMain do
  begin
    if Assigned(vstList.FocusedNode) then
    begin
      NodeData := vstList.GetNodeData(vstList.FocusedNode);
      if NodeData.Tipo = 1 then
        ShellExecute(GetDesktopWindow, 'open', PChar(String(NodeData.WebSite)),
                     nil, nil, SW_SHOWDEFAULT);
    end;
  end;
end;

procedure TfrmCard.TranslateForm(Lingua: string);
begin
  with frmMain.xmldTranslate.DocumentElement.ChildNodes['Form2'] do
  begin
    main.TransCompName.Card  := ChildNodes['FormCaptionCard'].Text;
    main.TransCompName.About := ChildNodes['FormCaptionAbout'].Text;
    //tbHome (About)
    lbASuiteVersion.Caption  := ChildNodes['LabelASVersion'].Text + ReleaseVersion;
    if PreReleaseVersion <> '' then
      lbASuiteVersion.Caption := lbASuiteVersion.Caption + PreReleaseVersion;
    memIntro.Text           := StringReplace(ChildNodes['LabelIntro'].Text,'[br]',#13#10,[rfReplaceAll]);
    //tbCard
    gbSoftware.Caption    := ChildNodes['GroupBoxSoftware'].Text;
    with TransCompName do
    begin
      LabelTitoloSw       := ChildNodes['LabelNameSw'].Text;
      LabelTitoloSHouse   := ChildNodes['LabelDeveloper'].Text;
      LabelTitoloVersione := ChildNodes['LabelVersion'].Text;
      lbxName.Caption     := LabelTitoloSw;
      lbxSHouse.Caption   := LabelTitoloSHouse;
      lbxVersion.Caption  := LabelTitoloVersione;
    end;
    lbWebSite.Caption   := ChildNodes['LabelWebSite'].Text;
    lbDesc.Caption      := ChildNodes['LabelDescription'].Text;
    lbNotes.Caption     := ChildNodes['LabelNote'].Text;
    lbOpinion.Caption   := ChildNodes['LabelOpinion'].Text;
  end;
end;

procedure TfrmCard.WMMoving(var Msg: TWMMoving);
var
  MainRect, FormRect : TRect;
  Point : TPoint;
begin
  //Save position of frmCard and frmMain in FormRect and MainRect
  FormRect        := Msg.DragRect^;
  MainRect.Left   := Application.MainForm.Left;
  MainRect.Top    := Application.MainForm.Top;
  MainRect.Right  := Application.MainForm.Left + Application.MainForm.Width;
  MainRect.Bottom := Application.MainForm.Top + Application.MainForm.Height;
  //Mouse position - If Magnet is active, this code
  GetCursorPos(Point);   
  UnMagnet := False;
  if (SideMagnet <> smNone) then
  begin
    //Coordinate X
    if (SideMagnet = smLeft) or
       (SideMagnet = smRight) then
    begin
      if (OldPoint.X < Point.X - 5) or
         (OldPoint.X > Point.X + 5) then
        UnMagnet := True;
    end;
    //Coordinate Y
    if (SideMagnet = smTop) or
       (SideMagnet = smBottom) then
    begin
      if (OldPoint.Y < Point.Y - 5) or
         (OldPoint.Y > Point.Y + 5) then
        UnMagnet := True;
    end;
  end;
  OldPoint := Point;
  if Not(UnMagnet) then
  begin
    //Coordinate X
    if (formRect.Bottom > MainRect.Top) and
       (formRect.Top < MainRect.Top + frmMain.Height) then
    begin
      //Right
      if ((formRect.Right < MainRect.Left) and
          (formRect.Right > MainRect.Left - Integer(FArea))) or
         ((formRect.Right > MainRect.Left) and
          (formRect.Right < MainRect.Left + Integer(FArea))) then
      begin
        formRect.Left  := MainRect.Left - frmCard.Width;
        formRect.Right := MainRect.Left;
        SideMagnet     := smRight;
      end;
      //Left
      if ((formRect.Left < MainRect.Right) and
          (formRect.Left > MainRect.Right - Integer(FArea))) or
         ((formRect.Left > MainRect.Right) and
          (formRect.Left < MainRect.Right + Integer(FArea))) then
      begin
        formRect.Left  := MainRect.Left + frmMain.Width;
        formRect.Right := formRect.Left + frmCard.Width;
        SideMagnet     := smLeft;
      end;
    end;
    //Coordinate Y
    if (formRect.Right > MainRect.Left) and
       (formRect.Left < MainRect.Right) then
    begin
      //Bottom
      if ((formRect.Bottom < MainRect.Top) and
          (formRect.Bottom > MainRect.Top - Integer(FArea))) or
         ((formRect.Bottom > MainRect.Top) and
          (formRect.Bottom < MainRect.Top + Integer(FArea))) then
      begin
        formRect.Top    := MainRect.Top - frmCard.Height;
        formRect.Bottom := MainRect.Top;
        SideMagnet      := smBottom;
      end;
      //Top
      if ((formRect.Top < MainRect.Bottom) and
          (formRect.Top > MainRect.Bottom - Integer(FArea))) or
         ((formRect.Top > MainRect.Bottom) and
          (formRect.Top < MainRect.Bottom + Integer(FArea))) then
      begin
        formRect.Top    := MainRect.Bottom;
        formRect.Bottom := formRect.Top + frmCard.Height;
        SideMagnet      := smTop;
      end;
    end;
    Msg.DragRect^ := FormRect;
  end
  else begin
    SideMagnet := smNone;
  end;
end;

end.
