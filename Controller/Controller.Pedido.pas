unit Controller.Pedido;

interface

uses  Model.Pedido,
      DAO.Sistema;

type
  TControlePedido = class
  private

  public
    // procedimento para salvar o cliente
    procedure Consultar(const objetoPedido: TPedido);
    procedure Salvar(const objetoPedido: TPedido);
  end;

implementation

uses
  StrUtils, SysUtils ;

{ TControleCliente }

procedure TControlePedido.Consultar(const objetoPedido: TPedido);
begin
  objetoPedido.Consultar(objetoPedido);
end;

procedure TControlePedido.Salvar(const objetoPedido: TPedido);
begin
  if objetoPedido.Numero = 0 then
    raise Exception.Create('Preencha o NÚMERO do pedido.');

  if objetoPedido.DataEmissao = 0 then
    raise Exception.Create('Preencha o DATA DE EMISSÃO do pedido.');

  if objetoPedido.CodigoCliente = 0 then
    raise Exception.Create('Preencha o CÓDIGO DO CLIENTE do pedido.');

  objetoPedido.Salvar(objetoPedido);
end;

end.
