# Creates a geojson file from each gpx file.

Get-ChildItem ".\data\*.gpx" | ForEach-Object {
    [xml]$xml = Get-Content $_.FullName

    $NewFileName = $_.FullName.Substring(0, $_.FullName.Length - 3) + "geojson"

    [Feature[]] $FeatureArray = @()

    $xml.gpx.wpt | ForEach-Object {
        $Geometry = [Geometry]::new("Point", ($_.GetAttribute("lon"), $_.GetAttribute("lat")))
        $Properties = [Properties]::new($_.name)
        $Feature = [Feature]::new($Geometry, $Properties)

        $FeatureArray += $Feature
    }

    $FeatureCollection = [FeatureCollection]::new($FeatureArray)


    ConvertTo-Json -InputObject $FeatureCollection -Depth 100 | Out-File -FilePath $NewFileName 
}

class FeatureCollection {
    [string]$type = "FeatureCollection"
    [Feature[]]$features

    FeatureCollection(
        [Feature[]]$features
    ) {
        $this.features = $features
    }
}

class Feature {
    [string]$type = "Feature"
    [Geometry]$geometry
    [Properties]$properties

    Feature(
        [Geometry]$geometry,
        [Properties]$properties
    ) {
        $this.geometry = $Geometry
        $this.properties = $properties
    }
}

class Geometry {
    [string]$type
    [double[]]$coordinates

    Geometry(
        [string]$type,
        [double[]]$coordinates
    ) {
        $this.type = $type
        $this.coordinates = $coordinates
    }
}

class Properties {
    [string]$name

    Properties(
        [string]$name
    ) {
        $this.name = $name
    }
}