unit Classe.Pessoa;

interface

uses
  system.sysutils, Classe.sql;

type
  TPessoa = class
  private
   Fnome   : string;
    FEtnia: string;
    Fdatanasc: string;
    Fsexo: String;
   function GetNome : string;
   procedure SetNome(Value : string);
    procedure SetEtnia(const Value: string);
    procedure Setdatanasc(const Value: string);
    procedure Setsexo(const Value: String);
  public

   Property datanasc: string read Fdatanasc write Setdatanasc;
   property sexo : String read Fsexo write Setsexo;
   Property Etnia: string read FEtnia write SetEtnia;
   property Nome : String read Getnome write Setnome;

   function idade : integer;
   function receber (I : integer) : String; overload;
   function receber (I : currency) : string;  overload;
   function receber (a,b : integer) : string; overload;

   function retornaNome : String; virtual;
   function metodoAbstrato : string; virtual; abstract;


  end;

implementation

{ TPessoa }

function TPessoa.GetNome: string;
begin
  Result:= Fnome;
end;

function TPessoa.idade: integer;
begin
  result := trunc((now - StrToDate(DataNasc)) / 365.25);
end;

function TPessoa.receber(I: currency): string;
begin
 result:= 'Recebi um valor currency:  ' + CurrToStr(i);
end;

function TPessoa.receber(I: integer): String;
begin
 result:= 'recebi um valor inteiro:  ' + IntToStr(i)
end;

procedure TPessoa.Setdatanasc(const Value: string);
begin
  Fdatanasc := Value;
end;

procedure TPessoa.SetEtnia(const Value: string);
begin
  FEtnia := Value;
end;

procedure TPessoa.SetNome(Value: string);
begin
  if value = '' then
   raise exception.Create('Valor não pode ser vazio');
  Fnome:=value;
end;

procedure TPessoa.Setsexo(const Value: String);
begin
  Fsexo := Value;
end;

function TPessoa.receber(a, b: integer): string;
begin
  result := 'A soma desses inteiros é :  ' + IntToStr(A+B);
end;

function TPessoa.retornaNome: String;
begin
  result:= 'Eu sou a calsse Tpessoa';
end;

end.
