{* ABCcompI.inc *}

// DON'T DELETE THIS COMMENT !!!

{ "AlPhAbEt" - Interpreter }

{--------------------------------------------}
{ Unit:     ABCcompI.inc                     }
{ Version:  0.24                             }
{                                            }
{ Coder:    Yahe <hello@yahe.sh>             }
{                                            }
{ I'm NOT Liable For Damages Of ANY Kind !!! }
{--------------------------------------------}

// DON'T DELETE THIS COMMENT !!!

(* Compiler-Directives *)

// Implementation of a very rudimentary Stack-Overflow - Protection.
const
  CMaxUsedStackSize = $00100000;

{$MaxStackSize $00102000} // number needs to be bigger than CMaxUsedStackSize
// Implementation of a very rudimentary Stack-Overflow - Protection.

// -----

{.$Define UseAssertions}
{.$Define UseDebug}

// -----

{$Define DelphiBooleval}
{$Define DelphiExtendedsyntax}
{$Define DelphiIOChecks}
{$Define DelphiLongstrings}
{$Define DelphiOpenstrings}
{$Define DelphiOptimization}
{$Define DelphiOverflowchecks}
{$Define DelphiRangechecks}
{$Define DelphiStackframes}
{$Define DelphiTypedaddress}
{$Define DelphiVarstringchecks}
{.$Define DelphiWritableconst}

// -----

{$IfDef UseAssertions}
{$ASSERTIONS ON}
{$Else}
{$ASSERTIONS OFF}
{$EndIf UseAssertions}

{$IfDef UseDebug}
{$DEBUGINFO ON}
{$DEFINITIONINFO ON}
{$LOCALSYMBOLS ON}
{$REFERENCEINFO ON}
{$Else}
{$DEBUGINFO OFF}
{$DEFINITIONINFO OFF}
{$LOCALSYMBOLS OFF}
{$REFERENCEINFO OFF}
{$EndIf UseDebug}


// -----

{$IfDef DelphiBooleval}
{$BOOLEVAL ON}
{$Else}
{$BOOLEVAL OFF}
{$EndIf DelphiBooleval}

{$IfDef DelphiExtendedsyntax}
{$EXTENDEDSYNTAX ON}
{$Else}
{$EXTENDEDSYNTAX OFF}
{$EndIf DelphiExtendedsyntax}

{$IfDef DelphiIOChecks}
{$IOCHECKS ON}
{$Else}
{$IOCHECKS OFF}
{$EndIf DelphiIOChecks}

{$IfDef DelphiLongstrings}
{$LONGSTRINGS ON}
{$Else}
{$LONGSTRINGS OFF}
{$EndIf}

{$IfDef DelphiOpenstrings}
{$OPENSTRINGS ON}
{$Else}
{$OPENSTRINGS OFF}
{$EndIf DelphiOpenstrings}

{$IfDef DelphiOptimization}
{$OPTIMIZATION ON}
{$Else}
{$OPTIMIZATION OFF}
{$EndIf DelphiOptimization}

{$IfDef DelphiOverflowchecks}
{$OVERFLOWCHECKS ON}
{$Else}
{$OVERFLOWCHECKS OFF}
{$EndIf DelphiOverflowchecks}

{$IfDef DelphiRangechecks}
{$RANGECHECKS ON}
{$Else}
{$RANGECHECKS OFF}
{$EndIf DelphiRangechecks}

{$IfDef DelphiStackframes}
{$STACKFRAMES ON}
{$Else}
{$STACKFRAMES OFF}
{$EndIf DelphiStackframes}

{$IfDef DelphiTypedaddress}
{$TYPEDADDRESS ON}
{$Else}
{$TYPEDADDRESS OFF}
{$EndIf DelphiTypedaddress}

{$IfDef DelphiVarstringchecks}
{$VARSTRINGCHECKS ON}
{$Else}
{$VARSTRINGCHECKS OFF}
{$EndIf DelphiVarstringchecks}

{$IfDef DelphiWritableconst}
{$WRITEABLECONST ON}
{$Else}
{$WRITEABLECONST OFF}
{$EndIf DelphiWritableconst}
