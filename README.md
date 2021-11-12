# Abevjava (ÁNYK) telepítése macOS-re (összes OS verzió, Intel/Apple Silicon)

Intro: Ha vállalkozó vagy, kell neked az abevjava. Ha maced van, nem olyan egyszerű a téma.
- A youtube-os guide-ok nem működnek ([ref 1](https://www.youtube.com/watch?v=IfNgQSIgwXA), [ref 2](https://www.youtube.com/watch?v=0dQQbkVdOwI)), a netelérés (tehát a beküldés vagy a törzsadatok szinkronizációja) nem fog működni, hiába telepítgetsz régebbi java verziókat
- Ráadásul eleve nem akarod javával szemetelni a rendszered.
- A NAV oldalán van egy JRE-vel együtt bundle-olt csomag Windowsra, ami nagyon kényelmes, csak az Windows.
- Apple Siliconon még kényesebb a téma. QEMU alá WinXP vagy Win 7-tel a Java nem fog működni, nem keresem vissza, mi a hibaüzenet.
- Ami működik: Wine. Ezzel működik minden a NAV-os bundle-lal. Ehhez találhatók alább a segédletek.

## Automatikus telepítő/indító app:
  https://github.com/sarimarton/abevjava-mac/releases

## Telepítés kézzel

1. Telepítsd a Homebrew-t:
   - Menj a brew.sh weboldalra
   - Másold be a telepítőparancsot a vágólapra
   - Nyiss egy Terminal ablakot
   - Illeszd be a telepítőparancsot és menj végig a telepítésen
   
2. Telepítsd a Wine-t:
   - Terminal ablakban futtasd:
      `brew tap gcenx/wine && brew install wine-crossover`
   - Adj engedélyt a wine futtatásához:
      - Indítsd el a feltelepült `Wine Crossover.app` appot. Ekkor kapsz egy hibaüzenetet. Cancel (Mégsem).
      - Menj a System Preferences-be (Rendszerbeállítások), majd Security and Privacy, General (Általános) fül,
        alul kattintsd ki a lakatot, majd a `"Wine Crossover.app" was blocked` felirat mellett kattints az "Open Anyway" gombra.
   - Terminalban futtasd:
      `wine REG ADD HKCU\\Software\\Wine\\Mac\ Driver /v ForceOpenGLBackingStore /t REG_SZ /d y`

3. Telepítsd az abevjava + JRE Windows-os csomagot:
   - Menj a https://nav.gov.hu weboldalra, majd ott kattints baloldalt a "Nyomtatványkitöltő programok" linkre
   - Töltsd le az `abevjava_install_oracle_jre.exe`-t a Downloads mappába
   - Terminalban futtasd: `wine ~/Downloads/abevjava_install_oracle_jre.exe`
   - Menj végig a telepítésen

4. Készíts indítóparancsot
  - Nyisd meg az Automator appot
  - Válaszd ki a `File` menü / `New` menüpontot
  - Választ az Applicationt
  - Adj hozzá egy `Run AppleScript` actiont, és másold be neki ezt:
    ```
    on run {input, parameters}
        tell application "Terminal" to do script "wine cmd.exe /c 'C:/users/Public/abevjava/jre/bin/java -jar c:/users/Public/abevjava/abevjava.jar'"
    end run
    ```
  - Mentsd el
  - Adj neki ikont:
    - Finderben keresd ki az abevjava.ico vagy .png fájlt az abevjava mappájában, és jelöld ki
    - `Command + C`
    - Finderben jelöld ki az Automatorral készül appodat
    - `Command + I`
    - Kattints a bal felső ikonra a panelen belül - ki lesz jelölve.
    - `Command + V`
    - Csukd be a panelt
