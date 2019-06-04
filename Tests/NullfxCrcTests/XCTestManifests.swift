import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Crc8Tests.allTests),
        testCase(Crc16Tests.allTests),
        testCase(Crc32Tests.allTests),
    ]
}
#endif