# Removes unnecessary info from the original exported GPX files.

Get-ChildItem ".\data\*.gpx" | ForEach-Object {
    [xml]$xml = Get-Content $_.FullName

    $xml.gpx.SetAttribute("creator", "Aaron Axvig")
    $xml.gpx.RemoveAttribute("xmlns:opencpn")

    $xml.gpx.wpt | ForEach-Object {
        # Remove gpx.wpt.sym nodes
        if($xml.gpx.wpt.sym -ne $null) {
            $_.RemoveChild($_.SelectSingleNode('//*[local-name() = ''sym'']'))
        }
        
        # Remove gpx.wpt.time nodes
        if($xml.gpx.wpt.time -ne $null) {
            $_.RemoveChild($_.SelectSingleNode('//*[local-name() = ''time'']'))
        }
        
        # Remove gpx.wpt.extensions nodes
        if($xml.gpx.wpt.extensions -ne $null) {
            $_.RemoveChild($_.SelectSingleNode('//*[local-name() = ''extensions'']'))
        }
        
        # Remove gpx.wpt.type nodes
        if($xml.gpx.wpt.type -ne $null) {
            $_.RemoveChild($_.SelectSingleNode('//*[local-name() = ''type'']'))
        }
    } | Out-Null

    $xml.Save($_.FullName)
}