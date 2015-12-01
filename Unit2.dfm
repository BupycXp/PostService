object Form3: TForm3
  Left = 0
  Top = 0
  ClientHeight = 71
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 165
    Height = 13
    Caption = #1055#1077#1088#1080#1086#1076#1080#1095#1085#1086#1089#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1087#1086#1095#1090#1099
  end
  object Label2: TLabel
    Left = 55
    Top = 35
    Width = 6
    Height = 13
    Caption = #1095
  end
  object Label3: TLabel
    Left = 114
    Top = 35
    Width = 6
    Height = 13
    Caption = #1084
  end
  object Label4: TLabel
    Left = 173
    Top = 35
    Width = 5
    Height = 13
    Caption = #1089
  end
  object SpinEdit1: TSpinEdit
    Left = 8
    Top = 32
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = SpinEdit1Change
  end
  object SpinEdit3: TSpinEdit
    Left = 126
    Top = 32
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = SpinEdit3Change
  end
  object SpinEdit2: TSpinEdit
    Left = 67
    Top = 32
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = SpinEdit2Change
  end
  object Button1: TButton
    Left = 192
    Top = 30
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
end
