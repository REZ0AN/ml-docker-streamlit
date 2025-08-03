FROM python:3.9

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY df.pkl .
COPY pipe.pkl .

# Create streamlit config directory and file
RUN mkdir -p ~/.streamlit && \
    echo "[server]\nport = 8501\nenableCORS = false\nheadless = true\n" > ~/.streamlit/config.toml

EXPOSE 8501

# Run streamlit directly
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]