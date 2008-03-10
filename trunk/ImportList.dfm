object frmImportList: TfrmImportList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Import list'
  ClientHeight = 443
  ClientWidth = 322
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
    Left = 152
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 240
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 305
    Height = 393
    Caption = 'panelImport'
    TabOrder = 0
    object lbPathList: TLabel
      Left = 8
      Top = 8
      Width = 41
      Height = 13
      Caption = 'List path'
    end
    object lbInfoList: TLabel
      Left = 8
      Top = 64
      Width = 134
      Height = 13
      Caption = 'Select applications to import'
    end
    object btnBrowse: TButton
      Left = 232
      Top = 24
      Width = 65
      Height = 21
      Caption = 'Browse'
      TabOrder = 1
      OnClick = btnBrowseClick
    end
    object btnDeselectAll: TButton
      Left = 152
      Top = 368
      Width = 105
      Height = 17
      Caption = 'Deselect all'
      TabOrder = 4
      OnClick = btnDeselectAllClick
    end
    object vstListImp: TVirtualStringTree
      Left = 8
      Top = 80
      Width = 289
      Height = 281
      AnimationDuration = 0
      CheckImageKind = ckSystem
      ClipboardFormats.Strings = (
        'CSV'
        'HTML Format'
        'Plain text'
        'Rich Text Format'
        'Rich Text Format Without Objects'
        'Unicode text'
        'Virtual Tree Data')
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'MS Shell Dlg 2'
      Header.Font.Style = []
      Header.MainColumn = -1
      Header.Options = [hoColumnResize, hoDrag]
      ParentFont = False
      TabOrder = 2
      TextMargin = 2
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking]
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
      OnGetText = vstListImpGetText
      Columns = <>
    end
    object edtPathList: TEdit
      Left = 8
      Top = 24
      Width = 217
      Height = 21
      TabOrder = 0
    end
    object btnSelectAll: TButton
      Left = 48
      Top = 368
      Width = 105
      Height = 17
      Caption = 'Select all'
      TabOrder = 3
      OnClick = btnSelectAllClick
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 8
    Top = 408
    DOMVendorDesc = 'MSXML'
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'All list|*.xml;*.ini|winPenPack/ASuite List (*.xml)|*.xml|PStart' +
      ' List (*.xml)|*.xml|ASuite 1.0 List (*.ini)|*.ini'
    Left = 40
    Top = 408
  end
end
