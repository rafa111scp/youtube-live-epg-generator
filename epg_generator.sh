#!/bin/bash
# YouTube Live EPG Generator - NBC News
# Generates an XMLTV EPG for your NBC News YouTube Live channel

## VARIABLES

# Output file path (first argument)
OUTPUT_FILE=${1:-"./NBC_News.xml"}

CHANNEL_ID="NBC_News"
CHANNEL_NAME="NBC News"
DESCRIPTION="This is a standard TV programme for your YouTube Live feed."
NDAYS=7  # Default: generate 7 days of EPG

# Create XML header
echo '<?xml version="1.0" encoding="UTF-8"?>' > "$OUTPUT_FILE"
echo '<tv generator-info-name="dummyepg" generator-info-url="https://null.null/">' >> "$OUTPUT_FILE"

# Channel definition
cat >> "$OUTPUT_FILE" <<EOL
    <channel id="$CHANNEL_ID">
        <display-name lang="en">$CHANNEL_NAME</display-name>
    </channel>
EOL

generate_programmes() {
    local dia=$1
    local dia_amanha=$(date -d "$dia +1 day" +%Y%m%d)
    local offset=$(date -d "$dia" +%z)
    local offset_next=$(date -d "$dia_amanha" +%z)

    echo "    <programme start=\"${dia}000000 $offset\" stop=\"${dia}235900 $offset\" channel=\"$CHANNEL_ID\">" >> "$OUTPUT_FILE"
    echo "        <title lang=\"en\">Test Programme</title>" >> "$OUTPUT_FILE"
    echo "        <desc lang=\"en\">$DESCRIPTION</desc>" >> "$OUTPUT_FILE"
    echo "    </programme>" >> "$OUTPUT_FILE"

    echo "    <programme start=\"${dia}235900 $offset\" stop=\"${dia_amanha}000000 $offset_next\" channel=\"$CHANNEL_ID\">" >> "$OUTPUT_FILE"
    echo "        <title lang=\"en\">Test Programme</title>" >> "$OUTPUT_FILE"
    echo "        <desc lang=\"en\">$DESCRIPTION</desc>" >> "$OUTPUT_FILE"
    echo "    </programme>" >> "$OUTPUT_FILE"
}

for i in $(seq 0 $((NDAYS-1))); do
    dia=$(date -d "+$i day" +%Y%m%d)
    generate_programmes $dia
done

echo '</tv>' >> "$OUTPUT_FILE"

echo "EPG file generated at $OUTPUT_FILE"
