unit DAO.Sistema;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, IniFiles;

type
  TDMMaster = class(TDataModule)
    fdcMaster: TFDConnection;
    MySQLLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    fdqDados: TFDQuery;
    fdtMaster: TFDTransaction;
    fdqDadosCliente: TFDQuery;
    fdqDadosProduto: TFDQuery;
    fdqDadosPedido: TFDQuery;
    fdqDadosItem: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMMaster: TDMMaster;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMMaster.DataModuleCreate(Sender: TObject);
var
  CfgBDIni: TIniFile;
begin
  fdcMaster.Connected := False;
  CfgBDIni := TIniFile.Create('PedidosMVC.ini');
  fdcMaster.Params.Database := CfgBDIni.ReadString('BancoDados', 'NomeBanco', '');
  MySQLLink.VendorLib       := CfgBDIni.ReadString('BancoDados', 'VendorDLL', '');
end;

end.
