unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,  DAO.Sistema, Controller.Cliente, Controller.Pedido, Controller.PedidoItem,
  Controller.Produto, Model.Cliente, Model.Pedido, Model.PedidoItem,
  Model.Produto;

type
  TfrmPedidos = class(TForm)
    pnlCliente: TPanel;
    pnlPedido: TPanel;
    dbgProduto: TDBGrid;
    edtEmissao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPedido: TEdit;
    Label3: TLabel;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    edtCodProduto: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtNomeProduto: TEdit;
    edtQtde: TMaskEdit;
    Label6: TLabel;
    edtValorUni: TMaskEdit;
    Label7: TLabel;
    edtValorItem: TMaskEdit;
    btnProduto: TBitBtn;
    pnlRodape: TPanel;
    Label8: TLabel;
    lblTotal: TLabel;
    btnGrava: TBitBtn;
    btnCancela: TBitBtn;
    dsPedidoItem: TDataSource;
    fdmPedidoItem: TFDMemTable;
    fdmPedidoItemcodigo_produto: TIntegerField;
    fdmPedidoItemnumero_item: TIntegerField;
    fdmPedidoItemnumero_pedido: TIntegerField;
    fdmPedidoItemquantidade: TFloatField;
    fdmPedidoItemvalor_unitario: TFloatField;
    fdmPedidoItemvalor_total: TFloatField;
    fdmPedidoItemdescricao: TStringField;
    btnCarregaPedido: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edtPedidoExit(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtQtdeExit(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCarregaPedidoClick(Sender: TObject);
    procedure dbgProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);

  private
    { Private declarations }
    FCliente    :TCliente;
    FProduto    :TProduto;
    FPedido     :TPedido;
    FPedidoItem :TPedidoItem;

    function CalculaPedido:Double;

    procedure LimpaCliente;
    procedure LimpaPedido;
    procedure LimpaCabecalho;
    procedure LimpaItem;
    procedure CarregaCabecalho(const objetoPedido: TPedido; const objetoCliente: TCliente);
    procedure CarregaItemGrid;
    procedure CalculaItem;
    procedure InsereItemGrid;


  public
    { Public declarations }

  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.dfm}

uses View.CarregaPedido;

procedure TfrmPedidos.FormCreate(Sender: TObject);
begin
  FCliente    := TCliente.Create;
  FProduto    := TProduto.Create;
  FPedido     := TPedido.Create;
  FPedidoItem := TPedidoItem.Create;

  fdmPedidoItem.CreateDataSet;

  LimpaCabecalho;
  LimpaItem;
end;

procedure TfrmPedidos.InsereItemGrid;
begin
  if not edtCodProduto.ReadOnly then
  begin
    fdmPedidoItem.Append;
    fdmPedidoItemnumero_item.Value    := 0;
    fdmPedidoItemnumero_pedido.Value  := FPedido.Numero;
    fdmPedidoItemcodigo_produto.Value := FProduto.Codigo;
    fdmPedidoItemdescricao.Value      := FProduto.Descricao;
  end else
    fdmPedidoItem.Edit;

  fdmPedidoItemquantidade.Value     := StrToFloat(edtQtde.Text);
  fdmPedidoItemvalor_unitario.Value := FProduto.PrecoVenda;
  fdmPedidoItemvalor_total.Value    := StrToFloat(edtValorItem.Text);;
  fdmPedidoItem.Post;

  lblTotal.Caption := FormatFloat('#,##0.00;(#,##0.00)', CalculaPedido);

  fdmPedidoItem.EnableControls
end;

procedure TfrmPedidos.LimpaCabecalho;
begin
  edtEmissao.Text    := FormatDateTime('dd/mm/yyyy', Now);
  edtPedido.Text     := '0';
  edtCodCliente.Text := '0';
  edtNomeCliente.Clear;
end;

procedure TfrmPedidos.LimpaCliente;
begin
  FCliente.Limpar(FCliente);
  edtCodCliente.Text := '0';
  edtNomeCliente.Clear;
end;

procedure TfrmPedidos.LimpaItem;
begin
  edtCodProduto.Text := '0';
  edtNomeProduto.Clear;
  edtQtde.Text       := '0';
  edtValorUni.Text   := '0';
  edtValorItem.Text  := '0';
end;

procedure TfrmPedidos.LimpaPedido;
begin
  FPedido.Limpar;
  edtPedido.Text := '0';
end;

procedure TfrmPedidos.btnProdutoClick(Sender: TObject);
begin
  if btnProduto.Tag = 0 then
    FPedidoItem.Item := 0;

  FPedidoItem.NumeroPedido  := StrToInt(edtPedido.Text);
  FPedidoItem.CodigoProduto := StrToInt(edtCodProduto.Text);
  FPedidoItem.QtdeUnitaria  := StrToFloat(edtQtde.Text);
  FPedidoItem.ValorUnitario := StrToFloat(edtValorUni.Text);
  FPedidoItem.ValorTotal    := StrToFloat(edtValorItem.Text);

  InsereItemGrid;

  lblTotal.Caption := FormatFloat('#,##0.00;(#,##0.00)', CalculaPedido);

  LimpaItem;
  edtCodProduto.SetFocus;

  edtCodProduto.ReadOnly  := False;
  edtNomeProduto.ReadOnly := False;
  btnProduto.Tag          := 0;
