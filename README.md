# MIDI Music Generator

An AI music generator that creates MIDI compositions from text prompts using LLMs.

## Motivation

Instead of text-to-music models, I wanted to experiment with LLMs generating music, and the MIDI format is perfect for this.

## Features

- 🎵 Generate MIDI music from natural language descriptions
- 🔄 Loop mode for seamless repeating tracks
- 🎹 Supports all General MIDI instruments (0-127)
- 🎼 Multi-track compositions with up to 4 variations in parallel
- 🔊 MIDI to WAV conversion via FluidSynth
- 🤖 Works with multiple LLM providers (Gemini, OpenAI, Anthropic, and any OpenAI-compatible API)

## Setup

### Docker (recommended)
- 🎼 Multi-track compositions
- 🔊 MIDI to WAV conversion with FluidSynth
- 🤖 Works with multiple LLM providers (Gemini, OpenAI, Anthropic, Ollama)

## Setup

### Docker Hub

```bash
docker run -d -p 5001:5001 --restart unless-stopped julesdg6/midi-music-generator
```

Open your browser to `http://localhost:5001`

### Docker Compose

```bash
docker compose up -d
```

### Local Development

Requires Python 3.12+ and [uv](https://docs.astral.sh/uv/).

```bash
uv sync
uv run flask run --port=5001
```

Open your browser to `http://localhost:5001`

> **Note:** MIDI-to-WAV conversion requires [FluidSynth](https://www.fluidsynth.org/) and the `GeneralUserGS.sf3` soundfont to be present in the working directory. The Docker image handles both automatically.

## Configuration

On first launch, click the **Settings** (⚙) button to configure your LLM provider:

| Setting | Description |
| --- | --- |
| **Provider** | `gemini`, `openai`, `anthropic`, or a custom OpenAI-compatible provider |
| **Model Name** | The model identifier for your chosen provider (e.g. `gemini-2.0-flash`, `gpt-4o`, `claude-opus-4-5`) |
| **API Key** | Your provider API key — stored in browser `localStorage` only. It is forwarded from your browser to this backend on each request and then on to the LLM provider; it is never persisted server-side |
| **Base URL** | (Optional) Override the API endpoint, useful for local models or proxies |

Settings are saved in your browser's `localStorage` and are never persisted on the server.
### Local Development

```bash
docker build -t midi-music-generator .
docker run -p 5001:5001 midi-music-generator
```

### Unraid

#### Option A — Install template via CLI (recommended)

SSH into your Unraid server and run:

```bash
wget -O /boot/config/plugins/dockerMan/templates-user/midi-music-generator.xml \
  https://raw.githubusercontent.com/julesdg6/midi-music-generator/main/unraid/midi-music-generator.xml
```

Then, in the Unraid web UI:

1. Go to the **Docker** tab
2. Click **Add Container**
3. Select **MidiMusicGenerator** from the template dropdown
4. Set your desired port (default: `5001`) and click **Apply**
5. Open the web UI at `http://<unraid-ip>:5001`

#### Option B — Add container manually

1. In the Unraid web UI, go to the **Docker** tab
2. Click **Add Container**
3. Fill in the following fields:

   | Field | Value |
   |---|---|
   | **Name** | `MidiMusicGenerator` |
   | **Repository** | `julesdg6/midi-music-generator` |
   | **Network type** | `bridge` |
   | **Port mapping** (Host → Container) | `5001` → `5001` |
   | **Auto-start** | Enabled |

4. Click **Apply** to pull the image and start the container
5. Open the web UI at `http://<unraid-ip>:5001`

## Usage

1. Open the app and configure your API key in **Settings**
2. Describe the music you want (e.g., "upbeat jazz with piano and drums")
3. Optionally enable **Loop mode** and choose how many **Variations** to generate
4. Click **Generate** to create your MIDI file(s)
5. Play back via the built-in piano-roll visualiser or download as MIDI/WAV

## License

MIT
