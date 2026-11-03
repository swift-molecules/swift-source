# swift-source

Use this package when you work across several source files at once (a compiler front end, linter or diagnostic renderer) and need positions that name their file and resolve to human-readable line and column. Start from `Source.Manager`: register each file's bytes, carry cheap `Source.Position` and `Source.Range` values through your pipeline, and resolve them to `Source.Location` only when you report. If you have a single buffer and no file identity, use `Text.Position` and `Text.Line.Map` from swift-text directly.

## Laws

- `Source.Manager` hands out `Source.File.ID`s in registration order, so earlier files compare lower. Registering the same `fileID` twice yields two distinct files; nothing is deduplicated.
- A `Source.File.ID` only means something to the `Source.Manager` that issued it.
- Offsets in `Source.Position` and `Source.Range` are byte offsets into the registered content. Resolved lines and columns are 1-based: offset zero is line 1, column 1.
- A file's `Text.Line.Map` is built on the first `lineMap(for:)` or `location(for:)` call for that file, then cached for the manager's lifetime. Registered content is never changed or re-read.
- `Source.Range` is half-open: it contains `start` and excludes `end`. Its `end` must not precede its `start`, and `count` traps if it does.
- `Source.Location` orders by `fileID` (string order, not registration order), then line, then column. `filePath` takes no part in ordering, but it does take part in equality.
