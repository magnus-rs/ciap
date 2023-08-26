object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Importa Ativo Imobilizado e CIAP'
  ClientHeight = 486
  ClientWidth = 838
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object EditSPED: TEdit
    Left = 8
    Top = 24
    Width = 671
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object BtnSPED: TButton
    Left = 685
    Top = 22
    Width = 145
    Height = 25
    Caption = 'Selecionar Arquivo do SPED'
    TabOrder = 1
    OnClick = BtnSPEDClick
  end
  object EditBloco_G: TEdit
    Left = 8
    Top = 152
    Width = 671
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object BtnBloco_G: TButton
    Left = 685
    Top = 150
    Width = 145
    Height = 25
    Caption = 'Selecionar Arquivo Bloco G'
    Enabled = False
    TabOrder = 3
    OnClick = BtnBloco_GClick
  end
  object Btn_Importar: TButton
    Left = 8
    Top = 181
    Width = 297
    Height = 25
    Caption = 'Importar Inform'#231#245'es e Gerar Arquivo TXT para o SPED'
    Enabled = False
    TabOrder = 4
    OnClick = Btn_ImportarClick
  end
  object Edit0300: TEdit
    Left = 8
    Top = 56
    Width = 671
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object Btn0300: TButton
    Left = 685
    Top = 54
    Width = 145
    Height = 25
    Caption = 'Selecionar Arquivo 0300'
    Enabled = False
    TabOrder = 6
    OnClick = Btn0300Click
  end
  object Edit0500: TEdit
    Left = 8
    Top = 88
    Width = 671
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object Btn0500: TButton
    Left = 685
    Top = 86
    Width = 145
    Height = 25
    Caption = 'Selecionar Arquivo 0500'
    Enabled = False
    TabOrder = 8
    OnClick = Btn0500Click
  end
  object Edit0600: TEdit
    Left = 8
    Top = 120
    Width = 671
    Height = 21
    Enabled = False
    TabOrder = 9
  end
  object Btn0600: TButton
    Left = 685
    Top = 118
    Width = 145
    Height = 25
    Caption = 'Selecionar Arquivo 0600'
    Enabled = False
    TabOrder = 10
    OnClick = Btn0600Click
  end
  object MemoSPED: TMemo
    Left = 8
    Top = 215
    Width = 822
    Height = 253
    Lines.Strings = (
      '')
    MaxLength = 2000
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 11
    WordWrap = False
  end
  object BtnCFOP_5929: TButton
    Left = 533
    Top = 181
    Width = 297
    Height = 25
    Caption = 'Corrigir Registros C100 - CFOP 5929'
    TabOrder = 12
    OnClick = BtnCFOP_5929Click
  end
  object BtnCancelar: TButton
    Left = 366
    Top = 181
    Width = 115
    Height = 25
    Caption = 'Reiniciar Tarefas'
    TabOrder = 13
    OnClick = BtnCancelarClick
  end
  object OpenFile: TOpenTextFileDialog
    Filter = 'Arquivo Texto|*.txt|Todos os Arquivos|*.*'
    Left = 648
    Top = 184
  end
  object SpedImporta: TACBrSpedFiscalImportar
    ACBrSpedFiscal = SpedFiscal
    Left = 648
    Top = 280
  end
  object SpedFiscal: TACBrSPEDFiscal
    Path = 'C:\Program Files (x86)\Embarcadero\Studio\21.0\bin\'
    Delimitador = '|'
    ReplaceDelimitador = False
    TrimString = True
    CurMascara = '#0.00'
    Left = 648
    Top = 231
  end
end
