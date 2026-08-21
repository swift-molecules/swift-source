extension Source {

    public struct Location: Sendable, Hashable {

        public let fileID: Swift.String

        public let filePath: Swift.String?

        public let position: Text.Location

        @inlinable
        public init(
            fileID: Swift.String,
            filePath: Swift.String? = nil,
            position: Text.Location
        ) {
            self.fileID = fileID
            self.filePath = filePath
            self.position = position
        }

        @inlinable
        public init(
            fileID: Swift.String,
            filePath: Swift.String? = nil,
            line: Int,
            column: Int
        ) {
            self.fileID = fileID
            self.filePath = filePath
            self.position = Text.Location(
                line: Text.Line.Number(UInt(line)),
                column: Text.Line.Column(_unchecked: Cardinal(UInt(column)))
            )
        }

        @inlinable
        public init(
            fileID: Swift.String,
            filePath: Swift.String? = nil,
            line: Text.Line.Number,
            column: Int
        ) {
            self.fileID = fileID
            self.filePath = filePath
            self.position = Text.Location(
                line: line,
                column: Text.Line.Column(_unchecked: Cardinal(UInt(column)))
            )
        }

        @inlinable
        public init(
            fileID: Swift.String,
            filePath: Swift.String? = nil,
            line: Text.Line.Number,
            column: Text.Line.Column
        ) {
            self.fileID = fileID
            self.filePath = filePath
            self.position = Text.Location(line: line, column: column)
        }
    }
}

extension Source.Location {

    @inlinable
    public var line: Text.Line.Number {
        position.line
    }

    @inlinable
    public var column: Text.Line.Column {
        position.column
    }
}

extension Source.Location: Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.fileID != rhs.fileID { return lhs.fileID < rhs.fileID }
        return lhs.position < rhs.position
    }
}

extension Source.Location: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(fileID):\(position.line):\(position.column)"
    }
}
