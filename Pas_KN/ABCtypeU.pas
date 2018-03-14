unit ABCtypeU;

// DON'T DELETE THIS COMMENT !!!

{ "AlPhAbEt" - Interpreter }

{--------------------------------------------}
{ Unit:     ABCtypeU.pas                     }
{ Version:  0.24                             }
{                                            }
{ Coder:    Yahe <hello@yahe.sh>             }
{                                            }
{ I'm NOT Liable For Damages Of ANY Kind !!! }
{--------------------------------------------}

// DON'T DELETE THIS COMMENT !!!

interface

uses
  ABCtuseU,
  ABCsymU;

{$I ABCcompI.inc}

type
{
// [Predefined Types Under Delphi 7]
  PAnsiChar   = ^AnsiChar;
  PAnsiString = ^AnsiString;
  PPointer    = ^Pointer;
// [Predefined Types Under Delphi 7]
}

  TABCAnsiCharList     = class;
  TABCAnsiStringList   = class;
  TABCBasicPointerList = class;
  TABCInterpreter      = class;
  TABCPointerList      = class;
  TABCRegistersItem    = class;

  TAnsiCharSet = set of AnsiChar;

  TABCCombinationRecord = record
    Static : Boolean;
    Value  : AnsiString;
  end;
  PABCCombinationRecord = ^TABCCombinationRecord;

  TABCExNumber = Low(CExRegisterArray) .. High(CExRegisterArray);
  TABCHiNumber = Low(CHiRegisterArray) .. High(CHiRegisterArray);
  TABCLoNumber = Low(CLoRegisterArray) .. High(CLoRegisterArray);

  TABCExCombinationArray = array [Low(TABCExNumber) .. High(TABCExNumber)] of TABCCombinationRecord;
  TABCHiCombinationArray = array [Low(TABCHiNumber) .. High(TABCHiNumber)] of TABCCombinationRecord;
  TABCLoCombinationArray = array [Low(TABCLoNumber) .. High(TABCLoNumber)] of TABCCombinationRecord;

  TABCExRegisterArray = array [Low(TABCExNumber) .. High(TABCExNumber)] of AnsiChar;
  TABCHiRegisterArray = array [Low(TABCHiNumber) .. High(TABCHiNumber)] of AnsiChar;
  TABCLoRegisterArray = array [Low(TABCLoNumber) .. High(TABCLoNumber)] of AnsiChar;

  TABCChangeOptionMethod = procedure (const AOptionName : AnsiString;
                                      const AOptionValue : AnsiString);
  TABCReadValueMethod    = procedure (var AValue : AnsiChar;
                                      var ASuccess : Boolean);
  TABCWriteValueMethod   = procedure (const AValue : AnsiChar;
                                      var ASuccess : Boolean);

  TABCOptionRecord = record
    OptionName  : AnsiString;
    OptionValue : AnsiString;
  end;
  TABCOptionArray = array of TABCOptionRecord;

  TABCBasicPointerListArray = array of Pointer;
  TABCBasicPointerList = class(TObject)
  private
  protected
    FArray     : TABCBasicPointerListArray;
    FCount     : LongWord;
    FDeltaSize : LongWord;

    function AdjustSize : Boolean; overload;
    function AdjustSize(const ADeltaSize : LongWord) : Boolean; overload;
    function DecreaseSize : Boolean; overload;
    function DecreaseSize(const ADeltaSize : LongWord) : Boolean; overload;
    function GetItem(const AIndex : LongWord) : Pointer;
    function IncreaseSize : Boolean; overload;
    function IncreaseSize(const ADeltaSize : LongWord) : Boolean; overload;

    procedure SetDeltaSize(const AValue : LongWord);
    procedure SetItem(const AIndex : LongWord;
                      const AValue : Pointer);
  public
    constructor Create;

    destructor Destroy; override;

    property Count                          : LongWord read FCount;
    property DeltaSize                      : LongWord read FDeltaSize write SetDeltaSize;
    property Items[const AIndex : LongWord] : Pointer  read GetItem    write SetItem;

    function Add(const AValue : Pointer) : LongWord;
    function Clear : Boolean;
    function Delete(const AIndex : LongWord) : Boolean;
    function DeleteFirst : Boolean;
    function DeleteLast : Boolean;
    function Insert(const AValue : Pointer;
                    const AIndex : LongWord) : Boolean;
    function InsertAsFirst(const AValue : Pointer) : Boolean;
    function InsertAsLast(const AValue : Pointer) : Boolean;
    function IsInLowerRange(const AIndex : LongWord) : Boolean;
    function IsInRange(const AIndex : LongWord) : Boolean;
    function IsInUpperRange(const AIndex : LongWord) : Boolean;
    function PutFirstToLast : Boolean;
    function PutLastToFirst : Boolean;
  published
  end;

  TABCPointerList = class(TABCBasicPointerList)
  private
  protected
    FEntriesOrder : TABCBasicPointerList;

    function GetEntry(const AIndex : LongWord) : Pointer;
    function GetItem(const AIndex : LongWord) : Pointer;

    procedure SetItem(const AIndex : LongWord;
                      const AValue : Pointer);
  public
    constructor Create;

    destructor Destroy; override;

    property Entries[const AIndex : LongWord] : Pointer read GetEntry;
    property Items[const AIndex : LongWord]   : Pointer read GetItem  write SetItem;

    function Add(const AValue : Pointer) : LongWord;
    function Clear : Boolean;
    function Delete(const AIndex : LongWord) : Boolean;
    function DeleteFirst : Boolean;
    function DeleteLast : Boolean;
    function Insert(const AValue : Pointer;
                    const AIndex : LongWord) : Boolean;
    function InsertAsFirst(const AValue : Pointer) : Boolean;
    function InsertAsLast(const AValue : Pointer) : Boolean;
    function IsFirstAddedEntry(const AIndex : LongWord) : Boolean;
    function IsLastAddedEntry(const AIndex : LongWord) : Boolean;
  published
  end;

  TABCAnsiCharList = class(TABCPointerList)
  private
  protected
    function GetItem(const AIndex : LongWord) : AnsiChar;

    procedure SetItem(const AIndex : LongWord;
                      const AValue : AnsiChar);
  public
    constructor Create;

    destructor Destroy; override;

    property Items[const AIndex : LongWord] : AnsiChar read GetItem write SetItem;

    function Add(const AValue : AnsiChar) : LongWord;
    function Clear : Boolean;
    function Delete(const AIndex : LongWord) : Boolean;
    function DeleteFirst : Boolean;
    function DeleteLast : Boolean;
    function Insert(const AValue : AnsiChar;
                    const AIndex : LongWord) : Boolean;
    function InsertAsFirst(const AValue : AnsiChar) : Boolean;
    function InsertAsLast(const AValue : AnsiChar) : Boolean;
  published
  end;

  TABCAnsiStringList = class(TABCBasicPointerList)
  private
  protected
    function GetItem(const AIndex : LongWord) : AnsiString;
    function GetLinedText : AnsiString;
    function GetText : AnsiString;

    procedure SetItem(const AIndex : LongWord;
                      const AValue : AnsiString);
  public
    constructor Create;

    destructor Destroy; override;

    property Items[const AIndex : LongWord] : AnsiString read GetItem      write SetItem;
    property LinedText                      : AnsiString read GetLinedText;
    property Text                           : AnsiString read GetText;

    function Add(const AValue : AnsiString) : LongWord;
    function Clear : Boolean;
    function Delete(const AIndex : LongWord) : Boolean;
    function DeleteFirst : Boolean;
    function DeleteLast : Boolean;
    function Insert(const AValue : AnsiString;
                    const AIndex : LongWord) : Boolean;
    function InsertAsFirst(const AValue : AnsiString) : Boolean;
    function InsertAsLast(const AValue : AnsiString) : Boolean;
  published
  end;

  TABCCombinationsItem = class(TObject)
  private
  protected
    FCombinationCount   : LongWord;
    FCombinationUse     : TABCAnsiCharList;
    FExCombinationArray : TABCExCombinationArray;
    FHiCombinationArray : TABCHiCombinationArray;
    FLoCombinationArray : TABCLoCombinationArray;

    function GetExCombinationArray(const AIndex : TABCExNumber) : TABCCombinationRecord;
    function GetHiCombinationArray(const AIndex : TABCHiNumber) : TABCCombinationRecord;
    function GetLoCombinationArray(const AIndex : TABCLoNumber) : TABCCombinationRecord;

    procedure SetExCombinationArray(const AIndex : TABCExNumber;
                                    const AValue : TABCCombinationRecord);
    procedure SetHiCombinationArray(const AIndex : TABCHiNumber;
                                    const AValue : TABCCombinationRecord);
    procedure SetLoCombinationArray(const AIndex : TABCLoNumber;
                                    const AValue : TABCCombinationRecord);
  public
    constructor Create;

    destructor Destroy; override;

    property CombinationCount                                : LongWord              read FCombinationCount;
    property ExCombinationArray[const AIndex : TABCExNumber] : TABCCombinationRecord read GetExCombinationArray write SetExCombinationArray;
    property HiCombinationArray[const AIndex : TABCHiNumber] : TABCCombinationRecord read GetHiCombinationArray write SetHiCombinationArray;
    property LoCombinationArray[const AIndex : TABCLoNumber] : TABCCombinationRecord read GetLoCombinationArray write SetLoCombinationArray;

    function AddCombinationUse(const AValue : AnsiChar) : Boolean;
    function CatchCombination(const AValue : AnsiChar) : PABCCombinationRecord;
    function CatchExCombination(const AValue : AnsiChar) : PABCCombinationRecord;
    function CatchHiCombination(const AValue : AnsiChar) : PABCCombinationRecord;
    function CatchLoCombination(const AValue : AnsiChar) : PABCCombinationRecord;
    function ContainsCombinationUse(const AValue : AnsiChar) : Boolean;
    function DeleteCombinationUse(const AValue : AnsiChar) : Boolean;

    procedure Assign(const AValue : TABCCombinationsItem);
    procedure DecCombinationCount;
    procedure IncCombinationCount;
    procedure Initialize;
  published
  end;

  TABCRegistersItem = class(TObject)
  private
  protected
    FBlockRegisterInBlock  : AnsiChar;
    FBlockRegisterResidual : AnsiChar;
    FExRegisterArray       : TABCExRegisterArray;
    FHiRegisterArray       : TABCHiRegisterArray;
    FLoRegisterArray       : TABCLoRegisterArray;
    FOptionBlock           : AnsiString;
    FWriteOptionBlock      : AnsiChar;
  public
    constructor Create;

    destructor Destroy; override;

    property BlockRegisterInBlock  : AnsiChar            read FBlockRegisterInBlock  write FBlockRegisterInBlock;
    property BlockRegisterResidual : AnsiChar            read FBlockRegisterResidual write FBlockRegisterResidual;
    property ExRegisterArray       : TABCExRegisterArray read FExRegisterArray       write FExRegisterArray;
    property HiRegisterArray       : TABCHiRegisterArray read FHiRegisterArray       write FHiRegisterArray;
    property LoRegisterArray       : TABCLoRegisterArray read FLoRegisterArray       write FLoRegisterArray;
    property OptionBlock           : AnsiString          read FOptionBlock;
    property WriteOptionBlock      : AnsiChar            read FWriteOptionBlock      write FWriteOptionBlock;

    function CatchBlockRegister(const AValue : AnsiChar) : PAnsiChar;
    function CatchExRegister(const AValue : AnsiChar) : PAnsiChar;
    function CatchHiRegister(const AValue : AnsiChar) : PAnsiChar;
    function CatchLoRegister(const AValue : AnsiChar) : PAnsiChar;
    function CatchRegister(const AValue : AnsiChar) : PAnsiChar;
    function CatchOptionRegister(const AValue : AnsiChar) : PAnsiChar;
    function GetAndResetOptionBlock : AnsiString;

    procedure Assign(const AValue : TABCRegistersItem);
    procedure Initialize;
    procedure WriteToOptionBlock(const AValue : AnsiChar);
  published
  end;

  TABCInterpreter = class(TObject)
  private
  protected
    FAllInMainCombination         : Boolean;
    FAnalysedSource               : AnsiString;
    FBlockCount                   : LongInt;
    FBreakInterpretation          : Boolean;
    FChangeOption                 : TABCChangeOptionMethod;
    FCombinations                 : TABCCombinationsItem;
    FGlobalRegisters              : TABCRegistersItem;
    FHasStackOverflow             : Boolean;
    FInterpretAnalysedOptionBlock : Boolean;
    FIsInMainCombination          : Boolean;
    FLineOrientedMode             : Boolean;
    FLocalRegisters               : TABCBasicPointerList;
    FMemory                       : TABCAnsiCharList;
    FMessages                     : TABCAnsiStringList;
    FNextChar                     : AnsiChar;
    FNextExecuteOperation         : Boolean;
    FNextOperator                 : AnsiChar;
    FNextParameters               : TABCBasicPointerList;
    FNextRegister                 : AnsiChar;
    FNextTypeRegister             : AnsiChar;
    FNextTypeValue                : AnsiChar;
    FNextValue                    : AnsiChar;
    FOptionArray                  : TABCOptionArray;
    FOwnParameters                : TABCBasicPointerList;
    FReadFileValue                : TABCReadValueMethod;
    FReadScreenValue              : TABCReadValueMethod;
    FShowErrors                   : Boolean;
    FShowInformation              : Boolean;
    FSource                       : TABCAnsiStringList;
    FStackBegin                   : LongWord;
    FStackProtection              : Boolean;
    FWasInMainCombination         : Boolean;
    FWriteFileValue               : TABCWriteValueMethod;
    FWriteScreenValue             : TABCWriteValueMethod;

    function ExtractCombination(const ASourceText : AnsiString;
                                var AIndex : LongWord;
                                var ASuccess : Boolean) : AnsiString;
    function ExtractCompare(const ASourceText : AnsiString;
                            var AIndex : LongWord;
                            var ASuccess : Boolean) : AnsiString;
    function GetAndResetOptionBlock(const ATypeRegister : AnsiChar;
                                    var ASuccess : Boolean) : AnsiString;
    function GetNextAnalyseUnIgnored(const ASourceText : AnsiString;
                                     var AInputIndex : LongWord;
                                     var ADestinationText : AnsiString;
                                     var AOutputIndex : LongWord) : AnsiChar;
    function GetNextUnIgnored(const ASourceText : AnsiString;
                              var AIndex : LongWord) : AnsiChar;
    function GetOperatorChar(const AOperator : AnsiChar) : AnsiString;
    function GetRandom(var ASuccess : Boolean) : AnsiChar;
    function GetRegister(const ARegister : AnsiChar;
                         const ATypeRegister : AnsiChar;
                         var ASuccess : Boolean) : PAnsiChar;
    function GetRegisterChar(const ARegister : AnsiChar) : AnsiString;
    function GetValueChar(const AValue : AnsiChar) : AnsiString;
    function GetSourceLine(const AIndex : LongWord) : LongWord;
    function GetTypeChar(const AType : AnsiChar) : AnsiString;
    function GetValue(const AValue : AnsiChar;
                      const AType : AnsiChar;
                      var ASuccess : Boolean) : AnsiChar;
    function RegistersToAnsiChar(const AType : AnsiChar;
                                 var ASuccess : Boolean) : AnsiChar;
    function SetOption(const AOptionName : AnsiString;
                       const AOptionValue : AnsiString) : Boolean;
    function VariablesEmpty(var ARegister : AnsiChar;
                            var AOperator : AnsiChar;
                            var AValue : AnsiChar;
                            var ATypeRegister : AnsiChar;
                            var ATypeValue : AnsiChar;
                            var AExecuteOperation : Boolean) : Boolean;

    procedure AnsiCharToRegisters(const AValue : AnsiChar;
                                  const AType : AnsiChar;
                                  var ASuccess : Boolean);
    procedure AssignAnd(const ARegister : AnsiChar;
                        const AValue : AnsiChar;
                        const ATypeRegister : AnsiChar;
                        const ATypeValue : AnsiChar;
                        var ASuccess : Boolean);
    procedure AssignBecomes(const ARegister : AnsiChar;
                            const AValue : AnsiChar;
                            const ATypeRegister : AnsiChar;
                            const ATypeValue : AnsiChar;
                            var ASuccess : Boolean);
    procedure AssignBecomesNot(const ARegister : AnsiChar;
                               const AValue : AnsiChar;
                               const ATypeRegister : AnsiChar;
                               const ATypeValue : AnsiChar;
                               var ASuccess : Boolean);
    procedure AssignCheckMemEmpty(const ARegister : AnsiChar;
                                  const AValue : AnsiChar;
                                  const ATypeRegister : AnsiChar;
                                  const ATypeValue : AnsiChar;
                                  var ASuccess : Boolean);
    procedure AssignCheckMemEntry(const ARegister : AnsiChar;
                                  const AValue : AnsiChar;
                                  const ATypeRegister : AnsiChar;
                                  const ATypeValue : AnsiChar;
                                  var ASuccess : Boolean);
    procedure AssignOr(const ARegister : AnsiChar;
                       const AValue : AnsiChar;
                       const ATypeRegister : AnsiChar;
                       const ATypeValue : AnsiChar;
                       var ASuccess : Boolean);
    procedure AssignReadMem(const ARegister : AnsiChar;
                            const AValue : AnsiChar;
                            const ATypeRegister : AnsiChar;
                            const ATypeValue : AnsiChar;
                            var ASuccess : Boolean);
    procedure AssignSymbol(const ASymbol : AnsiChar;
                           var ARegister : AnsiChar;
                           var AOperator : AnsiChar;
                           var AValue : AnsiChar;
                           var ATypeRegister : AnsiChar;
                           var ATypeValue : AnsiChar;
                           var AExecute : Boolean;
                           var ASuccess : Boolean);
    procedure AssignTouchMemFirst(const ARegister : AnsiChar;
                                  const AValue : AnsiChar;
                                  const ATypeRegister : AnsiChar;
                                  const ATypeValue : AnsiChar;
                                  var ASuccess : Boolean);
    procedure AssignTouchMemLast(const ARegister : AnsiChar;
                                 const AValue : AnsiChar;
                                 const ATypeRegister : AnsiChar;
                                 const ATypeValue : AnsiChar;
                                 var ASuccess : Boolean);
    procedure AssignWriteMem(const ARegister : AnsiChar;
                             const AValue : AnsiChar;
                             const ATypeRegister : AnsiChar;
                             const ATypeValue : AnsiChar;
                             var ASuccess : Boolean);
    procedure AssignXor(const ARegister : AnsiChar;
                        const AValue : AnsiChar;
                        const ATypeRegister : AnsiChar;
                        const ATypeValue : AnsiChar;
                        var ASuccess : Boolean);
    procedure BlockBegin(var ASuccess : Boolean);
    procedure BlockEnd(var ASuccess : Boolean);
    procedure CheckCommunication(const ARegister : AnsiChar;
                                 const ATypeRegister : AnsiChar;
                                 var ASuccess : Boolean);
    procedure CheckLength(var ASourceText : AnsiString;
                          const ALength : LongWord;
                          const AForceLength : Boolean);
    procedure CheckStack(var ASuccess : Boolean);
    procedure ClearAnalysedSource;
    procedure ClearLocalRegisters;
    procedure ClearNextParameters;
    procedure ClearOwnParameters;
    procedure ClearMessages;
    procedure ClearVariables(var ARegister : AnsiChar;
                             var AOperator : AnsiChar;
                             var AValue : AnsiChar;
                             var ATypeRegister : AnsiChar;
                             var ATypeValue : AnsiChar;
                             var AExecuteOperation : Boolean);
    procedure CombinationBegin(const ARegister : AnsiChar;
                               const ASourceText : AnsiString;
                               var AIndex : LongWord;
                               var ASuccess : Boolean);
    procedure CombinationEnd(var ASuccess : Boolean);
    procedure CombinationUse(const ARegister : AnsiChar;
                             var ASuccess : Boolean);
    procedure CompareIf(const ARegister : AnsiChar;
                        const AOperator : AnsiChar;
                        const AValue : AnsiChar;
                        const ATypeRegister : AnsiChar;
                        const ATypeValue : AnsiChar;
                        const ASourceText : AnsiString;
                        var AIndex : LongWord;
                        var ASuccess : Boolean);
    procedure CompareIfNot(const ARegister : AnsiChar;
                           const AOperator : AnsiChar;
                           const AValue : AnsiChar;
                           const ATypeRegister : AnsiChar;
                           const ATypeValue : AnsiChar;
                           const ASourceText : AnsiString;
                           var AIndex : LongWord;
                           var ASuccess : Boolean);
    procedure CompareWhile(const ARegister : AnsiChar;
                           const AOperator : AnsiChar;
                           const AValue : AnsiChar;
                           const ATypeRegister : AnsiChar;
                           const ATypeValue : AnsiChar;
                           const ASourceText : AnsiString;
                           var AIndex : LongWord;
                           var ASuccess : Boolean);
    procedure CompareWhileNot(const ARegister : AnsiChar;
                              const AOperator : AnsiChar;
                              const AValue : AnsiChar;
                              const ATypeRegister : AnsiChar;
                              const ATypeValue : AnsiChar;
                              const ASourceText : AnsiString;
                              var AIndex : LongWord;
                              var ASuccess : Boolean);
    procedure DoError(const ALineNumber : LongInt;
                      const AErrorCode : LongWord);
    procedure ExecuteAssign(const ARegister : AnsiChar;
                            const AOperator : AnsiChar;
                            const AValue : AnsiChar;
                            const ATypeRegister : AnsiChar;
                            const ATypeValue : AnsiChar;
                            var ASuccess : Boolean);
    procedure ExecuteBlock(const AOperator : AnsiChar;
                           var ASuccess : Boolean);
    procedure ExecuteCombination(const ARegister : AnsiChar;
                                 const AOperator : AnsiChar;
                                 const ASourceText : AnsiString;
                                 var AIndex : LongWord;
                                 var ASuccess : Boolean);
    procedure ExecuteCompare(const ARegister : AnsiChar;
                             const AOperator : AnsiChar;
                             const AValue : AnsiChar;
                             const ATypeRegister : AnsiChar;
                             const ATypeValue : AnsiChar;
                             const ASourceText : AnsiString;
                             var AIndex : LongWord;
                             var ASuccess : Boolean);
    procedure Interpret(const ASourceText : AnsiString;
                        var ASuccess : Boolean);
    procedure InterpretOptionBlock(const AOptionBlock : AnsiString);
    procedure NilProperties;
    procedure ResetData;
    procedure SetBlockRegisters(var ASuccess : Boolean);
    procedure SetFlagRegister(const AAccessDone : Boolean;
                              const AType : AnsiChar;
                              var ASuccess : Boolean);
    procedure WriteMessage(const ALineNumber : LongWord;
                           const AIsError : Boolean;
                           const AErrorCode : LongWord;
                           const AParameter : AnsiString);
    procedure WriteOperation(var ADestinationText : AnsiString;
                             var AIndex : LongWord;
                             var ARegister : AnsiChar;
                             var AOperator : AnsiChar;
                             var AValue : AnsiChar;
                             var ATypeRegister : AnsiChar;
                             var ATypeValue : AnsiChar);
    procedure WriteOption(var ADestinationText : AnsiString;
                          var AIndex : LongWord;
                          const AOptionBlock : String);
    procedure WriteToOptionBlock(const ATypeRegister : AnsiChar;
                                 const AValue : AnsiChar;
                                 var ASuccess : Boolean);

    function GetOptionCount : LongInt;
    function GetOptionNameByIndex(const AIndex : LongInt) : AnsiString;
    function GetOptionValueByIndex(const AIndex : LongInt) : AnsiString;
    function GetOptionValueByName(const AName : AnsiString) : AnsiString;
  public
    constructor Create;

    destructor Destroy; override;

    property AllInMainCombination                    : Boolean                read FAllInMainCombination         write FAllInMainCombination;
    property AnalysedSource                          : AnsiString             read FAnalysedSource;
    property ChangeOption                            : TABCChangeOptionMethod read FChangeOption                 write FChangeOption;
    property InterpretAnalysedOptionBlock            : Boolean                read FInterpretAnalysedOptionBlock write FInterpretAnalysedOptionBlock;
    property LineOrientedMode                        : Boolean                read FLineOrientedMode             write FLineOrientedMode;
    property Messages                                : TABCAnsiStringList     read FMessages                     write FMessages;
    property OptionCount                             : LongInt                read GetOptionCount;
    property OptionName  [const AIndex : LongInt]    : AnsiString             read GetOptionNameByIndex;
    property OptionValueI[const AIndex : LongInt]    : AnsiString             read GetOptionValueByIndex;
    property OptionValueN[const AName  : AnsiString] : AnsiString             read GetOptionValueByName;
    property ReadFileValue                           : TABCReadValueMethod    read FReadFileValue                write FReadFileValue;
    property ReadScreenValue                         : TABCReadValueMethod    read FReadScreenValue              write FReadScreenValue;
    property ShowErrors                              : Boolean                read FShowErrors                   write FShowErrors;
    property ShowInformation                         : Boolean                read FShowInformation              write FShowInformation;
    property Source                                  : TABCAnsiStringList     read FSource                       write FSource;
    property StackProtection                         : Boolean                read FStackProtection              write FStackProtection;
    property WriteFileValue                          : TABCWriteValueMethod   read FWriteFileValue               write FWriteFileValue;
    property WriteScreenValue                        : TABCWriteValueMethod   read FWriteScreenValue             write FWriteScreenValue;

    function AnalyseSource : Boolean;
    function InterpretSource : Boolean;

    procedure DeInitialize;
    procedure Initialize;
  end;

implementation

{ TABCBasicPointerList }

function TABCBasicPointerList.AdjustSize : Boolean;
begin
  Result := AdjustSize(FDeltaSize);
end;

function TABCBasicPointerList.AdjustSize(const ADeltaSize : LongWord) : Boolean;
begin
  Result := true;

  if (ADeltaSize > 000) then
  begin
    if (((Succ(FCount div ADeltaSize) * ADeltaSize) < High(LongWord)) and (((FCount div ADeltaSize) * ADeltaSize) < (Succ(FCount div ADeltaSize) * ADeltaSize))) then
    begin
      SetLength(FArray, (Succ(FCount div ADeltaSize) * ADeltaSize));
    end;

    Result := (Length(FArray) = (Succ(FCount div ADeltaSize) * ADeltaSize));
  end;
end;

function TABCBasicPointerList.DecreaseSize : Boolean;
begin
  Result := DecreaseSize(FDeltaSize);
end;

function TABCBasicPointerList.DecreaseSize(const ADeltaSize : LongWord) : Boolean;
var
  OldSize : LongWord;
begin
  OldSize := Length(FArray);

  if (OldSize >= ADeltaSize) then
  begin
    SetLength(FArray, (OldSize - ADeltaSize));
  end;

  Result := (Length(FArray) = (OldSize - ADeltaSize));
end;

function TABCBasicPointerList.GetItem(const AIndex : LongWord) : Pointer;
begin
  Result := nil;

  if (IsInRange(AIndex)) then
  begin
    Result := FArray[AIndex];
  end;
end;

function TABCBasicPointerList.IncreaseSize : Boolean;
begin
  Result := IncreaseSize(FDeltaSize);
end;

function TABCBasicPointerList.IncreaseSize(const ADeltaSize : LongWord) : Boolean;
var
  OldSize : LongWord;
begin
  OldSize := Length(FArray);

  if (OldSize < (High(LongWord) - ADeltaSize)) then
  begin
    SetLength(FArray, (OldSize + ADeltaSize));
  end;

  Result := (Length(FArray) = (OldSize + ADeltaSize));
end;

procedure TABCBasicPointerList.SetDeltaSize(const AValue : LongWord);
begin
  if ((AValue <> FDeltaSize) and (AValue > 000) and (AValue < High(LongWord))) then
  begin
    FDeltaSize := AValue;
  end;
end;

procedure TABCBasicPointerList.SetItem(const AIndex : LongWord;
                                       const AValue : Pointer);
begin
  if (IsInRange(AIndex)) then
  begin
    FArray[AIndex] := AValue;
  end;
end;

constructor TABCBasicPointerList.Create;
begin
  inherited Create;

  FCount     := 000;
  FDeltaSize := CDeltaSize;

  Clear;
end;

destructor TABCBasicPointerList.Destroy;
begin
  Clear;

  inherited Destroy;
end;

function TABCBasicPointerList.Add(const AValue : Pointer) : LongWord;
begin
  Result := High(LongWord);

  if (FCount < Pred(High(LongWord))) then
  begin
    if (AdjustSize) then
    begin
      Inc(FCount);
      Items[Pred(FCount)] := AValue;
      Result := Pred(FCount);
    end;
  end;
end;

function TABCBasicPointerList.Clear : Boolean;
begin
  FCount := 000;
  Result := AdjustSize;
end;

function TABCBasicPointerList.Delete(const AIndex : LongWord) : Boolean;
var
  Index : LongWord;
begin
  Result := false;

  if (AIndex < High(LongWord)) then
  begin
    if (FCount > 000) then
    begin
      if (IsInLowerRange(AIndex)) then
      begin
        if (AIndex = Pred(FCount)) then
        begin
          Dec(FCount);
          Result := AdjustSize;
        end
        else
        begin
          if (IsInUpperRange(AIndex)) then
          begin
            for Index := AIndex to Pred(Pred(FCount)) do
            begin
              FArray[Index] := FArray[Succ(Index)];
            end;

            Dec(FCount);
            Result := AdjustSize;
          end;
        end;
      end;
    end;
  end;
end;

function TABCBasicPointerList.DeleteFirst : Boolean;
begin
  Result := Delete(000);
end;

function TABCBasicPointerList.DeleteLast : Boolean;
begin
  Result := Delete(Pred(FCount));
end;

function TABCBasicPointerList.Insert(const AValue : Pointer;
                                     const AIndex : LongWord) : Boolean;
var
  Index : LongWord;
begin
  Result := false;

  if (FCount < Pred(High(LongWord))) then
  begin
    if (AIndex >= FCount) then
    begin
      Result := (Items[Add(AValue)] = AValue);
    end
    else
    begin
      if (IsInUpperRange(AIndex)) then
      begin
        if (Add(nil) <> High(LongWord)) then
        begin
          for Index := Pred(FCount) downto Succ(AIndex) do
          begin
            Items[Index] := Items[Pred(Index)];
          end;
          Items[AIndex] := AValue;

          Result := (Items[AIndex] = AValue);
        end;
      end;
    end;
  end;
end;

function TABCBasicPointerList.InsertAsFirst(const AValue : Pointer) : Boolean;
begin
  Result := Insert(AValue, 000);
end;

function TABCBasicPointerList.InsertAsLast(const AValue : Pointer) : Boolean;
begin
  Result := Insert(AValue, FCount);
end;

function TABCBasicPointerList.IsInLowerRange(const AIndex : LongWord) : Boolean;
begin
  Result := (AIndex >= 000);
end;

function TABCBasicPointerList.IsInRange(const AIndex : LongWord) : Boolean;
begin
  Result := (IsInLowerRange(AIndex) and IsInUpperRange(AIndex));
end;

function TABCBasicPointerList.IsInUpperRange(const AIndex : LongWord) : Boolean;
begin
  Result := (AIndex < FCount);
end;

function TABCBasicPointerList.PutFirstToLast : Boolean;
begin
  Result := true;

  if (FCount > 001) then
  begin
    Result := (InsertAsLast(Items[000]) and DeleteFirst);
  end;
end;

function TABCBasicPointerList.PutLastToFirst : Boolean;
begin
  Result := true;

  if (FCount > 001) then
  begin
    Result := (InsertAsFirst(Items[Pred(Count)]) and DeleteLast);
  end;
end;

{ TABCPointerList }

function TABCPointerList.GetEntry(const AIndex : LongWord) : Pointer;
begin
  Result := PPointer(FEntriesOrder.Items[AIndex])^;
end;

function TABCPointerList.GetItem(const AIndex : LongWord) : Pointer;
begin
  Result := PPointer(inherited Items[AIndex])^;
end;

procedure TABCPointerList.SetItem(const AIndex : LongWord;
                                  const AValue : Pointer);
begin
  PPointer(inherited Items[AIndex])^ := AValue;
end;

constructor TABCPointerList.Create;
begin
  inherited Create;

  FEntriesOrder := TABCBasicPointerList.Create;

  Clear;
end;

destructor TABCPointerList.Destroy;
begin
  Clear;

  FEntriesOrder.Free;
  FEntriesOrder := nil;

  inherited Destroy;
end;

function TABCPointerList.Add(const AValue : Pointer) : LongWord;
var
  TempPointer : PPointer;
begin
  Result := High(LongWord);

  New(TempPointer);
  try
    TempPointer^ := AValue;

    if (FEntriesOrder.Add(TempPointer) <> High(LongWord)) then
    begin
      Result := inherited Add(TempPointer);
    end;

    if (Result = High(LongWord)) then
    begin
      Dispose(TempPointer);
      TempPointer := nil;
    end;
  except
    Dispose(TempPointer);
    TempPointer := nil;
  end;
end;

function TABCPointerList.Clear : Boolean;
var
  Index : LongWord;
begin
  Result := false;

  if (Count > 000) then
  begin
    for Index := 000 to Pred(Count) do
    begin
      if (inherited Items[Index] <> nil) then
      begin
        Dispose(PPointer(inherited Items[Index]));
        inherited Items[Index] := nil;
      end;
    end;
  end;

  if (FEntriesOrder.Clear) then
  begin
    Result := inherited Clear;
  end;
end;

function TABCPointerList.Delete(const AIndex : LongWord) : Boolean;
var
  Index : LongWord;
begin
  Result := false;

  if (IsInRange(AIndex)) then
  begin
    if (FEntriesOrder.Count > 000) then
    begin
      for Index := 000 to Pred(FEntriesOrder.Count) do
      begin
        if (inherited Items[AIndex] = FEntriesOrder.Items[Index]) then
        begin
          Result := FEntriesOrder.Delete(Index);

          Break;
        end;
      end;
    end;

    if (inherited Items[AIndex] <> nil) then
    begin
      Dispose(PPointer(inherited Items[AIndex]));
      inherited Items[AIndex] := nil;
    end;

    Result := (Result and inherited Delete(AIndex));
  end;
end;

function TABCPointerList.DeleteFirst : Boolean;
begin
  Result := Delete(000);
end;

function TABCPointerList.DeleteLast : Boolean;
begin
  Result := Delete(Pred(Count));
end;

function TABCPointerList.Insert(const AValue : Pointer;
                                const AIndex : LongWord) : Boolean;
var
  TempPointer : PPointer;
begin
  Result := false;

  New(TempPointer);
  try
    TempPointer^ := AValue;

    if (FEntriesOrder.Add(TempPointer) <> High(LongWord)) then
    begin
      Result := inherited Insert(TempPointer, AIndex);
    end;

    if (not(Result)) then
    begin
      Dispose(TempPointer);
      TempPointer := nil;
    end;
  except
    Dispose(TempPointer);
    TempPointer := nil;
  end;
end;

function TABCPointerList.InsertAsFirst(const AValue : Pointer) : Boolean;
begin
  Result := Insert(AValue, 000);
end;

function TABCPointerList.InsertAsLast(const AValue : Pointer) : Boolean;
begin
  Result := Insert(AValue, Count);
end;

function TABCPointerList.IsFirstAddedEntry(const AIndex : LongWord) : Boolean;
begin
  Result := false;

  if (IsInRange(AIndex)) then
  begin
    Result := (inherited Items[AIndex] = FEntriesOrder.Items[000]);
  end;
end;

function TABCPointerList.IsLastAddedEntry(const AIndex : LongWord) : Boolean;
begin
  Result := false;

  if (IsInRange(AIndex)) then
  begin
    Result := (inherited Items[AIndex] = FEntriesOrder.Items[Pred(FEntriesOrder.Count)]);
  end;
end;

{ TABCAnsiCharList }

function TABCAnsiCharList.GetItem(const AIndex : LongWord) : AnsiChar;
begin
  Result := PAnsiChar(inherited Items[AIndex])^;
end;

procedure TABCAnsiCharList.SetItem(const AIndex : LongWord;
                                   const AValue : AnsiChar);
begin
  PAnsiChar(inherited Items[AIndex])^ := AValue;
end;

constructor TABCAnsiCharList.Create;
begin
  inherited Create;

  Clear;
end;

destructor TABCAnsiCharList.Destroy;
begin
  Clear;

  inherited Destroy;
end;

function TABCAnsiCharList.Add(const AValue : AnsiChar) : LongWord;
var
  TempChar : PAnsiChar;
begin
  Result := High(LongWord);

  New(TempChar);
  try
    TempChar^ := AValue;

    Result := inherited Add(TempChar);

    if (Result = High(LongWord)) then
    begin
      Dispose(TempChar);
      TempChar := nil;
    end;
  except
    Dispose(TempChar);
    TempChar := nil;
  end;
end;

function TABCAnsiCharList.Clear : Boolean;
var
  Index : LongWord;
begin
  if (FCount > 000) then
  begin
    for Index := 000 to Pred(FCount) do
    begin
      if (inherited Items[Index] <> nil) then
      begin
        Dispose(PAnsiChar(inherited Items[Index]));
        inherited Items[Index] := nil;
      end;
    end;
  end;

  Result := inherited Clear;
end;

function TABCAnsiCharList.Delete(const AIndex : LongWord) : Boolean;
begin
  Result := false;

  if (IsInRange(AIndex)) then
  begin
    if (inherited Items[AIndex] <> nil) then
    begin
      Dispose(PAnsiChar(inherited Items[AIndex]));
      inherited Items[AIndex] := nil;
    end;

    Result := inherited Delete(AIndex);
  end;
end;

function TABCAnsiCharList.DeleteFirst : Boolean;
begin
  Result := Delete(000);
end;

function TABCAnsiCharList.DeleteLast : Boolean;
begin
  Result := Delete(Pred(Count));
end;

function TABCAnsiCharList.Insert(const AValue : AnsiChar;
                                 const AIndex : LongWord) : Boolean;
var
  TempChar : PAnsiChar;
begin
  Result := false;

  New(TempChar);
  try
    TempChar^ := AValue;

    Result := inherited Insert(TempChar, AIndex);

    if (not(Result)) then
    begin
      Dispose(TempChar);
      TempChar := nil;
    end;
  except
    Dispose(TempChar);
    TempChar := nil;
  end;
end;

function TABCAnsiCharList.InsertAsFirst(const AValue : AnsiChar) : Boolean;
begin
  Result := Insert(AValue, 000);
end;

function TABCAnsiCharList.InsertAsLast(const AValue : AnsiChar) : Boolean;
begin
  Result := Insert(AValue, FCount);
end;

{ TABCAnsiStringList }

function TABCAnsiStringList.GetItem(const AIndex : LongWord) : AnsiString;
begin
  Result := PAnsiString(inherited Items[AIndex])^;
end;

function TABCAnsiStringList.GetLinedText : AnsiString;
var
  Index : LongWord;
begin
  Result := '';

  if (FCount > 000) then
  begin
    for Index := 000 to Pred(FCount) do
    begin
      Result := (Result + Items[Index]);

      if (Index < Pred(FCount)) then
      begin
        Result := (Result + CNewLine);
      end;
    end;
  end;
end;

function TABCAnsiStringList.GetText : AnsiString;
var
  Index : LongWord;
begin
  Result := '';

  if (FCount > 000) then
  begin
    for Index := 000 to Pred(FCount) do
    begin
      Result := (Result + Items[Index]);
    end;
  end;
end;

procedure TABCAnsiStringList.SetItem(const AIndex : LongWord;
                                     const AValue : AnsiString);
begin
  PAnsiString(inherited Items[AIndex])^ := AValue;
end;

constructor TABCAnsiStringList.Create;
begin
  inherited Create;

  Clear;
end;

destructor TABCAnsiStringList.Destroy;
begin
  Clear;

  inherited Destroy;
end;

function TABCAnsiStringList.Add(const AValue : AnsiString) : LongWord;
var
  TempString : PAnsiString;
begin
  Result := High(LongWord);

  New(TempString);
  try
    TempString^ := AValue;

    Result := inherited Add(TempString);

    if (Result = High(LongWord)) then
    begin
      Dispose(TempString);
      TempString := nil;
    end;
  except
    Dispose(TempString);
    TempString := nil;
  end;
end;

function TABCAnsiStringList.Clear : Boolean;
var
  Index : LongWord;
begin
  if (FCount > 000) then
  begin
    for Index := 000 to Pred(FCount) do
    begin
      if (inherited Items[Index] <> nil) then
      begin
        Dispose(PAnsiString(inherited Items[Index]));
        inherited Items[Index] := nil;
      end;
    end;
  end;

  Result := inherited Clear;
end;

function TABCAnsiStringList.Delete(const AIndex : LongWord) : Boolean;
begin
  Result := false;

  if (IsInRange(AIndex)) then
  begin
    if (inherited Items[AIndex] <> nil) then
    begin
      Dispose(PAnsiString(inherited Items[AIndex]));
      inherited Items[AIndex] := nil;
    end;

    Result := inherited Delete(AIndex);
  end;
end;

function TABCAnsiStringList.DeleteFirst : Boolean;
begin
  Result := Delete(000);
end;

function TABCAnsiStringList.DeleteLast : Boolean;
begin
  Result := Delete(Pred(Count));
end;

function TABCAnsiStringList.Insert(const AValue : AnsiString;
                                   const AIndex : LongWord) : Boolean;
var
  TempString : PAnsiString;
begin
  Result := false;

  New(TempString);
  try
    TempString^ := AValue;

    Result := inherited Insert(TempString, AIndex);

    if (not(Result)) then
    begin
      Dispose(TempString);
      TempString := nil;
    end;
  except
    Dispose(TempString);
    TempString := nil;
  end;
end;

function TABCAnsiStringList.InsertAsFirst(const AValue : AnsiString) : Boolean;
begin
  Result := Insert(AValue, 000);
end;

function TABCAnsiStringList.InsertAsLast(const AValue : AnsiString) : Boolean;
begin
  Result := Insert(AValue, FCount);
end;

{ TABCCombinationsItem }

function TABCCombinationsItem.GetExCombinationArray(const AIndex : TABCExNumber) : TABCCombinationRecord;
begin
  Result := FExCombinationArray[AIndex];
end;

function TABCCombinationsItem.GetHiCombinationArray(const AIndex : TABCHiNumber) : TABCCombinationRecord;
begin
  Result := FHiCombinationArray[AIndex];
end;

function TABCCombinationsItem.GetLoCombinationArray(const AIndex : TABCLoNumber) : TABCCombinationRecord;
begin
  Result := FLoCombinationArray[AIndex];
end;

procedure TABCCombinationsItem.SetExCombinationArray(const AIndex : TABCExNumber;
                                                     const AValue : TABCCombinationRecord);
begin
  FExCombinationArray[AIndex] := AValue;
end;

procedure TABCCombinationsItem.SetHiCombinationArray(const AIndex : TABCHiNumber;
                                                     const AValue : TABCCombinationRecord);
begin
  FHiCombinationArray[AIndex] := AValue;
end;

procedure TABCCombinationsItem.SetLoCombinationArray(const AIndex : TABCLoNumber;
                                                     const AValue : TABCCombinationRecord);
begin
  FLoCombinationArray[AIndex] := AValue;
end;

constructor TABCCombinationsItem.Create;
begin
  inherited Create;

  FCombinationUse := TABCAnsiCharList.Create;

  Initialize;
end;

destructor TABCCombinationsItem.Destroy;
begin
  Initialize;

  FCombinationUse.Free;
  FCombinationUse := nil;

  inherited Destroy;
end;

function TABCCombinationsItem.AddCombinationUse(const AValue : AnsiChar) : Boolean;
begin
  Result := (FCombinationUse.Add(AValue) <> High(LongWord));
end;

function TABCCombinationsItem.CatchCombination(const AValue : AnsiChar) : PABCCombinationRecord;
begin
  if (IsExRegister(AValue)) then
  begin
    Result := CatchExCombination(AValue);
  end
  else
  begin
    if (IsHiRegister(AValue)) then
    begin
      Result := CatchHiCombination(AValue);
    end
    else
    begin
      if (IsLoRegister(AValue)) then
      begin
        Result := CatchLoCombination(AValue);
      end
      else
      begin
        Result := nil;
      end;
    end;
  end;
end;

function TABCCombinationsItem.CatchExCombination(const AValue : AnsiChar) : PABCCombinationRecord;
begin
  case (AValue) of
    (CExRegister0) :
    begin
      Result := @FExCombinationArray[001];
    end;

    (CExRegister1) :
    begin
      Result := @FExCombinationArray[002];
    end;

    (CExRegister2) :
    begin
      Result := @FExCombinationArray[003];
    end;

    (CExRegister3) :
    begin
      Result := @FExCombinationArray[004];
    end;

    (CExRegister4) :
    begin
      Result := @FExCombinationArray[005];
    end;

    (CExRegister5) :
    begin
      Result := @FExCombinationArray[006];
    end;

    (CExRegister6) :
    begin
      Result := @FExCombinationArray[007];
    end;

    (CExRegister7) :
    begin
      Result := @FExCombinationArray[008];
    end;

    (CExRegister8) :
    begin
      Result := @FExCombinationArray[009];
    end;

    (CExRegister9) :
    begin
      Result := @FExCombinationArray[010];
    end;

    (CExRegisterFlag) :
    begin
      Result := @FExCombinationArray[011];
    end;
  else
    Result := nil;
  end;
end;

function TABCCombinationsItem.CatchHiCombination(const AValue : AnsiChar) : PABCCombinationRecord;
begin
  case (AValue) of
    (CHiRegisterA) :
    begin
      Result := @FHiCombinationArray[001];
    end;

    (CHiRegisterB) :
    begin
      Result := @FHiCombinationArray[002];
    end;

    (CHiRegisterC) :
    begin
      Result := @FHiCombinationArray[003];
    end;

    (CHiRegisterD) :
    begin
      Result := @FHiCombinationArray[004];
    end;

    (CHiRegisterE) :
    begin
      Result := @FHiCombinationArray[005];
    end;

    (CHiRegisterF) :
    begin
      Result := @FHiCombinationArray[006];
    end;

    (CHiRegisterG) :
    begin
      Result := @FHiCombinationArray[007];
    end;

    (CHiRegisterH) :
    begin
      Result := @FHiCombinationArray[008];
    end;

    (CHiRegisterI) :
    begin
      Result := @FHiCombinationArray[009];
    end;

    (CHiRegisterJ) :
    begin
      Result := @FHiCombinationArray[010];
    end;

    (CHiRegisterK) :
    begin
      Result := @FHiCombinationArray[011];
    end;

    (CHiRegisterL) :
    begin
      Result := @FHiCombinationArray[012];
    end;

    (CHiRegisterM) :
    begin
      Result := @FHiCombinationArray[013];
    end;

    (CHiRegisterN) :
    begin
      Result := @FHiCombinationArray[014];
    end;

    (CHiRegisterO) :
    begin
      Result := @FHiCombinationArray[015];
    end;

    (CHiRegisterP) :
    begin
      Result := @FHiCombinationArray[016];
    end;

    (CHiRegisterQ) :
    begin
      Result := @FHiCombinationArray[017];
    end;

    (CHiRegisterR) :
    begin
      Result := @FHiCombinationArray[018];
    end;

    (CHiRegisterS) :
    begin
      Result := @FHiCombinationArray[019];
    end;

    (CHiRegisterT) :
    begin
      Result := @FHiCombinationArray[020];
    end;

    (CHiRegisterU) :
    begin
      Result := @FHiCombinationArray[021];
    end;

    (CHiRegisterV) :
    begin
      Result := @FHiCombinationArray[022];
    end;

    (CHiRegisterW) :
    begin
      Result := @FHiCombinationArray[023];
    end;

    (CHiRegisterX) :
    begin
      Result := @FHiCombinationArray[024];
    end;

    (CHiRegisterY) :
    begin
      Result := @FHiCombinationArray[025];
    end;

    (CHiRegisterZ) :
    begin
      Result := @FHiCombinationArray[026];
    end;
  else
    Result := nil;
  end;
end;

function TABCCombinationsItem.CatchLoCombination(const AValue : AnsiChar) : PABCCombinationRecord;
begin
  case (AValue) of
    (CLoRegisterA) :
    begin
      Result := @FLoCombinationArray[001];
    end;

    (CLoRegisterB) :
    begin
      Result := @FLoCombinationArray[002];
    end;

    (CLoRegisterC) :
    begin
      Result := @FLoCombinationArray[003];
    end;

    (CLoRegisterD) :
    begin
      Result := @FLoCombinationArray[004];
    end;

    (CLoRegisterE) :
    begin
      Result := @FLoCombinationArray[005];
    end;

    (CLoRegisterF) :
    begin
      Result := @FLoCombinationArray[006];
    end;

    (CLoRegisterG) :
    begin
      Result := @FLoCombinationArray[007];
    end;

    (CLoRegisterH) :
    begin
      Result := @FLoCombinationArray[008];
    end;

    (CLoRegisterI) :
    begin
      Result := @FLoCombinationArray[009];
    end;

    (CLoRegisterJ) :
    begin
      Result := @FLoCombinationArray[010];
    end;

    (CLoRegisterK) :
    begin
      Result := @FLoCombinationArray[011];
    end;

    (CLoRegisterL) :
    begin
      Result := @FLoCombinationArray[012];
    end;

    (CLoRegisterM) :
    begin
      Result := @FLoCombinationArray[013];
    end;

    (CLoRegisterN) :
    begin
      Result := @FLoCombinationArray[014];
    end;

    (CLoRegisterO) :
    begin
      Result := @FLoCombinationArray[015];
    end;

    (CLoRegisterP) :
    begin
      Result := @FLoCombinationArray[016];
    end;

    (CLoRegisterQ) :
    begin
      Result := @FLoCombinationArray[017];
    end;

    (CLoRegisterR) :
    begin
      Result := @FLoCombinationArray[018];
    end;

    (CLoRegisterS) :
    begin
      Result := @FLoCombinationArray[019];
    end;

    (CLoRegisterT) :
    begin
      Result := @FLoCombinationArray[020];
    end;

    (CLoRegisterU) :
    begin
      Result := @FLoCombinationArray[021];
    end;

    (CLoRegisterV) :
    begin
      Result := @FLoCombinationArray[022];
    end;

    (CLoRegisterW) :
    begin
      Result := @FLoCombinationArray[023];
    end;

    (CLoRegisterX) :
    begin
      Result := @FLoCombinationArray[024];
    end;

    (CLoRegisterY) :
    begin
      Result := @FLoCombinationArray[025];
    end;

    (CLoRegisterZ) :
    begin
      Result := @FLoCombinationArray[026];
    end;
  else
    Result := nil;
  end;
end;

function TABCCombinationsItem.ContainsCombinationUse(const AValue : AnsiChar) : Boolean;
var
  Index : LongWord;
begin
  Result := false;

  if (FCombinationUse.Count > 000) then
  begin
    for Index := 000 to Pred(FCombinationUse.Count) do
    begin
      Result := (FCombinationUse.Items[Index] = AValue);

      if (Result) then
      begin
        Break;
      end;
    end;
  end;
end;

function TABCCombinationsItem.DeleteCombinationUse(const AValue : AnsiChar) : Boolean;
var
  Index : LongWord;
begin
  Result := false;

  if (FCombinationUse.Count > 000) then
  begin
    for Index := Pred(FCombinationUse.Count) downto 000 do
    begin
      if (FCombinationUse.Items[Index] = AValue) then
      begin
        Result := FCombinationUse.Delete(Index);

        Break;
      end;
    end;
  end;
end;

procedure TABCCombinationsItem.Assign(const AValue : TABCCombinationsItem);
var
  Index : Byte;
begin
  Initialize;

  if (AValue <> nil) then
  begin
    for Index := Low(FExCombinationArray) to High(FExCombinationArray) do
    begin
      FExCombinationArray[Index] := AValue.ExCombinationArray[Index];
    end;
    for Index := Low(FHiCombinationArray) to High(FHiCombinationArray) do
    begin
      FHiCombinationArray[Index] := AValue.HiCombinationArray[Index];
    end;
    for Index := Low(FLoCombinationArray) to High(FLoCombinationArray) do
    begin
      FLoCombinationArray[Index] := AValue.LoCombinationArray[Index];
    end;
  end;
end;

procedure TABCCombinationsItem.DecCombinationCount;
begin
  if (FCombinationCount > 000) then
  begin
    Dec(FCombinationCount);
  end;
end;

procedure TABCCombinationsItem.IncCombinationCount;
begin
  if (FCombinationCount < High(LongWord)) then
  begin
    Inc(FCombinationCount);
  end;
end;

procedure TABCCombinationsItem.Initialize;
var
  Index : Byte;
begin
  FCombinationCount := 000;
  FCombinationUse.Clear;

  for Index := Low(FExCombinationArray) to High(FExCombinationArray) do
  begin
    FExCombinationArray[Index].Static := false;
    FExCombinationArray[Index].Value  := '';
  end;
  for Index := Low(FHiCombinationArray) to High(FHiCombinationArray) do
  begin
    FHiCombinationArray[Index].Static := false;
    FHiCombinationArray[Index].Value  := '';
  end;
  for Index := Low(FLoCombinationArray) to High(FLoCombinationArray) do
  begin
    FLoCombinationArray[Index].Static := false;
    FLoCombinationArray[Index].Value  := '';
  end;
end;

{ TABCRegistersItem }

constructor TABCRegistersItem.Create;
begin
  inherited Create;

  Initialize;
end;

destructor TABCRegistersItem.Destroy;
begin
  Initialize;

  inherited Destroy;
end;

function TABCRegistersItem.CatchBlockRegister(const AValue : AnsiChar) : PAnsiChar;
begin
  case (AValue) of
    (CBlockRegisterInBlock) :
    begin
      Result := @FBlockRegisterInBlock;
    end;

    (CBlockRegisterResidual) :
    begin
      Result := @FBlockRegisterResidual;
    end;
  else
    Result := nil;
  end;
end;

function TABCRegistersItem.CatchExRegister(const AValue : AnsiChar) : PAnsiChar;
begin
  case (AValue) of
    (CExRegister0) :
    begin
      Result := @FExRegisterArray[001];
    end;

    (CExRegister1) :
    begin
      Result := @FExRegisterArray[002];
    end;

    (CExRegister2) :
    begin
      Result := @FExRegisterArray[003];
    end;

    (CExRegister3) :
    begin
      Result := @FExRegisterArray[004];
    end;

    (CExRegister4) :
    begin
      Result := @FExRegisterArray[005];
    end;

    (CExRegister5) :
    begin
      Result := @FExRegisterArray[006];
    end;

    (CExRegister6) :
    begin
      Result := @FExRegisterArray[007];
    end;

    (CExRegister7) :
    begin
      Result := @FExRegisterArray[008];
    end;

    (CExRegister8) :
    begin
      Result := @FExRegisterArray[009];
    end;

    (CExRegister9) :
    begin
      Result := @FExRegisterArray[010];
    end;

    (CExRegisterFlag) :
    begin
      Result := @FExRegisterArray[011];
    end;
  else
    Result := nil;
  end;
end;

function TABCRegistersItem.CatchHiRegister(const AValue : AnsiChar) : PAnsiChar;
begin
  case (AValue) of
    (CHiRegisterA) :
    begin
      Result := @FHiRegisterArray[001];
    end;

    (CHiRegisterB) :
    begin
      Result := @FHiRegisterArray[002];
    end;

    (CHiRegisterC) :
    begin
      Result := @FHiRegisterArray[003];
    end;

    (CHiRegisterD) :
    begin
      Result := @FHiRegisterArray[004];
    end;

    (CHiRegisterE) :
    begin
      Result := @FHiRegisterArray[005];
    end;

    (CHiRegisterF) :
    begin
      Result := @FHiRegisterArray[006];
    end;

    (CHiRegisterG) :
    begin
      Result := @FHiRegisterArray[007];
    end;

    (CHiRegisterH) :
    begin
      Result := @FHiRegisterArray[008];
    end;

    (CHiRegisterI) :
    begin
      Result := @FHiRegisterArray[009];
    end;

    (CHiRegisterJ) :
    begin
      Result := @FHiRegisterArray[010];
    end;

    (CHiRegisterK) :
    begin
      Result := @FHiRegisterArray[011];
    end;

    (CHiRegisterL) :
    begin
      Result := @FHiRegisterArray[012];
    end;

    (CHiRegisterM) :
    begin
      Result := @FHiRegisterArray[013];
    end;

    (CHiRegisterN) :
    begin
      Result := @FHiRegisterArray[014];
    end;

    (CHiRegisterO) :
    begin
      Result := @FHiRegisterArray[015];
    end;

    (CHiRegisterP) :
    begin
      Result := @FHiRegisterArray[016];
    end;

    (CHiRegisterQ) :
    begin
      Result := @FHiRegisterArray[017];
    end;

    (CHiRegisterR) :
    begin
      Result := @FHiRegisterArray[018];
    end;

    (CHiRegisterS) :
    begin
      Result := @FHiRegisterArray[019];
    end;

    (CHiRegisterT) :
    begin
      Result := @FHiRegisterArray[020];
    end;

    (CHiRegisterU) :
    begin
      Result := @FHiRegisterArray[021];
    end;

    (CHiRegisterV) :
    begin
      Result := @FHiRegisterArray[022];
    end;

    (CHiRegisterW) :
    begin
      Result := @FHiRegisterArray[023];
    end;

    (CHiRegisterX) :
    begin
      Result := @FHiRegisterArray[024];
    end;

    (CHiRegisterY) :
    begin
      Result := @FHiRegisterArray[025];
    end;

    (CHiRegisterZ) :
    begin
      Result := @FHiRegisterArray[026];
    end;
  else
    Result := nil;
  end;
end;

function TABCRegistersItem.CatchLoRegister(const AValue : AnsiChar) : PAnsiChar;
begin
  case (AValue) of
    (CLoRegisterA) :
    begin
      Result := @FLoRegisterArray[001];
    end;

    (CLoRegisterB) :
    begin
      Result := @FLoRegisterArray[002];
    end;

    (CLoRegisterC) :
    begin
      Result := @FLoRegisterArray[003];
    end;

    (CLoRegisterD) :
    begin
      Result := @FLoRegisterArray[004];
    end;

    (CLoRegisterE) :
    begin
      Result := @FLoRegisterArray[005];
    end;

    (CLoRegisterF) :
    begin
      Result := @FLoRegisterArray[006];
    end;

    (CLoRegisterG) :
    begin
      Result := @FLoRegisterArray[007];
    end;

    (CLoRegisterH) :
    begin
      Result := @FLoRegisterArray[008];
    end;

    (CLoRegisterI) :
    begin
      Result := @FLoRegisterArray[009];
    end;

    (CLoRegisterJ) :
    begin
      Result := @FLoRegisterArray[010];
    end;

    (CLoRegisterK) :
    begin
      Result := @FLoRegisterArray[011];
    end;

    (CLoRegisterL) :
    begin
      Result := @FLoRegisterArray[012];
    end;

    (CLoRegisterM) :
    begin
      Result := @FLoRegisterArray[013];
    end;

    (CLoRegisterN) :
    begin
      Result := @FLoRegisterArray[014];
    end;

    (CLoRegisterO) :
    begin
      Result := @FLoRegisterArray[015];
    end;

    (CLoRegisterP) :
    begin
      Result := @FLoRegisterArray[016];
    end;

    (CLoRegisterQ) :
    begin
      Result := @FLoRegisterArray[017];
    end;

    (CLoRegisterR) :
    begin
      Result := @FLoRegisterArray[018];
    end;

    (CLoRegisterS) :
    begin
      Result := @FLoRegisterArray[019];
    end;

    (CLoRegisterT) :
    begin
      Result := @FLoRegisterArray[020];
    end;

    (CLoRegisterU) :
    begin
      Result := @FLoRegisterArray[021];
    end;

    (CLoRegisterV) :
    begin
      Result := @FLoRegisterArray[022];
    end;

    (CLoRegisterW) :
    begin
      Result := @FLoRegisterArray[023];
    end;

    (CLoRegisterX) :
    begin
      Result := @FLoRegisterArray[024];
    end;

    (CLoRegisterY) :
    begin
      Result := @FLoRegisterArray[025];
    end;

    (CLoRegisterZ) :
    begin
      Result := @FLoRegisterArray[026];
    end;
  else
    Result := nil;
  end;
end;

function TABCRegistersItem.CatchRegister(const AValue : AnsiChar) : PAnsiChar;
begin
  if (IsBlockRegister(AValue)) then
  begin
    Result := CatchBlockRegister(AValue);
  end
  else
  begin
    if (IsExRegister(AValue)) then
    begin
      Result := CatchExRegister(AValue);
    end
    else
    begin
      if (IsHiRegister(AValue)) then
      begin
        Result := CatchHiRegister(AValue);
      end
      else
      begin
        if (IsLoRegister(AValue)) then
        begin
          Result := CatchLoRegister(AValue);
        end
        else
        begin
          if (IsOptionRegister(AValue)) then
          begin
            Result := CatchOptionRegister(AValue);
          end
          else
          begin
            Result := nil;
          end;
        end;
      end;
    end;
  end;
end;

function TABCRegistersItem.CatchOptionRegister(const AValue : AnsiChar) : PAnsiChar;
begin
  case (AValue) of
    (COptionRegister) :
    begin
      Result := @FWriteOptionBlock;
    end;
  else
    Result := nil;
  end;
end;

function TABCRegistersItem.GetAndResetOptionBlock : AnsiString;
begin
  Result := FOptionBlock;

  FOptionBlock := '';
end;

procedure TABCRegistersItem.Assign(const AValue : TABCRegistersItem);
var
  Index : Byte;
begin
  Initialize;

  if (AValue <> nil) then
  begin
    FBlockRegisterInBlock  := AValue.BlockRegisterInBlock;
    FBlockRegisterResidual := AValue.BlockRegisterResidual;
    for Index := Low(FExRegisterArray) to High(FExRegisterArray) do
    begin
      FExRegisterArray[Index] := AValue.ExRegisterArray[Index];
    end;
    for Index := Low(FHiRegisterArray) to High(FHiRegisterArray) do
    begin
      FHiRegisterArray[Index] := AValue.HiRegisterArray[Index];
    end;
    for Index := Low(FLoRegisterArray) to High(FLoRegisterArray) do
    begin
      FLoRegisterArray[Index] := AValue.LoRegisterArray[Index];
    end;
    FOptionBlock      := AValue.OptionBlock;
    FWriteOptionBlock := AValue.WriteOptionBlock;
  end;
end;

procedure TABCRegistersItem.Initialize;
var
  Index : Byte;
begin
  FBlockRegisterInBlock  := CDefaultValue;
  FBlockRegisterResidual := CDefaultValue;
  for Index := Low(FExRegisterArray) to High(FExRegisterArray) do
  begin
    FExRegisterArray[Index] := CDefaultValue;
  end;
  for Index := Low(FHiRegisterArray) to High(FHiRegisterArray) do
  begin
    FHiRegisterArray[Index] := CDefaultValue;
  end;
  for Index := Low(FLoRegisterArray) to High(FLoRegisterArray) do
  begin
    FLoRegisterArray[Index] := CDefaultValue;
  end;
  FOptionBLock      := '';
  FWriteOptionBlock := CDefaultValue;
end;

procedure TABCRegistersItem.WriteToOptionBlock(const AValue : AnsiChar);
begin
  FOptionBlock := FOptionBlock + AValue;
end;

{ TABCInterpreter }

function TABCInterpreter.ExtractCombination(const ASourceText : AnsiString;
                                            var AIndex : LongWord;
                                            var ASuccess : Boolean) : AnsiString;
var
  CharIndex        : LongWord;
  CombinationCount : LongInt;
  CombinationDone  : Boolean;
  CurrentIndex     : LongWord;
  InComment        : Boolean;
  WhiteMarkNext    : Boolean;
begin
  Result := '';

  ASuccess := true;
  if (ASuccess) then
  begin
    CharIndex := AIndex;
    if (not(AIndex >= Length(ASourceText)) and (GetNextUnIgnored(ASourceText, CharIndex) = CCombinationBegin)) then
    begin
      CombinationCount := 000;
      CombinationDone  := false;
      CurrentIndex     := 000;
      InComment        := false;
      WhiteMarkNext    := false;

      CheckLength(Result, (Length(ASourceText) - Pred(AIndex)), true);

      while (not(AIndex >= Length(ASourceText)) and not(CombinationDone)) do
      begin
        Inc(CurrentIndex);
        Inc(AIndex);
        Result[CurrentIndex] := ASourceText[AIndex];

        if (InComment) then
        begin
          if (WhiteMarkNext) then
          begin
            WhiteMarkNext := false;
          end
          else
          begin
            InComment     := (not(Result[CurrentIndex] = CIgnoreComment));
            WhiteMarkNext := (Result[CurrentIndex] = CIgnoreCommentWhiteMark);
          end;
        end
        else
        begin
          InComment := (Result[CurrentIndex] = CIgnoreComment);
          if (not(InComment)) then
          begin
            if (Result[CurrentIndex] = CCombinationBegin) then
            begin
              Inc(CombinationCount);
            end
            else
            begin
              if (Result[CurrentIndex] = CCombinationEnd) then
              begin
                Dec(CombinationCount);
              end;
            end;

            CombinationDone := (CombinationCount = 000);
          end;
        end;
      end;

      CheckLength(Result, CurrentIndex, true);

      ASuccess := CombinationDone;
    end;
  end;
end;

function TABCInterpreter.ExtractCompare(const ASourceText : AnsiString;
                                        var AIndex : LongWord;
                                        var ASuccess : Boolean) : AnsiString;
var
  CharIndex       : LongWord;
  CompareDone     : Boolean;
  CurrentIndex    : LongWord;
  TempCombination : AnsiString;
begin
  Result  := '';

  ASuccess := true;
  if (ASuccess) then
  begin
    ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);

    CompareDone  := false;
    CurrentIndex := 000;

    CheckLength(Result, (Length(ASourceText) - Pred(AIndex)), true);

    while (not(AIndex >= Length(ASourceText)) and not(CompareDone) and ASuccess) do
    begin
      AssignSymbol(GetNextUnIgnored(ASourceText, AIndex), FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation, ASuccess);
      if (ASuccess) then
      begin
        if (FNextExecuteOperation) then
        begin
          CompareDone := (IsAssign(FNextOperator) or IsBlock(FNextOperator) or IsCombination(FNextOperator));

          if (IsCombination(FNextOperator)) then
          begin
            case (FNextOperator) of
              (CCombinationBegin) :
              begin
                ASuccess := (AIndex > 000);
                if (ASuccess) then
                begin
                  if (FNextRegister <> CEmpty) then
                  begin
                    Inc(CurrentIndex);
                    CheckLength(Result, CurrentIndex, false);

                    Result[CurrentIndex] := FNextRegister;
                  end;

                  Dec(AIndex);
                  TempCombination := ExtractCombination(ASourceText, AIndex, ASuccess);
                  if (ASuccess) then
                  begin
                    for CharIndex := 001 to Length(TempCombination) do
                    begin
                      Inc(CurrentIndex);
                      CheckLength(Result, CurrentIndex, false);

                      Result[CurrentIndex] := TempCombination[CharIndex];
                    end;
                  end;
                end;
              end;

              (CCombinationUse) :
              begin
                WriteOperation(Result, CurrentIndex, FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue);
              end;
            else
              ASuccess := false;
            end;
          end
          else
          begin
            ASuccess := (IsAssign(FNextOperator) or IsBlock(FNextOperator) or IsCompare(FNextOperator));
            if (ASuccess) then
            begin
              WriteOperation(Result, CurrentIndex, FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue);
            end;
          end;

          ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);
        end;
      end;
    end;

    CheckLength(Result, CurrentIndex, true);
  end;
