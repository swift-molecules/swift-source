extension Source {

    public struct Range: Sendable, Equatable, Hashable {

        public let file: Source.File.ID

        public let start: Text.Position

        public let end: Text.Position

        @inlinable
        public init(file: Source.File.ID, start: Text.Position, end: Text.Position) {
            self.file = file
            self.start = start
            self.end = end
        }

        @inlinable
        public init(file: Source.File.ID, start: Text.Position, count: Text.Count) {
            self.file = file
            self.start = start

            self.end = try! start + Text.Offset(count)
        }
    }
}

extension Source.Range {

    @inlinable
    public var count: Text.Count {

        try! start.distance.forward(to: end)
    }

    @inlinable
    public var isEmpty: Bool {
        start == end
    }

    @inlinable
    public func contains(_ position: Text.Position) -> Bool {
        start <= position && position < end
    }

    @inlinable
    public var textRange: Text.Range {
        Text.Range(start: start, end: end)
    }

    @inlinable
    public var startPosition: Source.Position {
        Source.Position(file: file, offset: start)
    }

    @inlinable
    public var endPosition: Source.Position {
        Source.Position(file: file, offset: end)
    }
}

extension Source.Range: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(file):\(start)..<\(end)"
    }
}
