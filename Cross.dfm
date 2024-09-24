object App: TApp
  Left = 0
  Top = 0
  Caption = 'Cross'
  ClientHeight = 500
  ClientWidth = 500
  Color = clFuchsia
  TransparentColor = True
  TransparentColorValue = clFuchsia
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = AppMenu
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnPaint = FormPaint
  OnResize = FormResize
  TextHeight = 13
  object AppMenu: TMainMenu
    object Mode1: TMenuItem
      Caption = 'Mode'
      object Rectangle1: TMenuItem
        Caption = 'Rectangle'
        Checked = True
        RadioItem = True
        OnClick = Rectangle1Click
      end
      object Circle1: TMenuItem
        Caption = 'Circle'
        RadioItem = True
        OnClick = Circle1Click
      end
      object ShowSecondaryGrid: TMenuItem
        Caption = 'Show Secondary Grid'
        OnClick = ShowSecondaryGridClick
      end
      object ShowGridSize: TMenuItem
        Caption = 'Show Grid Size'
        OnClick = ShowGridSizeClick
      end
    end
    object Window1: TMenuItem
      Caption = 'Window'
      object Square1: TMenuItem
        Caption = 'Square'
        RadioItem = True
        OnClick = Square1Click
      end
      object Custom1: TMenuItem
        Caption = 'Custom'
        Checked = True
        RadioItem = True
        OnClick = Custom1Click
      end
      object FreezePosition: TMenuItem
        Caption = 'Freeze Position'
        OnClick = FreezePositionClick
      end
    end
    object Help: TMenuItem
      Caption = 'Help'
      object Help1: TMenuItem
        Caption = 'Help'
        OnClick = Help1Click
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
end
