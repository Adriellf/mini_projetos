unit strak.GPOS700.printer;

interface

uses

  System.Classes,
  System.SysUtils,
  Androidapi.JNI.Widget,
  Androidapi.JNI.App,
  Androidapi.Helpers,
  FMX.Helpers.Android,
  Androidapi.JNI.JavaTypes,
  FMX.Graphics,
  Androidapi.JNI.GraphicsContentViewText,
  libppcomp,
  FMX.Surfaces,
  Androidapi.JNIBridge,
  System.UITypes;

type

  TAlign = (LEFT = 0, CENTER = 1, RIGHT = 2);

  TBarcodeWidth = (SMALL = 0, NORMAL = 1, LARGE = 2, HUGE = 3);

  TBarcodeType = (AZTEC = 0, CODABAR = 1, CODE_39 = 2, CODE_93 = 3,
    CODE_128 = 4, DATA_MATRIX = 5, EAN_8 = 6, EAN_13 = 7, ITF = 8, MAXICODE = 9,
    PDF_417 = 10, QR_CODE = 11, RSS_14 = 12, RSS_EXPANDED = 13, UPC_A = 14,
    UPC_E = 15, UPC_EAN_EXTENSION = 16);

  TFont = (DEFAULT = 0, MONOSPACE = 1, SERIF = 2, SANS_SERIF = 3,
    DEFAULT_BOLD = 4);

  TArrayInt = array of integer;

  TPrinterGPOS700 = class
    FPrinter: Jlibbasebinder_Printer;
    destructor Destroy; override;
  public
    initialized: boolean;
    constructor create;
    function getPrinterStatus(P1: TArrayInt): integer;
    function printBarCode(P1: String; P2: integer; P3: boolean): integer;
    function printBarCodeBase(P1: String; P2: TBarcodeType; P3: TBarcodeWidth;
      P4: integer; P5: integer): integer;
    function printFinish: integer;
    function printImage(P1: TBitmap; P2: integer; P3: TAlign): integer;
    function printImageBase(P1: TBitmap; P2: integer; P3: integer; P4: TAlign;
      P5: integer): integer;
    function printInit: integer;
    function printPaper(P1: integer): integer;
    function printQRCode(P1: String): integer;
    function printString(P1: String; P2: integer; P3: TAlign; P4: boolean;
      P5: boolean): integer;
    function printStringBase(P1: String; P2: integer; P3: Single; P4: Single;
      P5: integer; P6: TAlign; P7: boolean; P8: boolean; P9: boolean): integer;
    function printStringExt(P1: String; P2: integer; P3: Single; P4: Single;
      P5: TFont; P6: integer; P7: TAlign; P8: boolean; P9: boolean;
      P10: boolean): integer;
  end;

var
  PrinterGPOS700: TPrinterGPOS700;

implementation

procedure execInThread(proc: Tproc);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.CurrentThread.FreeOnTerminate := true;
      if @proc <> nil then
        proc;
    end).Start;
end;

function STJ(text: string): Jstring;
begin
  result := stringToJstring(text);
end;

function JST(text: Jstring): string;
begin
  result := JStringToString(text);
end;

function JBitmapToBitmap(const AImage: JBitmap): TBitmap;
var
  ImageData: TJavaArray<integer>;
  BitmapData: TBitmapData;
  Width, Height: integer;
begin
  Assert(AImage <> nil);
  Width := AImage.getWidth;
  Height := AImage.getHeight;
  ImageData := TJavaArray<integer>.create(Width * Height);
  AImage.getPixels(ImageData, 0, Width, 0, 0, Width, Height);

  result := TBitmap.create(Width, Height);
  if result.Map(TMapAccess.maWrite, BitmapData) then
  begin
    try
      Move(ImageData.Data^, BitmapData.Data^, Width * Height * SizeOf(integer));
    finally
      result.Unmap(BitmapData);
    end
  end
  else
    result := nil;
