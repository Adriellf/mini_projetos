unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects,
  FMX.ListBox;

type
  TForm6 = class(TForm)
    Rectangle1: TRectangle;
    btnMenu: TButton;
    lyt1: TLayout;
    rctMenu: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    lst1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    procedure btnMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lst1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
  private
    { Private declarations }
  public
    procedure AbreMenu;
    procedure FechaMenu;
  end;

var
  Form6: TForm6;

implementation

{$R *.fmx}

{ TForm6 }

procedure TForm6.AbreMenu;
begin
  rctMenu.AnimateFloat('Position.Y', 0, 0.5);
  btnMenu.AnimateFloat('RotationAngle', 90 , 0.5);
  rctMenu.Tag := 1;
end;

procedure TForm6.btnMenuClick(Sender: TObject);
begin
  if(rctMenu.Tag = 0)then
    AbreMenu
  else
    FechaMenu;
end;

procedure TForm6.FechaMenu;
begin
  rctMenu.AnimateFloat('Position.Y', 0 - rctMenu.Height, 0.5);
  btnMenu.AnimateFloat('RotationAngle', 0, 0.5);
  rctMenu.Tag := 0;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  FechaMenu;
end;

procedure TForm6.lst1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin

  FechaMenu;
end;

end.
