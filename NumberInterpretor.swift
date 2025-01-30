import Foundation

func wordsToInt(_ words: String) -> Int? {
    let numberMap: [String: Int] = [
        "zero": 0, "one": 1, "two": 2, "three": 3, "four": 4,
        "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9,
        "ten": 10, "eleven": 11, "twelve": 12, "thirteen": 13,
        "fourteen": 14, "fifteen": 15, "sixteen": 16, "seventeen": 17,
        "eighteen": 18, "nineteen": 19, "twenty": 20, "thirty": 30,
        "forty": 40, "fifty": 50, "sixty": 60, "seventy": 70,
        "eighty": 80, "ninety": 90, "hundred": 100, "thousand": 1000,
        "million": 1_000_000, "billion": 1_000_000_000, "trillion": 1_000_000_000_000,
        "quadrillion": 1_000_000_000_000_000, "quintillion": 1_000_000_000_000_000_000,
        "sextillion": 1_000_000_000_000_000_000_000, "septillion": 1_000_000_000_000_000_000_000,
        "octillion": 1_000_000_000_000_000_000_000_000, "nonillion": 1_000_000_000_000_000_000_000_000_000,
        "decillion": 1_000_000_000_000_000_000_000_000_000_000
    ]

    var result = 0
    var currentValue = 0
    let wordsArray = words.lowercased().split(separator: " ")

    for word in wordsArray {
        if let number = numberMap[String(word)] {
            if word == "hundred" {
                // Multiply current value by 100 when "hundred" is found
                currentValue *= number
            } else if let multiplier = numberMap[String(word)], multiplier >= 1000 {
                // When we encounter a large multiplier like thousand, million, billion, etc.
                currentValue *= multiplier
                result += currentValue
                currentValue = 0
            } else {
                // Add regular number values to the current group
                currentValue += number
            }
        } else {
            // If an unrecognized word is found, return nil
            return nil
        }
    }
    // Add any leftover value from the last group
    result += currentValue
    return result
}

// Example Usage:
let numberInWords = "one decillion two octillion three septillion four sextillion five quintillion six quadrillion"
if let result = wordsToInt(numberInWords) {
    print("The number is \(result)")
} else {
    print("Invalid input")
}
