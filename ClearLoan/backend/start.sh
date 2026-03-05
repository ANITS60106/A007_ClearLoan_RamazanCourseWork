#!/usr/bin/env sh
set -e

echo "Starting ClearLoan backend..."

# Apply migrations
python manage.py migrate --noinput

# Collect static (safe even if no static assets)
python manage.py collectstatic --noinput || true

# Optional demo seed (creates banks + 25 demo users)
if [ "${SEED_DEMO:-0}" = "1" ]; then
  echo "Seeding demo data..."
  python manage.py seed_demo --users 25 || true
fi

# Run gunicorn on the platform-provided PORT (fallback 8000)
exec gunicorn clearloan_backend.wsgi:application --bind 0.0.0.0:${PORT:-8000} --workers ${GUNICORN_WORKERS:-2} --timeout ${GUNICORN_TIMEOUT:-60}
