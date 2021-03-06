#!/bin/bash
flutter clean
flutter build web --tree-shake-icons --csp --source-maps
sed -i -e 's/\<base href=\"\/\"\>/\<base href=\"\/faidashu\/\"\>/g' build/web/index.html

read  -n 1 -p "Press Enter to continue with FTP upload:" waitftpinput

sftp -P 22 "$SFTP_HOST" <<END
lcd build/web
put -r . /faiadashu
lcd ../../..
put -r ./lib /
lcd example
put -r ./lib /
bye
END

