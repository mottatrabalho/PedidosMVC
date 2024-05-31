object DMMaster: TDMMaster
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object fdcMaster: TFDConnection
    Params.Strings = (
      'Database=TesteWK'
      'Password=masterkey'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object MySQLLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Work\WK\libmysql.dll'
    Left = 56
    Top = 80
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 56
    Top = 144
  end
  object fdqDados: TFDQuery
    Connection = fdcMaster
    Left = 56
    Top = 208
  end
  object fdtMaster: TFDTransaction
    Connection = fdcMaster
    Left = 144
    Top = 16
  end
  object fdqDadosCliente: TFDQuery
    Connection = fdcMaster
    Left = 288
    Top = 16
  end
  object fdqDadosProduto: TFDQuery
    Connection = fdcMaster
    Left = 288
    Top = 80
  end
  object fdqDadosPedido: TFDQuery
    Connection = fdcMaster
    Left = 288
    Top = 144
  end
  object fdqDadosItem: TFDQuery
    Connection = fdcMaster
    Left = 288
    Top = 208
  end
end
