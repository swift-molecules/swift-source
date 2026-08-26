extension Source.File {

    public struct ID: Sendable, Equatable, Hashable, Comparable {
        @usableFromInline
        internal let underlying: Int

        @inlinable
        package init(_ underlying: Int) {
            self.underlying = underlying
        }
    }
}

extension Source.File.ID {

    @inlinable
    public static func < (lhs: Source.File.ID, rhs: Source.File.ID) -> Bool {
        lhs.underlying < rhs.underlying
    }
}

extension Source.File.ID: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "file(\(underlying))"
    }
}
