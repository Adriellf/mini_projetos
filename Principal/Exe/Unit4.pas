unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}
procedure AbrirForm(Valor1,Valor2:Real);stdcall;
external 'MinhaDll.dll' name 'AbrirForm';


procedure TForm4.Button1Click(Sender: TObject);
begin
  AbrirForm(strtofloat(Edit1.Text),strtofloat(Edit2.Text));

end;

end.
