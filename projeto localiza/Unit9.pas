unit Unit9;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.StdCtrls, FMX.Objects, FMX.Effects, FMX.Controls.Presentation,IdURI, Androidapi.Jni.GraphicsContentViewText,
  Androidapi.Jni.Net, Androidapi.Helpers;

type
  TForm9 = class(TForm)
    ToolBar1: TToolBar;
    ShadowEffect1: TShadowEffect;
    Rectangle1: TRectangle;
    ShadowEffect3: TShadowEffect;
    Rectangle2: TRectangle;
    ShadowEffect4: TShadowEffect;
    Button1: TButton;
    Label1: TLabel;
    EdtEndereco: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;
  vUri: string;
  vIntent: JIntent;


implementation

{$R *.fmx}

procedure TForm9.Button1Click(Sender: TObject);
var
  MyClass: TComponent;
begin
  if EdtEndereco.Text <> '' then
  begin
    vuri:='geo://0,0?q=' + EdtEndereco.Text;

    try

       vIntent:= TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW, TJnet_uri.JavaClass.parse(stringtojstring(TIdURI.URLDecode(vuri))));

       SharedActivity.startActivity(vIntent);

    except  on E:Exception do
      ShowMessage(E.message);
    end;
  end else
  begin
    ShowMessage('Escreva o Endereço');
  end;
end;

end.
