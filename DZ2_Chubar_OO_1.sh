#!/bin/bash

# Визначаємо масив з URL вебсайтів
websites=(
    "https://google.com"
    "https://facebook.com"
    "https://twitter.com"
    "https://www.ukr.net"
    "https://www.pravda.com.ua"
)

# Назва файлу логів
log_file="website_status.log"

# Очищаємо файл логів перед записом нових даних
> $log_file

# Проходимо по кожному сайту у списку
for site in "${websites[@]}"; do
    # Виконуємо запит curl з опціями для відключення виводу та перевірки тільки заголовка (-s -o /dev/null -I -w "%{http_code}")
    # Додаємо опцію -L для слідування за перенаправленнями
    status_code=$(curl -s -o /dev/null -I -w "%{http_code}" -L "$site")
    
    # Виведення діагностичної інформації
    echo "Перевірка сайту: $site"
    echo "Отриманий статус-код: $status_code"

    # Перевіряємо статус-код відповіді
    if [ "$status_code" -eq 200 ]; then
        echo "<$site> is UP" | tee -a $log_file
    else
        echo "<$site> is DOWN" | tee -a $log_file
    fi
done

# Вивід інформації про те, що результати записані у файл логів
echo "Результати записані у файл логів: $log_file"
