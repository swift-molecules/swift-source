public import Byte

extension Source {

    public struct Manager: ~Copyable, Sendable {
        @usableFromInline
        internal var files: [Source.File]

        @usableFromInline
        internal var contents: [[Byte]]

        @usableFromInline
        internal var maps: [Text.Line.Map?]

        @inlinable
        public init() {
            self.files = []
            self.contents = []
            self.maps = []
        }
    }
}

extension Source.Manager {

    @inlinable
    @discardableResult
    public mutating func register(
        fileID: Swift.String,
        filePath: Swift.String,
        content: [Byte]
    ) -> Source.File.ID {
        let id = Source.File.ID(files.count)
        let file = Source.File(id: id, fileID: fileID, filePath: filePath)
        files.append(file)
        contents.append(content)
        maps.append(nil)
        return id
    }
}

extension Source.Manager {

    @inlinable
    public borrowing func fileCount() -> Int {
        files.count
    }

    @inlinable
    public borrowing func file(for id: Source.File.ID) -> Source.File {
        files[id.underlying]
    }

    @inlinable
    public borrowing func content(for id: Source.File.ID) -> [Byte] {
        contents[id.underlying]
    }
}

extension Source.Manager {

    @inlinable
    public mutating func lineMap(for id: Source.File.ID) -> Text.Line.Map {
        if let existing = maps[id.underlying] {
            return existing
        }
        let map = Text.Line.Map(scanning: contents[id.underlying])
        maps[id.underlying] = map
        return map
    }

    @inlinable
    public mutating func location(
        for position: Source.Position
    ) -> Source.Location {
        let file = file(for: position.file)
        let map = lineMap(for: position.file)
        let textLocation = map.location(for: position.offset)
        return Source.Location(
            fileID: file.fileID,
            filePath: file.filePath,
            position: textLocation
        )
    }
}
