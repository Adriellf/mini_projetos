unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,Androidapi.JNI.Network,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfPrincipal = class(TForm)
    WebBrowser1: TWebBrowser;
    btnFechaTeclado: TButton;
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
      LcTecladoAtivo:Boolean;
      FKBBounds: TRectF;
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.fmx}


procedure TfPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   WebBrowser1.Navigate('about:blank');
end;

procedure TfPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if not lctecladoativo then
    begin
      if   (WebBrowser1.URL = 'http://www.propizzasistema.com/logout') or  (WebBrowser1.URL ='http://www.propizzasistema.com/login') then
      begin
        key := 0;
        exit
      end else
      begin
        WebBrowser1.GoBack;
        key := 0;
        exit
      end;
    end
     else
    begin
      btnFechaTeclado.SetFocus;
      key := 0;
      exit
    end;
  end;
end;

procedure TfPrincipal.FormShow(Sender: TObject);
begin
  WebBrowser1.URL:='http://www.propizzasistema.com/login';
end;

procedure TfPrincipal.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  LcTecladoAtivo:=KeyboardVisible;
end;

procedure TfPrincipal.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  LcTecladoAtivo:=KeyboardVisible;
end;


end.
