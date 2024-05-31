unit Controller.PedidoItem;

interface

uses  Model.PedidoItem,
      DAO.Sistema;

type
  TControlePedidoItem = class
  private

  public
    // procedimento para salvar o cliente
    procedure Consultar(const objetoPedidoItem: TPedidoItem);
    procedure Salvar(const objetoPedidoItem: TPedidoItem);
  end;

implementation

uses
  StrUtils, SysUtils ;

{ TControleCliente }

procedure TControlePedidoItem.Consultar(const objetoPedidoItem: TPedidoItem);
begin
  objetoPedidoItem.Consultar(objetoPedidoItem);
end;

procedure TControlePedidoItem.Salvar(const objetoPedidoItem: TPedidoItem);
begin
  if objetoPedidoItem.NumeroPedido = 0 then
    raise Exception.Create('Preencha o NÚMERO do pedido.');

  if objetoPedidoItem.CodigoProduto = 0 then
    raise Exception.Create('Preencha o CÓDIGO DO PRODUTO do pedido.');

  if objetoPedidoItem.QtdeUnitaria = 0 then
    raise Exception.Create('Preencha o QUANTIDADE do pedido.');

  if objetoPedidoItem.ValorUnitario = 0 then
    raise Exception.Create('Preencha o VALOR UNITÁRIO do pedido.');

  if objetoPedidoItem.ValorTotal = 0 then
    raise Exception.Create('Preencha o VALOR TOTAL do pedido.');

  objetoPedidoItem.Salvar(objetoPedidoItem);
end;

end.
