unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TForm3 = class(TForm)
    SpinEdit1: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses unit1;

procedure TForm3.Button1Click(Sender: TObject);
begin
  time_check := Form3.SpinEdit1.Value.ToString + ':' +
    Form3.SpinEdit2.Value.ToString + ':' + Form3.SpinEdit3.Value.ToString;
  Form1.Timer.Enabled := True;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  SpinEdit1.MaxValue := 23;
  SpinEdit2.MaxValue := 60;
  SpinEdit3.MaxValue := 60;

  SpinEdit1.Value := hh;
  SpinEdit2.Value := mm;
  SpinEdit3.Value := ss;
end;

procedure TForm3.SpinEdit1Change(Sender: TObject);
begin
  Form1.Timer.Enabled := false;
  if SpinEdit1.Value = 23 then
    SpinEdit2.MaxValue := 59

  else
  begin
    SpinEdit2.MaxValue := 60;
    SpinEdit3.MaxValue := 60;
  end;
end;

procedure TForm3.SpinEdit2Change(Sender: TObject);
begin
  Form1.Timer.Enabled := false;
  if (SpinEdit1.Value = 23) and (SpinEdit2.Value = 59) then
  begin
    SpinEdit2.MaxValue := 59;
    SpinEdit3.MaxValue := 59;
  end
  else
  begin
    SpinEdit2.MaxValue := 60;
    SpinEdit3.MaxValue := 60;
  end;

  if SpinEdit2.Value > 59 then
  begin
    SpinEdit2.Value := 0;
    SpinEdit1.Text := IntToStr(SpinEdit1.Value + 1);
  end;
end;

procedure TForm3.SpinEdit3Change(Sender: TObject);
begin
  Form1.Timer.Enabled := false;
  if SpinEdit3.Value > 59 then
  begin
    SpinEdit3.Value := 0;
    SpinEdit2.Text := IntToStr(SpinEdit2.Value + 1);
  end;
end;

end.
