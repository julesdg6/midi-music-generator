# Copilot Instructions

## Project Overview

This is an AI-powered MIDI music generator. Users describe music in natural language and the app calls an LLM to produce a JSON representation of MIDI tracks, which are then assembled into a `.mid` file and optionally converted to WAV using FluidSynth.

## Tech Stack

- **Language:** Python 3.12+
- **Package manager:** [uv](https://docs.astral.sh/uv/) — use `uv sync` to install dependencies and `uv run` to execute commands
- **Web framework:** Flask
- **LLM client:** [LiteLLM](https://github.com/BerriAI/litellm) — abstracts over Gemini, OpenAI, Anthropic, and any OpenAI-compatible provider
- **MIDI generation:** [MIDIUtil](https://github.com/MarkCWirt/MIDIUtil)
- **Audio rendering:** FluidSynth with the `GeneralUserGS.sf3` soundfont (only available inside the Docker image)
- **Containerisation:** Docker / Docker Compose

## Repository Layout

```
app.py            # Flask application — all routes live here
templates/        # Jinja2 HTML templates
samples/          # Static sample audio files served at /static/samples/
pyproject.toml    # Project metadata and dependencies (PEP 517)
uv.lock           # Locked dependency tree
Dockerfile        # Production image (includes FluidSynth + soundfont)
docker-compose.yml
```

## Running Locally

```bash
uv sync
uv run flask run --port=5001
```

The app is then available at `http://localhost:5001`.

MIDI-to-WAV conversion requires FluidSynth and `GeneralUserGS.sf3` in the working directory; the Docker image provides both automatically.

## Key Routes

| Route | Method | Purpose |
|---|---|---|
| `/` | GET | Serve the main UI |
| `/generate_midi` | POST | Accept a JSON prompt, call the LLM, return a `.mid` file |
| `/convert_midi_to_wav` | POST | Accept a MIDI file upload, render to WAV via FluidSynth |
| `/static/samples/<filename>` | GET | Serve sample WAV files |

## LLM Integration

- LiteLLM is used so that the same code path works with any supported provider.
- The provider, model name, API key, and optional base URL are sent by the browser on every request — **nothing is persisted server-side**.
- Model names are prefixed with the provider slug before being passed to LiteLLM (e.g. `gemini/gemini-2.0-flash`).
- Ollama is the exception: it runs locally and requires no API key; the default base URL is `http://localhost:11434`.

## Code Style

- Follow [PEP 8](https://peps.python.org/pep-0008/).
- All Python files are formatted with [Ruff](https://docs.astral.sh/ruff/) — run `uv run ruff format .` before committing.
- Keep Flask route handlers thin; extract helper logic into named functions.
- Sanitise all LLM-produced values before use (e.g. clamp `pitch` and `program` to `0–127`).
- Do not log or persist the user's API key.

## Adding Dependencies

```bash
uv add <package>
```

This updates both `pyproject.toml` and `uv.lock`. Commit both files.
