# Creates a geojson file from each gpx file.

Get-ChildItem ".\data\*.gpx" | ForEach-Object {
    [xml]$xml = Get-Content $_.FullName

    $NewFileName = $_.FullName.Substring(0, $_.FullName.Length - 3) + "geojson"

    $Geometry = [Geometry]::new("Point", (5.6, 6.7))
    $Properties = [Properties]::new("Test Point")
    $Feature = [Feature]::new($Geometry, $Properties)
    [Feature[]] $FeatureArray = $Feature
    $FeatureCollection = [FeatureCollection]::new($FeatureArray)
    $GeoJson = [GeoJson]::new($FeatureCollection)


    ConvertTo-Json -InputObject $GeoJson.FeatureCollection -Depth 100 | Out-File -FilePath $NewFileName 
}

class GeoJson {
    [FeatureCollection[]]$FeatureCollection

    GeoJson(
        [FeatureCollection]$featureCollection
    ) {
        $this.FeatureCollection = $featureCollection
    }
}

class FeatureCollection {
    [string]$type = "FeatureCollection"
    [Feature[]]$Features

    FeatureCollection(
        [Feature[]]$features
    ) {
        $this.Features = $features
    }
}

class Feature {
    [string]$type = "Feature"
    [Geometry]$Geometry
    [Properties]$Properties

    Feature(
        [Geometry]$geometry,
        [Properties]$properties
    ) {
        $this.Geometry = $Geometry
        $this.Properties = $properties
    }
}

class Geometry {
    [string]$Type
    [double[]]$Coordinates

    Geometry(
        [string]$type,
        [double[]]$coordinates
    ) {
        $this.Type = $type
        $this.Coordinates = $coordinates
    }
}

class Properties {
    [string]$Name

    Properties(
        [string]$name
    ) {
        $this.Name = $name
    }
}