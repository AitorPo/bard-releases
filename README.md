# Bard releases

Installers for the Bard desktop app (macOS and Windows). Download the newest one from
[Releases](https://github.com/AitorPo/bard-releases/releases/latest).

- **macOS:** open the `.dmg` and drag Bard to Applications. The app is not signed: right-click Bard > Open the first time, or run `xattr -d com.apple.quarantine /Applications/Bard.app`.
- **Windows:** run the `-setup.exe` (or `.msi`) installer.

Each release lists the SHA-256 of every file in `SHA256SUMS`. Bard checks it before installing an update.
