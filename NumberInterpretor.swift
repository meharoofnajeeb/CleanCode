import Foundation

public class NumberInterpretor {
    public static let instance = NumberInterpretor()
    
    private init() {}
    
    private let numberMap: [String: Int128] = [
        "zero": 0, "one": 1, "two": 2, "three": 3, "four": 4,
        "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9,
        "ten": 10, "eleven": 11, "twelve": 12, "thirteen": 13,
        "fourteen": 14, "fifteen": 15, "sixteen": 16, "seventeen": 17,
        "eighteen": 18, "nineteen": 19, "twenty": 20, "thirty": 30,
        "forty": 40, "fifty": 50, "sixty": 60, "seventy": 70,
        "eighty": 80, "ninety": 90, "hundred": 100, "thousand": 1000,
        "million": 1_000_000,
        "billion": 1_000_000_000,
        "trillion": 1_000_000_000_000,
        "quadrillion": 1_000_000_000_000_000,
        "quintillion": 1_000_000_000_000_000_000,
        "sextillion": 1_000_000_000_000_000_000_000,
        "septillion": 1_000_000_000_000_000_000_000,
        "octillion": 1_000_000_000_000_000_000_000_000,
        "nonillion": 1_000_000_000_000_000_000_000_000_000,
        "decillion": 1_000_000_000_000_000_000_000_000_000_000
    ]
    
    private var result: Int128 = 0
    private var currentValue: Int128 = 0
    
    private enum InterpretorError: String, Error {
        case invalidWordInInput = "Invalid"
        case emptyInput = "Empty"
    }
    
    public func interpret(_ words: String) throws -> Int128 {
        resetResultAndCurrentValue()
        
        try process(words: words)
        
        return result
    }
    
    private func resetResultAndCurrentValue() {
        result = 0
        currentValue = 0
    }
    
    private func process(words: String) throws {
        let wordsArray = words.lowercased().split(separator: " ")

        if wordsArray.count <= 0 {
            throw InterpretorError.emptyInput
        }
        
        for word in wordsArray {
            try process(String(word))
        }
        
        result += currentValue
    }
    
    private func process(_ word: String) throws {
        if numberMap[String(word)] != nil {
            processWordAndUpdate(word)
        } else {
            throw InterpretorError.invalidWordInInput
        }
    }
    
    private func processWordAndUpdate(_ word: String) {
        let number = numberMap[String(word)]!
        if isWord100(word) {
            currentValue *= number
        } else if let multiplier = multiplierFor(word) {
            currentValue *= multiplier
            result += currentValue
            currentValue = 0
        } else {
            currentValue += number
        }
    }
    
    private func isWord100(_ word: String) -> Bool {
        return word == "hundred"
    }
    
    private func multiplierFor(_ word: String) -> Int128? {
        guard let multiplier = numberMap[String(word)], multiplier >= 1000 else { return nil }
        return multiplier
    }
}

let numberInWords = "one decillion two octillion three septillion four sextillion five quintillion six quadrillion"

do {
    let result = try NumberInterpretor.instance.interpret(numberInWords)
    print("The number is \(result)")
} catch {
    print("Error \(error)")
}

