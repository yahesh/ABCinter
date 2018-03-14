unit MainF;

interface

uses
  Windows,
  SysUtils,
  StdCtrls,
  Menus,
  IniFiles,
  Forms,
  ExtCtrls,
  Dialogs,
  Controls,
  ComCtrls,
  Classes,
  Buttons,
  ABCintrU;

{$I ABCcompI.inc}

type
  TMainForm = class(TForm)
    AllInMainCombinationCheckBox : TCheckBox;
    AnalyseMemo                  : TMemo;
    AnalyseTabSheet              : TTabSheet;
    BottomPageControl            : TPageControl;
    BottomPanel                  : TPanel;
    CloseMenuItem                : TMenuItem;
    DivideAMenuItem              : TMenuItem;
    DivideBMenuItem              : TMenuItem;
    ErrorsCheckBox               : TCheckBox;
    FileMenuItem                 : TMenuItem;
    InformationCheckBox          : TCheckBox;
    InputACheckBox               : TCheckBox;
    InputBCheckBox               : TCheckBox;
    InterpretBitBtn              : TBitBtn;
    InterpretMemo                : TMemo;
    InterpretTabSheet            : TTabSheet;
    LeftPanel                    : TPanel;
    LineOrientedModeCheckBox     : TCheckBox;
    LoadFromMenuItem             : TMenuItem;
    MainMenu                     : TMainMenu;
    NewMenuItem                  : TMenuItem;
    OpenDialog                   : TOpenDialog;
    OptionsTabSheet              : TTabSheet;
    OutputCheckBox               : TCheckBox;
    OutputMemo                   : TMemo;
    OutputTabSheet               : TTabSheet;
    RightPanel                   : TPanel;
    SaveAsMenuItem               : TMenuItem;
    SaveDialog                   : TSaveDialog;
    SaveMenuItem                 : TMenuItem;
    SourceMemo                   : TMemo;
    StackCheckBox                : TCheckBox;
    TopPanel                     : TPanel;
    OptionBlocksCheckBox: TCheckBox;

    procedure AllInMainCombinationCheckBoxClick(Sender : TObject);
    procedure AnalyseMemoKeyDown(Sender : TObject;
                                 var Key : Word;
                                 Shift : TShiftState);
    procedure CloseMenuItemClick(Sender : TObject);
    procedure ErrorsCheckBoxClick(Sender: TObject);
    procedure FormClose(Sender : TObject;
                        var Action : TCloseAction);
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure FormKeyDown(Sender : TObject;
                          var Key : Word;
                          Shift : TShiftState);
    procedure FormShow(Sender : TObject);
    procedure InformationCheckBoxClick(Sender: TObject);
    procedure InputACheckBoxClick(Sender: TObject);
    procedure InputBCheckBoxClick(Sender: TObject);
    procedure InterpretBitBtnClick(Sender : TObject);
    procedure InterpretMemoKeyDown(Sender : TObject;
                                   var Key : Word;
                                   Shift : TShiftState);
    procedure LineOrientedModeCheckBoxClick(Sender : TObject);
    procedure LoadFromMenuItemClick(Sender : TObject);
    procedure NewMenuItemClick(Sender : TObject);
    procedure OptionBlocksCheckBoxClick(Sender : TObject);
    procedure OutputCheckBoxClick(Sender: TObject);
    procedure OutputMemoKeyDown(Sender : TObject;
                                var Key : Word;
                                Shift : TShiftState);
    procedure SaveAsMenuItemClick(Sender : TObject);
    procedure SaveMenuItemClick(Sender : TObject);
    procedure SourceMemoChange(Sender : TObject);
    procedure SourceMemoKeyDown(Sender : TObject;
                                var Key : Word;
                                Shift : TShiftState);
    procedure StackCheckBoxClick(Sender : TObject);
  private
    { Private-Deklarationen }
    FAnalysed         : Boolean;
    FAppendWriteFile  : Boolean;
    FDefaultCaption   : AnsiString;
    FInterpreted      : Boolean;
    FInterpreter      : TInterpreter;
    FLastFileText     : AnsiString;
    FLastFileName     : AnsiString;
    FObeyOptionBlocks : Boolean;
    FReadFileCount    : LongInt;
    FReadFileHandle   : THandle;
    FReadFileName     : AnsiString;
    FReadFileSize     : LongInt;
    FWriteFileHandle  : THandle;
    FWriteFileName    : AnsiString;

    function AskForSave : Boolean;
    function CheckChanged : Boolean;
    function CheckFileName(const AFileName : AnsiString) : AnsiString;

    procedure AssignOption(const AOptionName : AnsiString;
                           const AOptionValue : AnsiString);
    procedure ClearMemos;
    procedure CloseReadFile;
    procedure CloseWriteFile;
    procedure DoInterpret;
    procedure LoadFromFile(const AFileName : AnsiString);
    procedure LoadOptions;
    procedure OpenReadFile(var ADone : Boolean);
    procedure OpenWriteFile(var ADone : Boolean);
    procedure ReadChar(var AChar : AnsiChar;
                       var ADone : Boolean);
    procedure SaveOptions;
    procedure SaveToFile(const AFileName : AnsiString);
    procedure SetCaption(const AChanged : Boolean);
    procedure SetDialogFileName;
    procedure ShowAnalyse;
    procedure ShowInterpret;
    procedure ShowOptions;
    procedure ShowOutput;
    procedure WriteChar(const AChar : AnsiChar;
                        var ADone : Boolean);
  public
    { Public-Deklarationen }
    FByteOutput : Boolean;
    FOldInput   : Boolean;
    FShowInput  : Boolean;
  end;

