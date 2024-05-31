unit Model.Pedido;

interface

uses
  SysUtils,
  Dialogs,
  DAO.Sistema;

type
  TPedido = class
  private
    FNumero        :Integer;
    FDataEmissao   :TDateTime;
    FCodigoCliente :Integer;
    FValorTotal    :Double;
    FNovo          :Boolean;

  public
    constructor Create;
    procedure Limpar;
    procedure Consultar(const objetoPedido: TPedido);
    procedure Salvar(const objetoPedido: TPedido);
    procedure Excluir(const objetoPedido: TPedido);

    property Numero        :Integer   read    FNumero        write FNumero;
    property DataEmissao   :TDateTime read    FDataEmissao   write FDataEmissao;
    property CodigoCliente :Integer   read    FCodigoCliente write FCodigoCliente;
    property ValorTotal    :Double    read    FValorTotal    write FValorTotal;

  end;

implementation

Const
  C_SQL_SELECT = 'SELECT * ' +
                 '  FROM PEDIDOS ' +
                 ' WHERE NUMERO_PED     = :PNUMEROPED     OR :PNUMEROPED     = 0 ';

  C_SQL_INSERT = 'INSERT INTO PEDIDOS (NUMERO_PED, DATA_EMISSAO, CODIGO_CLIENTE, VALOR_TOTAL) ' +
                 '             VALUES (:PNUMEROPED, :PDATAEMISSAO, :PCODIGOCLIENTE, :PVALORTOTAL) ';

  C_SQL_UPDATE = 'UPDATE PEDIDOS ' +
                 '   SET NUMERO_PED     = :PNUMEROPED, ' +
                 '       DATA_EMISSAO   = :PDATAEMISSAO, ' +
                 '       CODIGO_CLIENTE = :PCODIGOCLIENTE, ' +
                 '       VALOR_TOTAL    = :PVALORTOTAL ' +
                 ' WHERE NUMERO_PED     = :PNUMEROPED ';

  C_SQL_DELETE = 'DELETE FROM PEDIDOS WHERE NUMERO_PED = :PNUMEROPED ';

constructor TPedido.Create;
begin
  FNumero        := 0;
  FDataEmissao   := 0;
  FCodigoCliente := 0;
  FValorTotal    := 0;
end;

procedure TPedido.Limpar;
begin
  FNumero        := 0;
  FDataEmissao   := 0;
  FCodigoCliente := 0;
  FValorTotal    := 0;
end;

procedure TPedido.Consultar(const objetoPedido: TPedido);
begin
  DMMaster.fdqDadosPedido.Close;
  DMMaster.fdqDadosPedido.SQL.Text := C_SQL_SELECT;
  DMMaster.fdqDadosPedido.Params[0].Value := objetoPedido.FNumero;
  DMMaster.fdqDadosPedido.Open;

  if DMMaster.fdqDadosPedido.RecordCount > 0 then
  begin
    FNumero        := DMMaster.fdqDadosPedido.FieldByName('NUMERO_PED'    ).Value;
    FDataEmissao   := DMMaster.fdqDadosPedido.FieldByName('DATA_EMISSAO'  ).Value;
    FCodigoCliente := DMMaster.fdqDadosPedido.FieldByName('CODIGO_CLIENTE').Value;
    FValorTotal    := DMMaster.fdqDadosPedido.FieldByName('VALOR_TOTAL'   ).Value;
  end
  else
  begin
    Limpar;
  end;

  DMMaster.fdqDadosPedido.Close;
  DMMaster.fdqDadosPedido.SQL.Clear;
end;

procedure TPedido.Salvar(const objetoPedido: TPedido);
begin
  FNovo := objetoPedido.FNumero = 0;

  DMMaster.fdqDadosPedido.Close;
  if FNovo then
  begin
    DMMaster.fdqDadosPedido.SQL.Text := C_SQL_INSERT;
    DMMaster.fdqDadosPedido.Params[0].Value := 0;
    DMMaster.fdqDadosPedido.Params[1].Value := objetoPedido.FDataEmissao;
    DMMaster.fdqDadosPedido.Params[2].Value := objetoPedido.FCodigoCliente;
    DMMaster.fdqDadosPedido.Params[3].Value := objetoPedido.FValorTotal;
  end
  else
  begin
    DMMaster.fdqDadosPedido.SQL.Text := C_SQL_UPDATE;
    DMMaster.fdqDadosPedido.Params[0].Value := objetoPedido.FNumero;
    DMMaster.fdqDadosPedido.Params[1].Value := objetoPedido.FDataEmissao;
    DMMaster.fdqDadosPedido.Params[2].Value := objetoPedido.FCodigoCliente;
    DMMaster.fdqDadosPedido.Params[3].Value := objetoPedido.FValorTotal;
  end;
  DMMaster.fdqDadosPedido.ExecSQL;

  DMMaster.fdqDadosPedido.Close;
  DMMaster.fdqDadosPedido.SQL.Clear;
  DMMaster.fdqDadosPedido.SQL.Text := 'SELECT MAX(NUMERO_PED) AS NUM FROM PEDIDOS';
  DMMaster.fdqDadosPedido.Open;
  objetoPedido.Numero := DMMaster.fdqDadosPedido.FieldByName('NUM').AsInteger;

  DMMaster.fdqDadosPedido.Close;
  DMMaster.fdqDadosPedido.SQL.Clear;
end;

procedure TPedido.Excluir(const objetoPedido: TPedido);
begin
  DMMaster.fdqDadosPedido.Close;
  DMMaster.fdqDadosPedido.SQL.Text := C_SQL_DELETE;
  DMMaster.fdqDadosPedido.Params[0].Value := objetoPedido.FNumero;
  DMMaster.fdqDadosPedido.ExecSQL;

  DMMaster.fdqDadosPedido.Close;
  DMMaster.fdqDadosPedido.SQL.Clear;
end;


end.
