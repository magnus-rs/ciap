unit Principal;

interface

uses
    Winapi.Windows, 
    Winapi.Messages, 
    System.SysUtils, 
    System.Variants,
    System.Classes,
    System.UITypes,
    Vcl.Graphics,
    Vcl.Controls, 
    Vcl.Forms, 
    Vcl.Dialogs, 
    Vcl.StdCtrls, 
    ACBrSpedFiscal,
    ACBrBase, 
    DateUtils,
    ACBrEFDImportar, 
    Vcl.ExtDlgs, 
    Data.DB, 
    Datasnap.DBClient, 
    ACBrEFDBlocos,
    Vcl.Grids, 
    Vcl.DBGrids, 
    Vcl.ExtCtrls;

type
    TForm1 = class(TForm)
        OpenFile: TOpenTextFileDialog;
        EditSPED: TEdit;
        BtnSPED: TButton;
        SpedImporta: TACBrSpedFiscalImportar;
        SpedFiscal: TACBrSPEDFiscal;
        EditBloco_G: TEdit;
        BtnBloco_G: TButton;
        Btn_Importar: TButton;
        Edit0300: TEdit;
        Btn0300: TButton;
        Edit0500: TEdit;
        Btn0500: TButton;
        Edit0600: TEdit;
        Btn0600: TButton;
        MemoSPED: TMemo;
        BtnCFOP_5929: TButton;
        BtnCancelar: TButton;
        procedure BtnSPEDClick(Sender: TObject);
        procedure BtnBloco_GClick(Sender: TObject);
        procedure Btn_ImportarClick(Sender: TObject);
        procedure Btn0300Click(Sender: TObject);
        procedure Btn0500Click(Sender: TObject);
        procedure Btn0600Click(Sender: TObject);
        procedure BtnCFOP_5929Click(Sender: TObject);
        procedure BtnCancelarClick(Sender: TObject);

    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnSPEDClick(Sender: TObject);
// Abre o Arquivo SPED que foi exportado pelo Sistema ERP
begin
    if OpenFile.Execute then
    begin
        EditSPED.Text := OpenFile.FileName;
        SpedImporta.Arquivo := EditSPED.Text;
        SpedImporta.Importar;
        SpedFiscal.Arquivo := 'CIAP_' + ExtractFileName(EditSPED.Text);
        SpedFiscal.Path := ExtractFileDir(EditSPED.Text);
        SpedFiscal.DT_INI := SpedFiscal.Bloco_0.Registro0000.DT_INI;
        SpedFiscal.DT_FIN := SpedFiscal.Bloco_0.Registro0000.DT_FIN;
    end;
    Btn0300.Enabled := True;
end;

procedure TForm1.Btn0300Click(Sender: TObject);
// Seleciona o Arquivo com o Bloco_0300 (BENS DO ATIVO IMOBILIZADO) fornecido pela SISPRO
begin
    if OpenFile.Execute then
    begin
        Edit0300.Text := OpenFile.FileName;
    end;
    Btn0500.Enabled := True;
end;

procedure TForm1.Btn0500Click(Sender: TObject);
// Seleciona o Arquivo com o Bloco_0500 (CONTAS CONT�BEIS DO ATIVO IMOBILIZADO) fornecido pela SISPRO
begin
    if OpenFile.Execute then
    begin
        Edit0500.Text := OpenFile.FileName;
    end;
    Btn0600.Enabled := True;
end;

procedure TForm1.Btn0600Click(Sender: TObject);
// Seleciona o Arquivo com o Bloco_0600 (CENTROS DE CUSTO DO ATIVO IMOBILIZADO) fornecido pela SISPRO
begin
    if OpenFile.Execute then
    begin
        Edit0600.Text := OpenFile.FileName;
    end;
    BtnBloco_G.Enabled := True;
end;

procedure TForm1.BtnBloco_GClick(Sender: TObject);
// Seleciona o Arquivo com o Bloco_G (CREDITO ICMS SOBRE ATIVO PERMANENTE - CIAP) fornecido pela SISPRO
begin
    if OpenFile.Execute then
    begin
        EditBloco_G.Text := OpenFile.FileName;
    end;
    Btn_Importar.Enabled := True
end;

procedure TForm1.BtnCancelarClick(Sender: TObject);
// Limpa todos os dados para reiniciar o processo
begin
    EditSPED.Clear;
    BtnSPED.Enabled := True;
    Edit0300.Clear;
    Btn0300.Enabled := False;
    Edit0500.Clear;
    Btn0500.Enabled := False;
    Edit0600.Clear;
    Btn0600.Enabled := False;
    EditBloco_G.Clear;
    BtnBloco_G.Enabled := False;
    Btn_Importar.Enabled := False;
    BtnCFOP_5929.Enabled := True;
    MemoSPED.Lines.Clear;
    SpedFiscal.CancelaGeracao;
