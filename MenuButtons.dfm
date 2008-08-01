object frmMenuButtons: TfrmMenuButtons
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change menu buttons'
  ClientHeight = 203
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 328
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 414
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object tv1: TTreeView
    Left = 8
    Top = 8
    Width = 97
    Height = 153
    Indent = 19
    TabOrder = 2
    Items.NodeData = {
      0108000000270000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000742007500740074006F006E003100270000000000000000000000FFFFFFFF
      FFFFFFFF00000000000000000742007500740074006F006E0032002700000000
      00000000000000FFFFFFFFFFFFFFFF0000000000000000074200750074007400
      6F006E003300270000000000000000000000FFFFFFFFFFFFFFFF000000000000
      00000742007500740074006F006E003400270000000000000000000000FFFFFF
      FFFFFFFFFF00000000000000000742007500740074006F006E00350027000000
      0000000000000000FFFFFFFFFFFFFFFF00000000000000000742007500740074
      006F006E003600270000000000000000000000FFFFFFFFFFFFFFFF0000000000
      0000000742007500740074006F006E003700270000000000000000000000FFFF
      FFFFFFFFFFFF00000000000000000742007500740074006F006E003800}
  end
  object pnl1: TPanel
    Left = 112
    Top = 8
    Width = 377
    Height = 153
    Caption = 'pnl1'
    TabOrder = 3
    object lbPathIcon1: TLabel
      Left = 8
      Top = 88
      Width = 132
      Height = 13
      Margins.Bottom = 0
      Caption = 'Custom icon path (optional)'
    end
    object lbPathExe: TLabel
      Left = 8
      Top = 48
      Width = 161
      Height = 13
      Margins.Bottom = 0
      Caption = 'Executable/folder/web page path'
    end
    object lbName1: TLabel
      Left = 8
      Top = 8
      Width = 27
      Height = 13
      Margins.Bottom = 0
      Caption = 'Name'
    end
    object cbActiveButton1: TCheckBox
      Left = 8
      Top = 128
      Width = 225
      Height = 17
      Caption = 'Active this button'
      TabOrder = 0
    end
    object edtPathIcon1: TEdit
      Left = 8
      Top = 104
      Width = 289
      Height = 21
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '$ASuite\'
    end
    object edtPathExe1: TEdit
      Left = 8
      Top = 64
      Width = 289
      Height = 21
      TabOrder = 2
      Text = '$Drive\Documents'
    end
    object edtName1: TEdit
      Left = 8
      Top = 24
      Width = 145
      Height = 21
      MaxLength = 12
      TabOrder = 3
      Text = 'Documents'
    end
    object btnBrowseA1: TButton
      Left = 304
      Top = 64
      Width = 57
      Height = 21
      Caption = 'Browse'
      TabOrder = 4
      OnClick = Browse
    end
    object btnBrowseB1: TButton
      Left = 304
      Top = 104
      Width = 57
      Height = 21
      Caption = 'Browse'
      TabOrder = 5
      OnClick = Browse
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 168
  end
end
