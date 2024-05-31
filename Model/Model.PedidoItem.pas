unit Model.PedidoItem;

interface

uses
  SysUtils, Dialogs, DAO.Sistema, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Model.Pedido,
  Model.Produto;

type
  TPedidoItem = class

  private
    FItem          :Integer;
    FNumeroPedido  :Integer;
    FCodigoProduto :Integer;
    FQtdeUnitaria  :Double;
    FValorUnitario :Double;
    FValorTotal    :Double;
    FNovo          :Boolean;

  public
    constructor Create;
    procedure Limpar(const objetoPedidoItem: TPedidoItem);
    procedure Consultar(const objetoPedidoItem: TPedidoItem);
    procedure ConsultarTodos(pNumeroPedido :Integer; pDataSet :TFDMemTable; objetoProduto :TProduto);
    procedure Salvar(const objetoPedidoItem: TPedidoItem);
    procedure SalvarTodos(const objetoPedidoItem: TPedidoItem; pDados: TFDMemTable; objetoPedido :TPedido);
    procedure Excluir(const objetoPedidoItem: TPedidoItem);
    procedure ExcluirTodos(const objetoPedidoItem: TPedidoItem);

    property Item          :Integer read FItem          write FItem;
    property NumeroPedido  :Integer read FNumeroPedido  write FNumeroPedido;
    property CodigoProduto :Integer read FCodigoProduto write FCodigoProduto;
    property QtdeUnitaria  :Double  read FQtdeUnitaria  write FQtdeUnitaria;
    property ValorUnitario :Double  read FValorUnitario write FValorUnitario;
    property ValorTotal    :Double  read FValorTotal    write FValorTotal;
  end;

implementation

Const
  C_SQL_SELECT = 'SELECT PI.NUMERO_ITEM, ' +
                 '       PI.NUMERO_PEDIDO, ' +
                 '       PI.CODIGO_PRODUTO, ' +
                 '       P.DESCRICAO, ' +
                 '       PI.QUANTIDADE, ' +
                 '       PI.VALOR_UNITARIO, ' +
                 '       PI.VALOR_TOTAL ' +
                 '  FROM PEDIDOS_ITEM PI' +
                 '  JOIN PRODUTOS P ON P.CODIGO = PI.CODIGO_PRODUTO ' +
                 ' WHERE PI.NUMERO_ITEM    = :PNUMEROITEM    OR :PNUMEROITEM    = 0 ' +
                 '   AND PI.NUMERO_PEDIDO  = :PNUMEROPEDIDO  OR :PNUMEROPEDIDO  = 0 ' +
                 '   AND PI.CODIGO_PRODUTO = :PCODIGOPRODUTO OR :PCODIGOPRODUTO = 0 ';

  C_SQL_INSERT = 'INSERT INTO PEDIDOS_ITEM (NUMERO_ITEM,  NUMERO_PEDIDO,  CODIGO_PRODUTO,  QUANTIDADE,   VALOR_UNITARIO,  VALOR_TOTAL) ' +
                 '                  VALUES (:PNUMEROITEM, :PNUMEROPEDIDO, :PCODIGOPRODUTO, :PQUANTIDADE, :PVALORUNITARIO, :PVALORTOTAL)';

  C_SQL_UPDATE = 'UPDATE PEDIDOS_ITEM ' +
                 '   SET NUMERO_PEDIDO  = :PNUMEROPEDIDO,  ' +
                 '       CODIGO_PRODUTO = :PCODIGOPRODUTO, ' +
                 '       QUANTIDADE     = :PQUANTIDADE,    ' +
                 '       VALOR_UNITARIO = :PVALORUNITARIO, ' +
                 '       VALOR_TOTAL    = :PVALORTOTAL     ' +
                 ' WHERE NUMERO_ITEM    = :PNUMEROITEM ';

  C_SQL_DELETE = 'DELETE FROM PEDIDOS_ITEM WHERE NUMERO_ITEM = :PNUMEROITEM ';

  C_SQL_DELETETODOS = 'DELETE FROM PEDIDOS_ITEM WHERE NUMERO_PEDIDO = :NUMEROPEDIDO ';

