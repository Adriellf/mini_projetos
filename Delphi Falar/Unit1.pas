unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls,ComObj;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  voz: OLEVariant;
begin
  voz := CreateOLEObject('SAPI.SpVoice');
  if (Edit1.Text <> 'Digite seu texto aqui') and (Edit1.Text <> '') then
    voz.Speak(Edit1.Text, 0); //o sistema vai falar o texto digitado no Edit1

end;
end.
