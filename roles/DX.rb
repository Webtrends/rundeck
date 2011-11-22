{
  "name": "DX",
  "default_attributes": {
  },
  "json_class": "Chef::Role",
  "env_run_lists": {
  },
  "run_list": [
    "recipe[vc2010]",
    "role[IIS]",
    "recipe[webtrends::dx]"
  ],
  "description": "Install DX. ",
  "chef_type": "role",
  "override_attributes": {
    "webtrends": {
      "dx": {
        "cfg_cmd": [
          "/section:staticContent /clientCache.cacheControlMode:UseMaxAge /clientCache.cacheControlMaxAge:04:00:00",
          "/section:urlCompression /doStaticCompression:True",
          "/section:urlCompression /doDynamicCompression:True",
          "/section:httpCompression /+\"[name='deflate',doStaticCompression='True',doDynamicCompression='True',dll='c:\\windows\\system32\\inetsrv\\gzip.dll']\" /commit:apphost",
          "/section:httpCompression -[name='gzip'].dynamicCompressionLevel:4",
          "/section:httpCompression -[name='gzip'].staticCompressionLevel:9",
          "/section:httpCompression -[name='deflate'].dynamicCompressionLevel:4",
          "/section:httpCompression -[name='deflate'].staticCompressionLevel:9",
          "/section:system.webServer/httpErrors /errorMode:Detailed",
          "/section:system.applicationHost/sites /siteDefaults.logfile.directory:\"D:\\wrs\\logs\"",
          "/section:system.applicationHost/sites /siteDefaults.logfile.logExtFileFlags:BytesRecv,BytesSent,ClientIP,ComputerName,Cookie,Date,Host,HttpStatus,HttpSubStatus,Method,ProtocolVersion,Referer,ServerIP,ServerPort,SiteName,Time,TimeTaken,UriQuery,UriStem,UserAgent,UserName,Win32Status",
          "/section:system.webServer/httpErrors /errorMode:DetailedLocalOnly",
          "/section:system.webServer/httpLogging /SelectiveLogging:LogAll"
        ],
        "dx_dir": [
          "OEM Data Extraction API\\v2_2",
          "Data Extraction API\\v1_1",
          "Data Extraction API\\v2",
          "Data Extraction API\\v2_1",
          "Data Extraction API\\v3"
        ],
        "dx_msi": "WebtrendsDataExtractionAPI.msi",
        "legacy_app_pool": [
          "Webtrends_WebServices_v1_1",
          "Webtrends_WebServices_v2",
          "Webtrends_WebServices_v2_1"
        ],
        "app_pool": [
          "Webtrends_WebServices_v2_2"
        ]
      }
    }
  }
}