var
  MainForm : TMainForm;

procedure ChangeOption(const AOptionName : AnsiString;
                       const AOptionValue : AnsiString);
procedure ReadFile(var AValue : AnsiChar;
                   var ADone : Boolean);
procedure ReadScreen(var AValue : AnsiChar;
                     var ADone : Boolean);
procedure WriteFile(const AValue : AnsiChar;
                    var ADone : Boolean);
procedure WriteScreen(const AValue : AnsiChar;
                      var ADone : Boolean);

implementation

uses
  InputF;

{$R *.dfm}

procedure ChangeOption(const AOptionName : AnsiString;
                       const AOptionValue : AnsiString);
begin
  MainForm.AssignOption(AOptionName,
                        AOptionValue);
end;

procedure ReadFile(var AValue : AnsiChar;
                   var ADone : Boolean);
begin
  MainForm.ReadChar(AValue,
                    ADone);
end;

procedure ReadScreen(var AValue : AnsiChar;
                     var ADone : Boolean);
begin
  MainForm.ShowOutput;

  if not(MainForm.FOldInput) then
  begin
    AValue := #000;
  end;

  InputForm.GetInput(AValue);
  if (InputForm.FDone) then
    AValue := AnsiChar(InputForm.InputSpinEdit.Value)
  else
    AValue := #000;

  if (MainForm.FShowInput) then
  begin
    MainForm.OutputMemo.Lines.Add('');

    if (MainForm.FByteOutput) then
    begin
      if (AValue = #000) then
        MainForm.OutputMemo.Lines.Add('Input:' + #032 + #032 + #032#040 + IntToStr(Ord(AValue)) + #041)
      else
        MainForm.OutputMemo.Lines.Add('Input:' + #032 + AValue + #032#040 + IntToStr(Ord(AValue)) + #041);
    end
    else
    begin
      if (AValue = #000) then
        MainForm.OutputMemo.Lines.Add('Input:' + #032 + #032)
      else
        MainForm.OutputMemo.Lines.Add('Input:' + #032 + AValue);
    end;

    MainForm.OutputMemo.Lines.Add('');
    MainForm.OutputMemo.Lines.Add('');
  end;

  ADone := InputForm.FDone;
end;

procedure WriteFile(const AValue : AnsiChar;
                    var ADone : Boolean);
begin
  MainForm.WriteChar(AValue,
                     ADone);
end;

procedure WriteScreen(const AValue : AnsiChar;
                      var ADone : Boolean);
begin
  MainForm.ShowOutput;

  if (MainForm.FByteOutput) then
  begin
    if (AValue = #000) then
      MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] := MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] + #032 + #032 + #032#040 + IntToStr(Ord(AValue)) + #041
    else
      MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] := MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] + #032 + AValue + #032#040 + IntToStr(Ord(AValue)) + #041;
  end
  else
  begin
    if (AValue = #000) then
      MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] := MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] + #032
    else
      MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] := MainForm.OutputMemo.Lines[Pred(MainForm.OutputMemo.Lines.Count)] + AValue;
  end;

  ADone := true;
end;

{ TMainForm }

procedure TMainForm.AllInMainCombinationCheckBoxClick(Sender : TObject);
begin
  FInterpreter.AllInMainCombination := AllInMainCombinationCheckBox.Checked;
end;

procedure TMainForm.AnalyseMemoKeyDown(Sender : TObject;
                                       var Key : Word;
                                       Shift : TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('A')) or (Key = Ord('a'))) then
  begin
    Key := 000;
    AnalyseMemo.SelectAll;
  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('C')) or (Key = Ord('c'))) then
