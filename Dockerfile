# Використовуємо офіційний образ Python
FROM python:3.10-slim

# Встановлюємо залежності
WORKDIR /app

# Встановлюємо необхідні системні бібліотеки
RUN apt-get update && apt-get install -y libpq-dev gcc

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копіюємо файли проекту
COPY . .

# Встановлюємо команду для запуску FastAPI застосунку
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
