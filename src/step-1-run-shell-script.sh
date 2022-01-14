[ -d /Users/$USER/Documents/abevjava-wine/abevjava ] && /opt/homebrew/bin/wine --version >/dev/null 2>/dev/null && SHORTCUT=shortcut

if [ ! "$SHORTCUT" = "shortcut" ]
then
	echo 2
    exit
fi

(/opt/homebrew/bin/wine REG QUERY HKCU\\Software\\Wine\\Mac\ Driver /v ForceOpenGLBackingStore | grep -c Force || (/opt/homebrew/bin/wine REG ADD HKCU\\Software\\Wine\\Mac\ Driver /v ForceOpenGLBackingStore /t REG_SZ /d y) > /dev/null) > /dev/null

if [ ! -f ~/.wine/drive_c/users/crossover/.abevjava/$USER.enyk ]
then

/opt/homebrew/bin/wine cmd /c mkdir C:\\users\\crossover\\.abevjava
cat <<EOT > ~/.wine/drive_c/users/crossover/.abevjava/$USER.enyk
prop.usr.naplo=Z:\\Users\\$USER\\Documents\\abevjava-wine\\abevjava-data\\naplo
prop.usr.kontroll=kontroll
prop.usr.saves=mentesek
prop.usr.tmp_calc=calc
prop.usr.ds_sent=KR/elkuldott
prop.usr.root=Z:\\Users\\$USER\\Documents\\abevjava-wine\\abevjava-data
prop.usr.ds_dest=KR/kuldendo
prop.usr.tmp=tmp
prop.usr.frissitesek=Z:\\Users\\$USER\\Documents\\abevjava-wine\\abevjava-data\\frissitesek
prop.usr.archive=archivum
prop.usr.ds_src=KR/digitalis_alairas
prop.usr.import=import
prop.usr.settings=beallitasok
prop.usr.tmp_xml=xml
prop.usr.attachment=csatolmanyok
prop.usr.primaryaccounts=Z:\\Users\\$USER\\Documents\\abevjava-wine\\abevjava-data\\torzsadatok
EOT

fi

/opt/homebrew/bin/wine cmd /c 'Z:\Users\%USER%\Documents\abevjava-wine\abevjava\jre\bin\java -jar Z:\Users\%USER%\Documents\abevjava-wine\abevjava\abevjava.jar' > /dev/null 2>/dev/null

echo "shortcut"

