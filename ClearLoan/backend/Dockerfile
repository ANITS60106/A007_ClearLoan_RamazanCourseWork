FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

# Koyeb (and most platforms) provide PORT env var
EXPOSE 8000

# Run migrations/collectstatic, then start gunicorn
CMD ["sh", "/app/start.sh"]