end;

function BitmapToJBitmap(const ABitmap: TBitmap): JBitmap;
var
  BitmapSurface: TBitmapSurface;
begin
  Assert(ABitmap <> nil);

  result := TJBitmap.JavaClass.createBitmap(ABitmap.Width, ABitmap.Height,
    TJBitmap_Config.JavaClass.ARGB_8888);
  BitmapSurface := TBitmapSurface.create;
  try
    BitmapSurface.Assign(ABitmap);
    if not SurfaceToJBitmap(BitmapSurface, result) then
      result := nil;
  finally
    BitmapSurface.Free;
  end;
end;

{ auxiliares }

function getTFont(value: TFont): JPrinter_Font;
begin
  case value of
    DEFAULT:
      result := TJPrinter_Font.JavaClass.DEFAULT;
    MONOSPACE:
      result := TJPrinter_Font.JavaClass.MONOSPACE;
    SERIF:
      result := TJPrinter_Font.JavaClass.SERIF;
    SANS_SERIF:
      result := TJPrinter_Font.JavaClass.SANS_SERIF;
    DEFAULT_BOLD:
      result := TJPrinter_Font.JavaClass.DEFAULT_BOLD;
  end;
end;

function getTAlign(value: TAlign): JPrinter_Align;
begin
  result := TJPrinter_Align.JavaClass.LEFT;
  case value of
    LEFT:
      result := TJPrinter_Align.JavaClass.LEFT;
    CENTER:
      result := TJPrinter_Align.JavaClass.CENTER;
    RIGHT:
      result := TJPrinter_Align.JavaClass.RIGHT;
  end;
end;

function getTBarcodeType(value: TBarcodeType): JPrinter_BarcodeType;
begin
  result := TJPrinter_BarcodeType.JavaClass.QR_CODE; // default
  case value of
    AZTEC:
      result := TJPrinter_BarcodeType.JavaClass.AZTEC;
    CODABAR:
      result := TJPrinter_BarcodeType.JavaClass.CODABAR;
    CODE_39:
      result := TJPrinter_BarcodeType.JavaClass.CODE_39;
    CODE_93:
      result := TJPrinter_BarcodeType.JavaClass.CODE_93;
    CODE_128:
      result := TJPrinter_BarcodeType.JavaClass.CODE_128;
    DATA_MATRIX:
      result := TJPrinter_BarcodeType.JavaClass.DATA_MATRIX;
    EAN_8:
      result := TJPrinter_BarcodeType.JavaClass.EAN_8;
    EAN_13:
      result := TJPrinter_BarcodeType.JavaClass.EAN_13;
    ITF:
      result := TJPrinter_BarcodeType.JavaClass.ITF;
    MAXICODE:
      result := TJPrinter_BarcodeType.JavaClass.MAXICODE;
    PDF_417:
      result := TJPrinter_BarcodeType.JavaClass.PDF_417;
    QR_CODE:
      result := TJPrinter_BarcodeType.JavaClass.QR_CODE;
    RSS_14:
      result := TJPrinter_BarcodeType.JavaClass.RSS_14;
    RSS_EXPANDED:
      result := TJPrinter_BarcodeType.JavaClass.RSS_EXPANDED;
    UPC_A:
      result := TJPrinter_BarcodeType.JavaClass.UPC_A;
    UPC_E:
      result := TJPrinter_BarcodeType.JavaClass.UPC_E;
    UPC_EAN_EXTENSION:
      result := TJPrinter_BarcodeType.JavaClass.UPC_EAN_EXTENSION;
  end;
end;

function getTBarcodeWidth(value: TBarcodeWidth): JPrinter_BarcodeWidth;
begin
  result := TJPrinter_BarcodeWidth.JavaClass.NORMAL; // default
  case value of
    SMALL:
      result := TJPrinter_BarcodeWidth.JavaClass.SMALL;
    NORMAL:
      result := TJPrinter_BarcodeWidth.JavaClass.NORMAL;
    LARGE:
      result := TJPrinter_BarcodeWidth.JavaClass.LARGE;
    HUGE:
      result := TJPrinter_BarcodeWidth.JavaClass.HUGE;
  end;