end;

procedure TForm1.BtnCFOP_5929Click(Sender: TObject);
// Fun��o espec�fica para ZERAR os valores das Notas Refer�nciadas CFOP 5929
var
    I: Integer;
    J: Integer;
    Arquivo: String;

begin
    if OpenFile.Execute then
    begin
        Arquivo := OpenFile.FileName;
        SpedImporta.Arquivo := Arquivo;
        SpedImporta.Importar;
        SpedFiscal.Arquivo := ExtractFileName(Arquivo);
        SpedFiscal.Path := ExtractFileDir(Arquivo);
        SpedFiscal.DT_INI := SpedFiscal.Bloco_0.Registro0000.DT_INI;
        SpedFiscal.DT_FIN := SpedFiscal.Bloco_0.Registro0000.DT_FIN;
    end;
    with SpedFiscal.Bloco_C.RegistroC001 do
        for J := 0 to RegistroC100.Count - 1 do
            with RegistroC100.Items[J] do
                for I := 0 to RegistroC190.Count - 1 do
                    with RegistroC190.Items[I] do
                    begin
                        if CFOP = '5929' then
                        begin
                            VL_DOC := 0.00;
                            VL_MERC := 0.00;
                            VL_OPR := 0.00;
                        end;

                    end;
    SpedFiscal.SaveFileTXT;
    MemoSPED.Lines.Clear;
    MemoSPED.Lines.LoadFromFile(SpedFiscal.Path + SpedFiscal.Arquivo);
    BtnCFOP_5929.Enabled := False;
    MessageDlg
      ('Zeramento Concluído! Clique em Reiniciar Tarefas para Limpar a tela.',
      mtInformation, [mbOK], 0);
end;

procedure TForm1.Btn_ImportarClick(Sender: TObject);
// Importa os dados para o Arquivo do SPED
var
    J: Integer;
    Valor: Currency;

begin
    SpedImporta.Arquivo := EditBloco_G.Text;
    SpedImporta.Importar;
    BtnBloco_G.Enabled := False;
    SpedImporta.Arquivo := Edit0300.Text;
    SpedImporta.Importar;
    Btn0300.Enabled := False;
    SpedImporta.Arquivo := Edit0500.Text;
    SpedImporta.Importar;
    Btn0500.Enabled := False;
    SpedImporta.Arquivo := Edit0600.Text;
    SpedImporta.Importar;
    Btn0600.Enabled := False;
    Valor := 0.00;
    with SpedFiscal.Bloco_G.RegistroG001 do
        for J := 0 to RegistroG110.Count - 1 do
            with RegistroG110.Items[J] do
            begin
                Valor := ICMS_APROP; // Pega o valor do Cr�dito CIAP no Bloco_G
            end;
    with SpedFiscal.Bloco_E.RegistroE001 do
        for J := 0 to RegistroE100.Count - 1 do
            with RegistroE100.Items[J] do
                with RegistroE110 do
                begin
                    VL_TOT_AJ_CREDITOS := Valor;
                    // Insere o Valor do Cr�dito no Registro_E110
                    VL_SLD_APURADO := (VL_SLD_APURADO - Valor);
                    // Atualiza o valor dos ICMS apurado
                    VL_ICMS_RECOLHER := (VL_ICMS_RECOLHER - Valor);
                    // Atualiza o valor do ICMS a ser pago
                    with RegistroE116.Items[0] do
                        VL_OR := (VL_OR - Valor);
                    // Atualiza o valor do ICMS no Registro E116
                end;
    with SpedFiscal.Bloco_E.RegistroE111New do
    // Insere Registro E111 de Ajuste do CIAP
    begin
        COD_AJ_APUR := 'RS020100'; // C�digo de Ajuste de Apura��o
        DESCR_COMPL_AJ :=
          'REFERENTE A CREDITO DO ATIVO IMOBILIZADO CONFORME LIVRO CIAP';
        // Descri��o do Cr�dito
        VL_AJ_APUR := Valor; // Valor do Cr�dito
    end;
    SpedFiscal.SaveFileTXT; // Salva o Novo Arquivo SPED
    Btn_Importar.Enabled := False;
    MemoSPED.Lines.Clear;
    MemoSPED.Lines.LoadFromFile(SpedFiscal.Path + SpedFiscal.Arquivo);

end;

end.
