unit uServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, FMX.Media, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  IdGlobal, IdSocketHandle, System.Generics.Collections,IOUtils;

type
  TDataTransRec = Record
  Block:TBytes;
  PeerIP:string;
  IdData:Byte;
  constructor Create(const aData:TIdBytes; const aPeerIp:string);
  function Info : string;
  function ToString: string;
  End;
  TfrmPrincipal = class(TForm)
    Memo: TMemo;
    Fundo: TRectangle;
    Titulo: TLabel;
    MediaPlayer: TMediaPlayer;
    IdUDPServer: TIdUDPServer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IdUDPServerUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
    Liste: TList<TDataTransRec>;
    StartPos:integer;
    procedure SaveFile(const aStart:integer);
    function Parada:string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


{$R *.fmx}

{ TDataTrasndRec }

constructor TDataTransRec.Create(const aData: TIdBytes; const aPeerIp: string);
  var S:String;
begin
  PeerIP := aPeerIp;
  SetLength(Block, Length(aData));
  System.Move(aData[0],Block[0],Length(aData));
  S:=ToString;
  IdData:=0;
  if Pos('StartFile',S) > 0 then IdData:=1;
  if Pos('StartData',S) > 0 then IdData:=3;
  if Pos('EndData',S) > 0 then IdData:=4;
end;

function TDataTransRec.Info: string;
begin
  Result:= ToString;
  if (Pos('StartFile',Result) > 0) or
  (Pos('StartData',Result) > 0) or
  (Pos('EndData',Result) > 0 )
  then Result := PeerIP+'->'+Result
  else Result:='';
end;

function TDataTransRec.ToString: string;
var
  A: Integer;
begin
  for A := 0 to Length(Block)-1 do
  Result:= Result+Char(Block[A]);
end;

{ TfrmPrincipal }

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Liste:= TList<TDataTransRec>.Create;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Liste);
end;

procedure TfrmPrincipal.IdUDPServerUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
  var
  W:TDataTransRec;
  S:String;
begin
  W:=TDataTransRec.Create(aData,ABinding.PeerIP);
  Liste.Add(W);
  S:=W.Info;
  if W.IdData = 1 then StartPos := Liste.Count-1;
  if W.IdData = 4 then SaveFile(StartPos);
  if S <> '' then Memo.Lines.Add(S)
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

procedure TfrmPrincipal.SaveFile(const aStart: integer);
  var
  A: integer;
  F: string;
  M:TMemoryStream;
begin
  A:= aStart+1;
  F:= Parada+Liste[A].ToString;
  A:=A+1;
  if (Liste[A].ToString = 'StartData')
  and (Liste[A].IdData = 3)then
    begin
      M:=TMemoryStream.Create;
      repeat
        Inc(A);
        if Liste[A].IdData = 0 then
        M.Write(Liste[A].Block, Length(Liste[A].Block))
      until Liste[A].IdData = 4;
      M.Position:=0;
      M.SaveToFile(F);
      M.Free;
      Liste.Clear;
      MediaPlayer.FileName:= F;
      MediaPlayer.Play;
    end;
end;

end.
