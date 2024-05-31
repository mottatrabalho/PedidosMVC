unit Controller.Produto;

interface

uses  DAO.Sistema, Model.Produto;

type
  TControleProduto = class
  private
  public
    // procedimento para salvar o cliente
    procedure Consultar(const objetoProduto: TProduto);
    procedure Salvar(const objetoProduto: TProduto);
  end;

implementation

uses
  StrUtils, SysUtils ;

{ TControleCliente }

procedure TControleProduto.Consultar(const objetoProduto: TProduto);
begin
  objetoProduto.Consultar(objetoProduto);
end;

procedure TControleProduto.Salvar(const objetoProduto: TProduto);
begin
  if objetoProduto.Codigo = 0 then
    raise Exception.Create('Preencha o CÓDIGO do produto.');

  if objetoProduto.Descricao = '' then
    raise Exception.Create('Preencha o DESCRIÇÃO do produto.');

  if objetoProduto.PrecoVenda = 0 then
    raise Exception.Create('Preencha o VALOR UNITARIO do produto.');

  objetoProduto.Salvar(objetoProduto);
end;

end.
