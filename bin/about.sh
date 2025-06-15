#!/bin/sh

FBINK="/mnt/us/extensions/ScreenSaverManager/bin/FBink"

# Сообщение
#TEXT1=""
#TEXT2=""
#TEXT3=""
#TEXT4=""
#TEXT5=""
#TEXT6=""

# Очистка экрана
$FBINK -c

# Положение по горизонтали (приблизительно по центру)
X=5

# Верх рамки
$FBINK -x $X -y 20 "╔═════════════════════════════╗"
# Текст в рамке
$FBINK -x $X -y 21 "║     ScreenSaverManager      ║"
$FBINK -x $X -y 22 "║           Author:           ║"
$FBINK -x $X -y 23 "║         @Shalom_Kir         ║"
$FBINK -x $X -y 24 "║        @made_by_Kir         ║"
$FBINK -x $X -y 25 "║        Version: 2.1         ║"
$FBINK -x $X -y 26 "║   Release date 16.06.2025   ║"
# Низ рамки
$FBINK -x $X -y 27 "╚═════════════════════════════╝"

# Сообщение ниже рамки
$FBINK -x $X -y 30 "╔═════════════════════════════╗"
$FBINK -x $X -y 31 "║<--------Click here          ║"
$FBINK -x $X -y 32 "║ or under the Author button  ║"
$FBINK -x $X -y 33 "╚═════════════════════════════╝"

# Ожидание (эмуляция, без кнопки Power)
while true; do
    sleep 1
done
