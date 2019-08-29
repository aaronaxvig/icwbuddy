var data =
    {
        "type": "FeatureCollection",
        "features": [
            
        ]
    };

var aicwFiles = [
    'data/aicw-mile-marker-0-99.geojson',
    'data/aicw-mile-marker-100-199.geojson',
    'data/aicw-mile-marker-200-299.geojson',
    'data/aicw-mile-marker-300-399.geojson',
    'data/aicw-mile-marker-400-499.geojson',
    'data/aicw-mile-marker-500-599.geojson',
    'data/aicw-mile-marker-600-699.geojson',
    'data/aicw-mile-marker-700-799.geojson',
    'data/aicw-mile-marker-800-899.geojson',
    'data/aicw-mile-marker-900-999.geojson',
    'data/aicw-mile-marker-1000-1099.geojson',
    'data/aicw-mile-marker-1100-1153.geojson'
]

function fetchJSON(url) {
    return fetch(url)
        .then(function(response) {
            return response.json();
        });
}

function concatGeoJSON(g1, g2){
    return { 
        "type" : "FeatureCollection",
        "features": [... g1.features, ... g2.features]
    }
}

function loadAllData() {
    return Promise.all([loadAicwData()]);
}

function loadAicwData() {
    var sequence = Promise.resolve();

    aicwFiles.forEach(function(aicwFileUrl) {
        sequence = sequence.then(function() {
            return fetchJSON(aicwFileUrl);
        }).then(function(aicwFile) {
            data = concatGeoJSON(data, aicwFile)
        });
    });
}