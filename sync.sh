#!/bin/bash
# Быстрая синхронизация Obsidian → GitHub
# Использование: ./sync.sh "описание изменений"
#            или ./sync.sh  (без аргументов — авто-сообщение)

MSG="${1:-"update notes $(date '+%Y-%m-%d %H:%M')"}"

echo "📝 Добавляю все изменения..."
git add .

# Проверяем есть ли что коммитить
if git diff --cached --quiet; then
  echo "✅ Нет изменений для сохранения"
  exit 0
fi

echo "💾 Коммит: $MSG"
git commit -m "$MSG"

echo "🚀 Отправляю на GitHub..."
git push origin main

echo "✅ Готово! Заметки синхронизированы."
