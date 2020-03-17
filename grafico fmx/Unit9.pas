unit Unit9;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.StdCtrls, FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.Edit,
  FMX.ImgList;

type
  TForm9 = class(TForm)
    Pie1: TPie;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Rectangle1: TRectangle;
    ShadowEffect2: TShadowEffect;
    Circle2: TCircle;
    Circle1: TCircle;
    Label1: TLabel;
    FloatAnimation1: TFloatAnimation;
    ShadowEffect1: TShadowEffect;
    Label3: TLabel;
    Rectangle2: TRectangle;
    ShadowEffect3: TShadowEffect;
    Circle3: TCircle;
    Pie2: TPie;
    Circle4: TCircle;
    Label2: TLabel;
    FloatAnimation2: TFloatAnimation;
    ShadowEffect4: TShadowEffect;
    Label4: TLabel;
    procedure Animacao(Porc1,Porc2 :Real);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.fmx}

{ TForm9 }

procedure TForm9.Animacao(Porc1, Porc2: Real);
begin

   Pie1.RotationAngle := -90;
   Pie1.EndAngle := 0;
   FloatAnimation1.StartFromCurrent := True;
   FloatAnimation1.Duration := 1;
   FloatAnimation1.StopValue := Porc1 * 3.6;
   Label1.Text :=  FloatToStr(Porc1)+'%';

   Pie2.RotationAngle := Pie1.RotationAngle;
   Pie2.EndAngle := Pie1.EndAngle;
   FloatAnimation2.StartFromCurrent := FloatAnimation1.StartFromCurrent;
   FloatAnimation2.Duration := FloatAnimation1.Duration;
   FloatAnimation2.StopValue := Porc2 * 3.6;
   Label2.Text :=  FloatToStr(Porc2)+'%';
   FloatAnimation1.Start;
   FloatAnimation2.Start;
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
Animacao(StrToInt64(Edit1.Text),StrToInt64(Edit2.Text));
end;

end.
