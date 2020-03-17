unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Effects, FMX.Ani;

type
  TForm1 = class(TForm)
    Pie1: TPie;
    Circle1: TCircle;
    Circle2: TCircle;
    ShadowEffect1: TShadowEffect;
    Rectangle1: TRectangle;
    ShadowEffect2: TShadowEffect;
    Label1: TLabel;
    Rectangle2: TRectangle;
    ShadowEffect3: TShadowEffect;
    Circle3: TCircle;
    Pie2: TPie;
    Circle4: TCircle;
    Label2: TLabel;
    ShadowEffect4: TShadowEffect;
    Label3: TLabel;
    Label4: TLabel;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    procedure Animacao(Porc1,Porc2 :Real);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Animacao(Porc1,Porc2 :Real);
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

end.