constructor TPedidoItem.Create;
begin
  FItem          := 0;
  FNumeroPedido  := 0;
  FCodigoProduto := 0;
  FQtdeUnitaria  := 0;
  FValorUnitario := 0;
  FValorTotal    := 0;
  FNovo          := False;
end;

procedure TPedidoItem.Consultar(const objetoPedidoItem: TPedidoItem);
begin
  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Text := C_SQL_SELECT;
  DMMaster.fdqDadosItem.Params[0].Value := objetoPedidoItem.FItem;
  DMMaster.fdqDadosItem.Params[1].Value := objetoPedidoItem.FNumeroPedido;
  DMMaster.fdqDadosItem.Params[2].Value := objetoPedidoItem.FCodigoProduto;
  DMMaster.fdqDadosItem.Open;

  objetoPedidoItem.FItem          := DMMaster.fdqDadosItem.FieldByName('NUMERO_ITEM'   ).Value;
  objetoPedidoItem.FNumeroPedido  := DMMaster.fdqDadosItem.FieldByName('NUMERO_PEDIDO' ).Value;
  objetoPedidoItem.FCodigoProduto := DMMaster.fdqDadosItem.FieldByName('CODIGO_PRODUTO').Value;
  objetoPedidoItem.FQtdeUnitaria  := DMMaster.fdqDadosItem.FieldByName('QUANTIDADE'    ).Value;
  objetoPedidoItem.FValorUnitario := DMMaster.fdqDadosItem.FieldByName('VALOR_UNITARIO').Value;
  objetoPedidoItem.FValorTotal    := DMMaster.fdqDadosItem.FieldByName('VALOR_TOTAL'   ).Value;

  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Clear;
end;

procedure TPedidoItem.ConsultarTodos(pNumeroPedido :Integer; pDataSet :TFDMemTable; objetoProduto :TProduto);
begin
  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Text := C_SQL_SELECT;
  DMMaster.fdqDadosItem.Params[0].Value := 0;
  DMMaster.fdqDadosItem.Params[1].Value := pNumeroPedido;
  DMMaster.fdqDadosItem.Params[2].Value := 0;
  DMMaster.fdqDadosItem.Open;
  DMMaster.fdqDadosItem.First;

  pDataSet.EmptyDataSet;

  while not DMMaster.fdqDadosItem.Eof do
  begin
    pDataSet.Append;
    pDataSet.FieldByName('numero_item'   ).Value := DMMaster.fdqDadosItem.FieldByName('NUMERO_ITEM'   ).Value;
    pDataSet.FieldByName('numero_pedido' ).Value := DMMaster.fdqDadosItem.FieldByName('NUMERO_PEDIDO' ).Value;
    pDataSet.FieldByName('codigo_produto').Value := DMMaster.fdqDadosItem.FieldByName('CODIGO_PRODUTO').Value;
    pDataSet.FieldByName('quantidade'    ).Value := DMMaster.fdqDadosItem.FieldByName('QUANTIDADE'    ).Value;
    pDataSet.FieldByName('valor_unitario').Value := DMMaster.fdqDadosItem.FieldByName('VALOR_UNITARIO').Value;
    pDataSet.FieldByName('valor_total'   ).Value := DMMaster.fdqDadosItem.FieldByName('VALOR_TOTAL'   ).Value;

    objetoProduto.Codigo := DMMaster.fdqDadosItem.FieldByName('CODIGO_PRODUTO').Value;
    objetoProduto.Consultar(objetoProduto);

    pDataSet.FieldByName('descricao'     ).Value := objetoProduto.Descricao;
    pDataSet.Post;

    DMMaster.fdqDadosItem.Next;
  end;

  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Clear;
end;

