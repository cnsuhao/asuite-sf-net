object frmMenuButtons: TfrmMenuButtons
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change menu buttons'
  ClientHeight = 217
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
  object btnOk: TButton
    Left = 224
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 310
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pgcMenuFolders: TPageControl
    Left = 8
    Top = 8
    Width = 377
    Height = 169
    ActivePage = tsButton7
    TabOrder = 2
    object tsButton1: TTabSheet
      Caption = 'Button1'
      object lbName1: TLabel
        Left = 8
        Top = 0
        Width = 27
        Height = 13
        Margins.Bottom = 0
        Caption = 'Name'
      end
      object lbPathExe: TLabel
        Left = 8
        Top = 40
        Width = 161
        Height = 13
        Margins.Bottom = 0
        Caption = 'Executable/folder/web page path'
      end
      object lbPathIcon1: TLabel
        Left = 8
        Top = 80
        Width = 132
        Height = 13
        Margins.Bottom = 0
        Caption = 'Custom icon path (optional)'
      end
      object edtName1: TEdit
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        MaxLength = 12
        TabOrder = 0
        Text = 'Documents'
      end
      object edtPathExe1: TEdit
        Left = 8
        Top = 56
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '$Drive\Documents'
      end
      object edtPathIcon1: TEdit
        Left = 8
        Top = 96
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '$ASuite\'
      end
      object btnBrowseB1: TButton
        Left = 304
        Top = 96
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 4
        OnClick = Browse
      end
      object btnBrowseA1: TButton
        Left = 304
        Top = 56
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 2
        OnClick = Browse
      end
      object cbActiveButton1: TCheckBox
        Left = 8
        Top = 120
        Width = 225
        Height = 17
        Caption = 'Active this button'
        TabOrder = 5
      end
    end
    object tsButton2: TTabSheet
      Caption = 'Button2'
      ImageIndex = 1
      object lbName2: TLabel
        Left = 8
        Top = 0
        Width = 27
        Height = 13
        Margins.Bottom = 0
        Caption = 'Name'
      end
      object lbPathExe2: TLabel
        Left = 8
        Top = 40
        Width = 161
        Height = 13
        Margins.Bottom = 0
        Caption = 'Executable/folder/web page path'
      end
      object lbPathIcon2: TLabel
        Left = 8
        Top = 80
        Width = 132
        Height = 13
        Margins.Bottom = 0
        Caption = 'Custom icon path (optional)'
      end
      object edtName2: TEdit
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        MaxLength = 12
        TabOrder = 0
        Text = 'Documents'
      end
      object edtPathExe2: TEdit
        Left = 8
        Top = 56
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '$Drive\Documents'
      end
      object btnBrowseA2: TButton
        Left = 304
        Top = 56
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 2
        OnClick = Browse
      end
      object edtPathIcon2: TEdit
        Left = 8
        Top = 96
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '$ASuite\'
      end
      object cbActiveButton2: TCheckBox
        Left = 8
        Top = 120
        Width = 225
        Height = 17
        Caption = 'Active this button'
        TabOrder = 5
      end
      object btnBrowseB2: TButton
        Left = 304
        Top = 96
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 4
        OnClick = Browse
      end
    end
    object tsButton3: TTabSheet
      Caption = 'Button3'
      ImageIndex = 2
      object lbName3: TLabel
        Left = 8
        Top = 0
        Width = 27
        Height = 13
        Margins.Bottom = 0
        Caption = 'Name'
      end
      object lbPathExe3: TLabel
        Left = 8
        Top = 40
        Width = 161
        Height = 13
        Margins.Bottom = 0
        Caption = 'Executable/folder/web page path'
      end
      object lbPathIcon3: TLabel
        Left = 8
        Top = 80
        Width = 132
        Height = 13
        Margins.Bottom = 0
        Caption = 'Custom icon path (optional)'
      end
      object edtName3: TEdit
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        MaxLength = 12
        TabOrder = 0
        Text = 'Documents'
      end
      object edtPathExe3: TEdit
        Left = 8
        Top = 56
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '$Drive\Documents'
      end
      object btnBrowseA3: TButton
        Left = 304
        Top = 56
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 2
        OnClick = Browse
      end
      object edtPathIcon3: TEdit
        Left = 8
        Top = 96
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '$ASuite\'
      end
      object cbActiveButton3: TCheckBox
        Left = 8
        Top = 120
        Width = 225
        Height = 17
        Caption = 'Active this button'
        TabOrder = 5
      end
      object btnBrowseB3: TButton
        Left = 304
        Top = 96
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 4
        OnClick = Browse
      end
    end
    object tsButton4: TTabSheet
      Caption = 'Button4'
      ImageIndex = 3
      object lbName4: TLabel
        Left = 8
        Top = 0
        Width = 27
        Height = 13
        Margins.Bottom = 0
        Caption = 'Name'
      end
      object lbPathExe4: TLabel
        Left = 8
        Top = 40
        Width = 161
        Height = 13
        Margins.Bottom = 0
        Caption = 'Executable/folder/web page path'
      end
      object lbPathIcon4: TLabel
        Left = 8
        Top = 80
        Width = 132
        Height = 13
        Margins.Bottom = 0
        Caption = 'Custom icon path (optional)'
      end
      object edtName4: TEdit
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        MaxLength = 12
        TabOrder = 0
        Text = 'Documents'
      end
      object edtPathExe4: TEdit
        Left = 8
        Top = 56
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '$Drive\Documents'
      end
      object btnBrowseA4: TButton
        Left = 304
        Top = 56
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 2
        OnClick = Browse
      end
      object edtPathIcon4: TEdit
        Left = 8
        Top = 96
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '$ASuite\'
      end
      object cbActiveButton4: TCheckBox
        Left = 8
        Top = 120
        Width = 225
        Height = 17
        Caption = 'Active this button'
        TabOrder = 5
      end
      object btnBrowseB4: TButton
        Left = 304
        Top = 96
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 4
        OnClick = Browse
      end
    end
    object tsButton5: TTabSheet
      Caption = 'Button5'
      ImageIndex = 4
      object lbName5: TLabel
        Left = 8
        Top = 0
        Width = 27
        Height = 13
        Margins.Bottom = 0
        Caption = 'Name'
      end
      object lbPathExe5: TLabel
        Left = 8
        Top = 40
        Width = 161
        Height = 13
        Margins.Bottom = 0
        Caption = 'Executable/folder/web page path'
      end
      object lbPathIcon5: TLabel
        Left = 8
        Top = 80
        Width = 132
        Height = 13
        Margins.Bottom = 0
        Caption = 'Custom icon path (optional)'
      end
      object edtName5: TEdit
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        MaxLength = 12
        TabOrder = 0
        Text = 'Documents'
      end
      object edtPathExe5: TEdit
        Left = 8
        Top = 56
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '$Drive\Documents'
      end
      object btnBrowseA5: TButton
        Left = 304
        Top = 56
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 2
        OnClick = Browse
      end
      object edtPathIcon5: TEdit
        Left = 8
        Top = 96
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '$ASuite\'
      end
      object cbActiveButton5: TCheckBox
        Left = 8
        Top = 120
        Width = 225
        Height = 17
        Caption = 'Active this button'
        TabOrder = 5
      end
      object btnBrowseB5: TButton
        Left = 304
        Top = 96
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 4
        OnClick = Browse
      end
    end
    object tsButton6: TTabSheet
      Caption = 'Button6'
      ImageIndex = 5
      object lbName6: TLabel
        Left = 8
        Top = 0
        Width = 27
        Height = 13
        Margins.Bottom = 0
        Caption = 'Name'
      end
      object lbPathExe6: TLabel
        Left = 8
        Top = 40
        Width = 161
        Height = 13
        Margins.Bottom = 0
        Caption = 'Executable/folder/web page path'
      end
      object lbPathIcon6: TLabel
        Left = 8
        Top = 80
        Width = 132
        Height = 13
        Margins.Bottom = 0
        Caption = 'Custom icon path (optional)'
      end
      object edtName6: TEdit
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        MaxLength = 12
        TabOrder = 0
        Text = 'Documents'
      end
      object edtPathExe6: TEdit
        Left = 8
        Top = 56
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '$Drive\Documents'
      end
      object btnBrowseA6: TButton
        Left = 304
        Top = 56
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 2
        OnClick = Browse
      end
      object edtPathIcon6: TEdit
        Left = 8
        Top = 96
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '$ASuite\'
      end
      object cbActiveButton6: TCheckBox
        Left = 8
        Top = 120
        Width = 225
        Height = 17
        Caption = 'Active this button'
        TabOrder = 5
      end
      object btnBrowseB6: TButton
        Left = 304
        Top = 96
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 4
        OnClick = Browse
      end
    end
    object tsButton7: TTabSheet
      Caption = 'Button7'
      ImageIndex = 6
      object lbName7: TLabel
        Left = 8
        Top = 0
        Width = 27
        Height = 13
        Margins.Bottom = 0
        Caption = 'Name'
      end
      object lbPathExe7: TLabel
        Left = 8
        Top = 40
        Width = 161
        Height = 13
        Margins.Bottom = 0
        Caption = 'Executable/folder/web page path'
      end
      object lbPathIcon7: TLabel
        Left = 8
        Top = 80
        Width = 132
        Height = 13
        Margins.Bottom = 0
        Caption = 'Custom icon path (optional)'
      end
      object edtName7: TEdit
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        MaxLength = 12
        TabOrder = 0
        Text = 'Documents'
      end
      object edtPathExe7: TEdit
        Left = 8
        Top = 56
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '$Drive\Documents'
      end
      object btnBrowseA7: TButton
        Left = 304
        Top = 56
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 2
        OnClick = Browse
      end
      object edtPathIcon7: TEdit
        Left = 8
        Top = 96
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '$ASuite\'
      end
      object cbActiveButton7: TCheckBox
        Left = 8
        Top = 120
        Width = 225
        Height = 17
        Caption = 'Active this button'
        TabOrder = 5
      end
      object btnBrowseB7: TButton
        Left = 304
        Top = 96
        Width = 57
        Height = 21
        Caption = 'Browse'
        TabOrder = 4
        OnClick = Browse
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 184
  end
end