end;

function TABCInterpreter.GetAndResetOptionBlock(const ATypeRegister : AnsiChar;
                                                var ASuccess : Boolean) : AnsiString;
var
  ValRegisters : TABCRegistersItem;
begin
  Result := '';

  ASuccess := true;
  if (ASuccess) then
  begin
    case ATypeRegister of
      CEmpty :
      begin
        Result := FGlobalRegisters.GetAndResetOptionBlock;
      end;

      CTypeLocal :
      begin
        ASuccess := (FLocalRegisters.Count >= FBlockCount);
        if (ASuccess) then
        begin
          ValRegisters := FLocalRegisters.Items[Pred(FBlockCount)];

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            Result := ValRegisters.GetAndResetOptionBlock;
          end;
        end;
      end;

      CTypeNextParameters :
      begin
        ASuccess := (FNextParameters.Count >= FCombinations.CombinationCount);
        if (ASuccess) then
        begin
          ValRegisters := nil;
          if (FCombinations.CombinationCount > 000) then
          begin
            ValRegisters := FNextParameters.Items[Pred(FCombinations.CombinationCount)];
          end;

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            Result := ValRegisters.GetAndResetOptionBlock;
          end;
        end;
      end;

      CTypeOwnParameters :
      begin
        ASuccess := (FOwnParameters.Count >= FCombinations.CombinationCount);
        if (ASuccess) then
        begin
          ValRegisters := nil;
          if (FCombinations.CombinationCount > 000) then
          begin
            ValRegisters := FOwnParameters.Items[Pred(FCombinations.CombinationCount)];
          end;

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            Result := ValRegisters.GetAndResetOptionBlock;
          end;
        end;
      end;
    else
      ASuccess := false;
    end;
  end;
