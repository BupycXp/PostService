object Form1: TForm1
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  AutoSize = True
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '0:30:00'
  ClientHeight = 281
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 281
    Align = alClient
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 613
      Height = 280
      ActivePage = TabSheet1
      Align = alTop
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1055#1086#1083#1091#1095#1077#1085#1080#1077' '#1087#1086#1095#1090#1099
        object Memo1: TMemo
          Left = 16
          Top = 16
          Width = 394
          Height = 201
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object Panel1: TPanel
          Left = 416
          Top = 16
          Width = 161
          Height = 201
          TabOrder = 1
          object Label1: TLabel
            Left = 16
            Top = 8
            Width = 60
            Height = 13
            Caption = #1057#1077#1088#1074#1077#1088' POP'
          end
          object Label2: TLabel
            Left = 16
            Top = 51
            Width = 25
            Height = 13
            Caption = #1055#1086#1088#1090
          end
          object Label3: TLabel
            Left = 16
            Top = 94
            Width = 72
            Height = 13
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          end
          object Label4: TLabel
            Left = 16
            Top = 141
            Width = 37
            Height = 13
            Caption = #1055#1072#1088#1086#1083#1100
          end
          object Edit_address: TEdit
            Left = 16
            Top = 24
            Width = 121
            Height = 21
            TabOrder = 0
          end
          object Edit_port: TEdit
            Left = 16
            Top = 67
            Width = 121
            Height = 21
            TabOrder = 1
          end
          object Edit_login: TEdit
            Left = 16
            Top = 112
            Width = 121
            Height = 21
            TabOrder = 2
          end
          object Edit_pass: TEdit
            Left = 16
            Top = 160
            Width = 121
            Height = 21
            PasswordChar = '*'
            TabOrder = 3
          end
        end
        object Button1: TButton
          Left = 16
          Top = 223
          Width = 121
          Height = 25
          Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1087#1086#1095#1090#1091' '
          TabOrder = 2
          OnClick = Button1Click
        end
        object CheckBox1: TCheckBox
          Left = 416
          Top = 223
          Width = 161
          Height = 17
          Caption = #1055#1077#1088#1077#1086#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1080#1089#1100#1084#1072
          TabOrder = 3
          OnClick = CheckBox1Click
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1087#1086#1095#1090#1099
        ImageIndex = 1
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 401
          Height = 252
          Align = alLeft
          TabOrder = 0
          object Label5: TLabel
            Left = 8
            Top = 16
            Width = 94
            Height = 13
            Caption = #1040#1076#1088#1077#1089' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
          end
          object Label6: TLabel
            Left = 8
            Top = 62
            Width = 62
            Height = 13
            Caption = #1058#1077#1084#1072' '#1087#1080#1089#1100#1084#1072
          end
          object Label10: TLabel
            Left = 216
            Top = 16
            Width = 100
            Height = 13
            Caption = #1040#1076#1088#1077#1089' '#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1103
          end
          object Label11: TLabel
            Left = 8
            Top = 108
            Width = 67
            Height = 13
            Caption = #1058#1077#1082#1089#1090' '#1087#1080#1089#1100#1084#1072
          end
          object Label13: TLabel
            Left = 216
            Top = 216
            Width = 5
            Height = 19
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Edit_recipient_smtp: TEdit
            Left = 8
            Top = 35
            Width = 185
            Height = 21
            TabOrder = 0
          end
          object Edit_subject_smtp: TEdit
            Left = 8
            Top = 81
            Width = 185
            Height = 21
            TabOrder = 1
          end
          object Edit_sender_smtp: TEdit
            Left = 216
            Top = 35
            Width = 179
            Height = 21
            TabOrder = 2
          end
          object Memo_body_smtp: TMemo
            Left = 8
            Top = 127
            Width = 185
            Height = 64
            TabOrder = 3
          end
          object Button2: TButton
            Left = 8
            Top = 216
            Width = 113
            Height = 25
            Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1080#1089#1100#1084#1086
            TabOrder = 4
            OnClick = Button2Click
          end
        end
        object Panel4: TPanel
          Left = 401
          Top = 0
          Width = 204
          Height = 252
          Align = alClient
          TabOrder = 1
          object Label7: TLabel
            Left = 24
            Top = 16
            Width = 66
            Height = 13
            Caption = #1057#1077#1088#1074#1077#1088' SMTP'
          end
          object Label8: TLabel
            Left = 24
            Top = 108
            Width = 72
            Height = 13
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          end
          object Label9: TLabel
            Left = 24
            Top = 154
            Width = 37
            Height = 13
            Caption = #1055#1072#1088#1086#1083#1100
          end
          object Label12: TLabel
            Left = 24
            Top = 62
            Width = 25
            Height = 13
            Caption = #1055#1086#1088#1090
          end
          object Edit_smtp_server: TEdit
            Left = 24
            Top = 35
            Width = 121
            Height = 21
            TabOrder = 0
          end
          object Edit_user_smtp: TEdit
            Left = 24
            Top = 127
            Width = 121
            Height = 21
            TabOrder = 1
          end
          object Edit_pass_smtp: TEdit
            Left = 24
            Top = 170
            Width = 121
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
          object Edit_port_smtp: TEdit
            Left = 24
            Top = 81
            Width = 121
            Height = 21
            TabOrder = 3
          end
        end
      end
    end
  end
  object IdPOP31: TIdPOP3
    AutoLogin = True
    SASLMechanisms = <>
    Left = 232
    Top = 120
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = mePlainText
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 232
    Top = 184
  end
  object Timer_mail: TTimer
    Interval = 900000
    OnTimer = Timer_mailTimer
    Left = 304
    Top = 184
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 360
    Top = 184
  end
  object TrayIcon1: TTrayIcon
    BalloonTitle = 'Dipost'
    BalloonFlags = bfInfo
    PopupMenu = PopupMenu1
    Visible = True
    OnClick = TrayIcon1Click
    Left = 232
    Top = 48
  end
  object IdSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 304
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Left = 53
    Top = 49
    object N2: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      OnClick = N2Click
    end
    object N1: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N1Click
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 53
    Top = 113
    DOMVendorDesc = 'MSXML'
  end
  object IdDecoderMIME1: TIdDecoderMIME
    FillChar = '='
    Left = 141
    Top = 113
  end
  object IdEncoderMIME1: TIdEncoderMIME
    FillChar = '='
    Left = 141
    Top = 49
  end
  object OpenDialog1: TOpenDialog
    Left = 53
    Top = 169
  end
end
