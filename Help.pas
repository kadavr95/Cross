unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX,
  Vcl.OleCtrls, SHDocVw, Vcl.Edge, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.DBCtrls;

type
  THelpForm = class(TForm)
    UserManual: TRichEdit;
    procedure UserManualWindowProc(var msg: TMessage);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HelpForm: THelpForm;
  InitialUserManualWindowProc : TWndMethod;

implementation

{$R *.dfm}

procedure THelpForm.FormCreate(Sender: TObject);
begin
  UserManual.Clear;
  UserManual.SelAttributes.Size := 26;
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := 'Controls'+#10;
  UserManual.SelText := '- change main grid type ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := '(lines/circles) ';
  UserManual.SelAttributes.Style := [];
  UserManual.SelText := 'via app menu'+#10#13;
  UserManual.SelText := '- select main grid element to resize via buttons ';
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := '1 ';
  UserManual.SelAttributes.Style := [];
  UserManual.SelText := 'and ';
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := '2 ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := '(circles mode only)';
  UserManual.SelAttributes.Style := [];
  UserManual.SelText := ' or secondary grid through button ';
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := '0'+#10#13;
  UserManual.SelText := '- change grid element size via mouse scroll or via' +
    ' buttons ';
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := '- ';
  UserManual.SelAttributes.Style := [];
  UserManual.SelText := 'and ';
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := '+ ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := '(hold ';
  UserManual.SelAttributes.Style := [fsItalic, fsBold];
  UserManual.SelText := 'Ctrl ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := 'for x10 speed, ';
  UserManual.SelAttributes.Style := [fsItalic, fsBold];
  UserManual.SelText := 'Shift ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := 'for x100 speed)'+#10#13;
  UserManual.SelText := '- change main grid lines width via buttons ';
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := '< ';
  UserManual.SelAttributes.Style := [];
  UserManual.SelText := 'and ';
  UserManual.SelAttributes.Style := [fsBold];
  UserManual.SelText := '>'+#10#13;
  UserManual.SelText := '- move window using arrow keys ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := '(hold ';
  UserManual.SelAttributes.Style := [fsItalic, fsBold];
  UserManual.SelText := 'Ctrl ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := 'for x10 speed, ';
  UserManual.SelAttributes.Style := [fsItalic, fsBold];
  UserManual.SelText := 'Shift ';
  UserManual.SelAttributes.Style := [fsItalic];
  UserManual.SelText := 'for x100 speed)'+#10#13;
  UserManual.SelText := '- lock app to be only of square size via app menu' +
    #10#13;
  UserManual.SelText := '- lock app to prevent its movement around the screen' +
    ' via app menu';
  InitialUserManualWindowProc := UserManual.WindowProc;
  UserManual.WindowProc := UserManualWindowProc;
end;

procedure THelpForm.FormResize(Sender: TObject);
begin
  UserManual.Width := HelpForm.ClientWidth;
  UserManual.Height := HelpForm.ClientHeight;
end;

procedure THelpForm.UserManualWindowProc(var msg: TMessage);
begin
  InitialUserManualWindowProc(msg);
  if (msg.Msg = WM_PAINT) or (msg.Msg = WM_SETFOCUS) or (msg.Msg = WM_NCHITTEST) then HideCaret(UserManual.Handle);
end;

end.
