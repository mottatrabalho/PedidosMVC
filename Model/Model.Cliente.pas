unit Model.Cliente;

interface

uses
  SysUtils,
  Dialogs,
  DAO.Sistema;

type
  TCliente = class
  private
    FCodigo :integer;
    FNome   :string;
    FCidade :string;
    FUF     :string;
    FNovo   :Boolean;

  public
    constructor Create;
    procedure Limpar(const objetoCliente: TCliente);
    procedure Consultar(const objetoCliente: TCliente);
    procedure Salvar(const objetoCliente: TCliente);

    property Codigo :integer read FCodigo write FCodigo;
    property Nome   :string  read FNome   write FNome;
    property Cidade :string  read FCidade write FCidade;
    property UF     :string  read FUF     write FUF;
  end;

implementation

Const
  C_SQL_SELECT = 'SELECT * ' +
                 '  FROM CLIENTES ' +
                 ' WHERE CODIGO = :PCODIGO';

  C_SQL_INSERT = 'INSERT INTO CLIENTES (CODIGO, NOME, CIDADE, UF) VALUES (:PCODIGO, :PNOME, :PCIDADE, :PUF)';

  C_SQL_UPDATE = 'UPDATE CLIENTES ' +
                 '   SET NOME   = :PNOME, ' +
                 '       CIDADE = :PCIDADE, ' +
                 '       UF     = :PUF ' +
                 ' WHERE CODIGO = :PCODIGO ';

  C_SQL_DELETE = 'DELETE FROM CLIENTES WHERE CODIGO = :PCODIGO ';

constructor TCliente.Create;
begin
  FCodigo := 0;
  FNome   := EmptyStr;
  FCidade := EmptyStr;
  FUF     := EmptyStr;
end;

procedure TCliente.Limpar(const objetoCliente: TCliente);
begin
  FCodigo := 0;
  FNome   := EmptyStr;
  FCidade := EmptyStr;
  FUF     := EmptyStr;
end;

procedure TCliente.Consultar(const objetoCliente: TCliente);
begin
  DMMaster.fdqDadosCliente.Close;
  DMMaster.fdqDadosCliente.SQL.Text := C_SQL_SELECT;
  DMMaster.fdqDadosCliente.Params[0].Value := objetoCliente.FCodigo;
  DMMaster.fdqDadosCliente.Open;

  objetoCliente.FCodigo := DMMaster.fdqDadosCliente.FieldByName('Codigo').Value;
  objetoCliente.FNome   := DMMaster.fdqDadosCliente.FieldByName('Nome'  ).Value;
  objetoCliente.FCidade := DMMaster.fdqDadosCliente.FieldByName('Cidade').Value;
  objetoCliente.FUF     := DMMaster.fdqDadosCliente.FieldByName('UF'    ).Value;

  DMMaster.fdqDadosCliente.Close;
  DMMaster.fdqDadosCliente.SQL.Clear;
end;

procedure TCliente.Salvar(const objetoCliente: TCliente);
begin
  FNovo := objetoCliente.FCodigo = 0;

  DMMaster.fdqDados.Close;
  if FNovo then
  begin
    DMMaster.fdqDadosCliente.SQL.Text := C_SQL_INSERT;
    DMMaster.fdqDadosCliente.Params[0].Value := 0;
    DMMaster.fdqDadosCliente.Params[1].Value := objetoCliente.FNome;
    DMMaster.fdqDadosCliente.Params[2].Value := objetoCliente.FCidade;
    DMMaster.fdqDadosCliente.Params[3].Value := objetoCliente.FUF;
  end
  else
  begin
    DMMaster.fdqDadosCliente.SQL.Text := C_SQL_UPDATE;
    DMMaster.fdqDadosCliente.Params[0].Value := objetoCliente.FNome;
    DMMaster.fdqDadosCliente.Params[1].Value := objetoCliente.FCidade;
    DMMaster.fdqDadosCliente.Params[2].Value := objetoCliente.FUF;
    DMMaster.fdqDadosCliente.Params[3].Value := objetoCliente.FCodigo;
  end;
  DMMaster.fdqDadosCliente.ExecSQL;

  DMMaster.fdqDadosCliente.Close;
  DMMaster.fdqDadosCliente.SQL.Clear;
end;

end.