//  begin
//    Key := 000;
//    AnalyseMemo.CopyToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('V')) or (Key = Ord('v'))) then
//  begin
//    Key := 000;
//    AnalyseMemo.PasteFromClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('X')) or (Key = Ord('x'))) then
//  begin
//    Key := 000;
//    AnalyseMemo.CutToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('Z')) or (Key = Ord('z'))) then
//  begin
//    Key := 000;
//    if AnalyseMemo.CanUndo then
//    begin
//      AnalyseMemo.Undo;
//    end;
//  end;
end;

procedure TMainForm.CloseMenuItemClick(Sender : TObject);
begin
  if (not(CheckChanged) or (CheckChanged and AskForSave)) then
  begin
    Close;
  end;
end;

procedure TMainForm.ErrorsCheckBoxClick(Sender : TObject);
begin
  FInterpreter.ShowErrors := ErrorsCheckBox.Checked;
end;

procedure TMainForm.FormClose(Sender : TObject;
                              var Action : TCloseAction);
begin
  if (CheckChanged and not(AskForSave)) then
  begin
    Action := caNone;
  end;
end;

procedure TMainForm.FormCreate(Sender : TObject);
begin
  FInterpreter := TInterpreter.Create;
  FInterpreter.Initialize;

  FInterpreter.ChangeOption     := ChangeOption;
  FInterpreter.Messages         := TAnsiStringList.Create;
  FInterpreter.ReadFileValue    := ReadFile;
  FInterpreter.ReadScreenValue  := ReadScreen;
  FInterpreter.ShowErrors       := true;
  FInterpreter.ShowInformation  := false;
  FInterpreter.Source           := TAnsiStringList.Create;
  FInterpreter.StackProtection  := true;
  FInterpreter.WriteFileValue   := WriteFile;
  FInterpreter.WriteScreenValue := WriteScreen;

  FAnalysed         := false;
  FDefaultCaption   := Caption;
  FInterpreted      := false;
  FByteOutput       := false;
  FLastFileName     := '';
  FLastFileText     := '';
  FObeyOptionBlocks := false;
  FOldInput         := false;
  FShowInput        := false;
  FReadFileCount    := 000;
  FReadFileHandle   := Invalid_Handle_Value;
  FReadFileName     := '';
  FReadFileSize     := 000;
  FWriteFileHandle  := Invalid_Handle_Value;
  FWriteFileName    := '';

  LoadOptions;
  SaveOptions;
  ShowOptions;
  SetCaption(CheckChanged);
end;

procedure TMainForm.FormDestroy(Sender : TObject);
begin
  SaveOptions;

  FInterpreter.Messages.Free;
  FInterpreter.Source.Free;
  FInterpreter.Free;
end;

