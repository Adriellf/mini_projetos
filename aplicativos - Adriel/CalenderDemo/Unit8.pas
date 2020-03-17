unit Unit8;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.DateTimeCtrls, FMX.StdCtrls,FMX.Helpers.Android,Androidapi.JNI.provider, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Net, Androidapi.Jni.App,
  Androidapi.JNIBridge, dateutils,
  CalendarEventsManager, FMX.Layouts, FMX.ListBox;

type
  TForm8 = class(TForm)
    CalendarEdit1: TCalendarEdit;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button5: TButton;
    ListBox1: TListBox;
    Button6: TButton;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
   fManager : TCalendarEventsManager;
  public
    { Déclarations publiques }
  end;

var
  Form8: TForm8;

implementation

{$R *.fmx}


procedure TForm8.Button1Click(Sender: TObject);
var wStrlist : TStringList;
begin
  wStrlist := fManager.GetAvailableCalendars;
  try
    ShowMessage( wStrlist.Text );
  finally
    wStrlist.Free;
  end;

end;

procedure TForm8.Button4Click(Sender: TObject);
begin
  if fManager.DeleteReminder(StrToInt(Edit1.Text)) then
    showmessage('deleted')
  else
    showmessage('failed');
end;

procedure TForm8.Button5Click(Sender: TObject);
var wId : integer;
begin
   wId := fManager.AddNewReminder(CalendarEdit1.Date, Edit2.Text);
   ListBox1.Items.Add(inttostr(wId));
end;

procedure TForm8.Button6Click(Sender: TObject);
begin
  fManager.UpdateReminder(StrToInt(ListBox1.Items[ListBox1.ItemIndex]),CalendarEdit1.Date, Edit2.Text );
end;

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fManager.Free;
end;

procedure TForm8.FormCreate(Sender: TObject);
begin
  fManager := TCalendarEventsManager.Create;
end;

end.
