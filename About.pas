unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, shellapi;

type
  TAboutForm = class(TForm)
    AppName: TStaticText;
    Version: TStaticText;
    Copyright: TStaticText;
    Image1: TImage;
    procedure CopyrightClick(Sender: TObject);
    procedure AppNameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

procedure TAboutForm.AppNameClick(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'https://github.com/DiminiInc/Cross', nil, nil, SW_SHOW);
end;

procedure TAboutForm.CopyrightClick(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'https://dimini.dev/', nil, nil, SW_SHOW);
end;

end.
