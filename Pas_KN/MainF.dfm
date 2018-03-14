object MainForm: TMainForm
  Left = 309
  Top = 136
  Width = 432
  Height = 499
  Caption = '| Shorei | AlPhAbEt - Interpreter (V 0.24)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    000001000200202002000000000030010000260000002020100000000000E802
    0000560100002800000020000000400000000100010000000000000100000000
    000000000000000000000000000000000000FFFFFF0000000000000000000000
    01F00000070800000E0400000C0040071C00200E1C00200E1C001FFC1C00181C
    1C0008380C0408380E0C0470071C047001E402E0000002E0000001C03E0001C0
    FC000081F0000080E04000000060000080E00000C1E00000C3C00000C0000000
    C0000000C1800009C3C0000FC7000007860000000000FFFFFF07FFFFFC03FFFF
    F801FFFFF0008FF820F00FF020F907F040FF800040FF8000C0FFC000C0FCC001
    C0F8E181E070E083E000F003F000F007F800F807E019F80B807FFC04003FFC18
    001FFE1C030FFE3E0F07FF7E1F07FFFE0807FFFA000FFFF6081FFFE60C3FFFE2
    0E1FFFE00C0FFFE0000FFFE0001FFFF030FFFFF879FF28000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000077777000000000000000000000000070000077000000
    0000000000000000000888880770000000000000000000000888000080770777
    0000000007777700888000000807000700000000000007008807000000000907
    7000000009990008880700000000009077777770999070088807000000000090
    0000000099900008880700000000000999999999990700088807000000770009
    9000000999000008880700000007000090700099907000008807700008070000
    9077009990000000888077708807000009070999070000000888000888070000
    0907099900000000000888800807000000909990700000077770000000000000
    0090999007000700000770000000000000099907007700CCCCC0770000000000
    000999000000CCCCCC0007700000000000009070000CCCCC0000007700000000
    000090000000CCC000000C0770000000000000000000000000000CC070000000
    000000000000C0770770CCC070000000000000000700CC07000CCCC000000000
    000000000000CC0700CCCC0000000000000000007000CC070000000000000000
    000000007700CC070000077000000000000000000770CC07000CC07700000000
    00000000C00CCC0770CCCC070000000000000000CCCCCC000CCC000000000000
    000000000CCCC0000CC00000000000000000000000000000000000000000FFFF
    FF07FFFFFC03FFFFF801FFFFF0008FF820F00FF020F907F040FF800040FF8000
    C0FFC000C0FCC001C0F8E181E070E083E000F003F000F007F800F807E019F80B
    807FFC04003FFC18001FFE1C030FFE3E0F07FF7E1F07FFFE0807FFFA000FFFF6
    081FFFE60C3FFFE20E1FFFE00C0FFFE0000FFFE0001FFFF030FFFFF879FF}
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 250
    Width = 424
    Height = 201
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object LeftPanel: TPanel
      Left = 0
      Top = 0
      Width = 113
      Height = 201
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object InterpretBitBtn: TBitBtn
        Left = 8
        Top = 8
        Width = 97
        Height = 25
        Caption = '&Interpretieren'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = InterpretBitBtnClick
      end
    end
    object RightPanel: TPanel
      Left = 113
      Top = 0
      Width = 311
      Height = 201
      Align = alClient
      TabOrder = 1
      object BottomPageControl: TPageControl
        Left = 1
        Top = 1
        Width = 309
        Height = 199
        ActivePage = OptionsTabSheet
        Align = alClient
        MultiLine = True
        TabOrder = 0
        TabPosition = tpBottom
        TabStop = False
        object AnalyseTabSheet: TTabSheet
          Caption = 'Analyse'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          object AnalyseMemo: TMemo
            Left = 0
            Top = 0
            Width = 324
            Height = 161
            TabStop = False
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
            WantReturns = False
            WordWrap = False
            OnKeyDown = AnalyseMemoKeyDown
          end
        end
        object InterpretTabSheet: TTabSheet
          Caption = 'In&terpretation'
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = False
          object InterpretMemo: TMemo
            Left = 0
            Top = 0
            Width = 324
            Height = 161
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
            WantReturns = False
            WordWrap = False
            OnKeyDown = InterpretMemoKeyDown
          end
        end
        object OutputTabSheet: TTabSheet
          Caption = 'A&usgabe'
          ImageIndex = 3
          object OutputMemo: TMemo
            Left = 0
            Top = 0
            Width = 324
            Height = 161
            TabStop = False
            Align = alClient
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
            WantReturns = False
            WordWrap = False
            OnKeyDown = OutputMemoKeyDown
          end
        end
        object OptionsTabSheet: TTabSheet
          Caption = '&Optionen'
          ImageIndex = 2
          object ErrorsCheckBox: TCheckBox
            Left = 8
            Top = 48
            Width = 185
            Height = 17
            Caption = '&Fehlermeldungen anzeigen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clOlive
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnClick = ErrorsCheckBoxClick
          end
          object InformationCheckBox: TCheckBox
            Left = 8
            Top = 64
            Width = 217
            Height = 17
            Caption = 'In&formationsmeldungen anzeigen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            OnClick = InformationCheckBoxClick
          end
          object StackCheckBox: TCheckBox
            Left = 8
            Top = 0
            Width = 241
            Height = 17
            Caption = '&Stack-Overflow-Protection aktivieren'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = StackCheckBoxClick
          end
          object OutputCheckBox: TCheckBox
            Left = 8
            Top = 80
            Width = 257
            Height = 17
            Caption = 'Aus&gabezeichen mit Bytecode anzeigen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            OnClick = OutputCheckBoxClick
          end
          object InputACheckBox: TCheckBox
            Left = 8
            Top = 96
            Width = 257
            Height = 17
            Caption = 'aktuelles &Zeichen bei Eingabe anzeigen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
            OnClick = InputACheckBoxClick
          end
          object InputBCheckBox: TCheckBox
            Left = 8
            Top = 112
            Width = 281
            Height = 17
            Caption = 'Eingabezeichen in Ausgabe &mitprotokollieren'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 6
            OnClick = InputBCheckBoxClick
          end
          object LineOrientedModeCheckBox: TCheckBox
            Left = 8
            Top = 136
            Width = 249
            Height = 17
            Caption = 'zeilen&orientierter Interpretationsmodus'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 7
            OnClick = LineOrientedModeCheckBoxClick
          end
          object AllInMainCombinationCheckBox: TCheckBox
            Left = 8
            Top = 152
            Width = 265
            Height = 17
            Caption = 'automatische M&ain-Kombinationeinf'#252'gung'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 8
            OnClick = AllInMainCombinationCheckBoxClick
          end
          object OptionBlocksCheckBox: TCheckBox
            Left = 8
            Top = 24
            Width = 169
            Height = 17
            Caption = 'Optionsbl'#246'cke beachten'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = OptionBlocksCheckBoxClick
          end
        end
      end
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 424
    Height = 250
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object SourceMemo: TMemo
      Left = 0
      Top = 0
      Width = 424
      Height = 250
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      WantTabs = True
      WordWrap = False
      OnChange = SourceMemoChange
      OnKeyDown = SourceMemoKeyDown
    end
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
    object FileMenuItem: TMenuItem
      Caption = '&Datei'
      object NewMenuItem: TMenuItem
        Caption = '&Neu'
        ShortCut = 16462
        OnClick = NewMenuItemClick
      end
      object DivideAMenuItem: TMenuItem
        Caption = '-'
      end
      object LoadFromMenuItem: TMenuItem
        Caption = '&Laden'
        ShortCut = 16460
        OnClick = LoadFromMenuItemClick
      end
      object SaveMenuItem: TMenuItem
        Caption = '&Speichern'
        ShortCut = 16467
        OnClick = SaveMenuItemClick
      end
      object SaveAsMenuItem: TMenuItem
        Caption = 'Speichern &unter'
        ShortCut = 16469
        OnClick = SaveAsMenuItemClick
      end
      object DivideBMenuItem: TMenuItem
        Caption = '-'
      end
      object CloseMenuItem: TMenuItem
        Caption = '&Beenden'
        Default = True
        ShortCut = 16450
        OnClick = CloseMenuItemClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.abc'
    Filter = 'AlPhAbEt - Quellen [*.abc]|*.abc|Alle Dateien [*.*]|*.*'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofCreatePrompt, ofEnableSizing]
    Left = 40
    Top = 8
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.abc'
    Filter = 'AlPhAbEt - Quellen [*.abc]|*.abc|Alle Dateien [*.*]|*.*'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofCreatePrompt, ofEnableSizing]
    Left = 72
    Top = 8
  end
end
