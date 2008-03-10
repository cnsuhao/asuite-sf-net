object frmPropertySw: TfrmPropertySw
  Left = 370
  Top = 237
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Properties'
  ClientHeight = 362
  ClientWidth = 402
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
  object btnOk: TButton
    Left = 233
    Top = 327
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 319
    Top = 327
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 385
    Height = 313
    ActivePage = tsInfo1
    TabOrder = 0
    object tsInfo1: TTabSheet
      Caption = 'General'
      object lbInfo1: TLabel
        Left = 9
        Top = 9
        Width = 361
        Height = 41
        AutoSize = False
        Caption = 
          'Every page in ASuite requires some information about the respect' +
          'ive application. All fields are optional except the application'#39 +
          's name.'
        WordWrap = True
      end
      object lbVersion: TLabel
        Left = 161
        Top = 56
        Width = 35
        Height = 13
        Caption = 'Version'
      end
      object lbName: TLabel
        Left = 9
        Top = 56
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object lbAuthor: TLabel
        Left = 225
        Top = 56
        Width = 49
        Height = 13
        Caption = 'Developer'
      end
      object lbWebSite: TLabel
        Left = 9
        Top = 96
        Width = 54
        Height = 13
        Caption = 'Home page'
      end
      object lbPathExe: TLabel
        Left = 9
        Top = 151
        Width = 161
        Height = 13
        Caption = 'Executable/folder/web page path'
      end
      object lbParameters: TLabel
        Left = 8
        Top = 197
        Width = 104
        Height = 13
        Caption = 'Parameters (optional)'
      end
      object lbInfo2: TLabel
        Left = 8
        Top = 243
        Width = 361
        Height = 25
        AutoSize = False
        Caption = 
          'Note: You can use $ASuite even when applications are in the same' +
          ' folder as ASuite.'
        WordWrap = True
      end
      object edtName: TEdit
        Left = 9
        Top = 72
        Width = 145
        Height = 21
        TabOrder = 0
      end
      object edtVersion: TEdit
        Left = 161
        Top = 72
        Width = 57
        Height = 21
        TabOrder = 1
      end
      object edtAuthor: TEdit
        Left = 225
        Top = 72
        Width = 145
        Height = 21
        TabOrder = 2
      end
      object btnRetrieve: TButton
        Left = 225
        Top = 112
        Width = 145
        Height = 21
        Caption = 'Retrieve application info'
        TabOrder = 4
        OnClick = btnRetrieveClick
      end
      object edtWebSite: TEdit
        Left = 9
        Top = 112
        Width = 145
        Height = 21
        TabOrder = 3
        Text = 'http:\\'
      end
      object edtPathExe: TEdit
        Left = 9
        Top = 170
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        Text = '$ASuite\'
        OnExit = edtPathExeExit
      end
      object edtParameters: TEdit
        Left = 8
        Top = 216
        Width = 289
        Height = 21
        TabOrder = 7
      end
      object btnBrowseExe: TButton
        Left = 304
        Top = 170
        Width = 65
        Height = 21
        Caption = 'Browse'
        TabOrder = 6
        OnClick = Browse
      end
    end
    object tsInfo2: TTabSheet
      Caption = 'Advanced'
      object lbPathIcon: TLabel
        Left = 8
        Top = 48
        Width = 132
        Height = 13
        Caption = 'Custom icon path (optional)'
      end
      object lbAutoExecute: TLabel
        Left = 8
        Top = 88
        Width = 62
        Height = 13
        Caption = 'Autoexecute'
      end
      object lbWindowState: TLabel
        Left = 272
        Top = 176
        Width = 66
        Height = 13
        Caption = 'Window state'
      end
      object lbWorkingDir: TLabel
        Left = 8
        Top = 8
        Width = 171
        Height = 13
        Caption = 'Custom working directory (optional)'
      end
      object lbActionOnExe: TLabel
        Left = 221
        Top = 129
        Width = 64
        Height = 13
        Caption = 'On execution'
      end
      object lbScheduler: TLabel
        Left = 8
        Top = 176
        Width = 47
        Height = 13
        Caption = 'Scheduler'
      end
      object edtPathIcon: TEdit
        Left = 8
        Top = 64
        Width = 289
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = '$ASuite\'
      end
      object btnBrowseIcon: TButton
        Left = 309
        Top = 64
        Width = 65
        Height = 21
        Caption = 'Browse'
        TabOrder = 3
        OnClick = Browse
      end
      object cxAutoExecute: TComboBox
        Left = 8
        Top = 104
        Width = 249
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = cxAutoExecuteChange
      end
      object cxWindowState: TComboBox
        Left = 272
        Top = 192
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 11
      end
      object cbHotKey: TCheckBox
        Left = 8
        Top = 128
        Width = 169
        Height = 17
        Caption = 'Active hotkey'
        TabOrder = 6
        OnClick = cbHotKeyClick
      end
      object cxHotkey1: TComboBox
        Left = 8
        Top = 148
        Width = 130
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
      object cxHotKey2: TComboBox
        Left = 144
        Top = 148
        Width = 49
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
      object edtWorkingDir: TEdit
        Left = 8
        Top = 24
        Width = 289
        Height = 21
        TabOrder = 0
        Text = '$ASuite\'
      end
      object btnBrowseWorkingDir: TButton
        Left = 309
        Top = 24
        Width = 65
        Height = 21
        Caption = 'Browse'
        TabOrder = 1
        OnClick = Browse
      end
      object cxActionOnExe: TComboBox
        Left = 221
        Top = 148
        Width = 153
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 9
      end
      object cbDontInsertMRU: TCheckBox
        Left = 143
        Top = 219
        Width = 231
        Height = 17
        Caption = 'Don'#39't insert this software in MRU'
        TabOrder = 13
      end
      object cbShortcutDesktop: TCheckBox
        Left = 8
        Top = 267
        Width = 366
        Height = 14
        Caption = 'Create shortcut on desktop when ASuite is running'
        TabOrder = 16
        WordWrap = True
      end
      object dtpSchDate: TDateTimePicker
        Left = 8
        Top = 216
        Width = 129
        Height = 21
        Date = 39092.942071932870000000
        Time = 39092.942071932870000000
        TabOrder = 12
      end
      object dtpSchTime: TDateTimePicker
        Left = 8
        Top = 240
        Width = 129
        Height = 21
        Date = 39092.942939814810000000
        Time = 39092.942939814810000000
        DateMode = dmUpDown
        Kind = dtkTime
        TabOrder = 14
      end
      object cxScheduler: TComboBox
        Left = 8
        Top = 192
        Width = 129
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 10
        OnChange = cxSchedulerChange
      end
      object cbHideSoftware: TCheckBox
        Left = 143
        Top = 242
        Width = 231
        Height = 17
        Caption = 'Hide this software from menu'
        TabOrder = 15
      end
      object btnChangeOrder: TButton
        Left = 272
        Top = 104
        Width = 102
        Height = 21
        Caption = 'Change order'
        TabOrder = 5
        OnClick = btnChangeOrderClick
      end
    end
    object tsInfo3: TTabSheet
      Caption = 'Information'
      object lbDesc: TLabel
        Left = 8
        Top = 8
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object lbOpinion: TLabel
        Left = 8
        Top = 108
        Width = 31
        Height = 13
        Caption = 'Rating'
      end
      object lbNotes: TLabel
        Left = 8
        Top = 192
        Width = 28
        Height = 13
        Caption = 'Notes'
      end
      object memDesc: TMemo
        Left = 8
        Top = 24
        Width = 361
        Height = 81
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object memOpinion: TMemo
        Left = 8
        Top = 124
        Width = 361
        Height = 65
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object memNotes: TMemo
        Left = 8
        Top = 208
        Width = 361
        Height = 65
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 296
  end
end