procedure TMainForm.FormKeyDown(Sender : TObject;
                                var Key : Word;
                                Shift : TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    if (Key = vk_Left) then
    begin
      if (BottomPageControl.ActivePage = AnalyseTabSheet) then
      begin
        ShowOptions;
      end
      else
      begin
        if (BottomPageControl.ActivePage = InterpretTabSheet) then
        begin
          ShowAnalyse;
        end
        else
        begin
          if (BottomPageControl.ActivePage = OptionsTabSheet) then
          begin
            ShowOutput;
          end
          else
          begin
            if (BottomPageControl.ActivePage = OutputTabSheet) then
            begin
              ShowInterpret;
            end
            else
            begin
              ShowAnalyse;
            end;
          end;
        end;
      end;
    end
    else
    begin
      if (Key = vk_Right) then
      begin
        if (BottomPageControl.ActivePage = AnalyseTabSheet) then
        begin
          ShowInterpret;
        end
        else
        begin
          if (BottomPageControl.ActivePage = InterpretTabSheet) then
          begin
            ShowOutput;
          end
          else
          begin
            if (BottomPageControl.ActivePage = OptionsTabSheet) then
            begin
              ShowAnalyse;
            end
            else
            begin
              if (BottomPageControl.ActivePage = OutputTabSheet) then
              begin
                ShowOptions;
              end
              else
              begin
                ShowAnalyse;
              end;
            end;
          end;
        end;
      end
      else
      begin
        if (ssCtrl in Shift) then
        begin
          if (Key = vk_Tab) then
          begin
            if (InterpretBitBtn.Focused) then
            begin
              SourceMemo.SetFocus;
            end
            else
            begin
              if (SourceMemo.Focused) then
              begin
                InterpretBitBtn.SetFocus;
              end
              else
              begin
                SourceMemo.SetFocus;
              end;
            end;

            Key := 000;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.FormShow(Sender : TObject);
const
  CExParamA = '-ex';
  CExParamB = 'ex';
  CExParamC = '+ex';
begin
  if (ParamCount > 000) then
  begin
    if (ParamCount = 001) then
    begin
      if (FileExists(ParamStr(001))) then
      begin
        LoadFromFile(ParamStr(001));
      end;
    end
    else
    begin
      if (ParamCount >= 002) then
      begin
        if ((AnsiLowerCase(ParamStr(001)) = CExParamA) or (AnsiLowerCase(ParamStr(001)) = CExParamB) or (AnsiLowerCase(ParamStr(001)) = CExParamC)) then
        begin
          if (FileExists(ParamStr(002))) then
          begin
            LoadFromFile(ParamStr(002));

            DoInterpret;
            if (FInterpreted) then
            begin
              if (AnsiLowerCase(ParamStr(001)) = CExParamB) then
              begin
                Close;
              end;
            end;

            if (AnsiLowerCase(ParamStr(001)) = CExParamA) then
            begin
              Close;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.InformationCheckBoxClick(Sender : TObject);
begin
  FInterpreter.ShowInformation := InformationCheckBox.Checked;
end;

procedure TMainForm.InputACheckBoxClick(Sender : TObject);
begin
  FOldInput := InputACheckBox.Checked;
end;

procedure TMainForm.InputBCheckBoxClick(Sender : TObject);
begin
  FShowInput := InputBCheckBox.Checked;
end;

procedure TMainForm.InterpretBitBtnClick(Sender : TObject);
begin
  InterpretBitBtn.Enabled := false;
  try
    DoInterpret;
  finally
    InterpretBitBtn.Enabled := true;
  end;
end;

procedure TMainForm.InterpretMemoKeyDown(Sender : TObject;
                                         var Key : Word;
                                         Shift : TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('A')) or (Key = Ord('a'))) then
  begin
    Key := 000;
    InterpretMemo.SelectAll;
  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('C')) or (Key = Ord('c'))) then
//  begin
//    Key := 000;
//    InterpretMemo.CopyToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('V')) or (Key = Ord('v'))) then
//  begin
//    Key := 000;
//    InterpretMemo.PasteFromClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('X')) or (Key = Ord('x'))) then
//  begin
//    Key := 000;
//    InterpretMemo.CutToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('Z')) or (Key = Ord('z'))) then
//  begin
//    Key := 000;
//    if InterpretMemo.CanUndo then
//    begin
//      InterpretMemo.Undo;
//    end;
//  end;
end;

procedure TMainForm.LineOrientedModeCheckBoxClick(Sender : TObject);
begin
  FInterpreter.LineOrientedMode := LineOrientedModeCheckBox.Checked;
end;

procedure TMainForm.LoadFromMenuItemClick(Sender : TObject);
begin
  if (not(CheckChanged) or (CheckChanged and AskForSave)) then
  begin
    SetDialogFileName;

    if (OpenDialog.Execute) then
    begin
      LoadFromFile(OpenDialog.FileName);
    end;
  end;
end;

