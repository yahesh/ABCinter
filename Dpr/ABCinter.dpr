program ABCinter;

uses
  Forms,
  MainF in '..\Pas_KN\MainF.pas' {MainForm},
  InputF in '..\Pas_KN\InputF.pas' {InputForm};

{$R *.res}

begin
  Application.Initialize;

  Application.Title := 'AlPhAbEt - Interpreter';

  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInputForm, InputForm);
  
  Application.Run;
end.
