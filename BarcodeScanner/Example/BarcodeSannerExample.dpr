program BarcodeSannerExample;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
