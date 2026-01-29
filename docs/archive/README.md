# HamClock clearskyinstitute.com Archive

This directory contains an archived snapshot of clearskyinstitute.com, specifically the HamClock application pages and documentation.

## Archive Details

- **Archive Source:** Internet Archive (web.archive.org)
- **Primary Snapshot Date:** January 23, 2025 (Archive Team collection)
- **HamClock Page Snapshot:** February 2, 2025
- **Last Version Archived:** v4.12 (2025-01-01)

## Important Note

**Elwood Downey WB0OEW**, the creator of HamClock, is deceased. The clearskyinstitute.com backend services are no longer available.

## Contents

### www/ - Browsable Website

A self-contained browsable version of the archive.

| File | Description |
|------|-------------|
| `index.html` | Main archive landing page |
| `HamClock.html` | Complete HamClock documentation page |
| `clearskyinstitute-home.html` | Original clearskyinstitute.com home page |

### main/ - Raw Archives

| File | Description |
|------|-------------|
| `HamClock-QST-article.pdf` | Original QST magazine article introducing HamClock |
| `HamClock-source.zip` | Source code archive (v4.12, Nov 2024) |
| `HamClock-source.tgz` | Source code archive (v4.12, Nov 2024) |

### backend-examples/ - Backend Data Examples

**Note:** Most backend API endpoint data was dynamic and not archived. These files may be empty.

## Captured URLs

The following URLs were captured:

- Main page: `https://www.clearskyinstitute.com/` (444 captures from 1998-2026)
- HamClock page: `https://www.clearskyinstitute.com/ham/HamClock/` (211 captures from 2017-2026)

## Backend Endpoints (No Longer Available)

The following backend endpoints that HamClock relied upon are **no longer available**:

| Endpoint | Purpose |
|----------|---------|
| `/wx.pl` | Weather and timezone data |
| `/worldwx/wx.txt` | World weather grid |
| `/solar-flux/solarflux-*.txt` | Solar flux data |
| `/ssn/ssn-*.txt` | Sunspot numbers |
| `/NOAASpaceWX/noaaswx.txt` | NOAA space weather scales |
| `/geomag/kindex.txt` | K-index |
| `/xray/xray.txt` | X-ray flux |
| `/aurora/aurora.txt` | Aurora predictions |
| `/Bz/Bz.txt` | IMF Bz component |
| `/drap/stats.txt` | D-Region Absorption Predictions |
| `/esats/esats.txt` | Satellite TLE data |
| `/dxpeds/dxpeditions.txt` | DXpedition information |
| `/contests/contests*.txt` | Contest schedules |
| `/fetchPSKReporter.pl` | PSKReporter spots |
| `/fetchWSPR.pl` | WSPR spots |
| `/fetchRBN.pl` | Reverse Beacon Network spots |
| `/fetchBandConditions.pl` | VOACAP band conditions |

## Alternative Data Sources

Many of the backend data sources are available directly from upstream providers:

- **Space Weather:** https://services.swpc.noaa.gov/json/
- **Satellite TLEs:** https://celestrak.org/NORAD/elements/
- **Weather:** https://openweathermap.org/api
- **Contests:** https://www.contestcalendar.com/weeklycont.php
- **PSKReporter:** https://pskreporter.info/

See `/docs/BACKEND_ANALYSIS.md` for complete details.

## Using This Archive

### Browse Locally

You can serve the archive locally with Python:

```bash
cd docs/archive/www
python3 -m http.server 8080
```

Then open http://localhost:8080 in your browser.

### View the Main Page

Open `www/index.html` in a web browser for the archive landing page.

### Extract Source Code

```bash
cd docs/archive/main
unzip HamClock-source.zip
tar -xzf HamClock-source.tgz
```

### Read the QST Article

Open `HamClock-QST-article.pdf` for the original magazine article.

## Version History (Archived)

The complete version history through v4.12 is preserved in the HamClock page HTML.

## License

See `/ESPHamClock/LICENSE` for licensing information. The MIT license applies to the client software only, not the backend services.

## Archive Source

- **Archive.org URL:** https://web.archive.org/web/*/clearskyinstitute.com/
- **Archive Team Collection:** https://archive.org/details/archiveteam-collections
- **Capture Count:** 444 total captures of clearskyinstitute.com

## Attribution

- Original content (c) Elwood Downey WB0OEW
- Archived by Internet Archive's Wayback Machine
- Preserved for historical and educational purposes
