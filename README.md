# MIDI Music Generator

An AI music generator that creates MIDI compositions from text prompts using LLMS.

## Motivation

Instead of text-to-music models, I wanted to experiment with LLMS generating music, and the MIDI format is perfect for this.

## Features

- 🎵 Generate MIDI music from natural language descriptions
- 🔄 Loop mode for seamless repeating tracks
- 🎹 Supports all General MIDI instruments (0-127)
- 🎼 Multi-track compositions
- 🔊 MIDI to WAV conversion with FluidSynth
- 🤖 Works with multiple LLM providers (Gemini, OpenAI, Anthropic)

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

Open your browser to `http://localhost:5001`

### Local Development

```bash
docker build -t midi-music-generator .
docker run -p 5001:5001 midi-music-generator
```

### Unraid

Install via the **Community Applications** plugin:

1. Open the **Apps** tab in Unraid
2. Search for **MidiMusicGenerator**
3. Click **Install** and set your desired port (default: `5001`)
4. Open the web UI at `http://<unraid-ip>:5001`

## Usage

1. Enter your API key in the settings
2. Describe the music you want (e.g., "upbeat jazz with piano and drums")
3. Click "Generate" to create your MIDI file
4. Download and play the generated music

## License

MIT
