object DMMaster: TDMMaster
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
end
