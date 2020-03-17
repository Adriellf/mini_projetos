unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.ListBox, FMX.MultiView,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Colors,
  System.StrUtils,IdAntiFreezeBase, Client_Tools,
  Chat_Tools,System.Math;

type
  TfPrincipal = class(TForm)
    recfundo: TRectangle;
    rectop: TRectangle;
    btnContatos: TButton;
    ShadowEffect1: TShadowEffect;
    btnConfig: TButton;
    pnConfig: TRectangle;
    lbEdtServidor: TEdit;
    lbEdtNick: TEdit;
    btnConecta: TRoundRect;
    ShadowEffect2: TShadowEffect;
    lbconecta: TLabel;
    lbEdtPorta: TEdit;
    memo1: TMemo;
    MultiView1: TMultiView;
    checkListUsuario: TListBox;
    Label2: TLabel;
    confimar: TButton;
    cboxReservado: TCheckBox;
    recbottom: TRectangle;
    ShadowEffect3: TShadowEffect;
    ColorBox1: TColorBox;
    lbEdtMsg: TEdit;
    btnEnviar: TButton;
    Label3: TLabel;
    IdTCPClient1: TIdTCPClient;
    ScrollBox1: TScrollBox;
    LyALL: TLayout;
    Rectangle1: TRectangle;
   // IdAntiFreeze1: TIdAntiFreeze;
    procedure btnConfigClick(Sender: TObject);
    procedure confimarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConectaClick(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure lbEdtNickChange(Sender: TObject);
    procedure lbEdtMsgKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure checkListUsuarioChangeCheck(Sender: TObject);
  private
    { Private declarations }


    procedure desconectou;
    procedure ShowReceiveMsg;
    procedure ListUsers;
    procedure UnknowCmd;
    procedure NickExistente;
    procedure ShowServerError;
    procedure SetCaptionAndAppTitle(Text: String);




    //retorna a lista dos usuários checkados (no CheckListBox) numa string separada por virgula
    function GetUserList: String;

    //descobre quantos itens estão checados (marcados)
    function CheckedUserCount: Integer;

    //marca ou desmarca (propriedade checked do checklistbox) todos os items do checklistbox de usuários
    procedure SetChecked(Value: Boolean);
  public
    { Public declarations }
  end;

  TClientThread = class(TThread)
  protected
    procedure Execute; override;
    procedure Terminado(Sender: TObject);
  public
    constructor Create(CreateSuspended: Boolean);
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.fmx}

procedure TfPrincipal.btnConectaClick(Sender: TObject);
begin
  if IdTCPClient1.Connected then
  begin
    IdTCPClient1.Disconnect;
    pnConfig.Visible:=false;
  end
  else
  begin
    //IdTCPClient1.Host := lbEdtServidor.Text;
  //  IdTCPClient1.Port := StrToInt(lbEdtPorta.Text);
    try
      //alterada propriedade connectTimeout
      IdTCPClient1.Connect;
      pnConfig.Visible:=false;
    except
      on e: Exception do
      begin
        if pos('connection refused',AnsiLowerCase(e.message)) > 0 then
          showmessage('Conexão recusada. Talvez o servidor esteja fora do ar.');
      end;
    end;
  end;
end;

procedure TfPrincipal.btnConfigClick(Sender: TObject);
begin
  pnConfig.Visible:=true;
end;

procedure TfPrincipal.btnEnviarClick(Sender: TObject);
begin
     //no indy 9 era IdTCPClient1.WriteLn
  IdTCPClient1.IOHandler.WriteLn(FormatChatMessage(lbEdtMsg.Text,lbEdtNick.Text,GetUserList,cboxReservado.isChecked));
  lbEdtMsg.SetFocus;
  lbEdtMsg.SelectAll;
end;


function TfPrincipal.CheckedUserCount: Integer;
var i: integer;
begin
  result:= 0;
  for i:= 0 to checkListUsuario.Items.Count -1 do
    if checkListUsuario.ListItems[i].isChecked then
       inc(result);
end;

procedure TfPrincipal.checkListUsuarioChangeCheck(Sender: TObject);
begin
  {verifica que o usuário selecionou o primeiro item  (Todos) e se este
  está selecionado. Se estiver, então deve desmarcar todos os outros itens
  pois o primeiro item já é pra enviar msg pra todos os usuários}

  if checkListUsuario.ListItems[0].IsSelected and checkListUsuario.ListItems[0].isChecked then
  begin
     SetChecked(false);
     checkListUsuario.ListItems[0].isChecked:= true;
  end
  else if CheckedUserCount > 1 then
     checkListUsuario.ListItems[0].isChecked:= false;

  cboxReservado.Enabled := not  checkListUsuario.ListItems[0].isChecked;
  if not cboxReservado.Enabled then
     cboxReservado.IsChecked:= false;

  btnEnviar.Enabled := (CheckedUserCount > 0) and (trim(lbEdtMsg.Text) <> '');
end;

