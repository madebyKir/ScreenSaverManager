#!/bin/sh
#
mntroot rw
cp -f /mnt/us/extensions/ScreenSaverManager/backup_screensavers/*.png /usr/share/blanket/screensaver/
mntroot ro
lipc-set-prop com.lab126.powerd refreshScreenSaver 1
echo "Оригинальные скринсейверы восстановлены!"
eips 30 30 "Бэкап применён"