end;

function TABCInterpreter.GetNextAnalyseUnIgnored(const ASourceText : AnsiString;
                                                 var AInputIndex : LongWord;
                                                 var ADestinationText : AnsiString;
                                                 var AOutputIndex : LongWord) : AnsiChar;
var
  CurrentChar   : AnsiChar;
  IgnoreDone    : Boolean;
  IsOptionBlock : Boolean;
  OptionBlock   : AnsiString;
  WhiteMarkNext : Boolean;
begin
  Result := CEmpty;

  if (not(AInputIndex >= Length(ASourceText))) then
  begin
    IgnoreDone    := false;
    IsOptionBlock := false;
    OptionBlock   := '';
    WhiteMarkNext := false;

    Inc(AInputIndex);
    while (not(AInputIndex > Length(ASourceText)) and not(IgnoreDone)) do
    begin
      CurrentChar   := ASourceText[AInputIndex];
      IsOptionBlock := false;

      if (IsIgnore(CurrentChar)) then
      begin
        case (CurrentChar) of
          (CIgnoreSpace), (CIgnoreTab) :
          begin
            Inc(AInputIndex);
          end;

          (CIgnoreComment) :
          begin
            Inc(AInputIndex);
            if (not(IsOptionBlock) and not(AInputIndex > Length(ASourceText))) then
            begin
              IsOptionBlock := (ASourceText[AInputIndex] = COptionBlockMark);
              if (IsOptionBlock) then
              begin
                Inc(AInputIndex);
              end;
            end;

            while (not(AInputIndex > Length(ASourceText))) do
            begin
              if ((ASourceText[AInputIndex] <> CIgnoreComment) or (WhiteMarkNext)) then
              begin
                if (IsOptionBlock) then
                begin
                  OptionBlock := OptionBlock + ASourceText[AInputIndex];
                end;

                if (WhiteMarkNext) then
                begin
                  WhiteMarkNext := false;
                end
                else
                begin
                  WhiteMarkNext := (ASourceText[AInputIndex] = CIgnoreCommentWhiteMark);
                end;

                Inc(AInputIndex);
              end
              else
              begin
                Break;
              end;
            end;
            Inc(AInputIndex);
          end;
        end;
      end
      else
      begin
        Result := CurrentChar;

        IgnoreDone := true;
      end;
    end;

    if (FInterpretAnalysedOptionBlock) then
    begin
      InterpretOptionBlock(OptionBlock);
    end;
    WriteOption(ADestinationText, AOutputIndex, OptionBlock);
  end;
