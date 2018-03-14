unit InputF;

interface

uses
  StdCtrls,
  Spin,
  Forms,
  Controls,
  Classes;

type
  TInputForm = class(TForm)
    CancelButton  : TButton;
    InputEdit     : TEdit;
    InputLabel    : TLabel;
    InputSpinEdit : TSpinEdit;
    OKButton      : TButton;

    procedure CancelButtonClick(Sender : TObject);
    procedure InputEditChange(Sender : TObject);
    procedure InputEditKeyUp(Sender : TObject;
                             var Key : Word;
                             Shift : TShiftState);
    procedure InputSpinEditChange(Sender : TObject);
    procedure InputSpinEditKeyUp(Sender : TObject;
                                 var Key : Word;
                                 Shift : TShiftState);
    procedure OKButtonClick(Sender : TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    FDone : Boolean;

    procedure GetInput(const ADefault : AnsiChar);
  end;

var
  InputForm : TInputForm;

implementation

{$R *.dfm}

procedure TInputForm.CancelButtonClick(Sender : TObject);
begin
  Close;
end;

procedure TInputForm.GetInput(const ADefault: AnsiChar);
begin
  FDone := false;
  InputSpinEdit.Value := Byte(ADefault);

  ShowModal;
end;

procedure TInputForm.InputEditChange(Sender : TObject);
begin
  if (Length(InputEdit.Text) >= 001) then
  begin
    InputSpinEdit.Value := Ord(InputEdit.Text[001]);
  end;
end;

procedure TInputForm.InputEditKeyUp(Sender : TObject;
                                    var Key : Word;
                                    Shift : TShiftState);
begin
  if (Key = 013) then
  begin
    OKButtonClick(nil);

    Key := 000;
  end;
  if (Key = 027) then
  begin
    CancelButtonClick(nil);

    Key := 000;
  end;
end;

procedure TInputForm.InputSpinEditChange(Sender : TObject);
begin
  if (Length(InputSpinEdit.Text) >= 001) then
  begin
    InputEdit.Text := AnsiChar(InputSpinEdit.Value);
  end
  else
  begin
    InputEdit.Text := '';
  end;
end;

procedure TInputForm.InputSpinEditKeyUp(Sender : TObject;
                                        var Key : Word;
                                        Shift : TShiftState);
begin
  if (Key = 013) then
  begin
    OKButtonClick(nil);

    Key := 000;
  end;
  if (Key = 027) then
  begin
    CancelButtonClick(nil);

    Key := 000;
  end;
end;

procedure TInputForm.OKButtonClick(Sender : TObject);
begin
  FDone := true;

  Close;
end;

end.
