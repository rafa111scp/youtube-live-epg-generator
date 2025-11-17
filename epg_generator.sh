#!/bin/bash
# YouTube Live EPG Generator - NBC News
# Generates an XMLTV EPG for your NBC News YouTube Live channel

## VARIABLES

# Output file path (first argument)

OUTPUT_FILE=${1:-"./NBC_News.xml"}

CHANNEL_ID="NBC_News"
CHANNEL_NAME="NBC News"
DESCRIPTION="This is a standard TV programme for your YouTube Live feed."
NDAYS=7  # Default: number of days to generate EPG (adjust accordingly)

# Create XML header

echo '<?xml version="1.0" encoding="UTF-8"?>' > "$OUTPUT_FILE"
echo '<tv generator-info-name="dummyepg" generator-info-url="https://null.null/">' >> "$OUTPUT_FILE"

# Channel definition

cat >> "$OUTPUT_FILE" <<EOL
    <channel id="$CHANNEL_ID">
        <display-name lang="en">$CHANNEL_NAME</display-name>
    </channel>
EOL

# Function to generate programmes for a given date

generate_programmes() {
    local day=$1
    local next_day=$(date -d "$day +1 day" +%Y%m%d)
    local offset=$(date -d "$day" +%z)
    local offset_next=$(date -d "$next_day" +%z)

    # Main programme: 00:00 → 23:59 local
    
    echo "    <programme start=\"${day}000000 $offset\" stop=\"${day}235900 $offset\" channel=\"$CHANNEL_ID\">" >> "$OUTPUT_FILE"
    echo "        <title lang=\"en\">Test Programme</title>" >> "$OUTPUT_FILE"
    echo "        <desc lang=\"en\">$DESCRIPTION</desc>" >> "$OUTPUT_FILE"
    echo "    </programme>" >> "$OUTPUT_FILE"

    # Short programme: 23:59 → 00:00 next day
    
    echo "    <programme start=\"${day}235900 $offset\" stop=\"${next_day}000000 $offset_next\" channel=\"$CHANNEL_ID\">" >> "$OUTPUT_FILE"
    echo "        <title lang=\"en\">Test Programme</title>" >> "$OUTPUT_FILE"
    echo "        <desc lang=\"en\">$DESCRIPTION</desc>" >> "$OUTPUT_FILE"
    echo "    </programme>" >> "$OUTPUT_FILE"
}

# Generate EPG for NDAYS

for i in $(seq 0 $((NDAYS-1))); do
    day=$(date -d "+$i day" +%Y%m%d)
    generate_programmes $day
done

# Close XML

echo '</tv>' >> "$OUTPUT_FILE"

echo "EPG file generated at $OUTPUT_FILE"
