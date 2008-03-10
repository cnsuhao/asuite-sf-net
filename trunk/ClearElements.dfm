object frmClearElements: TfrmClearElements
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Clear elements'
  ClientHeight = 128
  ClientWidth = 217
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
  object btnClear: TButton
    Left = 85
    Top = 95
    Width = 59
    Height = 25
    Caption = 'Clear'
    Default = True
    TabOrder = 0
    OnClick = btnClearClick
  end
  object btnCancel: TButton
    Left = 150
    Top = 95
    Width = 59
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 201
    Height = 81
    TabOrder = 2
    object lbClearElements: TLabel
      Left = 8
      Top = 8
      Width = 162
      Height = 13
      Caption = 'Clear the following elements now:'
    end
    object cbRecents: TCheckBox
      Left = 12
      Top = 24
      Width = 181
      Height = 17
      Caption = 'MRU'
      TabOrder = 0
    end
    object cbCache: TCheckBox
      Left = 12
      Top = 56
      Width = 181
      Height = 17
      Caption = 'Cache icons'
      TabOrder = 2
    end
    object cbBackup: TCheckBox
      Left = 12
      Top = 40
      Width = 181
      Height = 17
      Caption = 'Backups'
      TabOrder = 1
    end
  end
end
