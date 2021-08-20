object ViewMain: TViewMain
  Left = 0
  Top = 0
  Caption = 'ViewMain'
  ClientHeight = 493
  ClientWidth = 991
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
    Left = 64
    Top = 168
    Width = 92
    Height = 13
    Caption = 'Data Hora Cota'#231#227'o'
  end
  object Label2: TLabel
    Left = 64
    Top = 224
    Width = 60
    Height = 13
    Caption = 'Pre'#231'o Venda'
  end
  object Label3: TLabel
    Left = 64
    Top = 280
    Width = 67
    Height = 13
    Caption = 'Pre'#231'o Compra'
  end
  object Button1: TButton
    Left = 64
    Top = 112
    Width = 121
    Height = 25
    Caption = 'Buscar Cota'#231#227'o'
    TabOrder = 0
    OnClick = Button1Click
  end
  object dtpCotacao: TDateTimePicker
    Left = 64
    Top = 76
    Width = 121
    Height = 21
    Date = 44426.000000000000000000
    Time = 0.974598877313837900
    TabOrder = 1
  end
  object edtCotacao: TEdit
    Left = 64
    Top = 187
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtPrecoVenda: TEdit
    Left = 64
    Top = 243
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtPrecoCompra: TEdit
    Left = 64
    Top = 299
    Width = 121
    Height = 21
    TabOrder = 4
  end
end