procedure TMainForm.NewMenuItemClick(Sender : TObject);
begin
  if (not(CheckChanged) or (CheckChanged and AskForSave)) then
  begin
    SourceMemo.Lines.Clear;

    FLastFileName := '';
    FLastFileText := '';

    SetCaption(CheckChanged);
  end;
end;

procedure TMainForm.OptionBlocksCheckBoxClick(Sender : TObject);
begin
  FObeyOptionBlocks := OptionBlocksCheckBox.Checked;
end;

procedure TMainForm.OutputCheckBoxClick(Sender : TObject);
begin
  FByteOutput := OutputCheckBox.Checked;
end;

procedure TMainForm.OutputMemoKeyDown(Sender : TObject;
                                      var Key : Word;
                                      Shift : TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('A')) or (Key = Ord('a'))) then
  begin
    Key := 000;
    OutputMemo.SelectAll;
  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('C')) or (Key = Ord('c'))) then
//  begin
//    Key := 000;
//    OutputMemo.CopyToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('V')) or (Key = Ord('v'))) then
//  begin
//    Key := 000;
//    OutputMemo.PasteFromClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('X')) or (Key = Ord('x'))) then
//  begin
//    Key := 000;
//    OutputMemo.CutToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('Z')) or (Key = Ord('z'))) then
//  begin
//    Key := 000;
//    if OutputMemo.CanUndo then
//    begin
//      OutputMemo.Undo;
//    end;
//  end;
end;

procedure TMainForm.SaveAsMenuItemClick(Sender : TObject);
begin
  SetDialogFileName;

  if (SaveDialog.Execute) then
  begin
    SaveToFile(CheckFileName(SaveDialog.FileName));
  end;
end;

procedure TMainForm.SaveMenuItemClick(Sender : TObject);
begin
  if (FLastFileName <> '') then
  begin
    SaveToFile(FLastFileName);
  end
  else
  begin
    SaveAsMenuItemClick(nil);
  end;
end;

procedure TMainForm.SourceMemoChange(Sender : TObject);
begin
  SetCaption(CheckChanged);
end;

procedure TMainForm.SourceMemoKeyDown(Sender : TObject;
                                      var Key : Word;
                                      Shift : TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('A')) or (Key = Ord('a'))) then
  begin
    Key := 000;
    SourceMemo.SelectAll;
  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('C')) or (Key = Ord('c'))) then
//  begin
//    Key := 000;
//    SourceMemo.CopyToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('V')) or (Key = Ord('v'))) then
//  begin
//    Key := 000;
//    SourceMemo.PasteFromClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('X')) or (Key = Ord('x'))) then
//  begin
//    Key := 000;
//    SourceMemo.CutToClipboard;
//  end;
//  if (Shift = [ssCtrl]) and ((Key = Ord('Z')) or (Key = Ord('z'))) then
//  begin
//    Key := 000;
//    if SourceMemo.CanUndo then
//    begin
//      SourceMemo.Undo;
//    end;
//  end;
end;

procedure TMainForm.StackCheckBoxClick(Sender : TObject);
begin
  FInterpreter.StackProtection := StackCheckBox.Checked;
end;

function TMainForm.AskForSave : Boolean;
var
  DlgResult : LongInt;
begin
  Result := true;

  if (CheckChanged) then
  begin
    DlgResult := MessageDlg('Die letzten Änderungen wurden noch nicht gespeichert.' + #013#010 +
                            'Wollen sie die letzten Änderungen nun speichern?',
                            mtConfirmation, [mbYes, mbNo, mbCancel], 0);

    if (DlgResult = mrYes) then
    begin
      SaveMenuItemClick(nil);
    end
    else
    begin
      Result := (DlgResult = mrNo);
    end;
  end;
end;

function TMainForm.CheckChanged : Boolean;
begin
  Result := (SourceMemo.Text <> FLastFileText);
end;

function TMainForm.CheckFileName(const AFileName : AnsiString) : AnsiString;
begin
  Result := AFileName;

  if (SaveDialog.FilterIndex = 001) then
  begin
    if (not(AnsiLowerCase(ExtractFileExt(AFileName)) = '.abc')) then
    begin
      Result := Result + '.abc';
    end;
  end;
end;

procedure TMainForm.AssignOption(const AOptionName : AnsiString;
                                 const AOptionValue : AnsiString);
