import Foundation

let arrayLength = 10_000_000
let measureAttempts = 10

var numbers = Array(1...arrayLength)

func measure(attempts: Int, measuredClosure: (() -> ())) -> ([TimeInterval], TimeInterval) {
    var durationsInSeconds = [TimeInterval]()
    
    for _ in 1...attempts {
        let startDate = Date()
        
        measuredClosure()
        
        durationsInSeconds.append(Date().timeIntervalSince(startDate))
    }
    
    let averageInSeconds = durationsInSeconds.reduce(0, +) / Double(durationsInSeconds.count)
    
    return (durationsInSeconds, averageInSeconds)
}

let (_, averageEmptyForIn) = measure(attempts: measureAttempts) {
    for _ in numbers {}
}

print("averageEmptyForIn: \(averageEmptyForIn)")

let (_, averageForInSeconds) = measure(attempts: measureAttempts) {
    for i in numbers {
        _ = i + Int.random(in: 1...2)
    }
}

print("averageForInSeconds: \(averageForInSeconds)")

let (_, averageForEachInSeconds) = measure(attempts: measureAttempts) {
    numbers.forEach { i in
        _ = i + Int.random(in: 1...2)
    }
}

print("averageForEachInSeconds: \(averageForEachInSeconds)")

let (_, averageMapInSeconds) = measure(attempts: measureAttempts) {
    _ = numbers.map {
        $0 + Int.random(in: 1...100)
    }
}

print("averageMapInSeconds: \(averageMapInSeconds)")
