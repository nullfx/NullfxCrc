import XCTest
@testable import NullfxCrc


class Crc8Tests: XCTestCase {
    static let TestBuffer : [UInt8] = [ 0x74, 0x65, 0x73, 0x74, 0x20, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72 ];
    static let ExtendedTestBuffer : [UInt8] = [ 0x00, 0x01, 0x02, 0x74, 0x65, 0x73, 0x74, 0x20, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72, 0x03, 0x04 ];
    static let Crc8Crc : UInt8 = 0xF9;
    
    func test_crc8Validation() {
        XCTAssertEqual( Crc8.computeChecksum( on: Crc8Tests.TestBuffer), Crc8Tests.Crc8Crc );
    }
    
    func test_crc8SegmentValidation() {
        XCTAssertEqual( Crc8.computeChecksum( on: Crc8Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc8Tests.Crc8Crc );
    }
    
    func test_crc8TestPerformance() {
        self.measure {
            _ = Crc8.computeChecksum( on: Crc8Tests.TestBuffer );
        }
    } 
    
    static var allTests = [
        ("test_crc8Validation", test_crc8Validation),
        ("test_crc8SegmentValidation", test_crc8SegmentValidation),
        ("test_crc8TestPerformance", test_crc8TestPerformance )
    ]   
}

class Crc16Tests: XCTestCase {
    static let TestBuffer : [UInt8] = [ 0x74, 0x65, 0x73, 0x74, 0x20, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72 ];
    static let ExtendedTestBuffer : [UInt8] = [ 0x00, 0x01, 0x02, 0x74, 0x65, 0x73, 0x74, 0x20, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72, 0x03, 0x04 ];
    
    static let Crc16Crc : UInt16       = UInt16(0x132A);
    static let Crc16DnpCrc : UInt16    = UInt16(0xBAAD);
    static let Crc16CcittCrc : UInt16  = UInt16(0x23B9);
    static let Crc16CcittKCrc : UInt16 = UInt16(0xD552);
    static let Crc16Ccitt1Crc : UInt16 = UInt16(0x0BB5);
    static let Crc16CcittFCrc : UInt16 = UInt16(0xF7B6);
    
    // standard crc 16
    func test_crc16Validation() {
        XCTAssertEqual( Crc16.computeChecksum( on: Crc16Tests.TestBuffer ), Crc16Tests.Crc16Crc );
    }
    
