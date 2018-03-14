unit ABCtuseU;

// DON'T DELETE THIS COMMENT !!!

{ "AlPhAbEt" - Interpreter }

{--------------------------------------------}
{ Unit:     ABCtuseU.pas                     }
{ Version:  0.24                             }
{                                            }
{ Coder:    Yahe <hello@yahe.sh>             }
{                                            }
{ I'm NOT Liable For Damages Of ANY Kind !!! }
{--------------------------------------------}

// DON'T DELETE THIS COMMENT !!!

interface

uses
  ABCsymU;

{$I ABCcompI.inc}

const
  CDecimalChars : array [000 .. 009] of AnsiChar = (#048,
                                                    #049,
                                                    #050,
                                                    #051,
                                                    #052,
                                                    #053,
                                                    #054,
                                                    #055,
                                                    #056,
                                                    #057); // needed by LongIntToAnsiString, LongWordToAnsiString,

  CDefaultValue   = CValue0;  // needed by TABCRegisterItems, TABCInterpreter
  CDeltaSize      = 025;      // needed by TABCBasicPointerList
  CGeneralMessage = 000;      // needed by TABCInterpreter;
  CNewLine        = #013#010; // needed by TABCInterpreter (LF+CR)

function AnsiStringLowerCase(const AAnsiString : AnsiString) : AnsiString; // needed by TABCInterpreter
function AnsiStringTrim(const AAnsiString : AnsiString) : AnsiString; // needed by TABCInterpreter
function GetESP : LongWord; // needed by TABCInterpreter
function IntPower(const ABase : Extended;
                  const AExponent : LongInt) : Extended; // needed by TABCInterpreter
function LongWordToAnsiString(const ALongWord : LongWord) : AnsiString; // needed by TABCInterpreter

implementation

function AnsiStringLowerCase(const AAnsiString : AnsiString) : AnsiString; // needed by TABCInterpreter
var
  Index : LongInt;
begin
  SetLength(Result, Length(AAnsiString));

  for Index := 001 to Length(AAnsiString) do
  begin
    if (AAnsiString[Index] in [#065 .. #090]) then
    begin
      Result[Index] := Chr(Ord(AAnsiString[Index]) + 032);
    end
    else
    begin
      Result[Index] := AAnsiString[Index];
    end;
  end;
end;

function AnsiStringTrim(const AAnsiString : AnsiString) : AnsiString;
var
  HighIndex : LongInt;
  LowIndex  : LongInt;
  MaxIndex  : LongInt;
begin
  Result := '';

  MaxIndex := Length(AAnsiString);

  HighIndex := MaxIndex;
  LowIndex  := 001;

  while (LowIndex <= MaxIndex) do
  begin
    if (AAnsiString[LowIndex] <= #032) then
    begin
      Inc(LowIndex);
    end
    else
    begin
      Break;
    end;
  end;
  while (HighIndex >= 001) do
  begin
    if (AAnsiString[HighIndex] <= #032) then
    begin
      Dec(HighIndex);
    end
    else
    begin
      Break;
    end;
  end;

  if (((LowIndex >= 001) and (LowIndex <= MaxIndex)) and
      ((HighIndex >= 001) and (HighIndex <= MaxIndex)) and
      (LowIndex <= HighIndex)) then
  begin
    Result := Copy(AAnsiString, LowIndex, Succ(HighIndex - LowIndex));
  end;
end;

function GetESP : LongWord;
asm
  MOV Result, ESP
end;

function IntPower(const ABase : Extended;
                  const AExponent : LongInt) : Extended;
asm
  MOV    ECX, EAX
  CDQ
  FLD1                                                                          { Result := 1 }
  XOR    EAX, EDX
  SUB    EAX, EDX                                                               { EAX := Abs(AExponent) }
  JZ     @@3
  FLD    ABase
  JMP    @@2
@@1:
  FMUL   ST, ST                                                                 { X := ABase * ABase }
@@2:
  SHR    EAX, 001
  JNC    @@1
  FMUL   ST(1), ST                                                              { Result := Result * X }
  JNZ    @@1
  FSTP   ST                                                                     { pop X from FPU stack }
  CMP    ECX, 000
  JGE    @@3
  FLD1
  FDIVRP                                                                        { Result := 1 / Result }
@@3:
  FWAIT
end;

function LongWordToAnsiString(const ALongWord : LongWord) : AnsiString;
var
  BuffLongWord : LongWord;
begin
  if (ALongWord = 000) then
  begin
    Result := CDecimalChars[Low(CDecimalChars)]
  end
  else
  begin
    Result := '';

    BuffLongWord := ALongWord;
    while (BuffLongWord <> 000) do
    begin
      Result := (CDecimalChars[(BuffLongWord - ((BuffLongWord div Length(CDecimalChars)) * Length(CDecimalChars)))] + Result);

      BuffLongWord := (BuffLongWord div Length(CDecimalChars));
    end;
  end;
end;

end.
