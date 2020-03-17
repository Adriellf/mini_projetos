{===================}
{ ZXing is required }
{===================}

unit DataPak.Android.BarcodeScanner;

interface

uses
  System.Classes
  {$IFDEF ANDROID}
  , FMX.Platform, FMX.Helpers.Android, System.RTTI, FMX.Types
  , System.SysUtils, AndroidAPI.JNI.GraphicsContentViewText
  , AndroidAPI.JNI.JavaTypes, FMX.StdCtrls, FMX.Edit, AndroidAPI.Helpers
  {$ENDIF};

type

  TBarcodeScannerResult = procedure(Sender: TObject; AResult: string) of object;
  TBarcodeScannerAbort = procedure(Sender: TObject) of object;

  [ComponentPlatformsAttribute(pidAndroid)]
  TBarcodeScanner = class(TComponent)
  public
    type TBarcodeType = (btOneD, btQRCode, btProduct, btDataMatrix);
    type TBarcodeTypes = set of TBarcodeType;
  protected
    FOnScanAbort: TBarcodeScannerAbort;
    FOnScanResult: TBarcodeScannerResult;
    FBarcodeTypes: TBarcodeTypes;
  {$IFDEF ANDROID}
    FClipboardService: IFMXClipboardService;
    FPreservedClipboardValue: TValue;
    FMonitorClipboard: Boolean;
    const BarcodeTypeName: array [btOneD .. btDataMatrix] of string =
      ('ONE_D_MODE', 'QR_CODE_MODE', 'PRODUCT_MODE', 'DATA_MATRIX_MODE');
    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    function GetScanCommand: string;
  {$ENDIF}
  public
    procedure Scan;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BarcodeTypes: TBarcodeTypes read FBarcodeTypes write FBarcodeTypes;
    property OnScanAbort: TBarcodeScannerAbort read FOnScanAbort write FOnScanAbort;
    property OnScanResult: TBarcodeScannerResult read FOnScanResult write FOnScanResult;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DataPak Android Components', [TBarcodeScanner]);
end;

{ TBarcodeScanner }

constructor TBarcodeScanner.Create(AOwner: TComponent);
{$IFDEF ANDROID}
var
  aFMXApplicationEventService: IFMXApplicationEventService;
{$ENDIF}
begin
  inherited Create(AOwner);
  {$IFDEF ANDROID}
  FMonitorClipboard := False;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService,
    IInterface(FClipboardService)) then
  begin
    FClipboardService := nil;
    Log.d('Clipboard Service is not supported.');
  end;
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService,
    IInterface(aFMXApplicationEventService)) then
    aFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent)
  else
    Log.d('Application Event Service is not supported.');
  {$ENDIF}
  FBarcodeTypes := [btOneD, btQRCode, btProduct, btDataMatrix];
end;

destructor TBarcodeScanner.Destroy;
begin
  inherited Destroy;
end;

procedure TBarcodeScanner.Scan;
{$IFDEF ANDROID}
var
  Intent: JIntent;
{$ENDIF}
begin
  {$IFDEF ANDROID}
  if Assigned(FClipboardService) then
  begin
    FPreservedClipboardValue := FClipboardService.GetClipboard;
    FMonitorClipboard := True;
    FClipboardService.SetClipboard('');
    Intent := TJIntent.JavaClass.Init(StringToJString('com.google.zxing.client.android.SCAN'));
    with Intent do
    begin
      SetPackage(StringToJString('com.google.zxing.client.android'));
      PutExtra(StringToJString('SCAN_MODE'), StringToJString(GetScanCommand));
    end;
    SharedActivityContext.StartActivity(Intent);
  end;
  {$ENDIF}
end;

{$IFDEF ANDROID}
function TBarcodeScanner.HandleAppEvent(AAppEvent:
  TApplicationEvent; AContext: TObject): Boolean;
begin
  Result := False;
  if FMonitorClipboard and (AAppEvent = TApplicationEvent.aeBecameActive) then
  begin
    FMonitorClipboard := False;
    if FClipboardService.GetClipboard.ToString <> '' then
      if Assigned(FOnScanResult) then
        FOnScanResult(Self, FClipboardService.GetClipboard.ToString)
      else
    else
      if Assigned(FOnScanAbort) then
        FOnScanAbort(Self);
    FClipboardService.SetClipboard(FPreservedClipboardValue);
    Result := True;
  end;
end;

function TBarcodeScanner.GetScanCommand: string;
var
  BarcodeType: TBarcodeType;
begin
  Result := '';
  for BarcodeType in FBarcodeTypes do
    Result := Result + ',' + BarcodeTypeName[BarcodeType];
end;
{$ENDIF}

end.
