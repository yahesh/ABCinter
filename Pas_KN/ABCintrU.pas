unit ABCintrU;

// DON'T DELETE THIS COMMENT !!!

{ "AlPhAbEt" - Interpreter }

{--------------------------------------------}
{ Unit:     ABCintrU.pas                     }
{ Version:  0.24                             }
{                                            }
{ Coder:    Yahe <hello@yahe.sh>             }
{                                            }
{ I'm NOT Liable For Damages Of ANY Kind !!! }
{--------------------------------------------}

// DON'T DELETE THIS COMMENT !!!

(* WRAPPER-UNIT *)

interface

uses
  ABCtypeU;

{$I ABCcompI.inc}

type
  TAnsiStringList = class(TABCAnsiStringList);
  TInterpreter    = class(TABCInterpreter);

  TReadValueMethod =  TABCReadValueMethod;
  TWriteValueMethod = TABCWriteValueMethod;

implementation

end.