end;

procedure TfrmPedidos.CalculaItem;
begin
  edtValorItem.Text := FloatToStr(StrToFloat(edtQtde.Text) *
                                  StrToFloat(edtValorUni.Text) );
end;

function TfrmPedidos.CalculaPedido: Double;
var
  fTotal :Double;
begin
  fdmPedidoItem.DisableControls;

  fTotal := 0;
  fdmPedidoItem.First;
  while not fdmPedidoItem.Eof do
  begin
    fTotal := fTotal + fdmPedidoItemvalor_total.Value;
    fdmPedidoItem.Next;
  end;
  Result := fTotal;

  fdmPedidoItem.EnableControls;
end;

procedure TfrmPedidos.CarregaCabecalho(const objetoPedido: TPedido; const objetoCliente: TCliente);
begin
  objetoCliente.Codigo    := objetoPedido.CodigoCliente;
  objetoCliente.Consultar(objetoCliente);

  edtEmissao.Text     := FormatDateTime('dd/mm/yyyy', objetoPedido.DataEmissao);
  edtPedido.Text      := IntToStr(objetoPedido.Numero);
  edtCodCliente.Text  := IntToStr(objetoPedido.CodigoCliente);
  edtNomeCliente.Text := objetoCliente.Nome;
end;

procedure TfrmPedidos.CarregaItemGrid;
begin
  //
  FPedidoItem.Limpar(FPedidoItem);
  FPedidoItem.Item          := fdmPedidoItem.FieldByName('NUMERO_ITEM'   ).Value;
  FPedidoItem.NumeroPedido  := fdmPedidoItem.FieldByName('NUMERO_PEDIDO' ).Value;
  FPedidoItem.CodigoProduto := fdmPedidoItem.FieldByName('CODIGO_PRODUTO').Value;
  FPedidoItem.QtdeUnitaria  := fdmPedidoItem.FieldByName('QUANTIDADE'    ).Value;
  FPedidoItem.ValorUnitario := fdmPedidoItem.FieldByName('VALOR_UNITARIO').Value;
  FPedidoItem.ValorTotal    := fdmPedidoItem.FieldByName('VALOR_TOTAL'   ).Value;

  edtCodProduto.Text        := IntToStr(FPedidoItem.CodigoProduto);
  edtNomeProduto.Text       := fdmPedidoItem.FieldByName('DESCRICAO').Value;
  edtQtde.Text              := FloatToStr(FPedidoItem.QtdeUnitaria);
  edtValorUni.Text          := FloatToStr(FPedidoItem.ValorUnitario);
  edtValorItem.Text         := FloatToStr(FPedidoItem.ValorTotal);

  edtCodProduto.ReadOnly    := True;
  edtNomeProduto.ReadOnly   := True;

  edtQtde.SetFocus;
end;

procedure TfrmPedidos.dbgProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_LEFT)  then
  begin
    Key := 0;
    PostMessage(dbgProduto.Handle, WM_HSCROLL, 0, 0);
  end
  else
  if (Key = VK_RIGHT)  then
  begin
    Key := 0;
    PostMessage(dbgProduto.Handle, WM_HSCROLL, 1, 0);
  end
  else
  if (Key = VK_RETURN)  then
  begin
    Key := 0;
    LimpaItem;
    CarregaItemGrid;
    edtQtde.SetFocus;
  end
  else
  if (Key = VK_DELETE)  then
  begin
    Key := 0;

    if edtPedido.Text = '0' then
      fdmPedidoItem.Delete
    else
    begin
      try
        DMMaster.fdtMaster.StartTransaction;

        FPedidoItem.NumeroPedido := fdmPedidoItemnumero_item.Value;
        FPedidoItem.Item         := fdmPedidoItemnumero_pedido.Value;
        FPedidoItem.Excluir(FPedidoItem);

        DMMaster.fdtMaster.Commit;
      except
        DMMaster.fdtMaster.Rollback;
      end;

      fdmPedidoItem.Delete;
    end;
  end;
end;

procedure TfrmPedidos.edtPedidoExit(Sender: TObject);
begin
  if (Trim(edtPedido.Text) <> EmptyStr) and
     (Trim(edtPedido.Text) <> '0')  then
  begin
    FPedido.Numero := StrToInt(edtPedido.Text);
    FPedido.Consultar(FPedido);

    if FPedido.Numero = 0 then
    begin
      ShowMessage('Pedido não encontrado!');
      edtPedido.SetFocus;
    end;

    CarregaCabecalho(FPedido, FCliente);
    FPedidoItem.ConsultarTodos(FPedido.Numero, fdmPedidoItem, FProduto);
  end;

  btnCancela.Visible := (edtCodCliente.Text = '0') or (edtCodCliente.Text = EmptyStr);
end;

procedure TfrmPedidos.edtQtdeExit(Sender: TObject);
begin
  CalculaItem;
end;

