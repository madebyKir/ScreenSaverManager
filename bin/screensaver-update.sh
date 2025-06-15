#!/bin/sh
# 
SCREENS_DIR="/mnt/us/extensions/ScreenSaverManager/screens"
SYSTEM_SCREENSAVER_DIR="/usr/share/blanket/screensaver"

echo "=== Замена скринсейверов ==="
mntroot rw

#
echo "Очищаем старые заставки..."
find "$SYSTEM_SCREENSAVER_DIR" -name "bg_ss*.png" -type f -delete

#
echo "Копируем новые из $SCREENS_DIR..."
cp -f "$SCREENS_DIR"/bg_ss*.png "$SYSTEM_SCREENSAVER_DIR"/

#
echo "Устанавливаем права..."
chmod 644 "$SYSTEM_SCREENSAVER_DIR"/*.png
mntroot ro

#
echo "Обновляем систему..."
lipc-set-prop com.lab126.powerd refreshScreenSaver 1

#
COUNT=$(ls "$SYSTEM_SCREENSAVER_DIR"/bg_ss*.png 2>/dev/null | wc -l)
echo "Готово! Обновлено $COUNT файлов."
eips 30 30 "Скринсейверы заменены ($COUNT)"
eips 30 50 "Перезагрузите Kindle"
