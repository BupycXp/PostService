unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdPOP3, Vcl.StdCtrls, IdMessageCoder, IdMessageCoderMIME, IdAttachmentFile,
  Vcl.Menus, Vcl.ExtCtrls, DateUtils, Vcl.ComCtrls, IdSMTPBase, IdSMTP,
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, IdCoder, IdCoder3to4,
  IdCoderMIME;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    IdPOP31: TIdPOP3;
    IdMessage1: TIdMessage;
    Timer_mail: TTimer;
    Timer: TTimer;
    TrayIcon1: TTrayIcon;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_address: TEdit;
    Edit_port: TEdit;
    Edit_login: TEdit;
    Edit_pass: TEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Panel3: TPanel;
    Label5: TLabel;
    Edit_recipient_smtp: TEdit;
    Edit_subject_smtp: TEdit;
    Label6: TLabel;
    IdSMTP1: TIdSMTP;
    Panel4: TPanel;
    Edit_smtp_server: TEdit;
    Label7: TLabel;
    Edit_user_smtp: TEdit;
    Label8: TLabel;
    Edit_pass_smtp: TEdit;
    Label9: TLabel;
    Edit_sender_smtp: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Memo_body_smtp: TMemo;
    Label12: TLabel;
    Button2: TButton;
    Label13: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    XMLDocument1: TXMLDocument;
    IdDecoderMIME1: TIdDecoderMIME;
    IdEncoderMIME1: TIdEncoderMIME;
    OpenDialog1: TOpenDialog;
    Edit_port_smtp: TEdit;
    N2: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Timer_mailTimer(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N2Click(Sender: TObject);
  private
    procedure WMsysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MyTime: TTime;
  AccessClose: Boolean = false;
  time_check: string;
  hh: Cardinal;
  mm: Cardinal;
  ss: Cardinal;

implementation

{$R *.dfm}

uses unit2;

procedure TForm1.WMsysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = 01 then
    Form3.ShowModal
  else
    inherited;

end;

procedure Time_decode_format(s:string);
var
temp:string;
begin
    temp:=copy(s, 0, pos(':',s)-1);
    hh := StrToInt(temp); // часы
    delete(s, 1,pos(':',s));
    temp:=copy(s, 0, pos(':',s)-1);
    mm := StrToInt(temp); // минуты
    delete(s, 1,pos(':',s));
    ss := StrToInt(s); // секунды
    Form1.Timer_mail.Interval := (ss + (mm * 60) + (hh * 60 * 60)) * 1000;
end;

procedure TForm1.Button1Click(Sender: TObject);
const
  Ar: array [1 .. 12] of string = ('Январь', 'Февраль', 'Март', 'Апрель', 'Май',
    'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь');
var
  j, i: integer;
  Ds: TDate;
  d, g: string;
  m: integer;
  filen: string;
  f: TextFile;
begin
  TrayIcon1.BalloonTitle := 'Почта МВД';
  Label13.Caption := '';
  AssignFile(f, ExtractFilePath(Application.ExeName) + 'log.txt');
  if FileExists(ExtractFilePath(Application.ExeName) + 'log.txt') = true then
    Append(f)
  else
    Rewrite(f);
  try
    IdPOP31.Host := Edit_address.Text;
    IdPOP31.Port := StrToInt(Edit_port.Text);
    IdPOP31.Password := Edit_pass.Text;
    IdPOP31.Username := Edit_login.Text;
    IdPOP31.Connect();

    Memo1.Lines.Add(DateTimeToStr(now) + '>' + 'Подключились!');
    if IdPOP31.CheckMessages > 0 then
    begin
      Memo1.Lines.Add(DateTimeToStr(now) + '>' + 'В почтовом ящике ' +
        IntToStr(IdPOP31.CheckMessages) + ' писем');
      TrayIcon1.BalloonHint := 'Получено письмо';
      TrayIcon1.ShowBalloonHint;
      for j := 1 to IdPOP31.CheckMessages do
      begin
        SysLocale.SubLangID := LANG_UKRAINIAN;
        IdMessage1.Clear;
        IdPOP31.Retrieve(j, IdMessage1);
        IdMessage1.CharSet := 'windows-1251';
        ConvertDefaultLocale(LANG_UKRAINIAN);
        Ds := now;
        d := FormatDateTime('dd', Ds);
        m := StrToInt(FormatDateTime('mm', Ds));
        g := FormatDateTime('yyyy', Ds);
        Memo1.Lines.Add(DateTimeToStr(now) + '>' + 'От кого: ' +
          IdMessage1.From.Address);
        Memo1.Lines.Add(DateTimeToStr(now) + '>' + 'Тема сообщения: ' +
          IdMessage1.Subject);

        if IdMessage1.MessageParts.Count <> 0 then
        begin
          Application.ProcessMessages;
          for i := 0 to IdMessage1.MessageParts.Count - 1 do
            if IdMessage1.MessageParts.Items[i] is TIdAttachmentFile then
            begin
              if DirectoryExists('E:\svodka') = false then
                CreateDir('E:\svodka');
              if DirectoryExists('E:\svodka\' + g) = false then
                CreateDir('E:\svodka\' + g);
              if DirectoryExists('E:\svodka\' + g + '\' + Ar[m]) = false then
                CreateDir('E:\svodka\' + g + '\' + Ar[m]);
              if DirectoryExists('E:\svodka\' + g + '\' + Ar[m] + '\' +
                DateToStr(now)) = false then
                CreateDir('E:\svodka\' + g + '\' + Ar[m] + '\' +
                  DateToStr(now));

              if FileExists('E:\svodka\' + g + '\' + Ar[m] + '\' +
                DateToStr(now) + '\' + IdMessage1.MessageParts.Items[i].FileName)
              then
                filen := IdMessage1.MessageParts.Items[i].FileName + '_' +
                  IntToStr(j)
              else
                filen := IdMessage1.MessageParts.Items[i].FileName;

              if IdMessage1.MessageParts.Items[i].FileName = '��������� �� �������.xlsm'
              then
                filen := 'Раскрытие по службам.xlsm';

              TIdAttachmentFile(IdMessage1.MessageParts.Items[i])
                .SaveToFile('E:\svodka\' + g + '\' + Ar[m] + '\' +
                DateToStr(now) + '\' + filen);
              Memo1.Lines.Add(DateTimeToStr(now) + '>' +
                'Сохранили в каталог E:\svodka\' + g + '\' + Ar[m] + '\' +
                DateToStr(now) + '\' + ' файл с именем ' +
                IdMessage1.MessageParts.Items[i].FileName);
              Writeln(f, DateTimeToStr(now) + '>' +
                'Сохранили в каталог E:\svodka\' + g + '\' + Ar[m] + '\' +
                DateToStr(now) + '\' + ' файл с именем ' +
                IdMessage1.MessageParts.Items[i].FileName);

              // переотправка вложений
              if CheckBox1.Checked = true then
              begin
                IdSMTP1.Host := Edit_smtp_server.Text;
                IdSMTP1.Username := Edit_user_smtp.Text;
                IdSMTP1.Password := Edit_pass_smtp.Text;
                IdSMTP1.Port := StrToInt(Edit_port_smtp.Text);

                IdMessage1.Subject := Edit_subject_smtp.Text;
                IdMessage1.Sender.Name := Edit_sender_smtp.Text;
                IdMessage1.From.Address := Edit_recipient_smtp.Text;
                IdSMTP1.AuthType := satDefault;
                IdMessage1.Recipients.EMailAddresses :=
                  Edit_recipient_smtp.Text;
                IdMessage1.Sender.Address := Edit_sender_smtp.Text;
                IdMessage1.From.Name := Edit_recipient_smtp.Text;
                IdMessage1.Body.Text := Memo_body_smtp.Text;
                try
                  IdSMTP1.Connect;
                  IdSMTP1.Authenticate;
                  IdSMTP1.Send(IdMessage1);
                finally
                  IdSMTP1.Disconnect();
                end;

              end;
            end;
        end;
        // IdPOP31.Delete(j);
        Memo1.Lines.Add('');
      end;
    end
    else
      Memo1.Lines.Add(DateTimeToStr(now) + '>' + 'Писем нет!');
    IdPOP31.Disconnect;

    Memo1.Lines.Add(DateTimeToStr(now) + '>' + 'Отключились');
    CloseFile(f);
  except
    begin
      IdPOP31.Disconnect;
      Memo1.Lines.Add(DateTimeToStr(now) + ' > Ошибка подключения!');
      Writeln(f, DateTimeToStr(now) + ' > Ошибка подключения!');
      CloseFile(f);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Label13.Caption := '';
  IdMessage1.Clear;
  IdSMTP1.Host := Edit_smtp_server.Text;
  IdSMTP1.Username := Edit_user_smtp.Text;
  IdSMTP1.Password := Edit_pass_smtp.Text;
  IdSMTP1.Port := StrToInt(Edit_port_smtp.Text);
  try
    if OpenDialog1.Execute() then
      TIdAttachmentFile.Create(IdMessage1.MessageParts, OpenDialog1.FileName);
    IdMessage1.Subject := Edit_subject_smtp.Text;
    IdMessage1.Sender.Name := Edit_sender_smtp.Text;
    IdMessage1.From.Address := Edit_recipient_smtp.Text;
    IdSMTP1.AuthType := satDefault;
    IdMessage1.Recipients.Add;
    IdMessage1.Recipients.Items[0].Text := Edit_recipient_smtp.Text;

    IdMessage1.Body.Text := Memo_body_smtp.Text;
    IdSMTP1.Connect;
    IdSMTP1.Authenticate;
    IdSMTP1.Send(IdMessage1);
  except
    Label13.Font.Color := clRed;
    Label13.Caption := 'Письмо не отправлено';
  end;
  Label13.Font.Color := clGreen;
  Label13.Caption := 'Письмо отправлено!';
  IdSMTP1.Disconnect();
end;

procedure SaveSettings;
var
  root: IXMLNode;
  elem: IXMLNode;
begin
  with Form1 do
  begin
    with XMLDocument1 do
    begin
      FileName := '';
      Active := true;
      Version := '1.0';
      Encoding := 'unicode';

      root := XMLDocument1.AddChild('Main_settings');
      root.ChildValues['time_check'] := Form3.SpinEdit1.Value.ToString + ':' +
        Form3.SpinEdit2.Value.ToString + ':' + Form3.SpinEdit3.Value.ToString;

      elem := root.AddChild('POP');

      elem.ChildValues['pop_server'] := Edit_address.Text;
      elem.ChildValues['pop_port'] := Edit_port.Text;
      elem.ChildValues['pop_user'] := Form1.Edit_login.Text;
      elem.ChildValues['pop_pass'] := IdEncoderMIME1.EncodeString
        (Edit_pass.Text);
      elem.ChildValues['resend'] := Form1.CheckBox1.Checked;

      elem := root.AddChild('SMTP');
      elem.ChildValues['smtp_server'] := Edit_smtp_server.Text;
      elem.ChildValues['smtp_port'] := Edit_port_smtp.Text;
      elem.ChildValues['smtp_user'] := Edit_user_smtp.Text;
      elem.ChildValues['smtp_pass'] := IdEncoderMIME1.EncodeString
        (Edit_pass_smtp.Text);
      elem.ChildValues['smtp_recipient'] := Edit_recipient_smtp.Text;
      elem.ChildValues['smtp_sender'] := Edit_sender_smtp.Text;
      elem.ChildValues['smtp_subject'] := Edit_subject_smtp.Text;
      if Memo_body_smtp.Text = '' then
        elem.ChildValues['smtp_body'] := 'ФГКУ ОВО МВД по Республике Хакасия'
      else
        elem.ChildValues['smtp_body'] := Memo_body_smtp.Text;

      SaveToFile(ExtractFilePath(Application.ExeName) + '\setings.xml');
      Active := false;
    end;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
    TabSheet2.Tabvisible := true
  else
    TabSheet2.Tabvisible := false;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if AccessClose = true then
  begin
    SaveSettings;
    CanClose := true;
  end
  else
    CanClose := false;
  Hide;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AppendMenu(GetSystemMenu(Handle, false), MF_SEPARATOR, 0, '');
  AppendMenu(GetSystemMenu(Handle, false), MF_STRING, 01,
    'Настроить периодичность проверки');
  try
    XMLDocument1.LoadFromFile(ExtractFilePath(Application.ExeName) +
      '\setings.xml');

    // Загрузка времени переодичности проверки почты
    time_check := XMLDocument1.ChildNodes['Main_settings'].ChildValues
      ['time_check'];
    MyTime := StrToTime(time_check);
    Form1.Caption := time_check; // отображение времени в заголовке формы

    // установка времени в таймер

    // Загрузка параметров подключения к почтовому серверу POP
    Form1.Edit_address.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['POP'].ChildValues['pop_server']; // адрес сервера
    Form1.Edit_port.Text := XMLDocument1.ChildNodes['Main_settings'].ChildNodes
      ['POP'].ChildValues['pop_port']; // номер порта
    Form1.Edit_login.Text := XMLDocument1.ChildNodes['Main_settings'].ChildNodes
      ['POP'].ChildValues['pop_user']; // пользователь
    Form1.Edit_pass.Text := IdDecoderMIME1.DecodeString
      (XMLDocument1.ChildNodes['Main_settings'].ChildNodes['POP'].ChildValues
      ['pop_pass']); // пароль

    // установка переотправления почты на другой адрес
    CheckBox1.Checked := XMLDocument1.ChildNodes['Main_settings'].ChildNodes
      ['POP'].ChildValues['resend'];
    if CheckBox1.Checked = true then
      TabSheet2.Tabvisible := true
    else
      TabSheet2.Tabvisible := false;

    // Загрузка параметров подключения к почтовому серверу SMTP
    Form1.Edit_smtp_server.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['SMTP'].ChildValues['smtp_server']; // адрес сервера
    Form1.Edit_port_smtp.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['SMTP'].ChildValues['smtp_port']; // номер порта
    Form1.Edit_user_smtp.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['SMTP'].ChildValues['smtp_user']; // пользователь
    Form1.Edit_pass_smtp.Text := IdDecoderMIME1.DecodeString
      (XMLDocument1.ChildNodes['Main_settings'].ChildNodes['SMTP'].ChildValues
      ['smtp_pass']); // пароль

    Form1.Edit_recipient_smtp.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['SMTP'].ChildValues['smtp_recipient'];
    Form1.Edit_sender_smtp.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['SMTP'].ChildValues['smtp_sender'];
    Form1.Edit_subject_smtp.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['SMTP'].ChildValues['smtp_subject'];
    Form1.Memo_body_smtp.Text := XMLDocument1.ChildNodes['Main_settings']
      .ChildNodes['SMTP'].ChildValues['smtp_body'];

    XMLDocument1.Active := false;
  except
    Form1.Edit_address.Text := '10.228.15.99';
    Form1.Edit_port.Text := '110';
    Form1.Edit_login.Text := '601ovo_nch';
    Form1.Edit_pass.Text := IdDecoderMIME1.DecodeString('MTEyMjIz');

    Form1.Edit_smtp_server.Text := '10.228.15.99';
    Form1.Edit_port_smtp.Text := '25';
    Form1.Edit_user_smtp.Text := '601ovo_teh';
    Form1.Edit_pass_smtp.Text := IdDecoderMIME1.DecodeString('NjA2MTgx');
    Form1.Edit_recipient_smtp.Text := '602ovo2@abk.mvd.ru';
    Form1.Edit_sender_smtp.Text := '601ovo_teh@abk.mvd.ru';
    Form1.Edit_subject_smtp.Text := 'Оперативная сводка';
    Form1.Memo_body_smtp.Text := 'ФГКУ ОВО МВД по Республике Хакасия';
    ShowMessage('Загружены параметры по умолчанию');
  end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  AccessClose := true;
  Close();
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Form3.ShowModal;
end;

procedure TForm1.TimerTimer(Sender: TObject);
begin
  MyTime := IncSecond(MyTime, -1);
  Form1.Caption := TimeToStr(MyTime);
  if MyTime = StrToTime('00:00:00') then
    MyTime := StrToTime(time_check);

end;

procedure TForm1.Timer_mailTimer(Sender: TObject);
begin
  Button1Click(Self);
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  if Form1.Visible = true then
    Form1.Hide
  else
    Form1.show;
end;

end.
