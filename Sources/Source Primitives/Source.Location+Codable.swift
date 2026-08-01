// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-source-primitives open source project
//
// Copyright (c) 2025 Coen ten Thije Boonkkamp and the swift-source-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// MARK: - Codable

#if !hasFeature(Embedded)
    // The `Codable` conformance below realizes the stdlib `Decodable`/`Encodable`
    // requirements, whose signatures mandate existential decoder/encoder parameters
    // and untyped `throws`. Neither can be narrowed at the conformance site, so the
    // two rules are disabled for this block only.
    // swiftlint:disable no_any_protocol_existential typed_throws_required
    extension Source.Location: Codable {
        @usableFromInline
        internal enum CodingKeys: Swift.String, CodingKey {
            case fileID
            case filePath
            case line
            case column
        }

        /// Decodes a location from its keyed `fileID`, `filePath`, `line`, and `column` representation.
        @inlinable
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.fileID = try container.decode(Swift.String.self, forKey: .fileID)
            self.filePath = try container.decodeIfPresent(Swift.String.self, forKey: .filePath)
            let line = try container.decode(UInt.self, forKey: .line)
            let column = try container.decode(UInt.self, forKey: .column)
            self.position = Text.Location(
                line: Text.Line.Number(line),
                column: Text.Line.Column(_unchecked: Cardinal(column))
            )
        }

        /// Encodes the location as keyed `fileID`, `filePath`, `line`, and `column` values.
        @inlinable
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(fileID, forKey: .fileID)
            try container.encodeIfPresent(filePath, forKey: .filePath)
            try container.encode(position.line.underlying, forKey: .line)
            // swift-linter:disable:next raw value access
            // REASON: same-boundary use — this IS Source.Location's own Codable
            // wire-format boundary, encoding the typed Cardinal to its raw form
            // for the JSON-adjacent keyed container.
            try container.encode(position.column.underlying.rawValue, forKey: .column)
        }
    }
// swiftlint:enable no_any_protocol_existential typed_throws_required
#endif
