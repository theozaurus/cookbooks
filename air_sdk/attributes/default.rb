air_sdk Mash.new unless attribute?("air_sdk")

air_sdk[:version] = "1.5" unless air_sdk.has_key?(:version)
air_sdk[:link] = "http://airdownload.adobe.com/air/lin/download/latest/air_#{air_sdk[:version]}_sdk.tbz2" unless air_sdk.has_key?(:link)
air_sdk[:folder] = "/opt/air_sdk-#{air_sdk[:version]}" unless air_sdk.has_key?(:folder)
air_sdk[:path] = "#{air_sdk[:folder]}/bin" unless air_sdk.has_key?(:path)