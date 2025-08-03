# ML-DOCKER-STREAMLIT-DEPENDENCY ISSUES SOVLED




# Step by Step Manual Application Running Procedure
## Step-01 (Create virtual environment)

```bash
python3 -m venv .env
```
## Step-02 (Activate virtual environment)

```bash
source ./.env/bin/activate
```

## Step-03 (Install Requirements)

```bash
pip3 install -r requirements.txt
```

## Step-04 (Run laptop-price-predictor.ipynb)

First select `kernel`, from python environment select the `.env` (which you have created on Step-01). Then click on the `Run All`.

## Step-05 (Give executable permission to setup.sh file)

```bash
chmod +x ./setup.sh
```
## Step-06 (Run application by following command)

```bash
./setup.sh && streamlit run app.py
```

## Step-07 (Check on the browser)
Goto http://localhost:8501 you will find the application running.

# Docker setup

## Step-01 (Writting Dockerfile)

```bash
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
```

Why I'm writing the all contents of setup.sh manually in Dockerfile. because it's simpler and doesn't require managing a separate shell script. The configuration is built directly into the Docker image.

Why the exposed port is 8501, because we have set streamlit server port to 8501.

## Step-02 (Build the Image)

```bash
docker build -t laptop-price-predict .
```

## Step-03 (Run the Container out of the build Image)

```bash
docker run -it -d -p 8080:8501 laptop-price-predict:latest
```

## Step-04 (Check on the browser)
Goto http://localhost:8080 you will find the application running.