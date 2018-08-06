import XCTest

final class MapVsForInVsForEachChallengeTests: XCTestCase {

    let arrayLength = 10_000_000

    private var numbers: [Int]!

    // MARK: - Setting

    override func setUp() {
        super.setUp()

        numbers = Array(1...arrayLength)
    }

    // MARK: - Tests
    
    func testEmptyForIn() {
        measure {
            for _ in numbers {}
        }
    }

    func testForIn() {
        measure {
            for i in numbers {
                _ = i + Int.random(in: 1...2)
            }
        }
    }

    func testForEach() {
        measure {
            numbers.forEach { i in
                _ = i + Int.random(in: 1...2)
            }
        }
    }

    func testMap() {
        measure {
            _ = numbers.map { i in
                i + Int.random(in: 1...2)
            }
        }
    }
    
    static var allTests = [
        ("testEmptyForIn", testEmptyForIn),
        ("testForIn", testForIn),
        ("testForEach", testForEach),
        ("testMap", testMap)
    ]
    
}
