extension Source {

    public struct File: Sendable, Equatable {

        public let id: Self.ID

        public let fileID: Swift::String

        // swift-linter:disable:next raw concept
        // REASON: The compiler's #filePath text, carried verbatim for diagnostics and SwiftSyntax. It may name no file, as a control's or macro's does, so Path, which refuses empty text, isn't its owner.
        public let filePath: Swift::String

        @inlinable
        package init(id: Self.ID, fileID: Swift::String, filePath: Swift::String) {
            self.id = id
            self.fileID = fileID
            self.filePath = filePath
        }
    }
}
