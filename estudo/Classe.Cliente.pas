unit Classe.Cliente;

interface

uses Classe.Pessoa;
type
  Tcliente = class(Tpessoa)
  private
  constructor Create;
  public
  valorCredito : currency;
  function retornaNome : String; override;
    function metodoAbstrato : string; override;


  end;

implementation

{ Tcliente }

constructor Tcliente.Create;
begin
  Nome :='Novo Cliente';
end;

function Tcliente.metodoAbstrato: string;
begin
 result:= 'eu sou o metodo abstrato';
end;

function Tcliente.retornaNome: String;
begin
 inherited;
  result :=' eu sou filha de ' + nome;
end;

end.
