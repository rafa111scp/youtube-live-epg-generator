#!/bin/bash
# YouTube Live EPG Generator - NBC News
# Generates an XMLTV EPG for your NBC News YouTube Live channel

## VARIABLES

CHANNEL_ID="NBCNews"
CHANNEL_NAME="NBC News"
DESCRIPTION="This is a standard TV programme for your YouTube Live feed."
BASEPATH="/home/ubuntu/EPG"
DUMMYFILENAME="epg_nbc_news.xml"
NDAYS=3  # Number of days to generate the EPG (adjust as needed)

# Create XML header

mkdir -p "$BASEPATH"
echo '<?xml version="1.0" encoding="UTF-8"?>' > "$BASEPATH/$DUMMYFILENAME"
echo '<tv generator-info-name="dummyepg" generator-info-url="https://github.com/yurividal/dummyepgxml/">' >> "$BASEPATH/$DUMMYFILENAME"

# Channel definition

cat >> "$BASEPATH/$DUMMYFILENAME" <<EOL
<channel id="$CHANNEL_ID">
    <display-name lang="en">$CHANNEL_NAME</display-name>
</channel>
EOL

# Function to generate programmes

generate_programmes() {
    local day=$1
    local next_day=$(date -d "$day +1 day" +%Y%m%d)

    # Local timezone offset
    local offset=$(date -d "$day" +%z)
    local offset_next=$(date -d "$next_day" +%z)

    # Full-day program: 00:00 → 23:59
    echo "    <programme start=\"${day}000000 $offset\" stop=\"${day}235900 $offset\" channel=\"$CHANNEL_ID\">" >> "$BASEPATH/$DUMMYFILENAME"
    echo "        <title lang=\"en\">Test Programme</title>" >> "$BASEPATH/$DUMMYFILENAME"
    echo "        <desc lang=\"en\">$DESCRIPTION</desc>" >> "$BASEPATH/$DUMMYFILENAME"
    echo "    </programme>" >> "$BASEPATH/$DUMMYFILENAME"

    # Last-minute program: 23:59 → 00:00 next day
    echo "    <programme start=\"${day}235900 $offset\" stop=\"${next_day}000000 $offset_next\" channel=\"$CHANNEL_ID\">" >> "$BASEPATH/$DUMMYFILENAME"
    echo "        <title lang=\"en\">Test Programme</title>" >> "$BASEPATH/$DUMMYFILENAME"
    echo "        <desc lang=\"en\">$DESCRIPTION</desc>" >> "$BASEPATH/$DUMMYFILENAME"
    echo "    </programme>" >> "$BASEPATH/$DUMMYFILENAME"
}

# Generate EPG for the number of days specified

for i in $(seq 0 $((NDAYS-1))); do
    day=$(date -d "+$i day" +%Y%m%d)
    generate_programmes $day
done

# Close XML
echo '</tv>' >> "$BASEPATH/$DUMMYFILENAME"

echo "EPG file generated at $BASEPATH/$DUMMYFILENAME"