end;

function TABCInterpreter.GetNextUnIgnored(const ASourceText : AnsiString;
                                          var AIndex : LongWord) : AnsiChar;
var
  CurrentChar   : AnsiChar;
  IgnoreDone    : Boolean;
  IsOptionBlock : Boolean;
  OptionBlock   : AnsiString;
  WhiteMarkNext : Boolean;
begin
  Result := CEmpty;

  if (not(AIndex >= Length(ASourceText))) then
  begin
    IgnoreDone    := false;
    IsOptionBlock := false;
    OptionBlock   := '';
    WhiteMarkNext := false;

    Inc(AIndex);
    while (not(AIndex > Length(ASourceText)) and not(IgnoreDone)) do
    begin
      CurrentChar   := ASourceText[AIndex];
      IsOptionBlock := false;

      if (IsIgnore(CurrentChar)) then
      begin
        case (CurrentChar) of
          (CIgnoreSpace), (CIgnoreTab) :
          begin
            Inc(AIndex);
          end;

          (CIgnoreComment) :
          begin
            Inc(AIndex);
            if (not(IsOptionBlock) and not(AIndex > Length(ASourceText))) then
            begin
              IsOptionBlock := (ASourceText[AIndex] = COptionBlockMark);
              if (IsOptionBlock) then
              begin
                Inc(AIndex);
              end;
            end;

            while (not(AIndex > Length(ASourceText))) do
            begin
              if ((ASourceText[AIndex] <> CIgnoreComment) or (WhiteMarkNext)) then
              begin
                if (IsOptionBlock) then
                begin
                  OptionBlock := OptionBlock + ASourceText[AIndex];
                end;

                if (WhiteMarkNext) then
                begin
                  WhiteMarkNext := false;
                end
                else
                begin
                  WhiteMarkNext := (ASourceText[AIndex] = CIgnoreCommentWhiteMark);
                end;

                Inc(AIndex);
              end
              else
              begin
                Break;
              end;
            end;
            Inc(AIndex);
          end;
        end;
      end
      else
      begin
        Result := CurrentChar;

        IgnoreDone := true;
      end;
    end;

    InterpretOptionBlock(OptionBlock);
  end;
