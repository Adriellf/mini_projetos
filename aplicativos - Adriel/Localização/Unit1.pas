unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, System.Sensors,
  System.Sensors.Components;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Switch1: TSwitch;
    Lst_Localizacao: TListBox;
    LocationSensor: TLocationSensor;
    procedure LocationSensorLocationChanged(Sender: TObject;
      const [Ref] OldLocation, NewLocation: TLocationCoord2D);
    procedure Switch1Switch(Sender: TObject);
  private


  FGeocoder: TGeocoder;
  Procedure OnGeocodeReverseEvent(const Address: TCivicAddress);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }

procedure TForm1.LocationSensorLocationChanged(Sender: TObject;
  const [Ref] OldLocation, NewLocation: TLocationCoord2D);
Var
 IListAdd : TListBoxItem;
begin


  FormatSettings.DecimalSeparator := '.';

  Lst_localizacao.Items.Clear;

try

     IListAdd :=  TListBoxItem.Create(Lst_localizacao);
     IListAdd.StyleLookup     := 'listboxitemleftdetail';
     IListAdd.ItemData.Text   := 'Lat : ';
     IListAdd.ItemData.Detail := Format('%2.6f', [NewLocation.Latitude]);
     Lst_localizacao.AddObject( IListAdd );

     IListAdd :=  TListBoxItem.Create(Lst_localizacao);
     IListAdd.StyleLookup     := 'listboxitemleftdetail';
     IListAdd.ItemData.Text   := 'Lon : ';
     IListAdd.ItemData.Detail := Format('%2.6f', [NewLocation.Longitude]);
     Lst_localizacao.AddObject( IListAdd );


    If Not Assigned(FGeocoder) then
    Begin

      if Assigned(TGeocoder.Current) then
        FGeocoder := TGeocoder.Current.Create;

      if Assigned(FGeocoder) then
        FGeocoder.OnGeocodeReverse := OnGeocodeReverseEvent;

    End;

    if Assigned(FGeocoder) and not FGeocoder.Geocoding then
    FGeocoder.GeocodeReverse(NewLocation);
  Except

  end;



end;

procedure TForm1.OnGeocodeReverseEvent(const Address: TCivicAddress);
Var
 IListAdd : TListBoxItem;
begin


 if Address.AdminArea <> '' then
 Begin

  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'Area : ';
  IListAdd.ItemData.Detail := Address.AdminArea;
  Lst_localizacao.AddObject( IListAdd );


  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'Endereco : ';
  IListAdd.ItemData.Detail := Address.Thoroughfare;
  Lst_localizacao.AddObject( IListAdd );


  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'Nº Endereço : ';
  IListAdd.ItemData.Detail := Address.FeatureName;
  Lst_localizacao.AddObject( IListAdd );

  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'CEP : ';
  IListAdd.ItemData.Detail := Address.PostalCode;
  Lst_localizacao.AddObject( IListAdd );

  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'Bairro : ';
  IListAdd.ItemData.Detail := Address.SubLocality;
  Lst_localizacao.AddObject( IListAdd );

  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'Cidade : ';
  IListAdd.ItemData.Detail := Address.Locality;
  Lst_localizacao.AddObject( IListAdd );

  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'Estado : ';
  IListAdd.ItemData.Detail := Address.SubAdminArea;
  Lst_localizacao.AddObject( IListAdd );

  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'Código País : ';
  IListAdd.ItemData.Detail := Address.CountryCode;
  Lst_localizacao.AddObject( IListAdd );

  IListAdd :=  TListBoxItem.Create(Lst_localizacao);
  IListAdd.StyleLookup     := 'listboxitemleftdetail';
  IListAdd.ItemData.Text   := 'País : ';
  IListAdd.ItemData.Detail := Address.CountryName;
  Lst_localizacao.AddObject( IListAdd );

  LocationSensor.Active := False;
 End;




end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin

  LocationSensor.Active := Switch1.IsChecked;

end;

end.
