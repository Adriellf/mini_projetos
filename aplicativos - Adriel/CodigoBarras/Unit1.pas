unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation,

  {$IFDEF ANDROID}
     Androidapi.JNI.JavaTypes,
     Androidapi.JNI.GraphicsContentViewText,
     FMX.Helpers.Android,
     Androidapi.Helpers,
     Androidapi.NativeActivity,
     Androidapi.JNIBridge,
     IdURI,
     Androidapi.Jni.Net,
  {$ENDIF}

  {$IF defined(IOS)}
    DPF.iOS.BaseControl, DPF.iOS.BarCodeReader,
  {$ENDIF}


   FMX.Edit, DataPak.Android.BarcodeScanner;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    BarcodeScanner1: TBarcodeScanner;
    procedure BarcodeScanner1ScanResult(Sender: TObject; AResult: string);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  {$IFDEF IOS}
    CodeBarIOS : TDPFQRCodeScanner;
    Procedure CodeBarIOSResultScan(Sender: TObject; AText: string);
  {$ENDIF}

  {$IFDEF ANDROID}
   Function AppBarcodeScanInstalado : Boolean;
  {$ENDIF}

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }
  {$IFDEF ANDROID}
function TForm1.AppBarcodeScanInstalado: Boolean;
var

 Intent : JIntent;
 Info: JApplicationInfo;
begin


   Try

      Result := False;
      Info := SharedActivityContext.getPackageManager.getApplicationInfo(
            StringToJString('com.google.zxing.client.android'),0);

      if Info.packageName.equals(StringToJString('com.google.zxing.client.android')) then
      Begin

        Result := True;

      End;

    Except on E: Exception do
    begin


     Try
      Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
      Intent.setData(TJnet_Uri.JavaClass.parse(StringToJString(
        'https://play.google.com/store/apps/details?id=com.google.zxing.client.android')));
      Intent.setPackage(StringToJString('com.android.vending'));
      SharedActivity.startActivity(intent);
      SharedActivity.finishActivity(0);
      Except
          ShowMessage('Erro ao abrir o Google Play !');
        End;
    End;


  end;

end;
{$ENDIF}

procedure TForm1.BarcodeScanner1ScanResult(Sender: TObject; AResult: string);
begin

 Edit1.Text := AResult;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin

   {$IFDEF ANDROID}

       if AppBarcodeScanInstalado then
       BarcodeScanner1.Scan;

   {$ENDIF}

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  {$IFDEF IOS}

     if Not Assigned(CodeBarIOS) then
     CodeBarIOS := TDPFQRCodeScanner.Create( Self );

     CodeBarIOS.Name    := 'CodeBarIOSResult';
     CodeBarIOS.Parent  := Self;
     CodeBarIOS.Align   := TAlignLayout.Bottom;
     CodeBarIOS.Visible := True;
     CodeBarIOS.Margins.Left   := 10;
     CodeBarIOS.Margins.Right  := 10;
     CodeBarIOS.Margins.Bottom := 10;
     CodeBarIOS.Margins.Top    := 10;
     CodeBarIOS.OnScan  := CodeBarIOSResultScan;

  {$ENDIF}

end;

{$IFDEF IOS}
procedure TForm1.CodeBarIOSResultScan(Sender: TObject; AText: string);
Begin

    Edit1.Text := AText;
End;
{$ENDIF}

end.
