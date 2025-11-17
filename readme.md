# YouTube Live EPG Generator - NBC News

This project automatically generates a dummy XMLTV EPG (Electronic Program Guide) for the NBC News YouTube Live channel. It demonstrates how to produce EPG files for live streaming channels using **bash** scripts and optionally automate updates with **GitHub Actions**.

---

## Demo / Quick Test

If you just want to see the script in action without running any server or automation:

1. Open `epg_generator.sh` and ensure the channel details are correct.  

2. Run the script manually:

```bash

.\epg_generator.sh

```

    Check the generated XML file:

```bash

cat NBC_News.xml

```

You’ll see a simple EPG file with “Test Programme” for each day. This demonstrates the concept before using automation.

Features

    Generates a dummy EPG XML file for NBC News YouTube Live

    Default: 7 days of program schedules (adjustable via script)

    Simple bash implementation (no extra dependencies)

    Optional automation via GitHub Actions

    Fully customizable program titles and descriptions

Setup

    Clone the repository:

git clone https://github.com/rafa111scp/youtube-live-epg-generator.git
cd youtube-live-epg-generator

    Run the script manually:

```bash

.\epg_generator.sh

```

    The default output is NBC_News.xml in the repository root. You can pass a custom file path as an argument:

```bash

epg_generator.sh ./path/to/custom_filename.xml

```

GitHub Actions Automation (Optional)

The repository includes a sample workflow .github/workflows/generate_epg.yml that demonstrates how the EPG could be generated automatically on a schedule (daily, weekly, etc.).

    Note: For demonstration purposes, automatic commit & push may require repository permissions. The workflow will run locally or as an artifact without committing if permissions are restricted.

Optional Customization

You can adjust:

    Number of days generated: Edit the NDAYS variable in the script.

    Channel info: CHANNEL_NAME, CHANNEL_ID, DESCRIPTION.

    Program titles and descriptions: Change inside the generate_programmes function.

Example snippet:

echo "        <title lang=\"en\">Test Programme</title>" >> "$OUTPUT_FILE"
echo "        <desc lang=\"en\">This is a standard TV programme for your YouTube Live feed.</desc>" >> "$OUTPUT_FILE"

Thanks / Acknowledgements

    Inspired by and based on yurividal/dummyepgxml

    Special thanks for providing a minimal example for generating XMLTV EPG files.

    Thanks to GitHub Actions for workflow automation.

    Thanks to the open-source community for bash, Git, and XMLTV standards.

Notes

    This project is intended as a demo / educational resource.

    It does not require a web server to generate the EPG.

    Fully adaptable for other YouTube Live channels by editing the script variables.

    The EPG output can be used in IPTV players, media servers, or for personal testing.

License

This repository is MIT licensed. Feel free to fork, modify, and adapt for your own projects.