procedure TfrmPedidos.edtCodClienteExit(Sender: TObject);
begin
  if (edtCodCliente.Text <> '0') and
     (edtCodCliente.Text <> EmptyStr) then
  begin
    FCliente.Codigo     := StrToInt(edtCodCliente.Text);
    FCliente.Consultar(FCliente);
    edtCodCliente.Text  := IntToStr(FCliente.Codigo);
    edtNomeCliente.Text := FCliente.Nome;
    edtCodProduto.SetFocus;
  end;

  btnCancela.Visible       := (edtCodCliente.Text = '0') or (edtCodCliente.Text = EmptyStr);
  btnCarregaPedido.Visible := (edtCodCliente.Text = '0') or (edtCodCliente.Text = EmptyStr);
end;

procedure TfrmPedidos.edtCodProdutoExit(Sender: TObject);
begin
  if (edtCodProduto.Text <> '0') and
     (edtCodProduto.Text <> EmptyStr) then
  begin
    FProduto.Codigo     := StrToInt(edtCodProduto.Text);
    FProduto.Consultar(FProduto);
    edtCodProduto.Text  := IntToStr(FProduto.Codigo);
    edtNomeProduto.Text := FProduto.Descricao;
    edtValorUni.Text    := FloatToStr(FProduto.PrecoVenda);
    edtQtde.SetFocus;
  end;
end;

procedure TfrmPedidos.btnCancelaClick(Sender: TObject);
begin
  frmCarregaPedido := TfrmCarregaPedido.Create(Self);
  frmCarregaPedido.ShowModal;

  if frmCarregaPedido.ModalResult = mrOk then
  begin
    if MessageDlg('Deseja Excluir o Pedido Selecionado?' ,
                  mtConfirmation,
                  [mbYes, mbNo],
                  0) = mrYes then
    begin
      try
        DMMaster.fdtMaster.StartTransaction;

        if (frmCarregaPedido.edtPedido.Text <> '0') and
           (frmCarregaPedido.edtPedido.Text = EmptyStr) then
        begin
          FPedidoItem.NumeroPedido := StrToInt(edtPedido.Text);
          FPedidoItem.ExcluirTodos(FPedidoItem);

          FPedido.Numero := StrToInt(edtPedido.Text);
          FPedido.Excluir(FPedido);

          DMMaster.fdtMaster.Commit;

          fdmPedidoItem.EmptyDataSet;

          LimpaPedido;
          LimpaCliente;
          LimpaItem;
          LimpaCabecalho;
          edtPedido.SetFocus;
          lblTotal.Caption := '0,00';
        end;

      except
        DMMaster.fdtMaster.Rollback;
      end;
    end;
  end
  else
  begin
    LimpaPedido;
    LimpaCliente;
    LimpaItem;
    LimpaCabecalho;
  end;
end;

procedure TfrmPedidos.btnCarregaPedidoClick(Sender: TObject);
begin
  frmCarregaPedido := TfrmCarregaPedido.Create(Self);
  frmCarregaPedido.ShowModal;

  if frmCarregaPedido.ModalResult = mrOk then
  begin
    edtPedido.Text := frmCarregaPedido.edtPedido.Text;
    FPedido.Numero := StrToInt(frmCarregaPedido.edtPedido.Text);
    FPedido.Consultar(FPedido);

    if (frmCarregaPedido.edtPedido.Text = '0') then
    begin
      ShowMessage('Pedido não encontrado!');
      LimpaPedido;
      LimpaCliente;
      LimpaItem;
      LimpaCabecalho;
      edtPedido.SetFocus;
    end
    else
    begin
      CarregaCabecalho(FPedido, FCliente);

      FPedidoItem.NumeroPedido := FPedido.Numero;
      FPedidoItem.ConsultarTodos(FPedidoItem.NumeroPedido, fdmPedidoItem, FProduto);
      lblTotal.Caption :=  FormatFloat('#,##0.00;(#,##0.00)', CalculaPedido);
      fdmPedidoItem.First;
    end;
  end
  else
  begin
    LimpaPedido;
    LimpaCliente;
    LimpaItem;
    LimpaCabecalho;
  end;
end;

procedure TfrmPedidos.btnGravaClick(Sender: TObject);
begin
  try
    try
      DMMaster.fdtMaster.StartTransaction;

      FPedido.Numero        := StrToInt(edtPedido.Text);
      FPedido.DataEmissao   := Date;
      FPedido.CodigoCliente := FCliente.Codigo;
      FPedido.ValorTotal    := CalculaPedido;
      FPedido.Salvar(FPedido);
      edtPedido.Text        := IntToStr(FPedido.Numero);

      FPedidoItem.NumeroPedido := FPedido.Numero;
      FPedidoItem.SalvarTodos(FPedidoItem, fdmPedidoItem, FPedido);

      DMMaster.fdtMaster.Commit;

      LimpaPedido;
      LimpaCliente;
      LimpaItem;
      LimpaCabecalho;

      fdmPedidoItem.EmptyDataSet;
    except
      DMMaster.fdtMaster.Rollback;
    end;
  finally
  end;
end;

end.
