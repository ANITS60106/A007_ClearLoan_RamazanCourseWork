# ClearLoan Backend (Django, prototype)

## Setup
```bash
cd backend
python -m venv .venv
# Windows:
.venv\Scripts\activate
# macOS/Linux:
source .venv/bin/activate

pip install -r requirements.txt
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver 8000
```

## Seed demo offers
```bash
# In another terminal (or via Postman):
curl -X POST http://127.0.0.1:8000/api/seed/
```

## API (minimal)
- `POST /api/auth/register/`  -> `{ token, user }`
- `POST /api/auth/login/`     -> `{ token, user }`
- `GET  /api/offers/`         -> public list of offers
- `GET/POST /api/loans/`      -> user's active loans (token required)
- `GET/POST /api/requests/`   -> user's loan requests (token required)


## Deploy to Koyeb (Free Tier) — Recommended

This repo is prepared for Koyeb deployment using the included **Dockerfile**.

### A) Put the project on GitHub
1. Create a GitHub repository
2. Push the `ClearLoan/backend` folder (or the whole monorepo)

### B) Create a Postgres database on Koyeb (recommended)
In Koyeb dashboard:
- Create a **Postgres** database
- Copy the connection string and set it as `DATABASE_URL`

> Postgres is recommended for stability. SQLite may reset on redeploy.

### C) Create a Web Service (Docker)
In Koyeb dashboard:
1. Create App → **Service**
2. Source: GitHub repository
3. Build: Docker
4. Root directory: `ClearLoan/backend` (if your repo contains both frontend + backend)
5. Environment variables (minimum):
   - `DJANGO_SECRET_KEY` = (random long string)
   - `DJANGO_DEBUG` = `0`
   - `DJANGO_ALLOWED_HOSTS` = `*.koyeb.app,your-app-name.koyeb.app`
   - `DJANGO_CSRF_TRUSTED_ORIGINS` = `https://your-app-name.koyeb.app`
   - `DATABASE_URL` = (your Postgres URL)
   - `CORS_ALLOW_ALL_ORIGINS` = `1` (for prototype Flutter Web)
   - `SEED_DEMO` = `1` (optional, seeds demo users + banks on deploy)

Koyeb automatically provides the `PORT` environment variable. The container start script uses it.

### D) Verify the deployed API
Open in browser:
- `https://your-app-name.koyeb.app/api/loans/products/`
- `https://your-app-name.koyeb.app/api/loans/banks/`

If you see JSON responses, the backend is working.

