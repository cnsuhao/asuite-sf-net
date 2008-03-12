object frmOption: TfrmOption
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 547
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 281
    Height = 497
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'General'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 461
      object gbWindow: TGroupBox
        Left = 8
        Top = 88
        Width = 257
        Height = 281
        Caption = 'Window'
        TabOrder = 1
        object lbLanguage: TLabel
          Left = 8
          Top = 200
          Width = 47
          Height = 13
          Caption = 'Language'
        end
        object cxLanguage: TComboBox
          Left = 8
          Top = 216
          Width = 153
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 11
        end
        object cxWindowHotKeyCode: TComboBox
          Left = 167
          Top = 84
          Width = 57
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 5
          Items.Strings = (
            'A'
            'B'
            'C'
            'D'
            'E'
            'F'
            'G'
            'H'
            'I'
            'J'
            'K'
            'L'
            'M'
            'N'
            'O'
            'P'
            'Q'
            'R'
            'S'
            'T'
            'U'
            'V'
            'W'
            'X'
            'Y'
            'Z'
            'F1'
            'F2'
            'F3'
            'F4'
            'F5'
            'F6'
            'F7'
            'F8'
            'F9'
            'F10'
            'F11'
            'F12'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '0')
        end
        object cxWindowHotKeyMod: TComboBox
          Left = 8
          Top = 84
          Width = 153
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          Items.Strings = (
            'Alt'
            'Crtl'
            'Shift'
            'Crtl + Alt'
            'Shift + Alt'
            'Shift + Crtl'
            'Shift + Crtl + Alt'
            'WinKey')
        end
        object cbWindowHotKey: TCheckBox
          Left = 8
          Top = 64
          Width = 233
          Height = 17
          Caption = 'Show window when hotkey is pressed'
          TabOrder = 3
          OnClick = cbWindowHotKeyClick
        end
        object cbWindowOnTop: TCheckBox
          Left = 8
          Top = 48
          Width = 233
          Height = 17
          Caption = 'Window on top'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object cbFormCard: TCheckBox
          Left = 8
          Top = 32
          Width = 233
          Height = 17
          Caption = 'Show application info'
          TabOrder = 1
        end
        object cbHoldSize: TCheckBox
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Hold window size'
          TabOrder = 0
        end
        object cbCustomTitle: TCheckBox
          Left = 8
          Top = 156
          Width = 233
          Height = 17
          Caption = 'Custom window title'
          TabOrder = 9
          OnClick = cbCustomTitleClick
        end
        object edtCustomTitle: TEdit
          Left = 8
          Top = 176
          Width = 153
          Height = 21
          TabOrder = 10
          Text = 'ASuite'
        end
        object cbHideSearch: TCheckBox
          Left = 8
          Top = 240
          Width = 233
          Height = 17
          Caption = 'Hide tab Search'
          TabOrder = 12
        end
        object cbHideStats: TCheckBox
          Left = 8
          Top = 255
          Width = 233
          Height = 17
          Caption = 'Hide tab Stats'
          TabOrder = 13
        end
        object cbMenuHotKey: TCheckBox
          Left = 8
          Top = 111
          Width = 241
          Height = 17
          Caption = 'Show trayicon menu when hotkey is pressed'
          TabOrder = 6
          OnClick = cbMenuHotKeyClick
        end
        object cxMenuHotKeyCode: TComboBox
          Left = 167
          Top = 131
          Width = 57
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 8
          Items.Strings = (
            'A'
            'B'
            'C'
            'D'
            'E'
            'F'
            'G'
            'H'
            'I'
            'J'
            'K'
            'L'
            'M'
            'N'
            'O'
            'P'
            'Q'
            'R'
            'S'
            'T'
            'U'
            'V'
            'W'
            'X'
            'Y'
            'Z'
            'F1'
            'F2'
            'F3'
            'F4'
            'F5'
            'F6'
            'F7'
            'F8'
            'F9'
            'F10'
            'F11'
            'F12'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '0')
        end
        object cxMenuHotKeyMod: TComboBox
          Left = 8
          Top = 131
          Width = 153
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 7
          Items.Strings = (
            'Alt'
            'Crtl'
            'Shift'
            'Crtl + Alt'
            'Shift + Alt'
            'Shift + Crtl'
            'Shift + Crtl + Alt'
            'WinKey')
        end
      end
      object gbTreeView: TGroupBox
        Left = 8
        Top = 376
        Width = 257
        Height = 89
        Caption = 'Treeview'
        TabOrder = 2
        object cbBackground: TCheckBox
          Left = 8
          Top = 13
          Width = 233
          Height = 17
          Caption = 'Active background'
          TabOrder = 0
          OnClick = cbBackgroundClick
        end
        object btnFontSettings: TButton
          Left = 72
          Top = 64
          Width = 121
          Height = 17
          Caption = 'Font settings...'
          TabOrder = 3
          OnClick = btnFontSettingsClick
        end
        object edtBackground: TEdit
          Left = 8
          Top = 36
          Width = 177
          Height = 21
          TabOrder = 1
          Text = '$ASuite\'
        end
        object btnBrowseBackground: TButton
          Left = 192
          Top = 36
          Width = 57
          Height = 21
          Caption = 'Browse'
          TabOrder = 2
          OnClick = Browse
        end
      end
      object gbStartup: TGroupBox
        Left = 8
        Top = 0
        Width = 257
        Height = 81
        Caption = 'Startup'
        TabOrder = 0
        object cbWindowsStartup: TCheckBox
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Start ASuite on system startup'
          TabOrder = 0
        end
        object cbShowStartup: TCheckBox
          Left = 8
          Top = 32
          Width = 233
          Height = 17
          Caption = 'Show window on startup'
          TabOrder = 1
        end
        object cbAutorun: TCheckBox
          Left = 8
          Top = 62
          Width = 233
          Height = 17
          Caption = 'Enable autorun'
          TabOrder = 3
        end
        object cbMenuStartup: TCheckBox
          Left = 8
          Top = 47
          Width = 233
          Height = 17
          Caption = 'Show Menu on startup'
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Advanced'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 269
      ExplicitHeight = 0
      object gbRecents: TGroupBox
        Left = 8
        Top = 16
        Width = 257
        Height = 81
        Caption = 'Recents'
        TabOrder = 0
        object lbMaxMRU: TLabel
          Left = 8
          Top = 51
          Width = 84
          Height = 13
          Caption = 'Max number MRU'
        end
        object lbNumbMRU: TLabel
          Left = 234
          Top = 51
          Width = 12
          Height = 13
          Caption = '10'
        end
        object cbMRU: TCheckBox
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Active MRU'
          TabOrder = 0
        end
        object cbSubMenuMRU: TCheckBox
          Left = 8
          Top = 32
          Width = 233
          Height = 17
          Caption = 'MRU on trayicon submenu'
          TabOrder = 1
        end
        object tbMRU: TTrackBar
          Left = 136
          Top = 48
          Width = 97
          Height = 25
          ShowSelRange = False
          TabOrder = 2
          ThumbLength = 17
          OnChange = tbMRUChange
        end
      end
      object gbBackup: TGroupBox
        Left = 8
        Top = 120
        Width = 257
        Height = 65
        Caption = 'Backup'
        TabOrder = 1
        object lbMaxBackup: TLabel
          Left = 8
          Top = 35
          Width = 96
          Height = 13
          Caption = 'Max number Backup'
        end
        object lbNumbBackup: TLabel
          Left = 234
          Top = 35
          Width = 12
          Height = 13
          Caption = '10'
        end
        object cbBackup: TCheckBox
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Active backup'
          TabOrder = 0
        end
        object tbBackup: TTrackBar
          Left = 136
          Top = 32
          Width = 97
          Height = 25
          ShowSelRange = False
          TabOrder = 1
          ThumbLength = 17
          OnChange = tbBackupChange
        end
      end
      object gbOtherFunctions: TGroupBox
        Left = 8
        Top = 296
        Width = 257
        Height = 153
        Caption = 'Other functions'
        TabOrder = 2
        object lbClearElements: TLabel
          Left = 8
          Top = 88
          Width = 202
          Height = 13
          Caption = 'Clear all MRU, backups and/or cache icons'
        end
        object cbSaveSecurity: TCheckBox
          Left = 8
          Top = 48
          Width = 233
          Height = 17
          Caption = 'Enable save security'
          TabOrder = 2
        end
        object cbCache: TCheckBox
          Left = 8
          Top = 32
          Width = 233
          Height = 17
          Caption = 'Enable cache'
          TabOrder = 1
        end
        object cbHotKey: TCheckBox
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Enable hotkey'
          TabOrder = 0
          OnClick = cbHotKeyClick
        end
        object cbScheduler: TCheckBox
          Left = 8
          Top = 64
          Width = 233
          Height = 17
          Caption = 'Enable scheduler'
          TabOrder = 3
        end
        object btnClearElements: TButton
          Left = 72
          Top = 112
          Width = 113
          Height = 25
          Caption = 'Clear elements...'
          TabOrder = 4
          OnClick = btnClearElementsClick
        end
      end
      object gbCheckList: TGroupBox
        Left = 8
        Top = 208
        Width = 257
        Height = 65
        Caption = 'Check list'
        TabOrder = 3
        object lbCheckList: TLabel
          Left = 8
          Top = 35
          Width = 61
          Height = 13
          Caption = 'Time interval'
        end
        object lbNumbCheckList: TLabel
          Left = 234
          Top = 35
          Width = 12
          Height = 13
          Caption = '60'
        end
        object cbCheckList: TCheckBox
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Active check list'
          TabOrder = 0
        end
        object tbCheckList: TTrackBar
          Left = 136
          Top = 32
          Width = 97
          Height = 25
          Max = 60
          ShowSelRange = False
          TabOrder = 1
          ThumbLength = 17
          TickStyle = tsManual
          OnChange = tbCheckListChange
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Various'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 269
      ExplicitHeight = 0
      object gbExecution: TGroupBox
        Left = 8
        Top = 0
        Width = 257
        Height = 81
        Caption = 'Execution'
        TabOrder = 0
        object lbActionOnExe: TLabel
          Left = 8
          Top = 36
          Width = 64
          Height = 13
          Caption = 'On execution'
        end
        object cbRunSingleClick: TCheckBox
          Left = 8
          Top = 16
          Width = 225
          Height = 17
          Caption = 'Execute with single click'
          TabOrder = 0
        end
        object cxActionOnExe: TComboBox
          Left = 8
          Top = 52
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
        end
      end
      object gbTrayicon: TGroupBox
        Left = 8
        Top = 96
        Width = 257
        Height = 200
        Caption = 'System Tray'
        TabOrder = 1
        object lbTrayLeftClick: TLabel
          Left = 8
          Top = 56
          Width = 41
          Height = 13
          Caption = 'Left click'
        end
        object lbMenuTheme: TLabel
          Left = 8
          Top = 134
          Width = 32
          Height = 13
          Caption = 'Theme'
        end
        object lbTrayRightClick: TLabel
          Left = 8
          Top = 96
          Width = 47
          Height = 13
          Caption = 'Right click'
        end
        object cxLeftClick: TComboBox
          Left = 8
          Top = 71
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
        end
        object btnCustomTrayIcon: TButton
          Left = 160
          Top = 71
          Width = 89
          Height = 21
          Caption = 'Choose icon'
          TabOrder = 3
          OnClick = Browse
        end
        object cbMenuFade: TCheckBox
          Left = 8
          Top = 176
          Width = 241
          Height = 19
          Caption = 'Enable fade menu'
          TabOrder = 7
        end
        object cxTheme: TComboBox
          Left = 8
          Top = 150
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 5
          OnExit = cxThemeExit
        end
        object cbTrayicon: TCheckBox
          Left = 8
          Top = 16
          Width = 241
          Height = 17
          Caption = 'Enable the System Tray icon'
          TabOrder = 0
          OnClick = cbTrayiconClick
        end
        object cbClassicMenu: TCheckBox
          Left = 8
          Top = 32
          Width = 241
          Height = 17
          Caption = 'Use classic menu'
          TabOrder = 1
          OnClick = cbClassicMenuClick
        end
        object btnMenuFolders: TButton
          Left = 160
          Top = 150
          Width = 89
          Height = 21
          Caption = 'Menu folders...'
          TabOrder = 6
          OnClick = btnMenuFoldersClick
        end
        object cxRightClick: TComboBox
          Left = 8
          Top = 111
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 4
        end
      end
      object gbMouse: TGroupBox
        Left = 8
        Top = 298
        Width = 257
        Height = 137
        Caption = 'Mouse sensors'
        TabOrder = 2
        object lbSide: TLabel
          Left = 8
          Top = 16
          Width = 24
          Height = 13
          Caption = 'Side'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbLeftClick: TLabel
          Left = 56
          Top = 16
          Width = 50
          Height = 13
          Caption = 'Left click'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbRightClick: TLabel
          Left = 155
          Top = 16
          Width = 58
          Height = 13
          Caption = 'Right click'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbTop: TLabel
          Left = 8
          Top = 36
          Width = 18
          Height = 13
          Caption = 'Top'
        end
        object lbLeft: TLabel
          Left = 8
          Top = 60
          Width = 19
          Height = 13
          Caption = 'Left'
        end
        object lbRight: TLabel
          Left = 8
          Top = 84
          Width = 25
          Height = 13
          Caption = 'Right'
        end
        object lbBottom: TLabel
          Left = 8
          Top = 108
          Width = 34
          Height = 13
          Caption = 'Bottom'
        end
        object cxLCTop: TComboBox
          Left = 56
          Top = 32
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
        end
        object cxLCLeft: TComboBox
          Left = 56
          Top = 56
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
        end
        object cxLCRight: TComboBox
          Left = 56
          Top = 80
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 4
        end
        object cxLCBottom: TComboBox
          Left = 56
          Top = 104
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 6
        end
        object cxRCTop: TComboBox
          Left = 155
          Top = 32
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
        end
        object cxRCBottom: TComboBox
          Left = 155
          Top = 104
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 7
        end
        object cxRCRight: TComboBox
          Left = 155
          Top = 80
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 5
        end
        object cxRCLeft: TComboBox
          Left = 155
          Top = 56
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 3
        end
      end
    end
  end
  object btnOk: TButton
    Left = 125
    Top = 512
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 215
    Top = 512
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object OpenDialog1: TOpenDialog
    Left = 224
    Top = 8
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 192
    Top = 8
  end
end
