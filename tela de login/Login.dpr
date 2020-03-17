program Login;

uses
  System.StartUpCopy,
  FMX.Forms,
  uModelo in 'uModelo.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
