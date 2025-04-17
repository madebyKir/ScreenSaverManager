#!/bin/sh

# Пути (проверьте, что они верные!)
CONF_SOURCE="/mnt/us/extensions/ScreenSaverManager/bin/ss_fix.conf"
CONF_TARGET="/etc/upstart/ss_fix.conf"
LOG_FILE="/mnt/us/extensions/ScreenSaverManager/logs/install.log"

# Создаём лог-директорию
mkdir -p "$(dirname "$LOG_FILE")"

# Проверка существования исходного файла
if [ ! -f "$CONF_SOURCE" ]; then
  echo "❌ Ошибка: $CONF_SOURCE не найден!" | tee -a "$LOG_FILE"
  exit 1
fi

# Включаем запись в rootfs
/usr/sbin/mntroot rw >/dev/null 2>&1

# Копирование с проверкой
if cp "$CONF_SOURCE" "$CONF_TARGET"; then
  chmod 644 "$CONF_TARGET"
  echo "✅ Успешно скопировано в $CONF_TARGET" | tee -a "$LOG_FILE"
else
  echo "❌ Ошибка копирования (код $?)" | tee -a "$LOG_FILE"
  /usr/sbin/mntroot ro >/dev/null 2>&1
  exit 2
fi

# Возвращаем защиту rootfs
/usr/sbin/mntroot ro >/dev/null 2>&1
echo "Готово! Перезагрузите устройство." | tee -a "$LOG_FILE"