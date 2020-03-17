unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Effects;

  const
     PosicaoXPadrao : Integer = 20;


type
  TForm1 = class(TForm)
    Rct_Efeito: TRectangle;
    Button1: TButton;
    VertScrollBox1: TVertScrollBox;
    ToolBar1: TToolBar;
    Rct_principal: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Rct_EfeitoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure VertScrollBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure VertScrollBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rct_EfeitoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);

  private
    MoverObj : Boolean;
    Offset : TPointF;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin

 if (Rct_Efeito.Position.Y > 150) Or (Rct_Efeito.Opacity = 0) then
 Begin

  Rct_Efeito.Position.Y := Self.Height + 200;
  Rct_Efeito.Opacity    := 1;
  Rct_Efeito.Position.X := PosicaoXPadrao;
  Rct_Efeito.Width      := VertScrollBox1.Width - ( PosicaoXPadrao * 2 );

  Rct_Efeito.AnimateFloat('Position.Y',100,2.5, TAnimationType.InOut,TInterpolationType.Back);

 End
 Else
   Rct_Efeito.AnimateFloat('Opacity',0,1.5, TAnimationType.InOut,TInterpolationType.Circular);


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   MoverObj := False;
   Rct_Efeito.Position.Y := Self.Height + 200;
end;

procedure TForm1.Rct_EfeitoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin

  VertScrollBox1.Root.Captured := VertScrollBox1;
  MoverObj := True;

end;

procedure TForm1.Rct_EfeitoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin

   MoverObj := True;
   Offset.Y := Y;
   Offset.X := X;

end;

procedure TForm1.VertScrollBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);

begin


  if (MoverObj) And (ssLeft In Shift) then
  Begin


    if X > (VertScrollBox1.Width + Offset.X ) then
      X := VertScrollBox1.Width + Offset.X ;

    if Y > (VertScrollBox1.Height + Offset.Y ) then
      Y := VertScrollBox1.Height + Offset.Y ;

    if X < Offset.X then
      X := Offset.X;

    if Y < Offset.Y then
      Y := Offset.Y;

    if X > 0 then
    Rct_Efeito.Position.X := ( X - Offset.X );

  End;

end;

procedure TForm1.VertScrollBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin

    MoverObj := False;

    if Rct_Efeito.Position.X > ( (VertScrollBox1.Position.X + VertScrollBox1.Width) - 150 ) then
     Rct_Efeito.AnimateFloat('Position.X',1000,0.5)
    Else
     Rct_Efeito.AnimateFloat('Position.X',VertScrollBox1.Position.X + PosicaoXPadrao,0.5)


end;

end.
