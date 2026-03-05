FROM python:3.11-slim

WORKDIR /app

# 1) копируем requirements из правильного пути (от корня репо)
COPY ClearLoan/backend/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# 2) копируем весь backend (правильный путь от корня репо)
COPY ClearLoan/backend/ /app/

# 3) запуск
RUN chmod +x /app/start.sh

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

CMD ["/app/start.sh"]