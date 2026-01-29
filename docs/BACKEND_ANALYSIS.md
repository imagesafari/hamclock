# HamClock Backend Analysis

## Overview

HamClock is an amateur radio clock application that displays time, propagation, satellite, weather, and space weather information. This document analyzes the external backends it relies upon and evaluates whether data can be obtained directly from upstream sources without depending on clearskyinstitute.com.

---

## Current Backend Dependencies

### Primary Backend Server

**Host:** `clearskyinstitute.com` (port 80)

Defined in: `ESPHamClock/wifi.cpp` (lines 8-9)

```cpp
const char *backend_host = "clearskyinstitute.com";
int backend_port = 80;
```

The clearskyinstitute.com server acts as a proxy aggregator for multiple upstream data sources.

---

## Data Sources Through clearskyinstitute.com

### Weather and Time Zone Data

**Source:** OpenWeatherMap

**Endpoints:**
- `/wx.pl` - Specific weather/time at lat/lng (exact location)
- `/worldwx/wx.txt` - Gridded world weather table (fast lookup)

**Reference:** `ESPHamClock/tz.cpp` (line 2) states: *"uses the same data storage as wx.cpp because wx and tz data both arrive together from open weather map"*

---

### Space Weather Data

**Source:** NOAA and related space weather services (proxied through clearskyinstitute.com)

**Endpoints:**
- `/NOAASpaceWX/noaaswx.txt` - NOAA Space Weather Scales (R, S, G categories with current and 3-day predictions)
- `/solar-wind/swind-24hr.txt` - Solar wind data
- `/ssn/ssn-31.txt` - Sunspot numbers (31-day)
- `/solar-flux/solarflux-99.txt` - Solar flux (frequently updated)
- `/drap/stats.txt` - D-Region Absorption Predictions
- `/geomag/kindex.txt` - Planetary K-index
- `/xray/xray.txt` - Solar X-ray flux
- `/aurora/aurora.txt` - Aurora activity data
- `/dst/dst.txt` - Disturbance Storm Time index
- `/Bz/Bz.txt` - Interplanetary magnetic field Bz component
- `/NOAASpaceWX/rank2_coeffs.txt` - Ranking coefficients for space weather importance

**Reference:** `ESPHamClock/spacewx.cpp` (lines 9-19)

---

### Satellite Data

**Source:** TLE (Two-Line Element) sets from amateur radio satellite databases

**Endpoints:**
- `/esats/esats.txt` - Earth satellite TLE data

**Reference:** `ESPHamClock/earthsat.cpp` (lines 74-76)

---

### DX Cluster and Spotting Networks

**Sources:** Multiple DX Cluster server types supported directly:
- Spider clusters
- AR clusters
- CC clusters
- VE7CC
- UDP packet format (WSJT-X integration)

**Note:** Direct TCP connections to cluster servers (not proxied through clearskyinstitute.com)

**Reference:** `ESPHamClock/dxcluster.cpp` (lines 54-61)

---

### PSKReporter, WSPR, and RBN Data

**Source:** PSKReporter.info and Reverse Beacon Network

**Endpoints:**
- `/fetchPSKReporter.pl` - PSKReporter spots
- `/fetchWSPR.pl` - WSPR spots
- `/fetchRBN.pl` - Reverse Beacon Network spots

**Reference:** `ESPHamClock/pskreporter.cpp` (lines 16-18)

---

### Contest Data

**Source:** Compiled contest calendar (primarily from contestcalendar.com)

**Endpoints:**
- `/contests/contests311.txt` - Contest schedule
- Also references: `https://www.contestcalendar.com/weeklycont.php`

**Reference:** `ESPHamClock/contests.cpp` (lines 20-22)

---

### DXpedition Data

**Source:** Compiled DXpedition information

**Endpoints:**
- `/dxpeds/dxpeditions.txt` - Active and upcoming DXpeditions

**Reference:** `ESPHamClock/dxpeds.cpp` (lines 28-29)

---

### Country/Prefix Data

**Source:** Modified CTY (country) files

**Endpoints:**
- `/cty/cty_wt_mod-ll-dxcc.txt` - Country/prefix to lat/lng and DXCC mapping

**Reference:** `ESPHamClock/prefixes.cpp` (line 13)

---

### Solar Observatory Images

**Source:** NASA Solar Dynamics Observatory (SDO) - Direct connection (not proxied)

**Endpoints:** Direct URLs to NASA:
- `https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_*.mp4`
  - Composite images, Magnetogram, HMI continuum, and multiple wavelength channels (131A, 193A, 211A, 304A)

**Reference:** `ESPHamClock/sdo.cpp` (lines 30-38)

---

### Additional Data Sources

- **Band Conditions:** `/fetchBandConditions.pl` - VOACAP propagation predictions
- **IP Geolocation:** `/fetchIPGeoloc.pl` - Approximate location from IP address
- **Cities:** `/cities2.txt` - World cities database
- **RSS/Web Content:** `/RSS/web15rss.pl` - RSS feed aggregation
- **On-The-Air:** `/ONTA/onta.txt` - On-the-air broadcast schedules
- **Version Check:** `/version.pl` - Firmware version checking
- **Prefixes (backup):** Built-in hardcoded small prefix table for common callsigns

---

## Direct Access Alternatives

### ✅ Available Free (Direct Access)

#### 1. Space Weather (NOAA)

**Source:** `https://services.swpc.noaa.gov/json/`

