# Abevjava (ÁNYK) telepítése macOS-re (összes OS verzió, Intel/Apple Silicon)

## Automatikus telepítő/indító app:
  https://github.com/sarimarton/abevjava-mac/releases

## Telepítés kézzel

1. Telepítsd a Homebrew-t:
   - Menj a brew.sh weboldalra
   - Másold be a telepítőparancsot a vágólapra
   - Nyiss egy Terminal ablakot
   - Illeszd be a telepítőparancsot és menj végig a telepítésen
   
2. Telepítsd a Wine-t:
   - Terminal ablakban indíts el az alábbi parancsot:
      `brew tap gcenx/wine && brew install wine-crossover`
   - Adj engedélyt a wine futtatásához:
      - Indítsd el a feltelepült `Wine Crossover.app` appot. Ekkor kapsz egy hibaüzenetet. Cancel.
      - Menj a System Preferences-be (Rendszerbeállítások), majd Security and Privacy, General (Általános) fül,
        alul kattintsd ki a lakatot, majd a `"Wine Crossover.app" was blocked` felirat mellett kattints az "Open Anyway" gombra.
   - Terminalban indítsd el az alábbi parancsot:
      `wine REG ADD HKCU\\Software\\Wine\\Mac\ Driver /v ForceOpenGLBackingStore /t REG_SZ /d y`

3. Telepítsd az abevjava + JRE Windows-os csomagot:
   - Menj a https://nav.gov.hu weboldalra, majd ott kattints baloldalt a "Nyomtatványkitöltő programok" linkre
   - Töltsd le az `abevjava_install_oracle_jre.exe`-t a Downloads mappába
   - Terminalban futtasd: `wine ~/Downloads/abevjava_install_oracle_jre.exe`
   - Menj végig a telepítésen

