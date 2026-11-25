FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

RUN useradd --system --uid 10001 --no-create-home appuser \
    && mkdir -p /data \
    && chown -R appuser:appuser /app /data

USER 10001:10001

EXPOSE 8001

CMD ["uvicorn", "app.main:app", "--host", "127.0.0.1", "--port", "8001"]
