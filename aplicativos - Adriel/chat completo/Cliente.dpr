program Cliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  uClient in 'uClient.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

