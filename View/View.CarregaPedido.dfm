object frmCarregaPedido: TfrmCarregaPedido
  Left = 0
  Top = 0
  Caption = 'Carrega Pedidos'
  ClientHeight = 92
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlCarregaPedido: TPanel
    Left = 0
    Top = 0
    Width = 272
    Height = 92
    Align = alClient
    TabOrder = 0
    DesignSize = (
      272
      92)
    object Label9: TLabel
      Left = 56
      Top = 16
      Width = 60
      Height = 15
      Caption = 'Nro Pedido'
    end
    object edtPedido: TEdit
      Left = 122
      Top = 13
      Width = 79
      Height = 23
      TabOrder = 0
      Text = '0'
    end
    object btnCancela: TBitBtn
      Left = 19
      Top = 55
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Cancela'
      TabOrder = 1
      OnClick = btnCancelaClick
    end
    object btnCarrega: TBitBtn
      Left = 174
      Top = 55
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Carrega'
      TabOrder = 2
      OnClick = btnCarregaClick
    end
  end
end