procedure TPedidoItem.Salvar(const objetoPedidoItem: TPedidoItem);
begin
  FNovo := objetoPedidoItem.FItem = 0;

  DMMaster.fdqDadosItem.Close;
  if FNovo then
  begin
    DMMaster.fdqDadosItem.SQL.Text := C_SQL_INSERT;
    DMMaster.fdqDadosItem.Params[0].Value := 0;
    DMMaster.fdqDadosItem.Params[1].Value := objetoPedidoItem.FNumeroPedido;
    DMMaster.fdqDadosItem.Params[2].Value := objetoPedidoItem.FCodigoProduto;
    DMMaster.fdqDadosItem.Params[3].Value := objetoPedidoItem.FQtdeUnitaria;
    DMMaster.fdqDadosItem.Params[4].Value := objetoPedidoItem.FValorUnitario;
    DMMaster.fdqDadosItem.Params[5].Value := objetoPedidoItem.FValorTotal;
  end
  else
  begin
    DMMaster.fdqDadosItem.SQL.Text := C_SQL_UPDATE;
    DMMaster.fdqDadosItem.Params[0].Value := objetoPedidoItem.FNumeroPedido;
    DMMaster.fdqDadosItem.Params[1].Value := objetoPedidoItem.FCodigoProduto;
    DMMaster.fdqDadosItem.Params[2].Value := objetoPedidoItem.FQtdeUnitaria;
    DMMaster.fdqDadosItem.Params[3].Value := objetoPedidoItem.FValorUnitario;
    DMMaster.fdqDadosItem.Params[4].Value := objetoPedidoItem.FValorTotal;
    DMMaster.fdqDadosItem.Params[5].Value := objetoPedidoItem.FItem;
  end;
  DMMaster.fdqDadosItem.ExecSQL;

  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Clear;
end;

procedure TPedidoItem.Excluir(const objetoPedidoItem: TPedidoItem);
begin
  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Text := C_SQL_DELETE;
  DMMaster.fdqDadosItem.Params[0].Value := objetoPedidoItem.FItem;
  DMMaster.fdqDadosItem.ExecSQL;

  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Clear;
end;

procedure TPedidoItem.Limpar(const objetoPedidoItem: TPedidoItem);
begin
  objetoPedidoItem.FItem          := 0;
  objetoPedidoItem.FNumeroPedido  := 0;
  objetoPedidoItem.FCodigoProduto := 0;
  objetoPedidoItem.FQtdeUnitaria  := 0;
  objetoPedidoItem.FValorUnitario := 0;
  objetoPedidoItem.FValorTotal    := 0;
  objetoPedidoItem.FNovo          := False;
end;

procedure TPedidoItem.SalvarTodos(const objetoPedidoItem: TPedidoItem; pDados: TFDMemTable; objetoPedido :TPedido);
begin
  pDados.First;
  while not pDados.Eof do
  begin
    objetoPedidoItem.FItem          := pDados.FieldByName('NUMERO_ITEM'   ).Value;
    objetoPedidoItem.FNumeroPedido  := objetoPedido.Numero;
    objetoPedidoItem.FCodigoProduto := pDados.FieldByName('CODIGO_PRODUTO').Value;
    objetoPedidoItem.FQtdeUnitaria  := pDados.FieldByName('QUANTIDADE'    ).Value;
    objetoPedidoItem.FValorUnitario := pDados.FieldByName('VALOR_UNITARIO').Value;
    objetoPedidoItem.FValorTotal    := pDados.FieldByName('VALOR_TOTAL'   ).Value;

    objetoPedidoItem.Salvar(objetoPedidoItem);

    pDados.Next;
  end;
end;

procedure TPedidoItem.ExcluirTodos(const objetoPedidoItem: TPedidoItem);
begin
  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Text := C_SQL_DELETETODOS;
  DMMaster.fdqDadosItem.Params[0].Value := objetoPedidoItem.FNumeroPedido;
  DMMaster.fdqDadosItem.ExecSQL;

  DMMaster.fdqDadosItem.Close;
  DMMaster.fdqDadosItem.SQL.Clear;
end;

end.
