object frmMenuFolders: TfrmMenuFolders
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change menu folders'
  ClientHeight = 225
  ClientWidth = 393
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
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 377
    Height = 177
    TabOrder = 0
    object lbRoot: TLabel
      Left = 8
      Top = 152
      Width = 61
      Height = 13
      Caption = '$Drive = %s'
    end
    object lbFolderName: TLabel
      Left = 8
      Top = 8
      Width = 59
      Height = 13
      Caption = 'Folder name'
    end
    object lbFolderPath: TLabel
      Left = 104
      Top = 8
      Width = 55
      Height = 13
      Caption = 'Folder path'
    end
    object edtFolderName0: TEdit
      Left = 8
      Top = 24
      Width = 89
      Height = 21
      MaxLength = 12
      TabOrder = 0
      Text = 'Documents'
    end
    object edtFolderPath0: TEdit
      Left = 104
      Top = 24
      Width = 201
      Height = 21
      TabOrder = 1
      Text = '$Drive\Documents'
    end
    object edtFolderName1: TEdit
      Left = 8
      Top = 56
      Width = 89
      Height = 21
      MaxLength = 12
      TabOrder = 3
      Text = 'Music'
    end
    object edtFolderPath1: TEdit
      Left = 104
      Top = 56
      Width = 201
      Height = 21
      TabOrder = 4
      Text = '$Drive\Documents\Music'
    end
    object edtFolderName2: TEdit
      Left = 8
      Top = 88
      Width = 89
      Height = 21
      MaxLength = 12
      TabOrder = 6
      Text = 'Pictures'
    end
    object edtFolderPath2: TEdit
      Left = 104
      Top = 88
      Width = 201
      Height = 21
      TabOrder = 7
      Text = '$Drive\Documents\Pictures'
    end
    object edtFolderName3: TEdit
      Left = 8
      Top = 120
      Width = 89
      Height = 21
      MaxLength = 12
      TabOrder = 9
      Text = 'Video'
    end
    object edtFolderPath3: TEdit
      Left = 104
      Top = 120
      Width = 201
      Height = 21
      TabOrder = 10
      Text = '$Drive\Documents\Video'
    end
    object btnBrowse0: TButton
      Left = 312
      Top = 24
      Width = 57
      Height = 21
      Caption = 'Browse'
      TabOrder = 2
      OnClick = Browse
    end
    object btnBrowse1: TButton
      Tag = 1
      Left = 312
      Top = 56
      Width = 57
      Height = 21
      Caption = 'Browse'
      TabOrder = 5
      OnClick = Browse
    end
    object btnBrowse2: TButton
      Tag = 2
      Left = 312
      Top = 88
      Width = 57
      Height = 21
      Caption = 'Browse'
      TabOrder = 8
      OnClick = Browse
    end
    object btnBrowse3: TButton
      Tag = 3
      Left = 312
      Top = 120
      Width = 57
      Height = 21
      Caption = 'Browse'
      TabOrder = 11
      OnClick = Browse
    end
  end
  object btnOk: TButton
    Left = 224
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 310
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 192
  end
end
