-- tovabbfejl:
-- https://apple.stackexchange.com/questions/328329/is-there-a-way-via-the-command-line-to-cause-icloud-files-to-download#comment541070_387727

on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

on run {input, parameters}
	if input = {"shortcut"} then
		return input
	end if

	set wasTerminalRunning to is_running("Terminal")

	tell application "Terminal"
		set myTab to do script
		set myWindow to first window of (every window whose tabs contains myTab)
		activate

		-- check if homebrew is installed
		do script "brew --version >/dev/null 2>/dev/null || {
			echo \"\\nHomebrew telepítése. Majd be kell írni a felhasználói jelszót. Tovább: Enter\"; read;
			/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\";
			echo \"A Homebrew telepítése befejeződött. Tovább: Enter\";
		}" in myTab
		delay 1

		repeat until busy of myTab is false
			delay 1
		end repeat

		-- check if wine is installed
		do script "wine --version >/dev/null 2>/dev/null || {
			echo \"\\nWine telepítése. Tovább: Enter\"; read;
			brew tap gcenx/wine && brew install wine-crossover;
			echo \"A Wine telepítése befejeződött, most megkísérelem megnyitni. Ha a macOS hibaüzenetet ad, akkor Mégsem-ezd le (\"Cancel\"). Ha megnyílik, akkor csukd be az ablakát és térj ide vissza. Tovább: Enter\"; read;
			open /Applications/Wine\\ Crossover.app;
			echo \"Hibaüzenetet adott (i/n)?\"; read x;
			if [ $x = \"i\" ]; then
				echo \"Jó. Most megnyitom a Rendszerbeállításokat, és a panel sarkában kattintsd ki a lakatot, majd az alsó felében lévő gombbal engedélyezd a Wine Crossover futtatását. Ekkor meg fog nyílni a Wine ablaka, amire most nincs szükség, úgyhogy majd csukd be. Ha végeztél, térj ide vissza. Tovább: Enter\"; read;
				open \"x-apple.systempreferences:com.apple.preference.security\";
				echo \"Ha engedélyezted a Wine Crossover futtatását, nyomj Entert.\"; read;
			fi
		}" in myTab
		delay 1

		repeat until busy of myTab is false
			delay 1
		end repeat

		-- force creating a prefix
		do script "wine cmd /c" in myTab

		repeat until busy of myTab is false
			delay 1
		end repeat

		-- fix flickering
		do script "wine REG QUERY HKCU\\\\Software\\\\Wine\\\\Mac\\ Driver /v ForceOpenGLBackingStore | grep -c Force || (wine REG ADD HKCU\\\\Software\\\\Wine\\\\Mac\\ Driver /v ForceOpenGLBackingStore /t REG_SZ /d y)" in myTab

		repeat until busy of myTab is false
			delay 1
		end repeat

		-- check if abevjava is installed
		do script "if [ ! -d \"/Users/$USER/Documents/abevjava-wine/abevjava\" ]; then
			echo \"\\nÚgy tűnik, hogy az abevjava nincs még telepítve. Megnyitom a NAV weboldalát, ahonnan töltsd le a Windowshoz ajánlott \"abevjava_install_oracle_jre.exe\" fájlt a Downloads (Letöltések) mappádba. (A Safari alapból oda rakja.) Tovább: Enter\"; read;
			open https://www.nav.gov.hu/nav/letoltesek
			echo \"Ha letöltötted az abevjava_install_oracle_jre.exe fájlt, nyomj Entert.\"; read;
			echo Most elindítom az abevjava telepítőjét. A telepítő kérni fog mappákat, ahova telepíteni szeretne dolgokat.
			echo
			echo Amikor az abevjava mappáját kéri, akkor írd be neki ezt:
			echo Z:/Users/$USER/Documents/abevjava-wine/abevjava
			echo
			echo Amikor a felhasználói beállítások mappáját kéri, akkor pedig írd be neki ezt:
			echo Z:/Users/$USER/Documents/abevjava-wine/abevjava-data
			echo
			echo \"Tovább: Enter\"; read;
			wine ~/Downloads/abevjava_install_oracle_jre.exe
		fi" in myTab
		delay 1

		repeat until busy of myTab is false
			delay 1
		end repeat

		-- force recreate abevjava user config (in case if wine prefix was deleted)
		do script "
if [ ! -f ~/.wine/drive_c/users/crossover/.abevjava/$USER.enyk ]
then

wine cmd /c mkdir C:\\\\users\\\\crossover\\\\.abevjava
cat <<EOT > ~/.wine/drive_c/users/crossover/.abevjava/$USER.enyk
prop.usr.naplo=Z:\\Users\\\\$USER\\Documents\\abevjava-wine\\abevjava-data\\naplo
prop.usr.kontroll=kontroll
prop.usr.saves=mentesek
prop.usr.tmp_calc=calc
prop.usr.ds_sent=KR/elkuldott
prop.usr.root=Z:\\Users\\\\$USER\\Documents\\abevjava-wine\\abevjava-data
prop.usr.ds_dest=KR/kuldendo
prop.usr.tmp=tmp
prop.usr.frissitesek=Z:\\Users\\\\$USER\\Documents\\abevjava-wine\\abevjava-data\\frissitesek
prop.usr.archive=archivum
prop.usr.ds_src=KR/digitalis_alairas
prop.usr.import=import
prop.usr.settings=beallitasok
prop.usr.tmp_xml=xml
prop.usr.attachment=csatolmanyok
prop.usr.primaryaccounts=Z:\\Users\\\\$USER\\Documents\\abevjava-wine\\abevjava-data\\torzsadatok
EOT

fi
		" in myTab

		repeat until busy of myTab is false
			delay 1
		end repeat

		-- launch abevjava
		do script "wine cmd /c 'Z:\\Users\\%USER%\\Documents\\abevjava-wine\\abevjava\\jre\\bin\\java -jar Z:\\Users\\%USER%\\Documents\\abevjava-wine\\abevjava\\abevjava.jar'" in myTab

		--		repeat until busy of myTab is false
		--			delay 1
		--		end repeat

		--		repeat with i from 1 to the count of myWindow's tabs
		--			if item i of myWindow's tabs is myTab then close myWindow
		--		end repeat

		--		if wasTerminalRunning then
		--		else
		--			quit
		--		end if
	end tell
end run

