var data =
    {
        "type": "FeatureCollection",
        "features": [
            
        ]
    };

var aicwFiles = [
    'data/aicw-mile-marker-0-99.geojson',
    'data/aicw-mile-marker-100-199.geojson'
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