end;

{ TPrinterGPOS700 }

constructor TPrinterGPOS700.create;
begin
  FPrinter := TJlibbasebinder_Printer.JavaClass.init(TAndroidHelper.Context);
end;

destructor TPrinterGPOS700.Destroy;
begin
  FPrinter := nil;
  inherited;
end;

function TPrinterGPOS700.getPrinterStatus(P1: TArrayInt): integer;
var
  p1x: TJavaArray<integer>;
  x: longint;
begin
  p1x := TJavaArray<integer>.create(length(P1));
  for x := low(P1) to high(P1) do
    p1x.Items[x] := P1[x];
  result := FPrinter.getPrinterStatus(p1x);
end;

function TPrinterGPOS700.printBarCode(P1: String; P2: integer;
P3: boolean): integer;
begin
  result := FPrinter.printBarCode(STJ(P1), P2, P3);
end;

function TPrinterGPOS700.printBarCodeBase(P1: String; P2: TBarcodeType;
P3: TBarcodeWidth; P4, P5: integer): integer;

begin
  result := FPrinter.printBarCodeBase(STJ(P1), getTBarcodeType(P2),
    getTBarcodeWidth(P3), P4, P5);
end;

function TPrinterGPOS700.printFinish: integer;
begin
  result := FPrinter.printFinish;
  initialized := false;
end;

function TPrinterGPOS700.printImage(P1: TBitmap; P2: integer;
P3: TAlign): integer;
begin
  result := FPrinter.printImage(BitmapToJBitmap(P1), P2, getTAlign(P3));
end;

function TPrinterGPOS700.printImageBase(P1: TBitmap; P2, P3: integer;
P4: TAlign; P5: integer): integer;
begin
  result := FPrinter.printImageBase(BitmapToJBitmap(P1), P2, P3,
    getTAlign(P4), P5);
end;

function TPrinterGPOS700.printInit: integer;
begin
  result := FPrinter.printInit;
  initialized := true;
end;

function TPrinterGPOS700.printPaper(P1: integer): integer;
begin
  result := FPrinter.printPaper(P1);
end;

function TPrinterGPOS700.printQRCode(P1: String): integer;
begin
  result := FPrinter.printQRCode(STJ(P1));
end;

function TPrinterGPOS700.printString(P1: String; P2: integer; P3: TAlign;
P4, P5: boolean): integer;
begin
  result := FPrinter.printString(STJ(P1), P2, getTAlign(P3), P4, P5);
end;

function TPrinterGPOS700.printStringBase(P1: String; P2: integer;
P3, P4: Single; P5: integer; P6: TAlign; P7, P8, P9: boolean): integer;
begin
  result := FPrinter.printStringBase(STJ(P1), P2, P3, P4, P5, getTAlign(P6),
    P7, P8, P9);
end;

function TPrinterGPOS700.printStringExt(P1: String; P2: integer; P3, P4: Single;
P5: TFont; P6: integer; P7: TAlign; P8, P9, P10: boolean): integer;
begin
  result := FPrinter.printStringExt(STJ(P1), P2, P3, P4, getTFont(P5), P6,
    getTAlign(P7), P8, P9, P10);
end;

initialization

TThread.CreateAnonymousThread(
  procedure
  begin
    TThread.CurrentThread.FreeOnTerminate := true;
    PrinterGPOS700 := TPrinterGPOS700.create;
  end).Start;

finalization

PrinterGPOS700.Free;

end.

(*
  // olhar depois este comando  CallInUIThreadAndWaitFinishing

  CallInUIThreadAndWaitFinishing(procedure
  begin
  FToast.setDuration(Duration.ToJDuration);
  end); *)
