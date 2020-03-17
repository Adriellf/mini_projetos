program Project_Tulio;

uses
  Vcl.Forms,
  View.Principal in 'View.Principal.pas' {Form1},
  Classe.Pessoa in 'Classe.Pessoa.pas',
  Classe.sql in 'Classe.sql.pas',
  Classe.Cliente in 'Classe.Cliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
