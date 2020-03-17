unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Viewport3D, FMX.Controls.Presentation, FMX.StdCtrls, System.Math.Vectors,
  FMX.Types3D, FMX.ListBox, FMX.MaterialSources, FMX.Ani, FMX.Objects3D,
  FMX.OBJ.Importer, FMX.Import,
  FMX.Controls3D;

type
  TfrmPrincipal = class(TForm)
    Barra: TRectangle;
    View: TViewport3D;
    btnBump: TSpeedButton;
    btnObject: TSpeedButton;
    btnSpecular: TSpeedButton;
    btnIllumination: TSpeedButton;
    btnColor: TSpeedButton;
    Dummy: TDummy;
    Light: TLight;
    Model: TModel3D;
    FloatAnimation: TFloatAnimation;
    TMSBump: TTextureMaterialSource;
    TMSColor: TTextureMaterialSource;
    TMSIllumination: TTextureMaterialSource;
    TMSSpecular: TTextureMaterialSource;
    Char: TComboBox;
    procedure btnObjectClick(Sender: TObject);
    procedure btnBumpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.btnBumpClick(Sender: TObject);
var
M:TMesh;
begin
  for M in Model.MeshCollection
  do M.MaterialSource := TMaterialSource(FindComponent(TFmxObject(Sender).StyleName));
end;

procedure TfrmPrincipal.btnObjectClick(Sender: TObject);
var
dir  : string;
MI   : TOBJModelImporter;
ImpSe: TModelImportServices;
M    :TMesh;
begin
  MI:= TOBJModelImporter.Create;
  ImpSe := TModelImportServices.Create;
  ImpSe.RegisterImporter(MI);
  dir := ExtractFileDir(GetCurrentDir);
    case Char.ItemIndex of
      0:begin
        Model.LoadFromFile(dir+'\Obj\01\01.Obj');
        TMSBump.Texture.LoadFromFile(dir+'\Obj\01\01_Bump.gif');
        TMSColor.Texture.LoadFromFile(dir+'\Obj\01\01_Color.png');
        TMSIllumination.Texture.LoadFromFile(dir+'\Obj\01\01_Illumination.png');
        TMSSpecular.Texture.LoadFromFile(dir+'\Obj\01\01_Specular.png');
        for M in Model.MeshCollection do M.MaterialSource := TMSBump;
      end;
      1:begin
        Model.LoadFromFile(dir+'\Obj\02\02.Obj');
        TMSBump.Texture.LoadFromFile(dir+'\Obj\02\02_Bump.gif');
        TMSColor.Texture.LoadFromFile(dir+'\Obj\02\02_Color.png');
        TMSIllumination.Texture.LoadFromFile(dir+'\Obj\02\02_Illumination.png');
        TMSSpecular.Texture.LoadFromFile(dir+'\Obj\02\02_Specular.png');
        for M in Model.MeshCollection do M.MaterialSource := TMSBump;
      end;
      2:begin
        Model.LoadFromFile(dir+'\Obj\03\03.Obj');
        TMSBump.Texture.LoadFromFile(dir+'\Obj\03\03_Bump.png');
        TMSColor.Texture.LoadFromFile(dir+'\Obj\03\03_Color.png');
        TMSIllumination.Texture.LoadFromFile(dir+'\Obj\03\03_Illumination.png');
        TMSSpecular.Texture.LoadFromFile(dir+'\Obj\03\03_Specular.png');
        for M in Model.MeshCollection do M.MaterialSource := TMSBump;
      end;
    end;
end;

end.