end;

function TABCInterpreter.GetOperatorChar(const AOperator : AnsiChar) : AnsiString;
begin
  Result := '';

  if (AOperator <> CEmpty) then
  begin
    Result := AOperator;
  end;
end;

function TABCInterpreter.GetRandom(var ASuccess : Boolean) : AnsiChar;
begin
  Result := CDefaultValue;

  ASuccess := true;
  if (ASuccess) then
  begin
    case (Random(High(CValueArray))) of
      (000) :
      begin
        Result := CValue0;
      end;

      (001) :
      begin
        Result := CValue1;
      end;
    else
      ASuccess := false;
    end;
  end;
end;

function TABCInterpreter.GetRegister(const ARegister : AnsiChar;
                                     const ATypeRegister : AnsiChar;
                                     var ASuccess : Boolean) : PAnsiChar;
var
  ValRegisters : TABCRegistersItem;
begin
  Result := nil;

  ASuccess := true;
  if (ASuccess) then
  begin
    case ATypeRegister of
      CEmpty :
      begin
        Result := FGlobalRegisters.CatchRegister(ARegister);
      end;

      CTypeLocal :
      begin
        ASuccess := (FLocalRegisters.Count >= FBlockCount);
        if (ASuccess) then
        begin
          ValRegisters := FLocalRegisters.Items[Pred(FBlockCount)];

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            Result := ValRegisters.CatchRegister(ARegister);
          end;
        end;
      end;

      CTypeNextParameters :
      begin
        ASuccess := (FNextParameters.Count >= FCombinations.CombinationCount);
        if (ASuccess) then
        begin
          ValRegisters := nil;
          if (FCombinations.CombinationCount > 000) then
          begin
            ValRegisters := FNextParameters.Items[Pred(FCombinations.CombinationCount)];
          end;

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            Result := ValRegisters.CatchRegister(ARegister);
          end;
        end;
      end;

      CTypeOwnParameters :
      begin
        ASuccess := (FOwnParameters.Count >= FCombinations.CombinationCount);
        if (ASuccess) then
        begin
          ValRegisters := nil;
          if (FCombinations.CombinationCount > 000) then
          begin
            ValRegisters := FOwnParameters.Items[Pred(FCombinations.CombinationCount)];
          end;

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            Result := ValRegisters.CatchRegister(ARegister);
          end;
        end;
      end;
    else
      ASuccess := false;
    end;

    if (ASuccess) then
    begin
      ASuccess := (Result <> nil);
    end;
  end;
end;

function TABCInterpreter.GetRegisterChar(const ARegister : AnsiChar) : AnsiString;
begin
  Result := '';

  if (ARegister <> CEmpty) then
  begin
    Result := ARegister;
  end;
end;

function TABCInterpreter.GetSourceLine(const AIndex : LongWord) : LongWord;
var
  IndexA   : LongWord;
  IndexB   : LongWord;
  LineDone : Boolean;
begin
  Result := 000;

  if (FSource <> nil) then
  begin
    if (AIndex <= Length(FSource.Text)) then
    begin
      IndexA   := 000;
      LineDone := false;

      IndexB := 000;
      while ((IndexB < FSource.Count) and not(LineDone)) do
      begin
        IndexA := (IndexA + Length(FSource.Items[IndexB]));

        LineDone := (IndexA >= AIndex);
        if (not(LineDone)) then
        begin
          Inc(IndexB);
          Inc(Result);
        end;
      end;

      Inc(Result);
    end;
  end;
end;

function TABCInterpreter.GetTypeChar(const AType : AnsiChar) : AnsiString;
begin
  Result := '';

  if (AType <> CEmpty) then
  begin
    Result := AType;
  end;
end;

function TABCInterpreter.GetValueChar(const AValue : AnsiChar) : AnsiString;
begin
  Result := '';

  if (AValue <> CEmpty) then
  begin
    Result := AValue;
  end;
end;

function TABCInterpreter.GetValue(const AValue : AnsiChar;
                                  const AType : AnsiChar;
                                  var ASuccess : Boolean) : AnsiChar;
var
  ValRegister : PAnsiChar;
begin
  Result := CEmpty;

  ASuccess := true;
  if (ASuccess) then
  begin
    if (IsRandomValue(AValue)) then
    begin
      Result := GetRandom(ASuccess);
    end
    else
    begin
      if (IsRegister(AValue)) then
      begin
        ValRegister := GetRegister(AValue, AType, ASuccess);
        if (ASuccess) then
        begin
          Result := ValRegister^;
        end;
      end
      else
      begin
        ASuccess := (IsValue(AValue));
        if (ASuccess) then
        begin
          Result := AValue;
        end;
      end;
    end;

    if (ASuccess) then
    begin
      ASuccess := (Result <> CEmpty);
    end;
  end;
end;

function TABCInterpreter.RegistersToAnsiChar(const AType : AnsiChar;
                                             var ASuccess : Boolean) : AnsiChar;
var
  ByteResult : Byte;
  Index      : Byte;
  ValValue   : AnsiChar;
begin
  Result := CEmpty;

  ASuccess := true;
  if (ASuccess) then
  begin
    ByteResult := 000;
    for Index := 001 to 008 do
    begin
      ValValue := GetValue(CExRegisterArray[Succ(Index)], AType, ASuccess);
      if (ASuccess) then
      begin
        if (ValValue = CValue1) then
        begin
          ByteResult := (ByteResult + Trunc(IntPower(002, (008 - Index))));
        end;
      end
      else
      begin
        Break;
      end;
    end;

    if (ASuccess) then
    begin
      Result := AnsiChar(ByteResult);
    end;
  end;
end;

function TABCInterpreter.SetOption(const AOptionName : AnsiString;
                                   const AOptionValue : AnsiString) : Boolean;
var
  Found : LongInt;
  Index : LongInt;
begin
  Result := false;

  Found := - 001;
  for Index := High(FOptionArray) downto Low(FOptionArray) do
  begin
    if (AnsiStringLowerCase(AnsiStringTrim(AOptionName)) = AnsiStringLowerCase(AnsiStringTrim(FOptionArray[Index].OptionName))) then
    begin
      Found := Index;

      Break;
    end;
  end;

  if (Found < 000) then
  begin
    SetLength(FOptionArray, Succ(Length(FOptionArray)));
    FOptionArray[High(FOptionArray)].OptionName  := AnsiStringLowerCase(AnsiStringTrim(AOptionName));
    FOptionArray[High(FOptionArray)].OptionValue := AOptionValue;

    Result := true;
  end
  else
  begin
    if ((Found >= Low(FOptionArray)) and (Found <= High(FOptionArray))) then
    begin
      FOptionArray[Found].OptionValue := AOptionValue;

      Result := true;
    end;
  end;
end;

function TABCInterpreter.VariablesEmpty(var ARegister : AnsiChar;
                                        var AOperator : AnsiChar;
                                        var AValue : AnsiChar;
                                        var ATypeRegister : AnsiChar;
                                        var ATypeValue : AnsiChar;
                                        var AExecuteOperation : Boolean) : Boolean;
begin
  Result := ((ARegister = CEmpty) and (AOperator = CEmpty) and (AValue = CEmpty) and
             (ATypeRegister = CEmpty) and (ATypeValue = CEmpty) and (AExecuteOperation = false));
end;

procedure TABCInterpreter.AnsiCharToRegisters(const AValue : AnsiChar;
                                              const AType : AnsiChar;
                                              var ASuccess : Boolean);
var
  ByteValue   : Byte;
  Index       : Byte;
  NextNumber  : Byte;
  ValRegister : PAnsiChar;
