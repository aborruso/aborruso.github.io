#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$folder"/data
mkdir -p "$folder"/output

# carta di base

naturalearth_world="https://naciscdn.org/naturalearth/110m/cultural/ne_110m_admin_0_countries.zip"

if [ ! -f "$folder"/data/ne_110m_admin_0_countries.zip ]; then
    wget -O "$folder"/data/ne_110m_admin_0_countries.zip "$naturalearth_world"
fi

## Unzip the file
unzip -o "$folder"/data/ne_110m_admin_0_countries.zip -d "$folder"/data

## estrai soltanto il campo POSTAL
if [ -f "$folder"/output/world.geojson  ]; then
    rm "$folder"/output/world.geojson
fi

ogr2ogr -f geojson "$folder"/output/world.geojson "$folder"/data/ne_110m_admin_0_countries.shp -lco 'RFC7946=YES' -lco 'WRITE_BBOX=YES' -select "POSTAL"

# dati nazionalità migranti

migranti_nazionalita="https://raw.githubusercontent.com/ondata/liberiamoli-tutti/main/sbarchi-migranti/dati/nazionalita.csv"

if [ ! -f "$folder"/data/nazionalita.csv ]; then
    wget -O "$folder"/data/nazionalita.csv "$migranti_nazionalita"
fi

## estrai dati più recenti del 2023
mlrgo --csv filter '$Data_Report=~"2023-12-31"' then sub -f "ISO_3166-1" "SY" "SYR" "$folder"/data/nazionalita.csv > "$folder"/output/nazionalita_2023.csv

if [ -f "$folder"/tmp.geojson ]; then
    rm "$folder"/tmp.geojson
fi

## join tra mappa e dati
duckdb <<EOF
COPY (
    SELECT w.*,
           COALESCE(n.Valore, 0) AS Valore,
           n.Nazione
    FROM st_read('${folder}/output/world.geojson') w
    LEFT JOIN read_csv_auto('${folder}/output/nazionalita_2023.csv') n ON w.POSTAL = n."ISO_3166-1"
    ORDER BY POSTAL
) TO '${folder}/tmp.geojson' WITH (FORMAT 'GDAL', DRIVER 'GeoJSON',LAYER_CREATION_OPTIONS ('WRITE_BBOX=YES', 'RFC7946=YES'))
EOF

mapshaper "${folder}"/tmp.geojson -clean gap-fill-area=0 -o fix-geometry "${folder}"/output/world.geojson

exit 0

if [ -f "$folder"/tmp.geojson ]; then
    rm "$folder"/tmp.geojson
fi