procedure TfPrincipal.confimarClick(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

procedure TfPrincipal.desconectou;
begin
  lbconecta.text:= 'Conectar';

  lbEdtServidor.Enabled := true;
  //lbEdtServidor.Color := ColorEnabled[lbEdtServidor.Enabled];
  lbEdtNick.Enabled := true;
  lbEdtNick.SetFocus;
  lbEdtNick.enabled:= true;
  lbEdtPorta.Enabled := true;
  lbEdtPorta.enabled := true;
end;

procedure TfPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IdTCPClient1.Disconnect;
end;





procedure TfPrincipal.FormShow(Sender: TObject);
begin
  desconectou;

  if not IdTCPClient1.Connected then pnConfig.Visible:=true;
  
end;





function TfPrincipal.GetUserList: String;
var i: integer;
begin
  result:= '';
  for i:= 0 to checkListUsuario.Items.Count -1 do
    if checkListUsuario.ListItems[i].isChecked then
      result:= result + checkListUsuario.Items[i] + ';';
  delete(result,length(result),1);
end;

procedure TfPrincipal.IdTCPClient1Connected(Sender: TObject);
begin
   IdTCPClient1.IOHandler.WriteLn('nick='+lbEdtNick.Text);
  //ScrollBox1.Visible := true;
  lbconecta.text := 'Disconectar';
 // StatusBar1.Panels[0].text:= 'Conectado ao servidor remoto';
  TClientThread.Create(false);
  SetCaptionAndAppTitle('Indy Chat Client - ' + lbEdtNick.Text);
  Memo1.Lines.Clear;
  lbEdtServidor.Enabled := false;
  //lbEdtServidor.Color := ColorEnabled[lbEdtServidor.Enabled];
  lbEdtNick.Enabled := false;
  //lbEdtNick.Color := ColorEnabled[lbEdtNick.Enabled];
  lbEdtPorta.Enabled := false;
 // lbEdtPorta.Color := ColorEnabled[lbEdtPorta.Enabled];
  checkListUsuario.SetFocus;
end;

procedure TfPrincipal.lbEdtMsgKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
     {o usuário não pode utilizar # pois este é um caracter de controle usado
  nos parâmetros das mensagens enviadas e recebidas}
end;

procedure TfPrincipal.lbEdtNickChange(Sender: TObject);
begin
  lbconecta.Enabled :=
  (trim(lbEdtServidor.Text) <> '') and
  (trim(lbEdtPorta.Text) <> '') and
  (trim(lbEdtNick.Text) <> '');
end;

procedure TfPrincipal.ListUsers;
begin
  checkListUsuario.Items.Text := cmd.Values['list_user'];
  checkListUsuario.Items.Text:=AnsiReplaceText(checkListUsuario.Items.Text,';',#13);
  if checkListUsuario.Items.Count > 0 then
  begin
    //deleta o nome do próprio usuário da lista para que ele não mande msg para ele mesmo
    checkListUsuario.Items.Delete(checkListUsuario.Items.IndexOf(lbEdtNick.Text));
    checkListUsuario.ItemIndex := 0;
  end;
  lbEdtMsg.Enabled := checkListUsuario.Items.Count > 0;
  if checkListUsuario.Items.Count = 1 then
     checkListUsuario.ListItems[0].isChecked:= true;
end;

procedure TfPrincipal.NickExistente;
var msg: String;
begin
  msg:= copy(cmd.text,16,length(cmd.text));
  showmessage('NICK JÁ EXISTE');
  IdTCPClient1.Disconnect;
end;



procedure TfPrincipal.SetCaptionAndAppTitle(Text: String);
begin
  Caption:= Text;
  Application.Title := Caption;
end;

procedure TfPrincipal.SetChecked(Value: Boolean);
var i: integer;
begin
  for i:= 0 to checkListUsuario.Items.Count -1 do
     checkListUsuario.ListItems[i].isChecked:= value;
end;

procedure TfPrincipal.ShowReceiveMsg;
begin
   memo1.lines.add(ReceiveMsg(cmd.text));
 { if not Fprincipal.Active then
  begin
     SetForegroundWindow(Handle);
     Fprincipal.Activate;
  end;}
end;

procedure TfPrincipal.ShowServerError;
var msg: String;
begin
  msg:= copy(cmd.text,14,length(cmd.text));
  memo1.lines.Add('Erro no Servidor: ' + msg);
end;

procedure TfPrincipal.UnknowCmd;
begin
  Memo1.Lines.add(cmd.text);
end;



procedure TClientThread.Execute;
begin
  inherited;
  with fPrincipal do
  begin
    if not IdTCPClient1.Connected then
       exit;
    repeat
      try
        //no indy 9 era IdTCPClient1.ReadLn;
        cmd.text:= IdTCPClient1.IOHandler.ReadLn;
        if trim(cmd.text) <> '' then
        begin
          if VerificaComando(cmd.text,'msg=',true) then
             Synchronize(ShowReceiveMsg)
          else if VerificaComando(cmd.text,'list_user=',true) then
             Synchronize(ListUsers)
          else if VerificaComando(cmd.text,'nick_existente=',true) then
             Synchronize(NickExistente)
          else if VerificaComando(cmd.text,'server_error=',true) then
             Synchronize(ShowServerError)
          else Synchronize(UnknowCmd);
        end;
      except
        //código incluído
        on e: exception do
        begin
           if not AnsiSameText(e.message, 'Disconnected.') then
           begin
             ShowMessage( 'Erro');
             IdTCPClient1.Disconnect;
           end;
        end;
      end;
    until not IdTCPClient1.Connected;
  end;
  //Terminate;
end;


procedure TClientThread.Terminado(Sender: TObject);
begin
  ShowMessage('Terminou Thead');
  fPrincipal.desconectou;
end;



constructor TClientThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
 // Priority := tpIdle;
  FreeOnTerminate:= true;
  //código incluído
  OnTerminate := Terminado;
end;

end.
