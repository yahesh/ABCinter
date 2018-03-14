unit ABCsymU;

// DON'T DELETE THIS COMMENT !!!

{ "AlPhAbEt" - Interpreter }

{--------------------------------------------}
{ Unit:     ABCsymU.pas                      }
{ Version:  0.24                             }
{                                            }
{ Coder:    Yahe <hello@yahe.sh>             }
{                                            }
{ I'm NOT Liable For Damages Of ANY Kind !!! }
{--------------------------------------------}

// DON'T DELETE THIS COMMENT !!!

interface

{$I ABCcompI.inc}

const
  CEmpty = #000; // EMPTY

  CAssignAnd           = #043; // "+"
  CAssignBecomes       = #062; // ">"
  CAssignBecomesNot    = #060; // "<"
  CAssignCheckMemEmpty = #095; // "_"
  CAssignCheckMemEntry = #035; // "#"
  CAssignOr            = #045; // "-"
  CAssignReadMem       = #058; // ":"
  CAssignTouchMemFirst = #040; // "("
  CAssignTouchMemLast  = #041; // ")"
  CAssignWriteMem      = #059; // ";"
  CAssignXOr           = #037; // "%"
  CAssignArray : array [001 .. 011] of AnsiChar = (CAssignAnd,
                                                   CAssignBecomes,
                                                   CAssignBecomesNot,
                                                   CAssignCheckMemEmpty,
                                                   CAssignCheckMemEntry,
                                                   CAssignOr,
                                                   CAssignReadMem,
                                                   CAssignTouchMemFirst,
                                                   CAssignTouchMemLast,
                                                   CAssignWriteMem,
                                                   CAssignXOr);
  CAssignSet   : set                of AnsiChar = [CAssignAnd,
                                                   CAssignBecomes,
                                                   CAssignBecomesNot,
                                                   CAssignCheckMemEmpty,
                                                   CAssignCheckMemEntry,
                                                   CAssignOr,
                                                   CAssignReadMem,
                                                   CAssignTouchMemFirst,
                                                   CAssignTouchMemLast,
                                                   CAssignWriteMem,
                                                   CAssignXOr];

  CBlockBegin = #091; // "["
  CBlockEnd   = #093; // "]"
  CBlockArray : array [001 .. 002] of AnsiChar = (CBlockBegin,
                                                  CBlockEnd);
  CBlockSet   : set                of AnsiChar = [CBlockBegin,
                                                  CBlockEnd];

  CBlockRegisterInBlock  = #126; // "~"
  CBlockRegisterResidual = #124; // "|"
  CBlockRegisterArray : array [001 .. 002] of AnsiChar = (CBlockRegisterInBlock,
                                                          CBlockRegisterResidual);
  CBlockRegisterSet   : set                of AnsiChar = [CBlockRegisterInBlock,
                                                          CBlockRegisterResidual];

  CCombinationBegin = #123; // "{"
  CCombinationEnd   = #125; // "}"
  CCombinationUse   = #038; // "&"
  CCombinationArray : array [001 .. 003] of AnsiChar = (CCombinationBegin,
                                                        CCombinationEnd,
                                                        CCombinationUse);
  CCombinationSet   : set                of AnsiChar = [CCombinationBegin,
                                                        CCombinationEnd,
                                                        CCombinationUse];

  CCompareIf       = #061; // "="
  CCompareIfNot    = #033; // "!"
  CCompareWhile    = #042; // "*"
  CCompareWhileNot = #047; // "/"
  CCompareArray : array [001 .. 004] of AnsiChar = (CCompareIf,
                                                    CCompareIfNot,
                                                    CCompareWhile,
                                                    CCompareWhileNot);
  CCompareSet   : set                of AnsiChar = [CCompareIf,
                                                    CCompareIfNot,
                                                    CCompareWhile,
                                                    CCompareWhileNot];

  CExRegister0    = #048; // "0"
  CExRegister1    = #049; // "1"
  CExRegister2    = #050; // "2"
  CExRegister3    = #051; // "3"
  CExRegister4    = #052; // "4"
  CExRegister5    = #053; // "5"
  CExRegister6    = #054; // "6"
  CExRegister7    = #055; // "7"
  CExRegister8    = #056; // "8"
  CExRegister9    = #057; // "9"
  CExRegisterFlag = #036; // "$"
  CExRegisterArray : array [001 .. 011] of AnsiChar = (CExRegister0,
                                                       CExRegister1,
                                                       CExRegister2,
                                                       CExRegister3,
                                                       CExRegister4,
                                                       CExRegister5,
                                                       CExRegister6,
                                                       CExRegister7,
                                                       CExRegister8,
                                                       CExRegister9,
                                                       CExRegisterFlag);
  CExRegisterSet   : set                of AnsiChar = [CExRegister0,
                                                       CExRegister1,
                                                       CExRegister2,
                                                       CExRegister3,
                                                       CExRegister4,
                                                       CExRegister5,
                                                       CExRegister6,
                                                       CExRegister7,
                                                       CExRegister8,
                                                       CExRegister9,
                                                       CExRegisterFlag];

  CHiRegisterA = #065; // "A"
  CHiRegisterB = #066; // "B"
  CHiRegisterC = #067; // "C"
  CHiRegisterD = #068; // "D"
  CHiRegisterE = #069; // "E"
  CHiRegisterF = #070; // "F"
  CHiRegisterG = #071; // "G"
  CHiRegisterH = #072; // "H"
  CHiRegisterI = #073; // "I"
  CHiRegisterJ = #074; // "J"
  CHiRegisterK = #075; // "K"
  CHiRegisterL = #076; // "L"
  CHiRegisterM = #077; // "M"
  CHiRegisterN = #078; // "N"
  CHiRegisterO = #079; // "O"
  CHiRegisterP = #080; // "P"
  CHiRegisterQ = #081; // "Q"
  CHiRegisterR = #082; // "R"
  CHiRegisterS = #083; // "S"
  CHiRegisterT = #084; // "T"
  CHiRegisterU = #085; // "U"
  CHiRegisterV = #086; // "V"
  CHiRegisterW = #087; // "W"
  CHiRegisterX = #088; // "X"
  CHiRegisterY = #089; // "Y"
  CHiRegisterZ = #090; // "Z"
  CHiRegisterArray : array [001 .. 026] of AnsiChar = (CHiRegisterA,
                                                       CHiRegisterB,
                                                       CHiRegisterC,
                                                       CHiRegisterD,
                                                       CHiRegisterE,
                                                       CHiRegisterF,
                                                       CHiRegisterG,
                                                       CHiRegisterH,
                                                       CHiRegisterI,
                                                       CHiRegisterJ,
                                                       CHiRegisterK,
                                                       CHiRegisterL,
                                                       CHiRegisterM,
                                                       CHiRegisterN,
                                                       CHiRegisterO,
                                                       CHiRegisterP,
                                                       CHiRegisterQ,
                                                       CHiRegisterR,
                                                       CHiRegisterS,
                                                       CHiRegisterT,
                                                       CHiRegisterU,
                                                       CHiRegisterV,
                                                       CHiRegisterW,
                                                       CHiRegisterX,
                                                       CHiRegisterY,
                                                       CHiRegisterZ);
  CHiRegisterSet   : set                of AnsiChar = [CHiRegisterA,
                                                       CHiRegisterB,
                                                       CHiRegisterC,
                                                       CHiRegisterD,
                                                       CHiRegisterE,
                                                       CHiRegisterF,
                                                       CHiRegisterG,
                                                       CHiRegisterH,
                                                       CHiRegisterI,
                                                       CHiRegisterJ,
                                                       CHiRegisterK,
                                                       CHiRegisterL,
                                                       CHiRegisterM,
                                                       CHiRegisterN,
                                                       CHiRegisterO,
                                                       CHiRegisterP,
                                                       CHiRegisterQ,
                                                       CHiRegisterR,
                                                       CHiRegisterS,
                                                       CHiRegisterT,
                                                       CHiRegisterU,
                                                       CHiRegisterV,
                                                       CHiRegisterW,
                                                       CHiRegisterX,
                                                       CHiRegisterY,
                                                       CHiRegisterZ];

  CIgnoreComment          = #064; // "@"
  CIgnoreCommentWhiteMark = #047; // "/"
  CIgnoreSpace            = #032; // SPACE
  CIgnoreTab              = #009; // TAB
  CIgnoreArray : array [001 .. 003] of AnsiChar = (CIgnoreComment,
                                                   CIgnoreSpace,
                                                   CIgnoreTab);
  CIgnoreSet   : set                of AnsiChar = [CIgnoreComment,
                                                   CIgnoreSpace,
                                                   CIgnoreTab];

  CLoRegisterA = #097; // "a"
  CLoRegisterB = #098; // "b"
  CLoRegisterC = #099; // "c"
  CLoRegisterD = #100; // "d"
  CLoRegisterE = #101; // "e"
  CLoRegisterF = #102; // "f"
  CLoRegisterG = #103; // "g"
  CLoRegisterH = #104; // "h"
  CLoRegisterI = #105; // "i"
  CLoRegisterJ = #106; // "j"
  CLoRegisterK = #107; // "k"
  CLoRegisterL = #108; // "l"
  CLoRegisterM = #109; // "m"
  CLoRegisterN = #110; // "n"
  CLoRegisterO = #111; // "o"
  CLoRegisterP = #112; // "p"
  CLoRegisterQ = #113; // "q"
  CLoRegisterR = #114; // "r"
  CLoRegisterS = #115; // "s"
  CLoRegisterT = #116; // "t"
  CLoRegisterU = #117; // "u"
  CLoRegisterV = #118; // "v"
  CLoRegisterW = #119; // "w"
  CLoRegisterX = #120; // "x"
  CLoRegisterY = #121; // "y"
  CLoRegisterZ = #122; // "z"
  CLoRegisterArray : array [001 .. 026] of AnsiChar = (CLoRegisterA,
                                                       CLoRegisterB,
                                                       CLoRegisterC,
                                                       CLoRegisterD,
                                                       CLoRegisterE,
                                                       CLoRegisterF,
                                                       CLoRegisterG,
                                                       CLoRegisterH,
                                                       CLoRegisterI,
                                                       CLoRegisterJ,
                                                       CLoRegisterK,
                                                       CLoRegisterL,
                                                       CLoRegisterM,
                                                       CLoRegisterN,
                                                       CLoRegisterO,
                                                       CLoRegisterP,
                                                       CLoRegisterQ,
                                                       CLoRegisterR,
                                                       CLoRegisterS,
                                                       CLoRegisterT,
                                                       CLoRegisterU,
                                                       CLoRegisterV,
                                                       CLoRegisterW,
                                                       CLoRegisterX,
                                                       CLoRegisterY,
                                                       CLoRegisterZ);
  CLoRegisterSet   : set                of AnsiChar = [CLoRegisterA,
                                                       CLoRegisterB,
                                                       CLoRegisterC,
                                                       CLoRegisterD,
                                                       CLoRegisterE,
                                                       CLoRegisterF,
                                                       CLoRegisterG,
                                                       CLoRegisterH,
                                                       CLoRegisterI,
                                                       CLoRegisterJ,
                                                       CLoRegisterK,
                                                       CLoRegisterL,
                                                       CLoRegisterM,
                                                       CLoRegisterN,
                                                       CLoRegisterO,
                                                       CLoRegisterP,
                                                       CLoRegisterQ,
                                                       CLoRegisterR,
                                                       CLoRegisterS,
                                                       CLoRegisterT,
                                                       CLoRegisterU,
                                                       CLoRegisterV,
                                                       CLoRegisterW,
                                                       CLoRegisterX,
                                                       CLoRegisterY,
                                                       CLoRegisterZ];

  COptionBlockMark   = #092; // "\"
  COptionEntryAssign = #062; // ">"
  COptionEntryEnd    = #060; // "<"
  COptionArray : array [001 .. 003] of AnsiChar = (COptionBlockMark,
                                                   COptionEntryAssign,
                                                   COptionEntryEnd);
  COptionSet   : set                of AnsiChar = [COptionBlockMark,
                                                   COptionEntryAssign,
                                                   COptionEntryEnd];

  COptionRegister = #092; // "\"
  COptionRegisterArray : array [001 .. 001] of AnsiChar = (COptionRegister);
  COptionRegisterSet   : set                of AnsiChar = [COptionRegister];

  CRandomValue = #063; // "?"
  CRandomValueArray : array [001 .. 001] of AnsiChar = (CRandomValue);
  CRandomValueSet   : set                of AnsiChar = [CRandomValue];

  CTypeLocal          = #094; // "^"
  CTypeNextParameters = #034; // """
  CTypeOwnParameters  = #039; // "'"
  CTypeArray : array [001 .. 003] of AnsiChar = (CTypeLocal,
                                                 CTypeNextParameters,
                                                 CTypeOwnParameters);
  CTypeSet   : set                of AnsiChar = [CTypeLocal,
                                                 CTypeNextParameters,
                                                 CTypeOwnParameters];

  CValue0 = #046; // "."
  CValue1 = #044; // ","
  CValueArray : array [001 .. 002] of AnsiChar = (CValue0,
                                                  CValue1);
  CValueSet   : set                of AnsiChar = [CValue0,
                                                  CValue1];

function IsAssign(const AValue : AnsiChar) : Boolean;
function IsBlock(const AValue : AnsiChar) : Boolean;
function IsBlockRegister(const AValue : AnsiChar) : Boolean;
function IsCombination(const AValue : AnsiChar) : Boolean;
function IsCompare(const AValue : AnsiChar) : Boolean;
function IsExRegister(const AValue : AnsiChar) : Boolean;
function IsHiRegister(const AValue : AnsiChar) : Boolean;
function IsIgnore(const AValue : AnsiChar) : Boolean;
function IsLoRegister(const AValue : AnsiChar) : Boolean;
function IsOption(const AValue : AnsiChar) : Boolean;
function IsOptionRegister(const AValue : AnsiChar) : Boolean;
function IsRandomValue(const AValue : AnsiChar) : Boolean;
function IsRegister(const AValue : AnsiChar) : Boolean;
function IsType(const AValue : AnsiChar) : Boolean;
function IsValue(const AValue : AnsiChar) : Boolean;
function ValueNot(const AValue : AnsiChar) : AnsiChar;

implementation

function IsAssign(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CAssignSet);
end;

function IsBlock(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CBlockSet);
end;

function IsBlockRegister(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CBlockRegisterSet);
end;

function IsCombination(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CCombinationSet);
end;

function IsCompare(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CCompareSet);
end;

function IsExRegister(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CExRegisterSet);
end;

function IsHiRegister(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CHiRegisterSet);
end;

function IsIgnore(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CIgnoreSet);
end;

function IsLoRegister(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CLoRegisterSet);
end;

function IsOption(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in COptionSet);
end;

function IsOptionRegister(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in COptionRegisterSet);
end;

function IsRandomValue(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CRandomValueSet);
end;

function IsRegister(const AValue : AnsiChar) : Boolean;
begin
  Result := (IsBlockRegister(AValue) or
             IsExRegister(AValue) or
             IsHiRegister(AValue) or
             IsLoRegister(AValue) or
             IsOptionRegister(AValue));
end;

function IsType(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CTypeSet);
end;

function IsValue(const AValue : AnsiChar) : Boolean;
begin
  Result := (AValue in CValueSet);
end;

function ValueNot(const AValue : AnsiChar) : AnsiChar;
begin
  case AValue of
    CValue0 : Result := CValue1;
    CValue1 : Result := CValue0;
  else
    Result := AValue;
  end;
end;

end.
