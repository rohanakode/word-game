FROM python:3.11-slim

# (optional) tiny tools for building wheels
RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# your notebook
COPY word_guess.ipynb /app/word_guess.ipynb

# Railway injects PORT; Voilá must bind to it on 0.0.0.0
ENV PORT=10000
CMD voila /app/word_guess.ipynb \
  --port=$PORT \
  --no-browser \
  --Voila.ip=0.0.0.0 \
  --strip_sources=True