var
  Index : LongInt;
begin
  if ((FObeyOptionBlocks) and (FAnalysed)) then
  begin
    if (AnsiLowerCase(Trim(AOptionName)) = 'appendoutfile') then
    begin
      if (FAppendWriteFile <> (AnsiLowerCase(Trim(FInterpreter.OptionValueN['appendoutfile'])) = 'true')) then
      begin
        FAppendWriteFile := (AnsiLowerCase(Trim(FInterpreter.OptionValueN['appendoutfile'])) = 'true');

        if ((FAppendWriteFile) and (FWriteFileHandle <> Invalid_Handle_Value)) then
        begin
          FileSeek(FWriteFileHandle, 000, 002);
        end;
      end;
    end;

    if (AnsiLowerCase(Trim(AOptionName)) = 'infile') then
    begin
      if (AnsiLowerCase(Trim(AOptionValue)) <> AnsiLowerCase(Trim(FReadFileName))) then
      begin
        CloseReadFile;
      end;

      if (Length(AOptionValue) > 000) then
      begin
        FReadFileName := AOptionValue;
      end
      else
      begin
        FReadFileName := ChangeFileExt(Application.ExeName, '.in');
      end;
    end;

    if (AnsiLowerCase(Trim(AOptionName)) = 'outfile') then
    begin
      if (AnsiLowerCase(Trim(AOptionValue)) <> AnsiLowerCase(Trim(FWriteFileName))) then
      begin
        CloseWriteFile;
      end;

      if (Length(AOptionValue) > 000) then
      begin
        FWriteFileName := AOptionValue;
      end
      else
      begin
        Index := 001;
        while (FileExists(ChangeFileExt(Application.ExeName, '.out.' + IntToStr(Index)))) do
        begin
          Inc(Index);
        end;
        FWriteFileName := ChangeFileExt(Application.ExeName, '.out.' + IntToStr(Index));
      end;
    end;

    if (AnsiLowerCase(Trim(AOptionName)) = 'print') then
    begin
      ShowMessage(AOptionValue);
    end;
  end;
end;

procedure TMainForm.ClearMemos;
begin
  AnalyseMemo.Lines.Clear;
  InterpretMemo.Lines.Clear;
  OutputMemo.Lines.Clear;
end;

procedure TMainForm.CloseReadFile;
begin
  if (FReadFileHandle <> Invalid_Handle_Value) then
  begin
    FileClose(FReadFileHandle);

    FReadFileHandle := Invalid_Handle_Value;
  end;
end;

procedure TMainForm.CloseWriteFile;
begin
  if (FWriteFileHandle <> Invalid_Handle_Value) then
  begin
    FileClose(FWriteFileHandle);

    FWriteFileHandle := Invalid_Handle_Value;
  end;
end;

procedure TMainForm.DoInterpret;
var
  Index : LongInt;
