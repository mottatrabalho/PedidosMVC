unit Model.Produto;

interface

uses
  SysUtils,
  Dialogs,
  DAO.Sistema;

type
  TProduto = class
  private
    // Código, Descrição, Preço de venda
    FCodigo     :integer;
    FDescricao  :string;
    FPrecoVenda :Double;
    FNovo   :Boolean;

  public
    constructor Create;
    procedure Limpar(const objetoProduto: TProduto);
    procedure Consultar(const objetoProduto: TProduto);
    procedure Salvar(const objetoProduto: TProduto);


    property Codigo     :integer read FCodigo     write FCodigo;
    property Descricao  :string  read FDescricao  write FDescricao;
    property PrecoVenda :Double  read FPrecoVenda write FPrecoVenda;
  end;

implementation

Const
  C_SQL_SELECT = 'SELECT * ' +
                 '  FROM PRODUTOS ' +
                 ' WHERE CODIGO = :PCODIGO';

  C_SQL_INSERT = 'INSERT INTO PRODUTOS (CODIGO, DESCRICAO, PRECOVENDA) VALUES (:PCODIGO, :PDESCRICAO, :PPRECOVENDA)';

  C_SQL_UPDATE = 'UPDATE PRODUTOS ' +
                 '       CODIGO     = :PCODIGO,    ' +
                 '       DESCRICAO  = :PDESCRICAO, ' +
                 '       PRECOVENDA = :PPRECOVENDA ' +
                 ' WHERE CODIGO = :PCODIGO ';

  C_SQL_DELETE = 'DELETE FROM PRODUTOS WHERE CODIGO = :PCODIGO ';

constructor TProduto.Create;
begin
  FCodigo     := 0;
  FDescricao  := EmptyStr;
  FPrecoVenda := 0;
end;

procedure TProduto.Limpar(const objetoProduto: TProduto);
begin
  FCodigo     := 0;
  FDescricao  := EmptyStr;
  FPrecoVenda := 0;
end;

procedure TProduto.Consultar(const objetoProduto: TProduto);
begin
  DMMaster.fdqDadosProduto.Close;
  DMMaster.fdqDadosProduto.SQL.Text := C_SQL_SELECT;
  DMMaster.fdqDadosProduto.Params[0].Value := objetoProduto.FCodigo;
  DMMaster.fdqDadosProduto.Open;

  objetoProduto.FCodigo     := DMMaster.fdqDadosProduto.FieldByName('Codigo'    ).Value;
  objetoProduto.FDescricao  := DMMaster.fdqDadosProduto.FieldByName('Descricao' ).Value;
  objetoProduto.FPrecoVenda := DMMaster.fdqDadosProduto.FieldByName('PrecoVenda').Value;

  DMMaster.fdqDadosProduto.Close;
  DMMaster.fdqDadosProduto.SQL.Clear;
end;

procedure TProduto.Salvar(const objetoProduto: TProduto);
begin
  FNovo := objetoProduto.FCodigo = 0;

  DMMaster.fdqDadosProduto.Close;
  if FNovo then
  begin
    DMMaster.fdqDadosProduto.SQL.Text := C_SQL_INSERT;
    DMMaster.fdqDadosProduto.Params[0].Value := 0;
    DMMaster.fdqDadosProduto.Params[1].Value := objetoProduto.FDescricao;
    DMMaster.fdqDadosProduto.Params[2].Value := objetoProduto.FPrecoVenda;
  end
  else
  begin
    DMMaster.fdqDadosProduto.SQL.Text := C_SQL_UPDATE;
    DMMaster.fdqDadosProduto.Params[0].Value := objetoProduto.FDescricao;
    DMMaster.fdqDadosProduto.Params[1].Value := objetoProduto.FPrecoVenda;
    DMMaster.fdqDadosProduto.Params[2].Value := objetoProduto.FCodigo;
  end;
  DMMaster.fdqDadosProduto.ExecSQL;

  DMMaster.fdqDadosProduto.Close;
  DMMaster.fdqDadosProduto.SQL.Clear;
end;

end.
