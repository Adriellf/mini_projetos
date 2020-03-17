unit Unit9;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Styles.Objects, FMX.Controls.Presentation, FMX.StdCtrls,strak.GPOS700.printer;

type
  TForm9 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     function Replicate(c1: String; iTamanho: Integer): String;
  end;

var
  Form9: TForm9;

implementation

{$R *.fmx}


procedure TForm9.Button1Click(Sender: TObject);
begin

  PrinterGPOS700.printInit;
//  PrinterGPOS700.printString('Genis GPos700', 30, TAlign.CENTER, false, false);
//  PrinterGPOS700.printString('-------------', 30, TAlign.CENTER, false, false);
//  PrinterGPOS700.printString('www.geniusbrasil.com', 30, TAlign.CENTER,false, false);

  PrinterGPOS700.printString('TITULO' ,21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('Recebemos de:                Os produtos da NF-e',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('Roberto Ferreira Couto       No: 987643214563217',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('informacao limitada          SERIE: 12345678    ',21, TAlign.CENTER, true, false);
 // PrinterGPOS700.printString(' ');
  PrinterGPOS700.printString('________________________________________________',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('DATA DE RECEBIMENTO     IDENTIFICACAO/ASSINATURA',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('  __/___/_____         _______________________',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('------------------------------------------------',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' DANFE SIMPLIFICADO',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('DOCUMENTO AUXILIAR DA N.o =0123456789',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('NOTA FISCAL ELETRONICA SERIE = 1',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('29170214989417000180650021000008862100008868',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('CHAVE DE ACESSO:',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('29170214989417000180650021000008862100008868',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('NUM. PROTOCOLO: 129182100164652',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('DATA DE EMISSAO: 18/11/16 16:13:02',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('SAIDA: 18/11/16 21:16:02 HORA: 21:16:02',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('________________________________________________',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('DADOS DO PRODUTO/ SERVICO:',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('Qtde| Cod   |  Descricao       |Uni R$ |Total R$',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('21  | 00007 | SALMAO E SALADA  |3,35   |35,00   ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('________________________________________________',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('CALCULO DO IMPOSTO',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' VL ICMS     |  BC ICMS    | BC ICMSST',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' 000.000,00  |  000.000,00 | 000.000,00 ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' VL ICMSST   |  TOT PROD',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' 000.000,00  |  000.000,00',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' VL FRETE    | VL SEGURO   | Vl OUTROS ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' 000.000,00  | 000.000,00  | 000.000,00 ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' VL IPI      | TOT NFE',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' ',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString(' 000.000,00  | 000.000,00',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printString('________________________________________________',21, TAlign.CENTER, true, false);
  PrinterGPOS700.printPaper(100);
  PrinterGPOS700.printFinish() ;

end;

function TForm9.Replicate(c1: String; iTamanho: Integer): String;
Var iCont: Integer;
Begin
  Result:='';
  iCont:=0;
  while iCont<iTamanho do
  begin
    Result:=Result+c1;
    Inc(iCont);
  end;
end;


end.
