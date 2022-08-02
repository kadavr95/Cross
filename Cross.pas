unit Cross;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus;

type
  TApp = class(TForm)
    AppMenu: TMainMenu;
    Mode1: TMenuItem;
    Rectangle1: TMenuItem;
    Circle1: TMenuItem;
    Help: TMenuItem;
    About1: TMenuItem;
    Window1: TMenuItem;
    Square1: TMenuItem;
    Custom1: TMenuItem;
    procedure DrawRectangle;
    procedure DrawCircle;
    procedure DrawGrid;
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Circle1Click(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure Custom1Click(Sender: TObject);
    procedure Square1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    size, lineWidth: integer;
    appMode, resizingMode: string;
  public
    { Public declarations }
  end;

var
  App: TApp;

implementation

{$R *.dfm}

uses About;

procedure TApp.Rectangle1Click(Sender: TObject);
begin
  Rectangle1.Checked := True;
  Circle1.Checked := False;
  appMode := 'Rectangle';
  DrawRectangle();
end;

procedure TApp.About1Click(Sender: TObject);
begin
  AboutForm.Show();
end;

procedure TApp.Circle1Click(Sender: TObject);
begin
  Circle1.Checked := True;
  Rectangle1.Checked := False;
  appMode := 'Circle';
  DrawCircle();
end;

procedure TApp.Square1Click(Sender: TObject);
begin
  Square1.Checked := True;
  Custom1.Checked := False;
  resizingMode := 'Square';
  App.BorderIcons := [biSystemMenu, biMinimize];
  App.ClientWidth := App.ClientHeight;
end;

procedure TApp.Custom1Click(Sender: TObject);
begin
  Custom1.Checked := True;
  Square1.Checked := False;
  resizingMode := 'Custom';
  App.BorderIcons := [biSystemMenu, biMinimize, biMaximize];
end;

procedure TApp.DrawRectangle();
var
  centerX, centerY: real;
begin
  centerX := App.ClientWidth / 2;
  centerY := App.ClientHeight / 2;

  App.Canvas.Refresh;
  App.Canvas.Brush.Color := clFuchsia;
  App.Canvas.Rectangle(0, 0, App.ClientWidth, App.ClientHeight);

  App.Canvas.Pen.Color := clRed;
  App.Canvas.Pen.Width := lineWidth;

  App.Canvas.MoveTo(round(centerX - size / 2), 0);
  App.Canvas.LineTo(round(centerX - size / 2), App.Height);
  App.Canvas.MoveTo(round(centerX + size / 2), 0);
  App.Canvas.LineTo(round(centerX + size / 2), App.Height);

  App.Canvas.MoveTo(0, round(centerY - size / 2));
  App.Canvas.LineTo(App.Width, round(centerY - size / 2));
  App.Canvas.MoveTo(0, round(centerY + size / 2));
  App.Canvas.LineTo(App.Width, round(centerY + size / 2));

  App.Canvas.Pen.Color := clBlack;
  App.Canvas.Pen.Width := 1;
end;

procedure TApp.DrawCircle();
var
  centerX, centerY: real;
begin
  centerX := App.ClientWidth / 2;
  centerY := App.ClientHeight / 2;

  App.Canvas.Refresh;
  App.Canvas.Brush.Color := clFuchsia;
  App.Canvas.Rectangle(0, 0, App.ClientWidth, App.ClientHeight);

  App.Canvas.Pen.Color := clRed;
  App.Canvas.Pen.Width := lineWidth;

  App.Canvas.Ellipse(round(centerX - size / 2), round(centerY - size / 2),
    round(centerX + size / 2), round(centerY + size / 2));

  App.Canvas.MoveTo(round(centerX), 0);
  App.Canvas.LineTo(round(centerX), App.Height);
  App.Canvas.MoveTo(0, round(centerY));
  App.Canvas.LineTo(App.Width, round(centerY));

  App.Canvas.Pen.Color := clBlack;
  App.Canvas.Pen.Width := 1;
end;

procedure TApp.DrawGrid();
begin
  if appMode = 'Rectangle' then
    DrawRectangle()
  else
    DrawCircle();
end;

procedure TApp.FormCreate(Sender: TObject);
begin
  appMode := 'Rectangle';
  size := 10;
  lineWidth := 1;
end;

procedure TApp.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  App.DoubleBuffered := True;
  if Key = 38 then
  begin
    lineWidth := lineWidth + 1;
  end;
  if Key = 40 then
  begin
    lineWidth := lineWidth - 1;
  end;

  DrawGrid();
end;

procedure TApp.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  App.DoubleBuffered := True;
  if ssShift in Shift then
    size := size - 100
  else if ssCtrl in Shift then
    size := size - 10
  else
    size := size - 1;

  DrawGrid();
end;

procedure TApp.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  App.DoubleBuffered := True;
  if ssShift in Shift then
    size := size + 100
  else if ssCtrl in Shift then
    size := size + 10
  else
    size := size + 1;

  DrawGrid();
end;

procedure TApp.FormPaint(Sender: TObject);
begin
  DrawGrid();
end;

procedure TApp.FormResize(Sender: TObject);
begin
  if resizingMode = 'Square' then
  begin
    App.DoubleBuffered := False;
    if (App.ClientWidth <> App.ClientHeight) then
      App.ClientHeight := App.ClientWidth
    else
      App.DoubleBuffered := True;
  end;

  DrawGrid();
end;

end.
