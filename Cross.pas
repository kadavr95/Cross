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
    ShowGridSize: TMenuItem;
    Help1: TMenuItem;
    FreezePosition: TMenuItem;
    ShowSecondaryGrid: TMenuItem;
    procedure DrawRectangle;
    procedure DrawCircle;
    procedure DrawSecondaryGrid(x: real; y: real);
    procedure DrawGrid;
    procedure ResizeGrid(mode: integer; Shift: TShiftState);
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
    procedure FreezePositionClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShowGridSizeClick(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure ShowSecondaryGridClick(Sender: TObject);
  private
    size, sizeAdditional, sizeSecondary, lineWidth: integer;
    appMode, editMode, resizingMode: string;
  public
    { Public declarations }
  end;

var
  App: TApp;

implementation

{$R *.dfm}

uses About, Help;

procedure TApp.Rectangle1Click(Sender: TObject);
begin
  Rectangle1.Checked := True;
  Circle1.Checked := False;
  appMode := 'Rectangle';
  editMode := 'Main';
  DrawGrid();
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
  DrawGrid();
end;


procedure TApp.ShowSecondaryGridClick(Sender: TObject);
begin
  ShowSecondaryGrid.Checked := not ShowSecondaryGrid.Checked;
  DrawGrid();
end;

procedure TApp.ShowGridSizeClick(Sender: TObject);
begin
  ShowGridSize.Checked := not ShowGridSize.Checked;
  DrawGrid();
end;

procedure TApp.Square1Click(Sender: TObject);
begin
  Square1.Checked := True;
  Custom1.Checked := False;
  resizingMode := 'Square';
  App.BorderIcons := [biSystemMenu, biMinimize];
  App.ClientWidth := App.ClientHeight;
end;

procedure TApp.Help1Click(Sender: TObject);
begin
  HelpForm.Show();
end;

procedure TApp.Custom1Click(Sender: TObject);
begin
  Custom1.Checked := True;
  Square1.Checked := False;
  resizingMode := 'Custom';
  App.BorderIcons := [biSystemMenu, biMinimize, biMaximize];
end;


procedure TApp.FreezePositionClick(Sender: TObject);
begin
  FreezePosition.Checked := not FreezePosition.Checked;
  if (FreezePosition.Checked) then
   App.Align:=alCustom
  else
   App.Align:=alNone;
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

  if ShowSecondaryGrid.Checked then
    DrawSecondaryGrid(centerX, centerY);

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

  if ShowSecondaryGrid.Checked then
    DrawSecondaryGrid(centerX, centerY);

  App.Canvas.Pen.Color := clRed;
  App.Canvas.Pen.Width := lineWidth;

  App.Canvas.Brush.Style:=bsClear;

  App.Canvas.Ellipse(round(centerX - size / 2), round(centerY - size / 2),
    round(centerX + size / 2), round(centerY + size / 2));

  App.Canvas.Ellipse(round(centerX - sizeAdditional / 2),
    round(centerY - sizeAdditional / 2), round(centerX + sizeAdditional / 2),
    round(centerY + sizeAdditional / 2));

  App.Canvas.MoveTo(round(centerX), 0);
  App.Canvas.LineTo(round(centerX), App.Height);
  App.Canvas.MoveTo(0, round(centerY));
  App.Canvas.LineTo(App.Width, round(centerY));

  App.Canvas.Pen.Color := clBlack;
  App.Canvas.Pen.Width := 1;
end;

procedure TApp.DrawSecondaryGrid(x: real; y: real);
  var i: real;
begin
  App.Canvas.Pen.Color := clGray;
  App.Canvas.Pen.Width := 1;

  i := x;
  while i > 0 do
  begin
    App.Canvas.MoveTo(round(i), 0);
    App.Canvas.LineTo(round(i), App.Height);
    App.Canvas.MoveTo(round(i), 0);
    App.Canvas.LineTo(round(i), App.Height);

    i:= i - sizeSecondary;
  end;

  i := x + sizeSecondary;
  while i < App.Width do
  begin
    App.Canvas.MoveTo(round(i), 0);
    App.Canvas.LineTo(round(i), App.Height);
    App.Canvas.MoveTo(round(i), 0);
    App.Canvas.LineTo(round(i), App.Height);

    i:= i + sizeSecondary;
  end;

  i := y;
  while i > 0 do
  begin
    App.Canvas.MoveTo(0, round(i));
    App.Canvas.LineTo(App.Width, round(i));
    App.Canvas.MoveTo(0, round(i));
    App.Canvas.LineTo(App.Width, round(i));

    i:= i - sizeSecondary;
  end;

  i := y + sizeSecondary;
  while i < App.Height do
  begin
    App.Canvas.MoveTo(0, round(i));
    App.Canvas.LineTo(App.Width, round(i));
    App.Canvas.MoveTo(0, round(i));
    App.Canvas.LineTo(App.Width, round(i));

    i:= i + sizeSecondary;
  end;
end;

procedure TApp.ResizeGrid(mode: integer; Shift: TShiftState);
var
  tempSize: integer;
begin
  App.DoubleBuffered := True;

  if editMode = 'Main' then
    tempSize := size
  else if editMode = 'Additional' then
    tempSize := sizeAdditional
  else
    tempSize := sizeSecondary;

  if ssShift in Shift then
    tempSize := tempSize + 100 * mode
  else if ssCtrl in Shift then
    tempSize := tempSize + 10 * mode
  else
    tempSize := tempSize + mode;

  if editMode = 'Main' then
    size := tempSize
  else if editMode = 'Additional' then
    sizeAdditional := tempSize
  else
    sizeSecondary := tempSize;

  if size < 0 then
    size := 0;
  if sizeAdditional < 0 then
    sizeAdditional := 0;
  if sizeAdditional > size then
    sizeAdditional := size;
  if sizeSecondary < 1 then
    sizeSecondary := 1;


  DrawGrid();
end;

procedure TApp.DrawGrid();
begin
  if appMode = 'Rectangle' then
    DrawRectangle()
  else
    DrawCircle();
  App.Canvas.Font.Size:= 12;
  App.Canvas.Font.Color:= clRed;
  App.Canvas.Font.Quality:=fqnonAntiAliased;
  if ShowGridSize.Checked  then
  begin
    App.Canvas.TextOut(10,10, '⌀'+size.ToString);
    if appMode = 'Circle' then
      App.Canvas.TextOut(10,30, '⌀'+sizeAdditional.ToString);
    if ShowSecondaryGrid.Checked then
      App.Canvas.TextOut(10,50, '⌀'+sizeSecondary.ToString);
  end;
end;

procedure TApp.FormCreate(Sender: TObject);
begin
  appMode := 'Rectangle';
  editMode := 'Main';
  size := 100;
  sizeAdditional := 50;
  sizeSecondary := 50;
  lineWidth := 1;
end;

procedure TApp.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  speedModifier: integer;
begin
  App.DoubleBuffered := True;
  if Key = 190 then
  begin
    lineWidth := lineWidth + 1;
  end;
  if Key = 188 then
  begin
    lineWidth := lineWidth - 1;
    if lineWidth < 1 then
      lineWidth := 1
  end;

  if Key = 187 then
    ResizeGrid(1, Shift);
  if Key = 189 then
    ResizeGrid(-1, Shift);

  if ssShift in Shift then
    speedModifier := 100
  else if ssCtrl in Shift then
    speedModifier := 10
  else
    speedModifier := 1;

  if Key = 40 then
  begin
    App.Top := App.Top + speedModifier;
  end;
  if Key = 38 then
  begin
    App.Top := App.Top - speedModifier;
  end;
  if Key = 39 then
  begin
    App.Left := App.Left + speedModifier;
  end;
  if Key = 37 then
  begin
    App.Left := App.Left - speedModifier;
  end;

  if Key = 49 then
  begin
    editMode := 'Main';
  end;
  if Key = 50 then
  begin
    editMode := 'Additional';
  end;
  if Key = 48 then
  begin
    editMode := 'Secondary';
  end;

  DrawGrid();
end;

procedure TApp.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ResizeGrid(-1, Shift);
end;

procedure TApp.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ResizeGrid(1, Shift);
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