    func test_crc16SegmentValidation() {
        XCTAssertEqual( Crc16.computeChecksum( on: Crc16Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc16Tests.Crc16Crc );
    }
    
    func test_crc16TestPerformance() {
        self.measure {
            _ = Crc16.computeChecksum( on: Crc16Tests.TestBuffer );
        }
    }
    
    // crc 16 dnp
    func test_crc16DnpValidation() {
        XCTAssertEqual( Crc16Dnp.computeChecksum( on: Crc16Tests.TestBuffer ), Crc16Tests.Crc16DnpCrc );
    }
    
    func test_crc16DnpSegmentValidation() {
        XCTAssertEqual( Crc16Dnp.computeChecksum( on: Crc16Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc16Tests.Crc16DnpCrc );
    }
    
    func test_crc16DnpTestPerformance() {
        self.measure {
            _ = Crc16Dnp.computeChecksum( on: Crc16Tests.TestBuffer );
        }
    }
    
    // crc 16 ccitt 0x0000 iv
    func test_crc16ccittValidation() {
        XCTAssertEqual( Crc16Ccitt.computeChecksum( with: Crc16InitialValue.x0000, on: Crc16Tests.TestBuffer ), Crc16Tests.Crc16CcittCrc );
    }
    
    func test_crc16ccittSegmentValidation() {
        XCTAssertEqual( Crc16Ccitt.computeChecksum( with: Crc16InitialValue.x0000, on: Crc16Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc16Tests.Crc16CcittCrc );
    }
    
    func test_crc16ccittTestPerformance() {
        self.measure {
            _ = Crc16Ccitt.computeChecksum( with: Crc16InitialValue.x0000, on: Crc8Tests.TestBuffer );
        }
    }
    
    // crc 16 ccitt 0x1D0F iv
    func test_crc16ccitt1d0fValidation() {
        XCTAssertEqual( Crc16Ccitt.computeChecksum( with: Crc16InitialValue.x1D0F, on: Crc16Tests.TestBuffer ), Crc16Tests.Crc16Ccitt1Crc );
    }
    
    func test_crc16ccitt1d0fSegmentValidation() {
        XCTAssertEqual( Crc16Ccitt.computeChecksum( with: Crc16InitialValue.x1D0F, on: Crc16Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc16Tests.Crc16Ccitt1Crc );
    }
    
    func test_crc16ccitt1d0fTestPerformance() {
        self.measure {
            _ = Crc16Ccitt.computeChecksum( with: Crc16InitialValue.x1D0F, on: Crc8Tests.TestBuffer );
        }
    }
    
    // crc 16 ccitt 0xFFFF iv
    func test_crc16ccittffffValidation() {
        XCTAssertEqual( Crc16Ccitt.computeChecksum( with: Crc16InitialValue.xFFFF, on: Crc16Tests.TestBuffer ), Crc16Tests.Crc16CcittFCrc );
    }
    
    func test_crc16ccittffffSegmentValidation() {
        XCTAssertEqual( Crc16Ccitt.computeChecksum( with: Crc16InitialValue.xFFFF, on: Crc16Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc16Tests.Crc16CcittFCrc );
    }
    
    func test_crc16ccittffffTestPerformance() {
        self.measure {
            _ = Crc16Ccitt.computeChecksum( with: Crc16InitialValue.xFFFF, on: Crc8Tests.TestBuffer );
        }
    }

    // crc 16 ccitt Kermit
    func test_crc16ccittKermitValidation() {
        XCTAssertEqual( Crc16CcittKermit.computeChecksum( on: Crc16Tests.TestBuffer ), Crc16Tests.Crc16CcittKCrc );
    }
    
    func test_crc16ccittKermitSegmentValidation() {
        XCTAssertEqual( Crc16CcittKermit.computeChecksum( on: Crc16Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc16Tests.Crc16CcittKCrc );
    }
    
    func test_crc16ccittKermitTestPerformance() {
        self.measure {
            _ = Crc16CcittKermit.computeChecksum( on: Crc16Tests.TestBuffer );
        }
    }
    
    static var allTests = [
        ("test_crc16Validation", test_crc16Validation),
        ("test_crc16SegmentValidation", test_crc16SegmentValidation),
        ("test_crc16TestPerformance", test_crc16TestPerformance ),
        ("test_crc16DnpValidation", test_crc16DnpValidation),
        ("test_crc16DnpSegmentValidation", test_crc16DnpSegmentValidation),
        ("test_crc16DnpTestPerformance", test_crc16DnpTestPerformance ),
        ("test_crc16ccittValidation", test_crc16ccittValidation),
        ("test_crc16ccittSegmentValidation", test_crc16ccittSegmentValidation),
        ("test_crc16ccittTestPerformance", test_crc16ccittTestPerformance ),
        ("test_crc16ccitt1d0fValidation", test_crc16ccitt1d0fValidation),
        ("test_crc16ccitt1d0fSegmentValidation", test_crc16ccitt1d0fSegmentValidation),
        ("test_crc16ccitt1d0fTestPerformance", test_crc16ccitt1d0fTestPerformance ),
        ("test_crc16ccittKermitValidation", test_crc16ccittKermitValidation),
        ("test_crc16ccittKermitSegmentValidation", test_crc16ccittKermitSegmentValidation),
        ("test_crc16ccittKermitTestPerformance", test_crc16ccittKermitTestPerformance )
    ]   
}

class Crc32Tests: XCTestCase {
    static let TestBuffer : [UInt8] = [ 0x74, 0x65, 0x73, 0x74, 0x20, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72 ];
    static let ExtendedTestBuffer : [UInt8] = [ 0x00, 0x01, 0x02, 0x74, 0x65, 0x73, 0x74, 0x20, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72, 0x03, 0x04 ];
    static let Crc32Crc : UInt32 = 0xBCA3571E;
    
    
    func test_crc32Validation() {
        XCTAssertEqual( Crc32.computeChecksum( on: Crc8Tests.TestBuffer), Crc32Tests.Crc32Crc );
    }
    
    func test_crc32SegmentValidation() {
        XCTAssertEqual( Crc32.computeChecksum( on: Crc32Tests.ExtendedTestBuffer, startingAt: 3, length: 11), Crc32Tests.Crc32Crc );
    }
    
    func test_crc32TestPerformance() {
        self.measure {
            _ = Crc32.computeChecksum( on: Crc32Tests.TestBuffer );
        }
    }
    
    static var allTests = [
        ("test_crc32Validation", test_crc32Validation),
        ("test_crc32SegmentValidation", test_crc32SegmentValidation),
        ("test_crc32TestPerformance", test_crc32TestPerformance )
    ]
}