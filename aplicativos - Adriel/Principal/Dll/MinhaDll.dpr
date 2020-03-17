library MinhaDll;

uses
  System.Classes,
  System.SysUtils,
  FMX.Forms,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Types,
  Unit1 in 'Unit1.pas' {Form1};

procedure AbrirForm(Valor1,Valor2:Real);stdcall;
begin
  with TForm1.Create(Application) do
  try
    Animacao(Valor1,Valor2);
    ShowModal;
  finally
    Free;
  end;

end;

exports
  AbrirForm;
{$R *.res}

begin

end.