begin
  ASuccess := true;
  if (ASuccess) then
  begin
    for Index := 002 to 009 do
    begin
      ValRegister := GetRegister(CExRegisterArray[Index], AType, ASuccess);
      if (ASuccess) then
      begin
        ValRegister^ := CDefaultValue;
      end
      else
      begin
        Break;
      end;
    end;

    if (ASuccess) then
    begin
      ByteValue := Ord(AValue);
      if (ByteValue <> 000) then
      begin
        Index := 009;
        while ((not(ByteValue = 000) and not(Index < 002)) and ASuccess) do
        begin
          NextNumber := (ByteValue mod 002);
          ByteValue  := (ByteValue div 002);

          ValRegister := GetRegister(CExRegisterArray[Index], AType, ASuccess);
          if (ASuccess) then
          begin
            if (NextNumber = 000) then
            begin
              ValRegister^ := CValue0;
            end
            else
            begin
              ASuccess := (NextNumber = 001);
              if (ASuccess) then
              begin
                ValRegister^ := CValue1;
              end;
            end;

            Dec(Index);
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignAnd(const ARegister : AnsiChar;
                                    const AValue : AnsiChar;
                                    const ATypeRegister : AnsiChar;
                                    const ATypeValue : AnsiChar;
                                    var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if ((ValRegister^ = CValue1) and (ValValue = CValue1)) then
        begin
          ValRegister^ := CValue1;
        end
        else
        begin
          ValRegister^ := CValue0;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignBecomes(const ARegister : AnsiChar;
                                        const AValue : AnsiChar;
                                        const ATypeRegister : AnsiChar;
                                        const ATypeValue : AnsiChar;
                                        var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        ValRegister^ := ValValue;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignBecomesNot(const ARegister : AnsiChar;
                                           const AValue : AnsiChar;
                                           const ATypeRegister : AnsiChar;
                                           const ATypeValue : AnsiChar;
                                           var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        ValRegister^ := ValueNot(ValValue);
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignCheckMemEmpty(const ARegister : AnsiChar;
                                              const AValue : AnsiChar;
                                              const ATypeRegister : AnsiChar;
                                              const ATypeValue : AnsiChar;
                                              var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if (ValValue = CValue0) then
        begin
          if (FMemory.Count <= 000) then
          begin
            ValRegister^ := CValue0;
          end
          else
          begin
            ValRegister^ := CValue1;
          end;
        end
        else
        begin
          if (FMemory.Count <= 000) then
          begin
            ValRegister^ := CValue1;
          end
          else
          begin
            ValRegister^ := CValue0;
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignCheckMemEntry(const ARegister : AnsiChar;
                                              const AValue : AnsiChar;
                                              const ATypeRegister : AnsiChar;
                                              const ATypeValue : AnsiChar;
                                              var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if (FMemory.Count > 000) then
        begin
          if (ValValue = CValue0) then
          begin
            if (FMemory.IsFirstAddedEntry(000)) then
            begin
              ValRegister^ := CValue1;
            end
            else
            begin
              ValRegister^ := CValue0;
            end;
          end
          else
          begin
            if (FMemory.IsFirstAddedEntry(Pred(FMemory.Count))) then
            begin
              ValRegister^ := CValue1;
            end
            else
            begin
              ValRegister^ := CValue0;
            end;
          end;
        end
        else
        begin
          ValRegister^ := CValue1;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignOr(const ARegister : AnsiChar;
                                   const AValue : AnsiChar;
                                   const ATypeRegister : AnsiChar;
                                   const ATypeValue : AnsiChar;
                                   var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if ((ValRegister^ = CValue1) or (ValValue = CValue1)) then
        begin
          ValRegister^ := CValue1;
        end
        else
        begin
          ValRegister^ := CValue0;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignReadMem(const ARegister : AnsiChar;
                                        const AValue : AnsiChar;
                                        const ATypeRegister : AnsiChar;
                                        const ATypeValue : AnsiChar;
                                        var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if (FMemory.Count > 000) then
        begin
          if (ValValue = CValue0) then
          begin
            ValRegister^ := FMemory.Items[000];

            ASuccess := ((ValRegister^ = FMemory.Items[000]) and FMemory.DeleteFirst);
          end
          else
          begin
            ValRegister^ := FMemory.Items[Pred(FMemory.Count)];

            ASuccess := ((ValRegister^ = FMemory.Items[Pred(FMemory.Count)]) and FMemory.DeleteLast);
          end;
        end
        else
        begin
          ValRegister^ := CDefaultValue;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignSymbol(const ASymbol : AnsiChar;
                                       var ARegister : AnsiChar;
                                       var AOperator : AnsiChar;
                                       var AValue : AnsiChar;
                                       var ATypeRegister : AnsiChar;
                                       var ATypeValue : AnsiChar;
                                       var AExecute : Boolean;
                                       var ASuccess : Boolean);
begin
  ASuccess := true;
  if (ASuccess) then
  begin
    if (IsAssign(ASymbol) or IsBlock(ASymbol) or IsCombination(ASymbol) or IsCompare(ASymbol)) then
    begin
      ASuccess := (AOperator = CEmpty);
      if (ASuccess) then
      begin
        AOperator := ASymbol;
      end;
    end
    else
    begin
      if (IsType(ASymbol)) then
      begin
        ASuccess := ((ARegister = CEmpty) and (ATypeRegister = CEmpty));
        if (ASuccess) then
        begin
          ATypeRegister := ASymbol;
        end
        else
        begin
          ASuccess := ((AValue = CEmpty) and (ATypeValue = CEmpty));
          if (ASuccess) then
          begin
            ATypeValue := ASymbol;
          end;
        end;
      end
      else
      begin
        ASuccess := (IsRandomValue(ASymbol) or IsValue(ASymbol));
        if (ASuccess) then
        begin
          ASuccess := (AValue = CEmpty);
          if (ASuccess) then
          begin
            AValue := ASymbol;
          end;
        end
        else
        begin
          ASuccess := (IsRegister(ASymbol));
          if (ASuccess) then
          begin
            if (ARegister = CEmpty) then
            begin
              ARegister := ASymbol;
            end
            else
            begin
              ASuccess := (AValue = CEmpty);
              if (ASuccess) then
              begin
                AValue := ASymbol;
              end;
            end;
          end;
        end;
      end;
    end;

    if (ASuccess) then
    begin
      AExecute := false;

      if (IsAssign(AOperator) or IsCompare(AOperator)) then
      begin
        AExecute := ((ARegister <> CEmpty) and (AValue <> CEmpty));
      end
      else
      begin
        if (IsBlock(AOperator)) then
        begin
          if (AOperator = CBlockBegin) then
          begin
            AExecute := ((ARegister = CEmpty) and (AValue = CEmpty) and (ATypeRegister = CEmpty) and (ATypeValue = CEmpty));

            ASuccess := AExecute;
          end
          else
          begin
            if (AOperator = CBlockEnd) then
            begin
              AExecute := ((ARegister = CEmpty) and (AValue = CEmpty) and (ATypeRegister = CEmpty) and (ATypeValue = CEmpty));

              ASuccess := AExecute;
            end;
          end;
        end
        else
        begin
          if (IsCombination(AOperator)) then
          begin
            if (AOperator = CCombinationBegin) then
            begin
              AExecute := ((AValue = CEmpty) and (ATypeRegister = CEmpty) and (ATypeValue = CEmpty));

              ASuccess := AExecute;
            end
            else
            begin
              if (AOperator = CCombinationEnd) then
              begin
                AExecute := ((ARegister = CEmpty) and (AValue = CEmpty) and (ATypeRegister = CEmpty) and (ATypeValue = CEmpty));

                ASuccess := AExecute;
              end
              else
              begin
                if (AOperator = CCombinationUse) then
                begin
                  ASuccess := ((AValue = CEmpty) and (ATypeValue = CEmpty));
                  if (ASuccess) then
                  begin
                    AExecute := (ARegister <> CEmpty) or (ATypeRegister <> CEmpty);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignTouchMemFirst(const ARegister : AnsiChar;
                                              const AValue : AnsiChar;
                                              const ATypeRegister : AnsiChar;
                                              const ATypeValue : AnsiChar;
                                              var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if (FMemory.Count > 000) then
        begin
          ValRegister^ := FMemory.Items[000];

          ASuccess := (ValRegister^ = FMemory.Items[000]);
          if (ASuccess) then
          begin
            if (ValValue = CValue1) then
            begin
              ASuccess := FMemory.PutFirstToLast;
            end;
          end;
        end
        else
        begin
          ValRegister^ := CDefaultValue;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignTouchMemLast(const ARegister : AnsiChar;
                                             const AValue : AnsiChar;
                                             const ATypeRegister : AnsiChar;
                                             const ATypeValue : AnsiChar;
                                             var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if (FMemory.Count > 000) then
        begin
          ValRegister^ := FMemory.Items[Pred(FMemory.Count)];

          ASuccess := (ValRegister^ = FMemory.Items[Pred(FMemory.Count)]);
          if (ASuccess) then
          begin
            if (ValValue = CValue0) then
            begin
              ASuccess := FMemory.PutLastToFirst;
            end;
          end;
        end
        else
        begin
          ValRegister^ := CDefaultValue;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignWriteMem(const ARegister : AnsiChar;
                                         const AValue : AnsiChar;
                                         const ATypeRegister : AnsiChar;
                                         const ATypeValue : AnsiChar;
                                         var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if (ValValue = CValue0) then
        begin
          ASuccess := (FMemory.InsertAsFirst(ValRegister^) and (FMemory.Items[000] = ValRegister^));
        end
        else
        begin
          ASuccess := (ValValue = CValue1);
          if (ASuccess) then
          begin
            ASuccess := (FMemory.InsertAsLast(ValRegister^) and (FMemory.Items[Pred(FMemory.Count)] = ValRegister^));
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.AssignXor(const ARegister : AnsiChar;
                                    const AValue : AnsiChar;
                                    const ATypeRegister : AnsiChar;
                                    const ATypeValue : AnsiChar;
                                    var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
  ValValue    : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegister := GetRegister(ARegister, ATypeRegister, ASuccess);
    if (ASuccess) then
    begin
      ValValue := GetValue(AValue, ATypeValue, ASuccess);
      if (ASuccess) then
      begin
        if (((ValRegister^ = CValue0) and (ValValue = CValue1)) or ((ValRegister^ = CValue1) and (ValValue = CValue0))) then
        begin
          ValRegister^ := CValue1;
        end
        else
        begin
          ValRegister^ := CValue0;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.BlockBegin(var ASuccess : Boolean);
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    Inc(FBlockCount);

    ASuccess := (FLocalRegisters.Count >= FBlockCount);
    if (ASuccess) then
    begin
      ASuccess := (FLocalRegisters.Items[Pred(FBlockCount)] <> nil);
      if (not(ASuccess)) then
      begin
        FLocalRegisters.Items[Pred(FBlockCount)] := TABCRegistersItem.Create;

        ASuccess := (FLocalRegisters.Items[Pred(FBlockCount)] <> nil);
      end;
    end
    else
    begin
      ASuccess := FLocalRegisters.InsertAsLast(TABCRegistersItem.Create);
      if (ASuccess) then
      begin
        ASuccess := (FLocalRegisters.Count >= FBlockCount);
      end;
    end;

    if (ASuccess) then
    begin
      SetBlockRegisters(ASuccess);
    end;
  end;
end;

procedure TABCInterpreter.BlockEnd(var ASuccess : Boolean);
var
  ValValue     : AnsiChar;
  ValRegisters : TABCRegistersItem;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ASuccess := (FBlockCount > 000);
    if (ASuccess) then
    begin
      ValValue := GetValue(CBlockRegisterResidual, CTypeLocal, ASuccess);
      if (ASuccess) then
      begin
        if (not(ValValue = CValue1)) then
        begin
          ValRegisters := FLocalRegisters.Items[Pred(FBlockCount)];

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            if (FLocalRegisters.Count > FBlockCount) then
            begin
              ValRegisters.Initialize;
            end
            else
            begin
              ValRegisters.Free;

              ASuccess := FLocalRegisters.DeleteLast;
            end;
          end;
        end;
      end;

      if (ASuccess) then
      begin
        Dec(FBlockCount);

        SetBlockRegisters(ASuccess);
      end;
    end;
  end;
end;

procedure TABCInterpreter.CheckCommunication(const ARegister : AnsiChar;
                                             const ATypeRegister : AnsiChar;
                                             var ASuccess : Boolean);
var
  AccessDone  : Boolean;
  CharBuffer  : AnsiChar;
  OptionBlock : AnsiString;
  ValValueA   : AnsiChar;
  ValValueB   : AnsiChar;
begin
  ASuccess := true;
  if (ASuccess) then
  begin
    case (ARegister) of
      (CExRegister9) :
      begin
        ValValueA := GetValue(CExRegister0, ATypeRegister, ASuccess);
        if (ASuccess) then
        begin
          ValValueB := GetValue(CExRegister9, ATypeRegister, ASuccess);
          if (ASuccess) then
          begin
            AccessDone := false;
            CharBuffer := CEmpty;

            case (ValValueA) of
              (CValue0) : // file
              begin
                case (ValValueB) of
                  (CValue0) : // read from file
                  begin
                    if (Assigned(FReadFileValue)) then
                    begin
                      CharBuffer := RegistersToAnsiChar(ATypeRegister, ASuccess);
                      if (ASuccess) then
                      begin
                        FReadFileValue(CharBuffer, AccessDone);
                        if (AccessDone) then
                        begin
                          AnsiCharToRegisters(CharBuffer, ATypeRegister, ASuccess);
                        end;
                      end;
                    end;
                  end;

                  (CValue1) : // write to file
                  begin
                    if (Assigned(FWriteFileValue)) then
                    begin
                      CharBuffer := RegistersToAnsiChar(ATypeRegister, ASuccess);
                      if (ASuccess) then
                      begin
                        FWriteFileValue(CharBuffer, AccessDone);
                      end;
                    end;
                  end;
                else
                  ASuccess := false;
                end;
              end;

              (CValue1) : // screen
              begin
                case (ValValueB) of
                  (CValue0) : // read from screen
                  begin
                    if (Assigned(FReadScreenValue)) then
                    begin
                      CharBuffer := RegistersToAnsiChar(ATypeRegister, ASuccess);
                      if (ASuccess) then
                      begin
                        FReadScreenValue(CharBuffer, AccessDone);
                        if (ASuccess) then
                        begin
                          AnsiCharToRegisters(CharBuffer, ATypeRegister, ASuccess);
                        end;
                      end;
                    end;
                  end;

                  (CValue1) : // write to screen
                  begin
                    if (Assigned(FWriteScreenValue)) then
                    begin
                      CharBuffer := RegistersToAnsiChar(ATypeRegister, ASuccess);
                      if (ASuccess) then
                      begin
                        FWriteScreenValue(CharBuffer, AccessDone);
                      end;
                    end;
                  end;
                else
                  ASuccess := false;
                end;
              end;
            else
              ASuccess := false;
            end;
          end;
        end;

        if (ASuccess) then
        begin
          SetFlagRegister(AccessDone, ATypeRegister, ASuccess);
        end;
      end;

      (COptionRegister) :
      begin
        ValValueA := GetValue(COptionRegister, ATypeRegister, ASuccess);
        if (ASuccess) then
        begin
          case (ValValueA) of
            (CValue0) : // interpret optionblock
            begin
              OptionBlock := GetAndResetOptionBlock(ATypeRegister, ASuccess);
              if (ASuccess) then
              begin
                InterpretOptionBlock(OptionBlock);
              end;
            end;

            (CValue1) : // write to optionblock
            begin
              CharBuffer := RegistersToAnsiChar(ATypeRegister, ASuccess);
              if (ASuccess) then
              begin
                WriteToOptionBlock(ATypeRegister, CharBuffer, ASuccess);
              end;
            end;
          else
            ASuccess := false;
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.CheckLength(var ASourceText : AnsiString;
                                      const ALength : LongWord;
                                      const AForceLength : Boolean);
begin
  if ((Length(ASourceText) < ALength) or AForceLength) then
  begin
    SetLength(ASourceText, ALength);
  end;
end;

procedure TABCInterpreter.CheckStack(var ASuccess : Boolean);
begin
  ASuccess := ((GetESP > (FStackBegin - CMaxUsedStackSize)) or not(FStackProtection));
  if (not(ASuccess)) then
  begin
    FHasStackOverflow := not(ASuccess);
  end;
end;

procedure TABCInterpreter.ClearAnalysedSource;
begin
  FAnalysedSource := '';
end;

procedure TABCInterpreter.ClearLocalRegisters;
var
  Index        : LongWord;
  ValRegisters : TABCRegistersItem;
begin
  if (FLocalRegisters.Count > 000) then
  begin
    for Index := 000 to Pred(FLocalRegisters.Count) do
    begin
      ValRegisters := FLocalRegisters.Items[Index];
      if (ValRegisters <> nil) then
      begin
        ValRegisters.Free;
      end;
    end;
  end;

  FLocalRegisters.Clear;
end;

procedure TABCInterpreter.ClearNextParameters;
var
  Index        : LongWord;
  ValRegisters : TABCRegistersItem;
begin
  if (FNextParameters.Count > 000) then
  begin
    for Index := 000 to Pred(FNextParameters.Count) do
    begin
      ValRegisters := FNextParameters.Items[Index];
      if (ValRegisters <> nil) then
      begin
        ValRegisters.Free;
      end;
    end;
  end;

  FNextParameters.Clear;
end;

procedure TABCInterpreter.ClearOwnParameters;
var
  Index        : LongWord;
  ValRegisters : TABCRegistersItem;
begin
  if (FOwnParameters.Count > 000) then
  begin
    for Index := 000 to Pred(FOwnParameters.Count) do
    begin
      ValRegisters := FOwnParameters.Items[Index];
      if (ValRegisters <> nil) then
      begin
        ValRegisters.Free;
      end;
    end;
  end;

  FOwnParameters.Clear;
end;

procedure TABCInterpreter.ClearMessages;
begin
  if (FMessages <> nil) then
  begin
    FMessages.Clear;
  end;
end;

procedure TABCInterpreter.ClearVariables(var ARegister : AnsiChar;
                                         var AOperator : AnsiChar;
                                         var AValue : AnsiChar;
                                         var ATypeRegister : AnsiChar;
                                         var ATypeValue : AnsiChar;
                                         var AExecuteOperation : Boolean);
begin
  AExecuteOperation := false;
  ARegister         := CEmpty;
  AOperator         := CEmpty;
  ATypeRegister     := CEmpty;
  ATypeValue        := CEmpty;
  AValue            := CEmpty;
end;

procedure TABCInterpreter.CombinationBegin(const ARegister : AnsiChar;
                                           const ASourceText : AnsiString;
                                           var AIndex : LongWord;
                                           var ASuccess : Boolean);
var
  ValCombination : PABCCombinationRecord;
begin
  ASuccess := true;
  if (ASuccess) then
  begin
    if (ARegister <> CEmpty) then
    begin
      ASuccess := (not(FIsInMainCombination) or (FIsInMainCombination and not(FCombinations.CatchCombination(ARegister)^.Static)));
      if (ASuccess) then
      begin
        ASuccess := (not(FCombinations.ContainsCombinationUse(ARegister)));
        if (ASuccess) then
        begin
          ASuccess := (AIndex > 000);
          if (ASuccess) then
          begin
            ValCombination := FCombinations.CatchCombination(ARegister);

            ASuccess := (ValCombination <> nil);
            if (ASuccess) then
            begin
              if (not(FIsInMainCombination)) then
              begin
                ValCombination^.Static := true;
              end;

              Dec(AIndex);
              ValCombination^.Value := ExtractCombination(ASourceText, AIndex, ASuccess);
            end;
          end;
        end;
      end;
    end
    else
    begin
      ASuccess := FOwnParameters.InsertAsLast(TABCRegistersItem.Create);
      if (ASuccess) then
      begin
        if (FNextParameters.Count > 000) then
        begin
          TABCRegistersItem(FOwnParameters.Items[Pred(FOwnParameters.Count)]).Assign(TABCRegistersItem(FNextParameters.Items[Pred(FNextParameters.Count)]));
        end;

        ASuccess := FNextParameters.InsertAsLast(TABCRegistersItem.Create);
        if (ASuccess) then
        begin
          if (not(FIsInMainCombination)) then
          begin
            FIsInMainCombination := (FCombinations.CombinationCount = 000);
          end;
          FCombinations.IncCombinationCount;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.CombinationEnd(var ASuccess : Boolean);
var
  ValRegisters : TABCRegistersItem;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValRegisters := FNextParameters.Items[Pred(FNextParameters.Count)];

    ASuccess := (ValRegisters <> nil);
    if (ASuccess) then
    begin
      ValRegisters.Free;

      ASuccess := FNextParameters.DeleteLast;
      if (ASuccess) then
      begin
        if (FNextParameters.Count > 000) then
        begin
          TABCRegistersItem(FNextParameters.Items[Pred(FNextParameters.Count)]).Assign(TABCRegistersItem(FOwnParameters.Items[Pred(FOwnParameters.Count)]));
        end;

        ValRegisters := FOwnParameters.Items[Pred(FOwnParameters.Count)];

        ASuccess := (ValRegisters <> nil);
        if (ASuccess) then
        begin
          ValRegisters.Free;

          ASuccess := FOwnParameters.DeleteLast;
          if (ASuccess) then
          begin
            FCombinations.DecCombinationCount;
            if (FIsInMainCombination and (FCombinations.CombinationCount = 000)) then
            begin
              if (not(FWasInMainCombination)) then
              begin
                FWasInMainCombination := FIsInMainCombination;
              end;
              FIsInMainCombination := (FCombinations.CombinationCount = 000);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.CombinationUse(const ARegister : AnsiChar;
                                         var ASuccess : Boolean);
var
  ValCombination : PABCCombinationRecord;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ValCombination := FCombinations.CatchCombination(ARegister);

    ASuccess := (ValCombination <> nil);
    if (ASuccess) then
    begin
      ASuccess := FCombinations.AddCombinationUse(ARegister);
      if (ASuccess) then
      begin
        Interpret(ValCombination^.Value, ASuccess);
        if (ASuccess) then
        begin
          ASuccess := FCombinations.DeleteCombinationUse(ARegister);
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.CompareIf(const ARegister : AnsiChar;
                                    const AOperator : AnsiChar;
                                    const AValue : AnsiChar;
                                    const ATypeRegister : AnsiChar;
                                    const ATypeValue : AnsiChar;
                                    const ASourceText : AnsiString;
                                    var AIndex : LongWord;
                                    var ASuccess : Boolean);
var
  CompareText : AnsiString;
  ValValueA   : AnsiChar;
  ValValueB   : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    CompareText := ExtractCompare(ASourceText, AIndex, ASuccess);
    if (ASuccess) then
    begin
      ValValueA := GetValue(ARegister, ATypeRegister, ASuccess);
      if (ASuccess) then
      begin
        ValValueB := GetValue(AValue, ATypeValue, ASuccess);
        if (ASuccess) then
        begin
          if (ValValueA = ValValueB) then
          begin
            Interpret(CompareText, ASuccess);
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.CompareIfNot(const ARegister : AnsiChar;
                                       const AOperator : AnsiChar;
                                       const AValue : AnsiChar;
                                       const ATypeRegister : AnsiChar;
                                       const ATypeValue : AnsiChar;
                                       const ASourceText : AnsiString;
                                       var AIndex : LongWord;
                                       var ASuccess : Boolean);
var
  CompareText : AnsiString;
  ValValueA   : AnsiChar;
  ValValueB   : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    CompareText := ExtractCompare(ASourceText, AIndex, ASuccess);
    if (ASuccess) then
    begin
      ValValueA := GetValue(ARegister, ATypeRegister, ASuccess);
      if (ASuccess) then
      begin
        ValValueB := GetValue(AValue, ATypeValue, ASuccess);
        if (ASuccess) then
        begin
          if (ValValueA <> ValValueB) then
          begin
            Interpret(CompareText, ASuccess);
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.CompareWhile(const ARegister : AnsiChar;
                                       const AOperator : AnsiChar;
                                       const AValue : AnsiChar;
                                       const ATypeRegister : AnsiChar;
                                       const ATypeValue : AnsiChar;
                                       const ASourceText : AnsiString;
                                       var AIndex : LongWord;
                                       var ASuccess : Boolean);
var
  CompareText : AnsiString;
  ValValueA   : AnsiChar;
  ValValueB   : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    CompareText := ExtractCompare(ASourceText, AIndex, ASuccess);
    if (ASuccess) then
    begin
      ValValueA := GetValue(ARegister, ATypeRegister, ASuccess);
      if (ASuccess) then
      begin
        ValValueB := GetValue(AValue, ATypeValue, ASuccess);
        if (ASuccess) then
        begin
          while ((ValValueA = ValValueB) and ASuccess) do
          begin
            Interpret(CompareText, ASuccess);
            if (ASuccess) then
            begin
              ValValueA := GetValue(ARegister, ATypeRegister, ASuccess);
              if (ASuccess) then
              begin
                ValValueB := GetValue(AValue, ATypeValue, ASuccess);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.CompareWhileNot(const ARegister : AnsiChar;
                                          const AOperator : AnsiChar;
                                          const AValue : AnsiChar;
                                          const ATypeRegister : AnsiChar;
                                          const ATypeValue : AnsiChar;
                                          const ASourceText : AnsiString;
                                          var AIndex : LongWord;
                                          var ASuccess : Boolean);
var
  CompareText : AnsiString;
  ValValueA   : AnsiChar;
  ValValueB   : AnsiChar;
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    CompareText := ExtractCompare(ASourceText, AIndex, ASuccess);
    if (ASuccess) then
    begin
      ValValueA := GetValue(ARegister, ATypeRegister, ASuccess);
      if (ASuccess) then
      begin
        ValValueB := GetValue(AValue, ATypeValue, ASuccess);
        if (ASuccess) then
        begin
          while ((ValValueA <> ValValueB) and ASuccess) do
          begin
            Interpret(CompareText, ASuccess);
            if (ASuccess) then
            begin
              ValValueA := GetValue(ARegister, ATypeRegister, ASuccess);
              if(ASuccess) then
              begin
                ValValueB := GetValue(AValue, ATypeValue, ASuccess);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TABCInterpreter.DoError(const ALineNumber : LongInt;
                                  const AErrorCode : LongWord);
begin
  WriteMessage(ALineNumber, true, AErrorCode,  GetTypeChar(FNextTypeRegister) + GetRegisterChar(FNextRegister) + GetOperatorChar(FNextOperator) + GetTypeChar(FNextTypeValue) + GetValueChar(FNextValue));
  ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);
end;

procedure TABCInterpreter.ExecuteAssign(const ARegister : AnsiChar;
                                        const AOperator : AnsiChar;
                                        const AValue : AnsiChar;
                                        const ATypeRegister : AnsiChar;
                                        const ATypeValue : AnsiChar;
                                        var ASuccess : Boolean);
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ASuccess := (not(((ATypeRegister = CTypeLocal) or (ATypeValue = CTypeLocal)) and not(FBlockCount > 000)));
    if (ASuccess) then
    begin
      case (AOperator) of
        (CAssignAnd) :
        begin
          AssignAnd(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignBecomes) :
        begin
          AssignBecomes(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignBecomesNot) :
        begin
          AssignBecomesNot(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignCheckMemEmpty) :
        begin
          AssignCheckMemEmpty(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignCheckMemEntry) :
        begin
          AssignCheckMemEntry(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignOr) :
        begin
          AssignOr(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignReadMem) :
        begin
          AssignReadMem(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignTouchMemFirst) :
        begin
          AssignTouchMemFirst(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignTouchMemLast) :
        begin
          AssignTouchMemLast(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignWriteMem) :
        begin
          AssignWriteMem(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;

        (CAssignXOr) :
        begin
          AssignXOr(ARegister, AValue, ATypeRegister, ATypeValue, ASuccess);
        end;
      else
        ASuccess := false;
      end;

      if (ASuccess) then
      begin
        CheckCommunication(ARegister, ATypeRegister, ASuccess);
      end;
    end;
  end;
end;

procedure TABCInterpreter.ExecuteBlock(const AOperator : AnsiChar;
                                       var ASuccess : Boolean);
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    case (AOperator) of
      (CBlockBegin) :
      begin
        BlockBegin(ASuccess);
      end;

      (CBlockEnd) :
      begin
        BlockEnd(ASuccess);
      end;
    else
      ASuccess := false;
    end;
  end;
end;

procedure TABCInterpreter.ExecuteCombination(const ARegister : AnsiChar;
                                             const AOperator : AnsiChar;
                                             const ASourceText : AnsiString;
                                             var AIndex : LongWord;
                                             var ASuccess : Boolean);
begin
  ASuccess := true;
  if (ASuccess) then
  begin
    case (AOperator) of
      (CCombinationBegin) :
      begin
        CombinationBegin(ARegister, ASourceText, AIndex, ASuccess);
      end;

      (CCombinationEnd) :
      begin
        CombinationEnd(ASuccess);
      end;

      (CCombinationUse) :
      begin
        CombinationUse(ARegister, ASuccess);
      end;
    else
      ASuccess := false;
    end;
  end;
end;

procedure TABCInterpreter.ExecuteCompare(const ARegister : AnsiChar;
                                         const AOperator : AnsiChar;
                                         const AValue : AnsiChar;
                                         const ATypeRegister : AnsiChar;
                                         const ATypeValue : AnsiChar;
                                         const ASourceText : AnsiString;
                                         var AIndex : LongWord;
                                         var ASuccess : Boolean);
begin
  ASuccess := (FCombinations.CombinationCount > 000);
  if (ASuccess) then
  begin
    ASuccess := (not(((ATypeRegister = CTypeLocal) or (ATypeValue = CTypeLocal)) and not(FBlockCount > 000)));
    if (ASuccess) then
    begin
      case (AOperator) of
        (CCompareIf) :
        begin
          CompareIf(ARegister, AOperator, AValue, ATypeRegister, ATypeValue, ASourceText, AIndex, ASuccess);
        end;

        (CCompareIfNot) :
        begin
          CompareIfNot(ARegister, AOperator, AValue, ATypeRegister, ATypeValue, ASourceText, AIndex, ASuccess);
        end;

        (CCompareWhile) :
        begin
          CompareWhile(ARegister, AOperator, AValue, ATypeRegister, ATypeValue, ASourceText, AIndex, ASuccess);
        end;

        (CCompareWhileNot) :
        begin
          CompareWhileNot(ARegister, AOperator, AValue, ATypeRegister, ATypeValue, ASourceText, AIndex, ASuccess);
        end;
      else
        ASuccess := false;
      end;
    end;
  end;
end;

procedure TABCInterpreter.Interpret(const ASourceText : AnsiString;
                                    var ASuccess : Boolean);
var
  CharIndex : LongWord;
begin
  CheckStack(ASuccess);
  if (ASuccess) then
  begin
    ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);

    CharIndex := 000;
    while (not(CharIndex >= Length(ASourceText)) and ASuccess) do
    begin
      ASuccess := not(FWasInMainCombination);
      if (ASuccess) then
      begin
        AssignSymbol(GetNextUnIgnored(ASourceText, CharIndex), FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation, ASuccess);
        if (ASuccess) then
        begin
          if (FNextExecuteOperation) then
          begin
            if (IsCombination(FNextOperator)) then
            begin
              FBreakInterpretation := (FNextTypeRegister <> CEmpty);
              if (FBreakInterpretation) then
                ASuccess := false;

              if (not(FBreakInterpretation)) then
              begin
                ExecuteCombination(FNextRegister, FNextOperator, ASourceText, CharIndex, ASuccess);
                if (not(ASuccess)) then
                begin
                  if ((FNextOperator = CCombinationBegin) and (FCombinations.ContainsCombinationUse(FNextRegister))) then
                  begin
                    // Combination Cannot Be Redefined When Executed
                    DoError(CGeneralMessage, 025);
                  end
                  else
                  begin
                    if ((FNextOperator = CCombinationBegin) and not(CharIndex > 000)) then
                    begin
                      // Combination-Source Not Found
                      DoError(CGeneralMessage, 020);
                    end
                    else
                    begin
                      if ((FNextOperator = CCombinationEnd) and not(FCombinations.CombinationCount > 000)) then
                      begin
                        // Missing Combination-Beginning
                        DoError(CGeneralMessage, 021);
                      end
                      else
                      begin
                        if ((FNextOperator = CCombinationUse) and not(FCombinations.CombinationCount > 000)) then
                        begin
                          // Only Allowed Within Combination
                          DoError(CGeneralMessage, 023);
                        end
                        else
                        begin
                          if ((FNextOperator = CCombinationBegin) and (FNextRegister <> CEmpty)) then
                          begin
                            if (FIsInMainCombination and FCombinations.CatchCombination(FNextRegister)^.Static) then
                            begin
                              // Static Combination Cannot Be Redefined
                              DoError(CGeneralMessage, 024);
                            end
                            else
                            begin
                              // Internal Error Encountered
                              DoError(CGeneralMessage, 000);
                            end;
                          end
                          else
                          begin
                            // Internal Error Encountered
                            DoError(CGeneralMessage, 000);
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end
            else
            begin
              if (FCombinations.CombinationCount > 000) then
              begin
                if (IsAssign(FNextOperator)) then
                begin
                  ExecuteAssign(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, ASuccess);
                  if (not(ASuccess)) then
                  begin
                    if (not(((FNextTypeRegister = CTypeLocal) or (FNextTypeValue = CTypeLocal)) and not((FBlockCount > 000)))) then
                    begin
                      // Only Allowed Within Block
                      DoError(CGeneralMessage, 032);
                    end
                    else
                    begin
                      // Internal Error Encountered
                      DoError(CGeneralMessage, 000);
                    end;
                  end;
                end
                else
                begin
                  if (IsBlock(FNextOperator)) then
                  begin
                    ExecuteBlock(FNextOperator, ASuccess);
                    if (not(ASuccess)) then
                    begin
                      if ((FNextOperator = CBlockEnd) and not(FBlockCount > 000)) then
                      begin
                        // Missing Block-Beginning
                        DoError(CGeneralMessage, 030);
                      end
                      else
                      begin
                        // Internal Error Encountered
                        DoError(CGeneralMessage, 000);
                      end;
                    end;
                  end
                  else
                  begin
                    if (IsCompare(FNextOperator)) then
                    begin
                      ExecuteCompare(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, ASourceText, CharIndex, ASuccess);
                      if (not(ASuccess)) then
                      begin
                        // Internal Error Encountered
                        DoError(CGeneralMessage, 000);
                      end;
                    end
                    else
                    begin
                      // Unknown Symbol Encountered
                      DoError(CGeneralMessage, 001);
                    end;
                  end;
                end
              end
              else
              begin
                // Only Allowed Within Combination
                DoError(CGeneralMessage, 023);
              end;
            end;

            ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);
          end;
        end
        else
        begin
          // Unknown Symbol Encountered
           DoError(CGeneralMessage, 001);
        end;
      end
      else
      begin
        // Source Behind Main-Combination Is Ignored
        DoError(CGeneralMessage, 011);
      end;
    end;
  end
  else
  begin
    // Possible Stack-Overflow Encountered
    DoError(CGeneralMessage, 040);
  end;

  if (not(VariablesEmpty(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation))) then
  begin
    // Incomplete Operation Encountered
    DoError(CGeneralMessage, 002);

    ASuccess := false;
  end;
end;

procedure TABCInterpreter.InterpretOptionBlock(const AOptionBlock : AnsiString);
var
  CharIndex     : LongWord;
  OptionName    : AnsiString;
  OptionValue   : AnsiString;
  ReadValue     : Boolean;
  WhiteMarkNext : Boolean;
begin
  OptionName    := '';
  OptionValue   := '';
  ReadValue     := false;
  WhiteMarkNext := false;

  CharIndex := 001;
  while (not(CharIndex > Length(AOptionBlock))) do
  begin
    if (WhiteMarkNext) then
    begin
      WhiteMarkNext := false;

      if (ReadValue) then
      begin
        OptionValue := OptionValue + AOptionBlock[CharIndex];
      end
      else
      begin
        OptionName := OptionName + AOptionBlock[CharIndex];
      end;
    end
    else
    begin
      WhiteMarkNext := (AOptionBlock[CharIndex] = CIgnoreCommentWhiteMark);
      if (not(WhiteMarkNext)) then
      begin
        case (AOptionBlock[CharIndex]) of
          (COptionEntryAssign) :
          begin
            ReadValue := true;
          end;

          (COptionEntryEnd) :
          begin
            if SetOption(OptionName, OptionValue) then
            begin
              if (Assigned(FChangeOption)) then
              begin
                FChangeOption(OptionName, OptionValue);
              end;
            end;

            OptionName  := '';
            OptionValue := '';
            ReadValue   := false;
          end;
        else
          if ReadValue then
          begin
            OptionValue := OptionValue + AOptionBlock[CharIndex];
          end
          else
          begin
            OptionName := OptionName + AOptionBlock[CharIndex];
          end;
        end;
      end;
    end;

    Inc(CharIndex);
  end;

//!!! I know this failure-proof variant works but it's not intended to be actually implemented !!!
//  if ((Length(OptionName) > 000) or (Length(OptionValue) > 000)) then
//  begin
//    if SetOption(OptionName, OptionValue) then
//    begin
//      if (Assigned(FChangeOption)) then
//      begin
//        FChangeOption(OptionName, OptionValue);
//      end;
//    end;
//  end;
//!!! I know this failure-proof variant works but it's not intended to be actually implemented !!!
end;

procedure TABCInterpreter.NilProperties;
begin
  FChangeOption     := nil;
  FMessages         := nil;
  FReadFileValue    := nil;
  FReadScreenValue  := nil;
  FSource           := nil;
  FWriteFileValue   := nil;
  FWriteScreenValue := nil;
end;

procedure TABCInterpreter.ResetData;
begin
  ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);

  FBlockCount := 000;

  FBreakInterpretation  := false;
  FHasStackOverflow     := false;
  FIsInMainCombination  := false;
  FWasInMainCombination := false;

  ClearLocalRegisters;
  ClearNextParameters;
  ClearOwnParameters;

  FCombinations.Initialize;
  FGlobalRegisters.Initialize;
  FMemory.Clear;

  SetLength(FOptionArray, 000);
end;

procedure TABCInterpreter.SetBlockRegisters(var ASuccess : Boolean);
var
  ValRegisterA : PAnsiChar;
  ValRegisterB : PAnsiChar;
begin
  ValRegisterA := GetRegister(CBlockRegisterInBlock, CEmpty, ASuccess);
  if (ASuccess) then
  begin
    if (FBlockCount > 000) then
    begin
      ValRegisterA^ := CValue1;

      ValRegisterB := GetRegister(CBlockRegisterInBlock, CTypeLocal, ASuccess);
      if (ASuccess) then
      begin
        ValRegisterB^ := CValue1;
      end;
    end
    else
    begin
      ValRegisterA^ := CValue0;
    end;
  end;
end;

procedure TABCInterpreter.SetFlagRegister(const AAccessDone : Boolean;
                                          const AType : AnsiChar;
                                          var ASuccess : Boolean);
var
  ValRegister : PAnsiChar;
begin
  ValRegister := GetRegister(CExRegisterFlag, AType, ASuccess);
  if (ASuccess) then
  begin
    if (AAccessDone) then
    begin
      ValRegister^ := CValue1;
    end
    else
    begin
      ValRegister^ := CValue0;
    end;
  end;
end;

procedure TABCInterpreter.WriteMessage(const ALineNumber : LongWord;
                                       const AIsError : Boolean;
                                       const AErrorCode : LongWord;
                                       const AParameter : AnsiString);
var
  DoWrite  : Boolean;
  TempText : AnsiString;
begin
  if (FMessages <> nil) then
  begin
    if (AIsError) then
    begin
      if (FShowErrors) then
      begin
        DoWrite := not(FHasStackOverflow);

        if (ALineNumber > 000) then
        begin
          TempText := ('Line' + #032 + LongWordToAnsiString(ALineNumber) + #058#032);
        end
        else
        begin
          TempText := '';
        end;

        TempText := (TempText + 'Error' + #032 + LongWordToAnsiString(AErrorCode) + #032#045#032);

        case (AErrorCode) of
          (000) :
          begin
            TempText := (TempText + 'Internal Error Encountered');
          end;

          (001) :
          begin
            TempText := (TempText + 'Unknown Symbol Encountered');
          end;

          (002) :
          begin
            TempText := (TempText + 'Incomplete Operation Encountered');
          end;

          (010) :
          begin
            TempText := (TempText + 'No Main-Combination Encountered');
          end;

          (011) :
          begin
            TempText := (TempText + 'Source Behind Main-Combination Is Ignored');
          end;

          (020) :
          begin
            TempText := (TempText + 'Combination-Source Not Found');
          end;

          (021) :
          begin
            TempText := (TempText + 'Missing Combination-Beginning');
          end;

          (022) :
          begin
            TempText := (TempText + 'Missing Combination-Ending');
          end;

          (023) :
          begin
            TempText := (TempText + 'Only Allowed Within Combination');
          end;

          (024) :
          begin
            TempText := (TempText + 'Static Combination Cannot Be Redefined');
          end;

          (025) :
          begin
            TempText := (TempText + 'Combination Cannot Be Redefined When Executed');
          end;

          (030) :
          begin
            TempText := (TempText + 'Missing Block-Beginning');
          end;

          (031) :
          begin
            TempText := (TempText + 'Missing Block-Ending');
          end;

          (032) :
          begin
            TempText := (TempText + 'Only Allowed Within Block');
          end;

          (040) :
          begin
            TempText := (TempText + 'Possible Stack-Overflow Encountered');

            DoWrite := true;
          end;
        else
          TempText := (TempText + 'UNKNOWN ERROR');
        end;

        if (AParameter <> '') then
        begin
          TempText := (TempText + #032#040 + AParameter + #041);
        end;

        if (DoWrite) then
        begin
          FMessages.Add(TempText);
        end;
      end;
    end
    else
    begin
      if (FShowInformation) then
      begin
        if (ALineNumber > 000) then
        begin
          TempText := ('Line' + #032 + LongWordToAnsiString(ALineNumber) + #058#032);
        end
        else
        begin
          TempText := '';
        end;

        TempText := (TempText + AParameter);

        FMessages.Add(TempText);
      end;
    end;
  end;
end;

procedure TABCInterpreter.WriteOperation(var ADestinationText : AnsiString;
                                         var AIndex : LongWord;
                                         var ARegister : AnsiChar;
                                         var AOperator : AnsiChar;
                                         var AValue : AnsiChar;
                                         var ATypeRegister : AnsiChar;
                                         var ATypeValue : AnsiChar);
begin
  if (ARegister <> CEmpty) then
  begin
    if (IsType(ATypeRegister) and IsRegister(ARegister)) then
    begin
      Inc(AIndex);
      CheckLength(ADestinationText, AIndex, false);

      ADestinationText[AIndex] := ATypeRegister;
    end;

    Inc(AIndex);
    CheckLength(ADestinationText, AIndex, false);

    ADestinationText[AIndex] := ARegister;
  end;

  if (AOperator <> CEmpty) then
  begin
    if (IsType(ATypeRegister) and (AOperator = CCombinationUse)) then
    begin
      Inc(AIndex);
      CheckLength(ADestinationText, AIndex, false);

      ADestinationText[AIndex] := ATypeRegister;
    end;

    Inc(AIndex);
    CheckLength(ADestinationText, AIndex, false);

    ADestinationText[AIndex] := AOperator;
  end;

  if (AValue <> CEmpty) then
  begin
    if (IsType(ATypeValue) and IsRegister(AValue)) then
    begin
      Inc(AIndex);
      CheckLength(ADestinationText, AIndex, false);

      ADestinationText[AIndex] := ATypeValue;
    end;

    Inc(AIndex);
    CheckLength(ADestinationText, AIndex, false);

    ADestinationText[AIndex] := AValue;
  end;

  ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);
end;

procedure TABCInterpreter.WriteOption(var ADestinationText : AnsiString;
                                      var AIndex : LongWord;
                                      const AOptionBlock : String);
var
  Index : LongInt;
begin
  if (Length(AOptionBlock) > 000) then
  begin
    Inc(AIndex);
    CheckLength(ADestinationText, AIndex, false);

    ADestinationText[AIndex] := CIgnoreComment;

    Inc(AIndex);
    CheckLength(ADestinationText, AIndex, false);

    ADestinationText[AIndex] := COptionBlockMark;

    for Index := 001 to Length(AOptionBlock) do
    begin
      Inc(AIndex);
      CheckLength(ADestinationText, AIndex, false);

      ADestinationText[AIndex] := AOptionBlock[Index];
    end;

    Inc(AIndex);
    CheckLength(ADestinationText, AIndex, false);

    ADestinationText[AIndex] := CIgnoreComment;
  end;
end;

procedure TABCInterpreter.WriteToOptionBlock(const ATypeRegister : AnsiChar;
                                             const AValue : AnsiChar;
                                             var ASuccess : Boolean);
var
  ValRegisters : TABCRegistersItem;
begin
  ASuccess := true;
  if (ASuccess) then
  begin
    case ATypeRegister of
      CEmpty :
      begin
        FGlobalRegisters.WriteToOptionBlock(AValue);
      end;

      CTypeLocal :
      begin
        ASuccess := (FLocalRegisters.Count >= FBlockCount);
        if (ASuccess) then
        begin
          ValRegisters := FLocalRegisters.Items[Pred(FBlockCount)];

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            ValRegisters.WriteToOptionBlock(AValue);
          end;
        end;
      end;

      CTypeNextParameters :
      begin
        ASuccess := (FNextParameters.Count >= FCombinations.CombinationCount);
        if (ASuccess) then
        begin
          ValRegisters := nil;
          if (FCombinations.CombinationCount > 000) then
          begin
            ValRegisters := FNextParameters.Items[Pred(FCombinations.CombinationCount)];
          end;

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            ValRegisters.WriteToOptionBlock(AValue);
          end;
        end;
      end;

      CTypeOwnParameters :
      begin
        ASuccess := (FOwnParameters.Count >= FCombinations.CombinationCount);
        if (ASuccess) then
        begin
          ValRegisters := nil;
          if (FCombinations.CombinationCount > 000) then
          begin
            ValRegisters := FOwnParameters.Items[Pred(FCombinations.CombinationCount)];
          end;

          ASuccess := (ValRegisters <> nil);
          if (ASuccess) then
          begin
            ValRegisters.WriteToOptionBlock(AValue);
          end;
        end;
      end;
    else
      ASuccess := false;
    end;
  end;
end;

function TABCInterpreter.GetOptionCount : LongInt;
begin
  Result := Length(FOptionArray);
end;

function TABCInterpreter.GetOptionNameByIndex(const AIndex : LongInt) : AnsiString;
begin
  Result := '';

  if ((AIndex >= Low(FOptionArray)) and (AIndex <= High(FOptionArray))) then
  begin
    Result := FOptionArray[AIndex].OptionName;
  end;
end;

function TABCInterpreter.GetOptionValueByIndex(const AIndex : LongInt) : AnsiString;
begin
  Result := '';

  if ((AIndex >= Low(FOptionArray)) and (AIndex <= High(FOptionArray))) then
  begin
    Result := FOptionArray[AIndex].OptionValue;
  end;
end;

function TABCInterpreter.GetOptionValueByName(const AName : AnsiString) : AnsiString;
var
  Index : LongInt;
begin
  Result := '';

  for Index := High(FOptionArray) downto Low(FOptionArray) do
  begin
    if (AnsiStringLowerCase(AnsiStringTrim(AName)) = AnsiStringLowerCase(AnsiStringTrim(FOptionArray[Index].OptionName))) then
    begin
      Result := FOptionArray[Index].OptionValue;

      Break;
    end;
  end;
end;

constructor TABCInterpreter.Create;
begin
  inherited Create;

  FStackBegin := GetESP;

  Randomize;

  FCombinations    := TABCCombinationsItem.Create;
  FGlobalRegisters := TABCRegistersItem.Create;
  FLocalRegisters  := TABCBasicPointerList.Create;
  FMemory          := TABCAnsiCharList.Create;
  FNextParameters  := TABCBasicPointerList.Create;
  FOwnParameters   := TABCBasicPointerList.Create;

  FAllInMainCombination         := false;
  FInterpretAnalysedOptionBlock := true;
  FLineOrientedMode             := false;
  FShowErrors                   := true;
  FShowInformation              := true;
  FStackProtection              := true;

  Initialize;
  NilProperties;
end;

destructor TABCInterpreter.Destroy;
begin
  DeInitialize;
  NilProperties;

  FCombinations.Free;
  FCombinations := nil;
  FGlobalRegisters.Free;
  FGlobalRegisters := nil;
  FLocalRegisters.Free;
  FLocalRegisters := nil;
  FMemory.Free;
  FMemory := nil;

  inherited Destroy;
end;

function TABCInterpreter.AnalyseSource : Boolean;
var
  CharIndex    : LongWord;
  CurrentIndex : LongWord;
  NoError      : Boolean;
  SourceText   : AnsiString;
begin
  Result := true;

  ClearAnalysedSource;
  ClearVariables(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation);
  ClearMessages;
  ResetData;

  WriteMessage(CGeneralMessage, false, 000, 'Analysis:');

  if (FAllInMainCombination) then
  begin
    CombinationBegin(CEmpty, SourceText, CurrentIndex, Result);
  end;
  if (Result) then
  begin
    Result := (FSource <> nil);
    if (Result) then
    begin
      CurrentIndex := 000;
      SourceText   := FSource.Text;

      CheckLength(FAnalysedSource, Length(SourceText), true);

      CharIndex := 000;
      while (not(CharIndex >= Length(SourceText)) and not(not(Result) and (FWasInMainCombination))) do
      begin
        NoError := not(FWasInMainCombination);
        if (NoError) then
        begin
          AssignSymbol(GetNextAnalyseUnIgnored(SourceText, CharIndex, FAnalysedSource, CurrentIndex), FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation, NoError);
          if (NoError) then
          begin
            if (FNextExecuteOperation) then
            begin
              if (IsCombination(FNextOperator)) then
              begin
                case (FNextOperator) of
                  (CCombinationBegin) :
                  begin
                    if (FNextRegister <> CEmpty) then
                    begin
                      NoError := (not(FIsInMainCombination) or (FIsInMainCombination and not(FCombinations.CatchCombination(FNextRegister)^.Static)));
                      if (NoError) then
                      begin
                        if (not(FIsInMainCombination) and (FCombinations.CombinationCount = 000)) then
                        begin
                          FCombinations.CatchCombination(FNextRegister)^.Static := true;
                        end;
                      end;
                    end
                    else
                    begin
                      if (not(FIsInMainCombination)) then
                      begin
                        FIsInMainCombination := (FCombinations.CombinationCount = 000);
                      end;
                    end;

                    FCombinations.IncCombinationCount;
                  end;

                  (CCombinationEnd) :
                  begin
                    NoError := (FCombinations.CombinationCount > 000);
                    if (NoError) then
                    begin
                      FCombinations.DecCombinationCount;
                      if (FIsInMainCombination and (FCombinations.CombinationCount = 000)) then
                      begin
                        if (not(FWasInMainCombination)) then
                        begin
                          FWasInMainCombination := FIsInMainCombination;
                        end;
                        FIsInMainCombination := (FCombinations.CombinationCount = 000);
                      end;
                    end;
                  end;

                  (CCombinationUse) :
                  begin
                    NoError := (FCombinations.CombinationCount > 000);
                  end;
                else
                  NoError := false;
                end;

                if (not(NoError)) then
                begin
                  if ((FNextOperator = CCombinationBegin) and not(CharIndex > 000)) then
                  begin
                    // Combination-Source Not Found
                    DoError(CGeneralMessage, 020);
                  end
                  else
                  begin
                    if ((FNextOperator = CCombinationEnd) and not(FCombinations.CombinationCount > 000)) then
                    begin
                      // Missing Combination-Beginning
                      DoError(CGeneralMessage, 021);
                    end
                    else
                    begin
                      if ((FNextOperator = CCombinationUse) and not(FCombinations.CombinationCount > 000)) then
                      begin
                        // Only Allowed Within Combination
                        DoError(CGeneralMessage, 023);
                      end
                      else
                      begin
                        if ((FNextOperator = CCombinationBegin) and (FNextRegister <> CEmpty)) then
                        begin
                          if (FIsInMainCombination and FCombinations.CatchCombination(FNextRegister)^.Static) then
                          begin
                            // Static Combination Cannot Be Redefined
                            DoError(CGeneralMessage, 024);
                          end
                          else
                          begin
                            // Internal Error Encountered
                            DoError(CGeneralMessage, 000);
                          end;
                        end
                        else
                        begin
                          // Internal Error Encountered
                          DoError(CGeneralMessage, 000);
                        end;
                      end;
                    end;
                  end;
                end;
              end
              else
              begin
                NoError := (FCombinations.CombinationCount > 000);
                if (NoError) then
                begin
                  NoError := (IsAssign(FNextOperator) or IsBlock(FNextOperator) or IsCompare(FNextOperator));
                  if (not(NoError)) then
                  begin
                    // Unknown Symbol Encountered
                    DoError(GetSourceLine(CharIndex), 001);
                  end;
                end
                else
                begin
                  // Only Allowed Within Combination
                  DoError(GetSourceLine(CharIndex), 023);
                end;
              end;

              if (NoError) then
              begin
                WriteOperation(FAnalysedSource, CurrentIndex, FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue);
              end;
            end;
          end
          else
          begin
            // Unknown Symbol Encountered
             DoError(GetSourceLine(CharIndex), 001);
          end;
        end
        else
        begin
          // Source Behin Main-Combination Is Ignored
          DoError(GetSourceLine(CharIndex), 011);
        end;

        if (Result) then
        begin
          Result := NoError;
        end;
      end;

      CheckLength(FAnalysedSource, CurrentIndex, true);

      if (Result and FAllInMainCombination) then
      begin
        CombinationEnd(Result);
        if (not(Result)) then
        begin
          if (not(FCombinations.CombinationCount > 000)) then
          begin
            // Missing Combination-Beginning
            DoError(CGeneralMessage, 021);
          end
          else
          begin
            // Internal Error Encountered
            DoError(CGeneralMessage, 000);
          end;
        end;
      end;

      if (not(FWasInMainCombination) or (not(Length(FAnalysedSource) > 000) and not(FAllInMainCombination))) then
      begin
        // No Main-Combination Encountered
        DoError(CGeneralMessage, 010);

        Result := false;
      end;

      while (FCombinations.CombinationCount > 000) do
      begin
        // Missing Combination-Ending
        DoError(CGeneralMessage, 022);
        FCombinations.DecCombinationCount;

        Result := false;
      end;
    end;
  end
  else
  begin
    // Internal Error Encountered
    DoError(CGeneralMessage, 000);
  end;

  if (not(VariablesEmpty(FNextRegister, FNextOperator, FNextValue, FNextTypeRegister, FNextTypeValue, FNextExecuteOperation))) then
  begin
    // Incomplete Operation Encountered
    DoError(CGeneralMessage, 002);

    Result := false;
  end;
end;

function TABCInterpreter.InterpretSource : Boolean;
var
  CombinationIndex      : LongWord;
  CombinationSourceText : AnsiString;
  Index                 : LongWord;
begin
  Result := true;

  ClearMessages;
  ResetData;

  WriteMessage(CGeneralMessage, false, 000, 'Interpretation:');

  if (FAllInMainCombination) then
  begin
    CombinationBegin(CEmpty, CombinationSourceText, CombinationIndex, Result);
  end;
  if (Result) then
  begin
    if (FLineOrientedMode) then
    begin
      Result := (FSource <> nil);
      if (Result) then
      begin
        if (FSource.Count > 000) then
        begin
          for Index := 000 to Pred(FSource.Count) do
          begin
            Interpret(FSource.Items[Index], Result);
            if (not(Result)) then
            begin
              Break;
            end;
          end;
        end;
      end;
    end
    else
    begin
      if (Length(FAnalysedSource) > 000) then
      begin
        Interpret(FAnalysedSource, Result);
      end;
    end;

    // Interpretation Was Quit:
    // Set Everything So That No Error Will Occur
    if (FBreakInterpretation) then
    begin
      Result := true;

      ResetData;
      FWasInMainCombination := true;
    end;

    if (Result and FAllInMainCombination) then
    begin
      CombinationEnd(Result);
      if (not(Result)) then
      begin
        if (not(FCombinations.CombinationCount > 000)) then
        begin
          // Missing Combination-Beginning
          DoError(CGeneralMessage, 021);
        end
        else
        begin
          // Internal Error Encountered
          DoError(CGeneralMessage, 000);
        end;
      end;
    end;

    if (not(FWasInMainCombination) or (not(Length(FAnalysedSource) > 000) and not(FAllInMainCombination or FLineOrientedMode))) then
    begin
      // No Main-Combination Encountered
      DoError(CGeneralMessage, 010);

      Result := false;
    end;

    while (FBlockCount > 000) do
    begin
      // Missing Block-Ending
      DoError(CGeneralMessage, 031);
      Dec(FBlockCount);

      Result := false;
    end;

    while (FCombinations.CombinationCount > 000) do
    begin
      // Missing Combination-Ending
      DoError(CGeneralMessage, 022);
      FCombinations.DecCombinationCount;

      Result := false;
    end;
  end
  else
  begin
    // Internal Error Encountered
    DoError(CGeneralMessage, 000);
  end;
end;

procedure TABCInterpreter.DeInitialize;
begin
  ClearAnalysedSource;
  ResetData;
end;

procedure TABCInterpreter.Initialize;
begin
  ClearAnalysedSource;
  ResetData;
end;

end.
