RDCL = ./src/道路中心線/DKG-SHP-513351-RdCL3d-20231031-0001.shp
BLDG = ./src/建物/DKG-SHP-513351-BldA3d-20231031-0001.shp
TCL = ./src/軌道の中心線/DKG-SHP-513351-RailTrCL3d-20231031-0001.shp

OGR_CMD = ogr2ogr -of GeoJSONSeq /vsistdout/
DST_PATH = docs/minari.pmtiles

all: 
	( \
	(${OGR_CMD} ${RDCL} | jq -c -f rdcl.jq);\
	(${OGR_CMD} ${BLDG} | jq -c -f bldg.jq);\
	(${OGR_CMD} ${TCL} | jq -c -f tcl.jq)\
	) | tippecanoe -f -o ${DST_PATH}

download: 
	curl -o src/src.zip https://www.gsi.go.jp/common/000268433.zip

extract:
	unar --force-overwrite src/src.zip

