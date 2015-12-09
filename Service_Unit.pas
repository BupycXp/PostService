unit Service_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TServiceOVOMail = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ServiceOVOMail: TServiceOVOMail;

implementation

uses unit1;

{$R *.DFM}

procedure GetMail();
begin
  OutputDebugString('Работает');
  sleep(5000);
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServiceOVOMail.Controller(CtrlCode);
end;

function TServiceOVOMail.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TServiceOVOMail.ServiceAfterInstall(Sender: TService);
begin
  ShowMessage('Успешно установленна');
end;

procedure TServiceOVOMail.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
  GetMail();
  end;

end;

procedure TServiceOVOMail.ServiceStart(Sender: TService; var Started: Boolean);
begin
  GetMail();
end;

end.
