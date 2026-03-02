FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends curl fluidsynth && rm -rf /var/lib/apt/lists/*

RUN curl 'https://raw.githubusercontent.com/spessasus/SpessaSynth/master/soundfonts/GeneralUserGS.sf3' -o GeneralUserGS.sf3

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"
COPY pyproject.toml uv.lock .python-version ./
RUN uv python install
RUN uv sync

COPY . /app

EXPOSE 5001
CMD ["uv", "run", "flask", "run", "--host=0.0.0.0", "--port=5001"]
