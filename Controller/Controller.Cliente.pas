unit Controller.Cliente;

interface

uses Model.Cliente;

type
  TControleCliente = class
  private
  public
    // procedimento para salvar o cliente
    procedure Consultar(const objetoCliente: TCliente);
    procedure Salvar(const objetoCliente: TCliente);
  end;

implementation

uses
  StrUtils, SysUtils;

{ TControleCliente }

procedure TControleCliente.Consultar(const objetoCliente: TCliente);
begin
  objetoCliente.Consultar(objetoCliente);
end;

procedure TControleCliente.Salvar(const objetoCliente: TCliente);
begin
  if objetoCliente.Codigo = 0 then
    raise Exception.Create('Preencha o CÓDIGO do cliente.');

  if objetoCliente.Nome = '' then
    raise Exception.Create('Preencha o NOME do cliente.');

  if objetoCliente.Cidade = '' then
    raise Exception.Create('Preencha o CIDADE do cliente.');

  if objetoCliente.UF = '' then
    raise Exception.Create('Preencha a UF do cliente.');


  objetoCliente.Salvar(objetoCliente);
end;

end.
