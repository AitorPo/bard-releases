# Bard

Shows what Spotify is playing inside World of Warcraft (Retail and WoW Forever) and controls it from the game: play, pause, next, previous, shuffle, repeat, volume (macOS), your playlists and search.

A small desktop app does the work the addon cannot: it reads the addon's messages from a strip of pixels at the corner of the WoW window, talks to the Spotify app on the same computer, and answers through small helper addons it installs next to Bard. This repository only hosts the downloads.

## Download

Get the installer for your system from the [Releases page](https://github.com/AitorPo/bard-releases/releases/latest):

- **macOS:** `Bard_<version>_aarch64.dmg` for Apple Silicon (M1 and newer). Open the dmg and drag Bard to Applications. There is no Intel Mac build for now.
- **Windows:** `Bard_<version>_x64-setup.exe` for 64-bit Windows. Run it and follow the setup steps.

Bard updates itself: when a new version is out, the app offers it and "Update now" installs it.

### macOS from Terminal (no warning)

Files fetched by `curl` have no quarantine flag, so the app opens normally. The command picks the right build for your CPU, installs `/Applications/Bard.app` and starts it.

```bash
curl -fsSL https://raw.githubusercontent.com/AitorPo/bard-releases/main/scripts/install-macos.sh | bash
```

### If you download in the browser

The builds are not signed yet, so the system warns on first launch:

- **macOS:** "Bard cannot be opened because the developer cannot be verified". Right-click Bard in Applications, choose Open, then Open again. Or open System Settings, Privacy & Security, and click Open Anyway. If macOS says the app is damaged, run `xattr -d com.apple.quarantine /Applications/Bard.app` in Terminal and open it again.
- **Windows:** SmartScreen says "Windows protected your PC". Click More info, then Run anyway.

Each release lists a `SHA256SUMS` file to verify the downloads.

## Setup

1. Start the Bard app. It finds your WoW folder and installs the addon. After the first install, fully quit and start WoW once. Type `/reload` in game after an app update.
2. macOS: grant Screen Recording access when asked (Bard reads the pixel strip the addon draws), and allow Bard to control Spotify. Keep game sound enabled: the addon hears the app through silent sound files.
3. For your playlists and search, create a free app at https://developer.spotify.com/dashboard (Web API), add the Redirect URI `http://127.0.0.1:8899/callback`, add your Spotify account under User Management, then paste its Client ID into the Bard app and log in.
4. In game: `/bard`.

Bard runs from the menu bar (macOS) or the system tray (Windows). Closing its window keeps it running there; use the tray menu to quit.
