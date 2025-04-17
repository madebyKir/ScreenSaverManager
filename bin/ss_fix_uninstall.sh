#!/bin/sh

# Пути
CONF_TARGET="/etc/upstart/ss_fix.conf"
LOG_DIR="/mnt/us/extensions/ScreenSaverManager/logs"
LOG_FILE="$LOG_DIR/restore.log"

# Создаем директорию для логов
mkdir -p "$LOG_DIR"

{
    echo "=== Восстановление рекламы $(date) ==="
    echo "Проверяем наличие файла..."

    # Проверка root-прав через mntroot
    if ! /usr/sbin/mntroot rw >/dev/null 2>&1; then
        echo "❌ Ошибка: Не удалось получить root-права!"
        exit 1
    fi

    # Проверка существования файла
    if [ ! -f "$CONF_TARGET" ]; then
        echo "ℹ️ Файл $CONF_TARGET не найден (уже удалён?)"
        /usr/sbin/mntroot ro >/dev/null 2>&1
        exit 0
    fi

    # Удаление файла
    if rm -f "$CONF_TARGET"; then
        echo "✅ Успешно удалено: $CONF_TARGET"
        
        # Перезагрузка конфигурации upstart
        if initctl reload-configuration; then
            echo "♻️ Конфигурация upstart обновлена"
        else
            echo "⚠️ Не удалось обновить upstart (но файл удалён)"
        fi
    else
        echo "❌ Критическая ошибка удаления!"
        exit 2
    fi

    # Возвращаем защиту FS
    /usr/sbin/mntroot ro >/dev/null 2>&1
    echo "🔒 Файловая система защищена (ro)"
    echo "Готово! Реклама восстановится после перезагрузки."

} 2>&1 | tee -a "$LOG_FILE" | showtxt

# Гарантированный сброс прав
/usr/sbin/mntroot ro >/dev/null 2>&1
exit 0