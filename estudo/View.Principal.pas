unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Classe.Cliente;

type
  TForm1 = class(TForm)
    Button1: TButton;
    edtnome: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{
 4 - principais conceitos

 abstração
 herança
 encapsulamento
 polimorfismo


}



procedure TForm1.Button1Click(Sender: TObject);
var
 pessoa1, pessoa2 : Tcliente;
begin
  pessoa1:= Tcliente.Create;
  pessoa2:= Tcliente.Create;
  try
   with pessoa1 do
   begin
     nome:=edtnome.Text;
     sexo:='Masculino';
     datanasc:='22/07/1995';

   end;


   ShowMessage(pessoa1.nome +'-'+ inttostr(pessoa1.idade));
  finally
    pessoa1.Free;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
pessoa3 : Tcliente;
value : currency;
begin
 pessoa3:= Tcliente.Create;
 {value:=10.5;
 ShowMessage(pessoa3.receber(5));
 ShowMessage(pessoa3.receber(value));
 ShowMessage(pessoa3.receber(10,5));
 ShowMessage(pessoa3.retornaNome);    }
 //ShowMessage(pessoa3.metodoAbstrato);
 ShowMessage(pessoa3.nome);

 end;

end.
