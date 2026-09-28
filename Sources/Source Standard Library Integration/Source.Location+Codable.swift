public import Source
public import Text

#if !hasFeature(Embedded)
    extension Source.Location: Codable {
        @usableFromInline
        internal enum CodingKeys: Swift.String, CodingKey {
            case fileID
            case filePath
            case line
            case column
        }

        @inlinable
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let fileID = try container.decode(Swift.String.self, forKey: .fileID)
            let filePath = try container.decodeIfPresent(Swift.String.self, forKey: .filePath)
            let line = try container.decode(UInt.self, forKey: .line)
            let column = try container.decode(UInt.self, forKey: .column)
            self.init(
                fileID: fileID,
                filePath: filePath,
                position: Text.Location(
                    line: Text.Line.Number(line),
                    column: Text.Line.Column(_unchecked: Cardinal(column))
                )
            )
        }

        @inlinable
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(fileID, forKey: .fileID)
            try container.encodeIfPresent(filePath, forKey: .filePath)
            try container.encode(position.line.underlying, forKey: .line)

            try container.encode(position.column.underlying.rawValue, forKey: .column)
        }
    }
#endif