object frmPedidos: TfrmPedidos
  Left = 0
  Top = 0
  Caption = 'Pedidos MVC |:::... Tela Principal'
  ClientHeight = 504
  ClientWidth = 813
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlCliente: TPanel
    Left = 0
    Top = 0
    Width = 813
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 16
      Width = 43
      Height = 15
      Caption = 'Emiss'#227'o'
    end
    object Label2: TLabel
      Left = 152
      Top = 16
      Width = 60
      Height = 15
      Caption = 'Nro Pedido'
    end
    object Label3: TLabel
      Left = 271
      Top = 16
      Width = 65
      Height = 15
      Caption = 'C'#243'd. Cliente'
    end
    object edtEmissao: TEdit
      Left = 49
      Top = 13
      Width = 96
      Height = 23
      TabOrder = 0
    end
    object edtPedido: TEdit
      Left = 218
      Top = 13
      Width = 47
      Height = 23
      TabOrder = 1
      OnExit = edtPedidoExit
    end
    object edtCodCliente: TEdit
      Left = 342
      Top = 13
      Width = 50
      Height = 23
      TabOrder = 2
      OnExit = edtCodClienteExit
    end
    object edtNomeCliente: TEdit
      Left = 398
      Top = 13
      Width = 280
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 3
    end
    object btnCancela: TBitBtn
      Left = 696
      Top = 12
      Width = 106
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 4
      TabStop = False
      Visible = False
      OnClick = btnCancelaClick
    end
  end
  object pnlPedido: TPanel
    Left = 0
    Top = 49
    Width = 813
    Height = 80
    Align = alTop
    TabOrder = 1
    object Label4: TLabel
      Left = 0
      Top = 16
      Width = 71
      Height = 15
      Caption = 'C'#243'd. Produto'
    end
    object Label5: TLabel
      Left = 341
      Top = 16
      Width = 26
      Height = 15
      Caption = 'Qtde'
    end
    object Label6: TLabel
      Left = 422
      Top = 16
      Width = 45
      Height = 15
      Caption = 'Vlr. Unit.'
    end
    object Label7: TLabel
      Left = 553
      Top = 16
      Width = 45
      Height = 15
      Caption = 'Vlr. Total'
    end
    object edtCodProduto: TEdit
      Left = 3
      Top = 37
      Width = 68
      Height = 23
      TabOrder = 0
      OnExit = edtCodProdutoExit
    end
    object edtNomeProduto: TEdit
      Left = 77
      Top = 37
      Width = 258
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtQtde: TMaskEdit
      Left = 341
      Top = 37
      Width = 68
      Height = 23
      TabOrder = 2
      Text = ''
      OnExit = edtQtdeExit
    end
    object edtValorUni: TMaskEdit
      Left = 422
      Top = 37
      Width = 125
      Height = 23
      TabOrder = 3
      Text = ''
      OnExit = edtQtdeExit
    end
    object edtValorItem: TMaskEdit
      Left = 553
      Top = 37
      Width = 125
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 4
      Text = ''
    end
    object btnProduto: TBitBtn
      Left = 696
      Top = 33
      Width = 106
      Height = 25
      Caption = 'Inserir'
      TabOrder = 5
      OnClick = btnProdutoClick
    end
  end
  object dbgProduto: TDBGrid
    Left = 0
    Top = 129
    Width = 813
    Height = 323
    Align = alClient
    DataSource = dsPedidoItem
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = dbgProdutoKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'numero_pedido'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'numero_item'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Caption = 'C'#243'd. Produto'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Produto'
        Width = 380
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Caption = 'Quantidade'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_unitario'
        Title.Caption = 'Vl. Unit'#225'rio'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        Title.Caption = 'Vl. Total'
        Width = 95
        Visible = True
      end>
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 452
    Width = 813
    Height = 52
    Align = alBottom
    TabOrder = 3
    object Label8: TLabel
      Left = 469
      Top = 1
      Width = 189
      Height = 50
      Align = alRight
      AutoSize = False
      Caption = 'Total do Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 391
    end
    object lblTotal: TLabel
      AlignWithMargins = True
      Left = 668
      Top = 4
      Width = 134
      Height = 44
      Margins.Left = 10
      Margins.Right = 10
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 600
      ExplicitTop = 1
      ExplicitHeight = 50
    end
    object btnGrava: TBitBtn
      AlignWithMargins = True
      Left = 11
      Top = 6
      Width = 118
      Height = 40
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Gravar Pedido'
      TabOrder = 0
      OnClick = btnGravaClick
      ExplicitLeft = 149
    end
    object btnCarregaPedido: TBitBtn
      AlignWithMargins = True
      Left = 149
      Top = 6
      Width = 118
      Height = 40
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Carrega Pedido'
      TabOrder = 1
      Visible = False
      OnClick = btnCarregaPedidoClick
      ExplicitLeft = 218
      ExplicitTop = 8
    end
  end
  object dsPedidoItem: TDataSource
    DataSet = fdmPedidoItem
    Left = 632
    Top = 368
  end
  object fdmPedidoItem: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 720
    Top = 368
    object fdmPedidoItemcodigo_produto: TIntegerField
      FieldName = 'codigo_produto'
    end
    object fdmPedidoItemnumero_item: TIntegerField
      FieldName = 'numero_item'
    end
    object fdmPedidoItemnumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
    end
    object fdmPedidoItemquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object fdmPedidoItemvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object fdmPedidoItemvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object fdmPedidoItemdescricao: TStringField
      FieldName = 'descricao'
      Size = 105
    end
  end
end