begin
  FAnalysed        := false;
  FAppendWriteFile := false;
  FInterpreted     := false;

  CloseReadFile;
  CloseWriteFile;

  ClearMemos;

  FInterpreter.Initialize;
  FInterpreter.Messages.Clear;
  FInterpreter.Source.Clear;

  for Index := 000 to Pred(SourceMemo.Lines.Count) do
    FInterpreter.Source.Add(SourceMemo.Lines[Index]);

  ShowAnalyse;
  Application.ProcessMessages;

  FAnalysed := FInterpreter.AnalyseSource;
  if (FAnalysed) then
  begin
    FReadFileName := ChangeFileExt(Application.ExeName, '.in');

    Index := 001;
    while (FileExists(ChangeFileExt(Application.ExeName, '.out.' + IntToStr(Index)))) do
    begin
      Inc(Index);
    end;
    FWriteFileName := ChangeFileExt(Application.ExeName, '.out.' + IntToStr(Index));

    ClearMemos;

    // Memo-Bugfix (first memo-line has to contain a single #013)
    OutputMemo.Lines.Add(#013);

    if (FInterpreter.LineOrientedMode) then
    begin
      FInterpreter.Initialize;
    end;

    FInterpreter.Messages.Clear;

    if (not(FInterpreter.LineOrientedMode)) then
    begin
      FInterpreter.Source.Clear;
    end;

    ShowInterpret;
    Application.ProcessMessages;

    FInterpreted := FInterpreter.InterpretSource;
    if (not(FInterpreted)) then
    begin
      InterpretMemo.Text := FInterpreter.Messages.LinedText;
      ShowInterpret;
    end;

    CloseReadFile;
    CloseWriteFile;
  end
  else
  begin
    AnalyseMemo.Text := FInterpreter.Messages.LinedText;
    ShowAnalyse;
  end;

  FInterpreter.Messages.Clear;
  FInterpreter.Source.Clear;
end;

procedure TMainForm.LoadFromFile(const AFileName : AnsiString);
begin
  if (FileExists(AFileName)) then
  begin
    SourceMemo.Lines.LoadFromFile(AFileName);

    FLastFileName := AFileName;
    FLastFileText := SourceMemo.Text;

    SetCaption(CheckChanged);
  end;
end;

procedure TMainForm.LoadOptions;
const
  CSection = 'AlPhAbEt';
var
  IniFile : TIniFile;
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.opt'));
  try
    FByteOutput                       := IniFile.ReadBool(CSection, 'ByteOutput',           false);
    FInterpreter.AllInMainCombination := IniFile.ReadBool(CSection, 'AllInMainCombination', false);
    FInterpreter.LineOrientedMode     := IniFile.ReadBool(CSection, 'LineOrientedMode',     false);
    FInterpreter.ShowErrors           := IniFile.ReadBool(CSection, 'ShowErrors',           true);
    FInterpreter.ShowInformation      := IniFile.ReadBool(CSection, 'ShowInformation',      false);
    FObeyOptionBlocks                 := IniFile.ReadBool(CSection, 'ObeyOptionBlocks',     true);
    FOldInput                         := IniFile.ReadBool(CSection, 'OldInput',             true);
    FShowInput                        := IniFile.ReadBool(CSection, 'ShowInput',            false);
    FInterpreter.StackProtection      := IniFile.ReadBool(CSection, 'StackProtection',      true);

    Height := IniFile.ReadInteger(CSection, 'Height', 385);
    Left   := IniFile.ReadInteger(CSection, 'Left',   000);
    Top    := IniFile.ReadInteger(CSection, 'Top',    000);
    Width  := IniFile.ReadInteger(CSection, 'Width',  455);

    WindowState := TWindowState(IniFile.ReadInteger(CSection, 'WindowState', LongInt(wsNormal)));
  finally
    IniFile.Free;
  end;
end;

procedure TMainForm.OpenReadFile(var ADone : Boolean);
begin
  ADone := false;

  if (FReadFileHandle = Invalid_Handle_Value) then
  begin
    if (FileExists(FReadFileName)) then
    begin
      FReadFileHandle := FileOpen(FReadFileName, fmOpenRead or fmShareDenyNone);
      try
        if (FReadFileHandle <> Invalid_Handle_Value) then
        begin
          FReadFileCount := 000;
          FReadFileSize  := FileSeek(FReadFileHandle, 000, 002);
          FileSeek(FReadFileHandle, 000, 000);

          ADone := (FReadFileSize > 000);
        end;
      finally
        if (not(ADone)) then
        begin
          CloseReadFile;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OpenWriteFile(var ADone : Boolean);
begin
  ADone := false;

  if (FWriteFileHandle = Invalid_Handle_Value) then
  begin
    if not(FileExists(FWriteFileName)) then
    begin
      FWriteFileHandle := FileCreate(FWriteFileName);
      try
      finally
        CloseWriteFile;
      end;
    end;
    FWriteFileHandle := FileOpen(FWriteFileName, fmOpenWrite or fmShareDenyNone);
    try
      ADone := (FWriteFileHandle <> Invalid_Handle_Value);

      if (ADone) then
      begin
        if (FAppendWriteFile) then
        begin
          FileSeek(FWriteFileHandle, 000, 002);
        end
        else
        begin
          FileSeek(FWriteFileHandle, 000, 000);
        end;
      end;
    finally
      if (not(ADone)) then
      begin
        CloseWriteFile;
      end;
    end;
  end;
end;

procedure TMainForm.ReadChar(var AChar : AnsiChar; var ADone : Boolean);
begin
  ADone := (FReadFileHandle <> Invalid_Handle_Value);
  if (not(ADone)) then
  begin
    OpenReadFile(ADone);
  end;

  if (ADone) then
  begin
    ADone := (FReadFileCount < FReadFileSize);

    if (ADone) then
    begin
      ADone := (FileRead(FReadFileHandle, AChar, 001) = 001);

      Inc(FReadFileCount);
    end;
  end;
end;

procedure TMainForm.SaveOptions;
const
  CSection = 'AlPhAbEt';
var
  IniFile : TIniFile;
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.opt'));
  try
    IniFile.WriteBool(CSection, 'ByteOutput',           FByteOutput);
    IniFile.WriteBool(CSection, 'AllInMainCombination', FInterpreter.AllInMainCombination);
    IniFile.WriteBool(CSection, 'LineOrientedMode',     FInterpreter.LineOrientedMode);
    IniFile.WriteBool(CSection, 'ShowErrors',           FInterpreter.ShowErrors);
    IniFile.WriteBool(CSection, 'ShowInformation',      FInterpreter.ShowInformation);
    IniFile.WriteBool(CSection, 'ObeyOptionBlocks',     FObeyOptionBlocks);
    IniFile.WriteBool(CSection, 'OldInput',             FOldInput);
    IniFile.WriteBool(CSection, 'ShowInput',            FShowInput);
    IniFile.WriteBool(CSection, 'StackProtection',      FInterpreter.StackProtection);

    IniFile.WriteInteger(CSection, 'Height', Height);
    IniFile.WriteInteger(CSection, 'Left',   Left);
    IniFile.WriteInteger(CSection, 'Top',    Top);
    IniFile.WriteInteger(CSection, 'Width',  Width);

    IniFile.WriteInteger(CSection, 'WindowState', LongInt(WindowState));
  finally
    IniFile.Free;
  end;
end;

procedure TMainForm.SaveToFile(const AFileName : AnsiString);
begin
  try
    SourceMemo.Lines.SaveToFile(AFileName);

    FLastFileName := AFileName;
    FLastFileText := SourceMemo.Text;

    SetCaption(CheckChanged);
  except
  end;
end;

procedure TMainForm.SetCaption(const AChanged : Boolean);
begin
  Caption := FDefaultCaption + #032#091 + FLastFileName + #093;

  if (AChanged) then
  begin
    Caption := Caption + #032#035;
  end;
end;

procedure TMainForm.SetDialogFileName;
begin
  if (FileExists(FLastFileName)) then
  begin
    OpenDialog.FileName := FLastFileName;
    SaveDialog.FileName := FLastFileName;
  end
  else
  begin
    OpenDialog.FileName := Application.ExeName;
    SaveDialog.FileName := Application.ExeName;
  end;
end;

procedure TMainForm.ShowAnalyse;
begin
  BottomPageControl.ActivePage := AnalyseTabSheet;
end;

procedure TMainForm.ShowInterpret;
begin
  BottomPageControl.ActivePage := InterpretTabSheet;
end;

procedure TMainForm.ShowOptions;
begin
  AllInMainCombinationCheckBox.Checked := FInterpreter.AllInMainCombination;
  ErrorsCheckBox.Checked               := FInterpreter.ShowErrors;
  InformationCheckBox.Checked          := FInterpreter.ShowInformation;
  InputACheckBox.Checked               := FOldInput;
  InputBCheckBox.Checked               := FShowInput;
  LineOrientedModeCheckBox.Checked     := FInterpreter.LineOrientedMode;
  OptionBlocksCheckBox.Checked         := FObeyOptionBlocks;
  OutputCheckBox.Checked               := FByteOutput;
  StackCheckBox.Checked                := FInterpreter.StackProtection;

  BottomPageControl.ActivePage := OptionsTabSheet;
end;

procedure TMainForm.ShowOutput;
begin
  BottomPageControl.ActivePage := OutputTabSheet;
end;

procedure TMainForm.WriteChar(const AChar : AnsiChar;
                              var ADone : Boolean);
begin
  ADone := (FWriteFileHandle <> Invalid_Handle_Value);
  if (not(ADone)) then
  begin
    OpenWriteFile(ADone);
  end;

  if (ADone) then
  begin
    ADone := (FileWrite(FWriteFileHandle, AChar, 001) = 001);
  end;
end;

end.
