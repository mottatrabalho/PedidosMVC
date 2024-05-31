program PedidosWK;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {frmPedidos},
  Controller.Cliente in 'Controller\Controller.Cliente.pas',
  Controller.Pedido in 'Controller\Controller.Pedido.pas',
  Controller.PedidoItem in 'Controller\Controller.PedidoItem.pas',
  Controller.Produto in 'Controller\Controller.Produto.pas',
  Model.Cliente in 'Model\Model.Cliente.pas',
  Model.Pedido in 'Model\Model.Pedido.pas',
  Model.PedidoItem in 'Model\Model.PedidoItem.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  DAO.Sistema in 'DAO\DAO.Sistema.pas' {DMMaster: TDataModule},
  View.CarregaPedido in 'View\View.CarregaPedido.pas' {frmCarregaPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedidos, frmPedidos);
  Application.CreateForm(TDMMaster, DMMaster);
  Application.CreateForm(TfrmCarregaPedido, frmCarregaPedido);
  Application.Run;
end.
