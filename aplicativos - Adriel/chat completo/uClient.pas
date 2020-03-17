unit uClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Media, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, FMX.Objects,
  FMX.Effects, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TfrmPrincipal = class(TForm)
    Barra: TRectangle;
    spbMenu: TSpeedButton;
    spbShare: TSpeedButton;
    Titulo: TLabel;
    Rectangle: TRectangle;
    Shadow: TShadowEffect;
    Messagem: TText;
    IdUDPClient: TIdUDPClient;
    MediaPlayer: TMediaPlayer;
    Animation: TFloatAnimation;
    procedure RectangleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AnimationFinish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Micro: TAudioCaptureDevice;
    Index: integer;
    procedure StartRec;
    function Parada:string;
    function FileName:string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses IdGlobal,IOUtils;

{$R *.fmx}

procedure TfrmPrincipal.AnimationFinish(Sender: TObject);
begin
  StartRec;
end;

function TfrmPrincipal.FileName: string;
begin
  Index:= index+1;
  Result:= Format('TestAR %u.mp3',[Index]);
  Result:= Parada+Result;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Micro:= TCaptureDeviceManager.Current.DefaultAudioCaptureDevice;
  Rectangle.Enabled := Assigned(Micro);
  Index:=0;
  IdUDPClient.Host:= '192.168.100.4';
  IdUDPClient.Port:= 5556;
end;

function TfrmPrincipal.Parada: string;
begin
  {$IFDEF ANDROID}
    Result:= TPath.GetHomePath;
  {$ELSE}
    Result:= TPath.GetDocumentsPath+TPath.DirectorySeparatorChar+'NomedaPastaCriada';
    ForceDirectories(Result);
  {$ENDIF}
    Result:= Result + TPath.DirectorySeparatorChar;
end;

procedure TfrmPrincipal.RectangleClick(Sender: TObject);
begin
  if Rectangle.Fill.Color <> TAlphaColors.Red then
    begin
      Rectangle.Fill.Color := TAlphaColors.Red;
      StartRec;
      Messagem.Text:= 'Gravando audio...';
    end
  else
    begin
      Rectangle.Fill.Color := TAlphaColors.Blue;
      Messagem.Text:= 'Aperte o botão para falar!';
    end;
Rectangle.Repaint;
end;

procedure TfrmPrincipal.StartRec;
  var
  M:TMemoryStream;
  K:TIdBytes;
  B:TBytes;
  A,L:integer;
begin
  if Micro.State = TCaptureDeviceState.Capturing then
    begin
      Micro.StopCapture;
      M:=TMemoryStream.Create;
        if FileExists(Micro.FileName) then
          begin
            M.LoadFromFile(Micro.FileName);
            IdUDPClient.Send('StartFile',IndyTextEncoding_UTF8);
            IdUDPClient.Send(ExtractFileName(Micro.FileName),IndyTextEncoding_UTF8);
            IdUDPClient.Send('StartData',IndyTextEncoding_UTF8);
            M.Position:=0;
            L:=40;
            SetLength(K,L);
            SetLength(B,L);
            while M.Read(B,L) > 0 do
              begin
                for A := 0 to L-1 do K[A]:=B[A];
                  with IdUDPClient do SendBuffer(Host,Port,K);
                  for A := 0 to L-1 do B[A]:=0;
              end;
            IdUDPClient.Send('EndData',IndyTextEncoding_UTF8);
          end;
    end;
  if Rectangle.Fill.Color <> TAlphaColors.Red then Exit;
  Micro.FileName:= FileName;
  Micro.StartCapture;
  Animation.Start;
end;

end.
