extension Source {

    public struct File: Sendable, Equatable {

        public let id: Self.ID

        public let fileID: Swift.String

        public let filePath: Swift.String

        @inlinable
        package init(id: Self.ID, fileID: Swift.String, filePath: Swift.String) {
            self.id = id
            self.fileID = fileID
            self.filePath = filePath
        }
    }
}
