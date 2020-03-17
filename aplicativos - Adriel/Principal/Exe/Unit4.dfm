object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'VCL := FMX'
  ClientHeight = 115
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 95
    Top = 29
    Width = 100
    Height = 13
    Caption = '% Contas '#224' Receber'
  end
  object Label2: TLabel
    Left = 95
    Top = 54
    Width = 88
    Height = 13
    Caption = '% Contas '#224' Pagar'
  end
  object Button1: TButton
    Left = 17
    Top = 76
    Width = 180
    Height = 25
    Caption = 'Gr'#225'fico'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 19
    Top = 22
    Width = 68
    Height = 21
    MaxLength = 2
    NumbersOnly = True
    TabOrder = 1
    Text = '0'
  end
  object Edit2: TEdit
    Left = 19
    Top = 49
    Width = 68
    Height = 21
    MaxLength = 2
    NumbersOnly = True
    TabOrder = 2
    Text = '0'
  end
end
