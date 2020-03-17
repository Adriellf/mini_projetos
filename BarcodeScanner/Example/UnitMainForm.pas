unit UnitMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Memo, FMX.StdCtrls, DataPak.Android.BarcodeScanner;

type
  TMainForm = class(TForm)
    ButtonScan: TButton;
    MemoScanResult: TMemo;
    BarcodeScanner: TBarcodeScanner;
    procedure ButtonScanClick(Sender: TObject);
    procedure BarcodeScannerScanResult(Sender: TObject; AResult: string);
    procedure BarcodeScannerScanAbort(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.BarcodeScannerScanAbort(Sender: TObject);
begin
  MemoScanResult.Lines.Add('--- ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' ---');
  MemoScanResult.Lines.Add('Scanning aborted');
end;

procedure TMainForm.BarcodeScannerScanResult(Sender: TObject; AResult: string);
begin
  MemoScanResult.Lines.Add('--- ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' ---');
  MemoScanResult.Lines.Add(AResult);
end;

procedure TMainForm.ButtonScanClick(Sender: TObject);
begin
   BarcodeScanner.Scan;
end;

end.
