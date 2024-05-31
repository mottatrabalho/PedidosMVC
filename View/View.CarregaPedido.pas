unit View.CarregaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmCarregaPedido = class(TForm)
    pnlCarregaPedido: TPanel;
    Label9: TLabel;
    edtPedido: TEdit;
    btnCancela: TBitBtn;
    btnCarrega: TBitBtn;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnCarregaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCarregaPedido: TfrmCarregaPedido;

implementation

{$R *.dfm}

uses Model.Cliente, Model.Pedido;

procedure TfrmCarregaPedido.btnCancelaClick(Sender: TObject);
begin
  edtPedido.Text := '0';
  ModalResult    := mrCancel;
end;

procedure TfrmCarregaPedido.btnCarregaClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmCarregaPedido.FormCreate(Sender: TObject);
begin
  edtPedido.Text := '0';
end;

end.
