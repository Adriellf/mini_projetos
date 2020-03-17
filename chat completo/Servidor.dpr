program Servidor;

uses
  System.StartUpCopy,
  FMX.Forms,
  uServer in 'uServer.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
