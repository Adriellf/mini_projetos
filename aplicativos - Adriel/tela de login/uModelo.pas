unit uModelo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.StdCtrls, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects;

type
  TfrmPrincipal = class(TForm)
    Layout1: TLayout;
    gradienteFundo: TRectangle;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Image1: TImage;
    Label1: TLabel;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    RoundRect1: TRoundRect;
    Layout8: TLayout;
    RoundRect2: TRoundRect;
    Edit1: TEdit;
    StyleBook1: TStyleBook;
    RoundRect3: TRoundRect;
    Edit2: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Layout3D1: TLayout3D;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

end.
