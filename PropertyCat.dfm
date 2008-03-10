object frmPropertyCat: TfrmPropertyCat
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Properties'
  ClientHeight = 160
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancel: TButton
    Left = 200
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnOk: TButton
    Left = 112
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 265
    Height = 113
    TabOrder = 0
    object lbName: TLabel
      Left = 8
      Top = 8
      Width = 41
      Height = 13
      AutoSize = False
      Caption = 'Name'
    end
    object lbPathIcon: TLabel
      Left = 8
      Top = 60
      Width = 132
      Height = 13
      Caption = 'Custom icon path (optional)'
    end
    object edtName: TEdit
      Left = 8
      Top = 24
      Width = 249
      Height = 21
      TabOrder = 0
    end
    object edtPathIcon: TEdit
      Left = 8
      Top = 76
      Width = 185
      Height = 21
      TabOrder = 1
      Text = '$ASuite\'
    end
    object btnBrowseIcon: TButton
      Left = 200
      Top = 76
      Width = 57
      Height = 21
      Caption = 'Browse'
      TabOrder = 2
      OnClick = btnBrowseIconClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 128
  end
end
