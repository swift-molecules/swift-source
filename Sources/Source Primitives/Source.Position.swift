extension Source {

    public struct Position: Sendable, Equatable, Hashable {

        public let file: Source.File.ID

        public let offset: Text.Position

        @inlinable
        public init(file: Source.File.ID, offset: Text.Position) {
            self.file = file
            self.offset = offset
        }
    }
}

extension Source.Position: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(file):\(offset)"
    }
}
