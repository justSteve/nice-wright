# ClipMate — Objectives & Forward Intent

Compiled from prior conversation history. Reflects the state of thinking as of early April 2026.

---

## What ClipMate Was

ClipMate is a discontinued Windows clipboard manager. Steve used it continuously from 2005 to 2026, accumulating 5.8 GB of clipboard history across 1,125 clips in 19 content formats (TEXT, PNG, HTML, RTF, PICTURE, HDROP, FileName, and others). It has no API, no active development, and no vendor support.

---

## What Was Built (Completed)

### ParseClipmate — Data Migration (COMPLETE)

The historical data was fully extracted. The XML export method was chosen over binary parsing because it yielded 4.4x more clips (1,125 vs 258) with 100% accurate timestamps from DBISAM metadata.

**Artifacts:**
- `clipmate_xml_parser.py` — XML parser (primary)
- `process_xml_export.py` — database populator
- `clipmate_from_xml.db` — SQLite, 1,125 clips, fully queryable
- `server.py` — FastAPI web server
- React frontend at `http://localhost:8000` for clipboard browsing

**Workflow:**
1. Export from ClipMate: File → Export → XML → "Everything"
2. Run `python process_xml_export.py` to populate SQLite
3. Run `python server.py` to browse

The data is preserved. Historical access is solved.

---

## What Was In Progress

### myCapper — GUI Automation Library (Phase 1, In Development)

Since ClipMate has no API, myCapper was built to automate it via GUI: capture screen regions, run OCR, verify state, and drive actions. It was designed as reusable infrastructure — not ClipMate-specific.

**Architecture:**
```
Consumer Script (clipmate_auto.py)
    ├── myCapper (capture, OCR, verify)   ← this repo
    └── pyautogui (click, type)
```

**What exists:**
- `mycapper/capture/` — region, window, monitor, temporal modes
- `mycapper/process/` — filter pipeline (grayscale, threshold, scale, denoise, etc.)
- `mycapper/ocr/` — Tesseract wrapper with PSM configuration
- `mycapper/assertions/` — text, numeric, composite assertions
- Installed as editable Python package on Windows
- Phase 1 checklist partially complete; CLI tools and recipe system not yet built

**ParseClipmate's use of myCapper:**
- `clipmate_auto.py` — main automation driver
- `capture_regions.py` — coordinate discovery tool
- `config.py` — window-relative coordinates, timing, OCR settings
- `test_ocr.py` — OCR testing utility

---

## The Forward Intent

The key statement from the gtOps-era enterprise summary (April 2026):

> *"The specific clipboard tool is a dead product; the intent to treat clipboard as a first-class data source persists. Tools held loosely: ClipMate XML parser (done), myCapper GUI automation (in progress)."*

**What this means:**

1. **ClipMate is not the goal.** It was a vehicle. The goal is clipboard-as-enterprise-input-channel — content Steve copies throughout his day, processed and made available to the enterprise.

2. **myCapper was built to extend ClipMate's life** via GUI automation, not to be bound to it permanently. If ClipMate is replaced by a tool with an actual API, myCapper's GUI automation layer becomes unnecessary for that function (though the library remains useful for other automation).

3. **The data migration is the permanent artifact.** 19 years of clipboard history is in SQLite and is not dependent on ClipMate continuing to run.

4. **"Tools held loosely"** — the phrasing is deliberate. No hard dependency on ClipMate continuing to exist. If a better tool appears, the architecture accommodates switching.

---

## Open Questions (as of this writing)

- Is ClipMate still running and being used daily?
- Has a replacement clipboard manager been evaluated? (Ditto, CopyQ, 1Clipboard, etc.)
- If a replacement is chosen, does it offer an API or export format that removes the need for GUI automation?
- Should myCapper Phase 1 be completed for ClipMate, or should that effort be redirected toward integrating a replacement?
- What is the forward capture strategy — is the intent to continue building clipboard history in the enterprise, or was the migration a one-time archival?

---

## Related Files

| Location | Purpose |
|----------|---------|
| `PLAN.md` | Full myCapper architecture and 5-phase roadmap |
| `CLAUDE.md` | Development guide and design decisions |
| `../../../ParseClipmate/` | The zgent that uses myCapper for ClipMate automation |
| `../../../ParseClipmate/CLAUDE.md` | ParseClipmate's two-function overview and status |
