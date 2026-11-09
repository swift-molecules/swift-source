import Foundation
import Source
import Source_Standard_Library_Integration
import Testing
import Text

enum `Source.Location Codable Tests` {}

extension `Source.Location Codable Tests` {
    @Suite
    struct Test {
        @Test
        func `round trip preserves every field`() throws {
            let location = Source.Location(
                fileID: "M/F.swift",
                filePath: "/path/F.swift",
                line: 5,
                column: 10
            )
            let data = try JSONEncoder().encode(location)
            #expect(try JSONDecoder().decode(Source.Location.self, from: data) == location)
        }

        @Test
        func `round trip without filePath omits the key`() throws {
            let location = Source.Location(fileID: "M/F.swift", line: 5, column: 10)
            let data = try JSONEncoder().encode(location)
            let object = try #require(try JSONSerialization.jsonObject(with: data) as? [Swift::String: Any])
            #expect(object["filePath"] == nil)
            let decoded = try JSONDecoder().decode(Source.Location.self, from: data)
            #expect(decoded == location)
            #expect(decoded.filePath == nil)
        }

        @Test(arguments: [
            #"{"fileID":"M/F.swift","line":0,"column":1}"#,
            #"{"fileID":"M/F.swift","line":1,"column":0}"#,
        ])
        func `decoding rejects a zero line or column`(json: Swift::String) {
            #expect(throws: DecodingError.self) {
                try JSONDecoder().decode(Source.Location.self, from: Data(json.utf8))
            }
        }
    }
}