**All the data HamClock uses is available:**
- Solar flux: `/json/solar-radio-flux.json`
- Sunspot numbers: `/json/sunspot_report.json`
- K-index: `/json/planetary_k_index_1m.json`
- X-ray flux: `/json/goes/xray_flux.json`
- Dst index: Available in the JSON hierarchy
- Aurora predictions: `/json/ovation_aurora_latest.json`
- And more...

**Access:** Completely free, no API key required

---

#### 2. Satellite TLE Data

**CelesTrak:** `https://celestrak.org/NORAD/elements/`

**Specific feeds:**
- Amateur radio satellites: `https://celestrak.org/NORAD/elements/amateur.txt`
- ISS: `https://celestrak.org/NORAD/elements/gp.php?CATNR=25544`
- Weather satellites: `https://celestrak.org/NORAD/elements/weather.txt`
- GPS: `https://celestrak.org/NORAD/elements/gps-ops.txt`

**Access:** Completely free, no API key required

---

#### 3. Contest Schedules

**Source:** `https://www.contestcalendar.com/weeklycont.php`

**Access:** Web-scrapable, or use the 8-day calendar directly. Completely free.

---

#### 4. PSKReporter/WSPR/RBN Data

**PSKReporter:** `https://pskreporter.info/`

**Endpoints:**
- Best frequency query: `https://pskreporter.info/cgi-bin/psk-freq.pl?grid=AB12`
- Map display and statistics available on the website

**WSPRnet:** `http://wsprnet.org`

**Reverse Beacon Network:** `http://reversebeacon.net`

**Access:** Free for querying

---

#### 5. DX Cluster

**Already direct:** HamClock already supports TCP connections to Spider, AR, CC, VE7CC clusters (not proxied through clearskyinstitute).

---

#### 6. Country/Prefix Data

**CTY Files:** Available from multiple sources:
- `https://www.country-files.com/cty/`
- `https://www.dxwatch.com/cty/`

**Format:** Standard CTY.DAT format used by many logging programs

**Access:** Completely free

---

### ⚠️ Limited/Paid Access

#### 7. Weather (OpenWeatherMap)

**Source:** `https://openweathermap.org/api`

**Free Tier:**
- Current weather: Free
- 5-day forecast: Free
- Limited API calls per minute

**Paid Tiers:**
- One Call API 3.0: Paid subscription required
- Extended forecasts: Paid tiers
- Historical data: Paid tiers
- Bulk downloads: Professional/Expert only

**Timezones:** Available through OpenWeatherMap API (free tier may have limits)

**World weather grid:** Would need to be assembled from multiple API calls

---

#### 8. Satellite Tracking (N2YO.com)

**Source:** `https://www.n2yo.com/api/`

**Free Tier (with registration):**
- TLE queries: 1000 requests/hour
- Visual passes: 100/day
- Radio passes: 100/day
- Above query: Rate limited

**API Key Required:** Must register at n2yo.com to get an API key

**Recommendation:** Better to use CelesTrak for TLEs directly (completely free)

---

#### 9. Band Conditions (VOACAP)

**Source:** VOACAP propagation model

**Status:** Proprietary model - unclear if free direct access exists

**Notes:** This is one area where clearskyinstitute likely provides unique value through pre-computed predictions or a licensed VOACAP service.

---

## Direct Access Summary Table

| Data | Direct Source | Availability | Notes |
|------|---------------|--------------|-------|
| Space weather | NOAA (services.swpc.noaa.gov) | ✅ Free | All data available |
| Satellite TLEs | CelesTrak (celestrak.org) | ✅ Free | No API key needed |
| Weather | OpenWeatherMap | ⚠️ Limited | Free tier available |
| Timezones | OpenWeatherMap | ⚠️ Limited | API key needed |
| Contests | contestcalendar.com | ✅ Free | Web-scrapable |
| PSKReporter | pskreporter.info | ✅ Free | Query API available |
| Band conditions | VOACAP | ❓ Unknown | May need licensing |
| DXPeditions | Various sources | ❓ Complex | Would need compilation |
| Country/prefix | country-files.com | ✅ Free | CTY.DAT format |
| DX Cluster | Direct TCP | ✅ Native | Already supported |

---

## Alternative Backend Architecture

If you want to eliminate clearskyinstitute.com dependency, a custom backend could proxy only:

### Recommended Direct Sources

1. **NOAA Space Weather** - Completely free, comprehensive JSON APIs
2. **CelesTrak TLEs** - Free, regularly updated
3. **Contest Calendar** - Web scrape or partner
4. **PSKReporter** - Free query API
5. **OpenWeatherMap** - Free tier for basic weather

### Potentially Complex

- **Band Conditions (VOACAP)** - May require licensing or alternative propagation model
- **DXPedition Compilation** - Would need to aggregate from multiple DX news sources

---

## Conclusions

1. **Most data can be obtained directly** from upstream sources without clearingkyinstitute.com

2. **Space weather** is the easiest to migrate - NOAA provides all needed data completely free

3. **Satellite TLEs** from CelesTrak are free and reliable

4. **Weather** has a free tier but may be rate-limited for heavy usage

5. **Band conditions** is the main area of uncertainty - may require licensing or alternative modeling

6. **Clearskyinstitute.com** provides value as a unified aggregator and cache, simplifying client implementation

---

## References

- NOAA Space Weather Prediction Center: https://www.swpc.noaa.gov
- CelesTrak: https://celestrak.org
- OpenWeatherMap: https://openweathermap.org
- PSKReporter: https://pskreporter.info
- WA7BNM Contest Calendar: https://www.contestcalendar.com
- N2YO Satellite API: https://www.n2yo.com/api/
