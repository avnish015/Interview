import Foundation

//////////////////////////////////////////////////////////
///Higher order functions
/////////////////////////////////////////////////////////
//Map
extension Array {
    func customMap<T>(completion: (Element) -> T?) -> [T] {
        var array = [T]()
        forEach { element in
            array.append(completion(element)!)
        }
        return array
    }
}

print([1, 2, 3, 4].customMap(completion: {$0 * 2}))

//CompactMap
extension Array {
    func customCompactMap<T>(completion: (Element)->T?) -> [T] {
        var array: [T] = []
        for element in self {
            if let obj = completion(element) {
                print(obj)
                array.append(obj)
            }
        }
        return array
    }
}

[1, 2, 3, nil].customCompactMap {"\($0 ?? 0)"}

//FlatMap
extension Array {
    func customFlatMap<T>(completion: (Element)->[T]) -> [T] {
        var array: [T] = []
        for element in self {
            array += completion(element)
        }
        return array
    }
}

print([1, 2, 3].customFlatMap{[$0]})

//Reduce
//extension Array {
//    
//    func customReduce<T>(_ initialValue: T, _ transform: (T, Element) -> T) -> T {
//        
//        var value = initialValue
//        forEach {
//            value = transform(value, $0)
//        }
//        return value
//    }
//}
//print([1, 2, 3].customReduce(0){$0 + $1})

//Filter
//extension Array {
//
//    func customFilter( _ transform: (Element) -> Bool) -> [Element] {
//        var result = [Element]()
//        forEach {
//            if transform($0) {
//                result.append($0)
//            }
//        }
//        return result
//    }
//}
//print([1, 2, 3].customFilter{$0 % 2 == 0})

//////////////////////////////////////////////////////////
///Some other questions
/////////////////////////////////////////////////////////
//Is a string a palindrome?

extension String {
    
    func isPalindrome() -> Bool {
        var characters: [Character] = Array(self)
        var low = 0
        var high = characters.endIndex - 1
        while low < high {
            let temp = characters[low]
            characters[low] = characters[high]
            characters[high] = temp
            low += 1
            high -= 1
        }
        return String(characters) == self
    }
}

"HeleH".isPalindrome()

//Do two strings contain the same characters?

extension String {
    
    func doesContainSameCharacters(_ string: String) -> Bool {
        
        let firstArray = Set(self)
        var secondArray = Set(string)
        
        if firstArray.count != secondArray.count {
            return false
        }
        
        for char in secondArray {
            secondArray.remove(char)
        }
        return secondArray.isEmpty
    }
}

"abc".doesContainSameCharacters("cba")

//Does one string contain another?

extension String {
    
    func doesContains(_ string: String) -> Int {
//        return self.localizedStandardContains(string)
        var first = Array(self)
        var second = Array(string)
        
        for i in 0..<first.count {
            var k = i
            for j in 0..<second.count {
                if k < first.count &&
                   first[k] == second[j] {
                    if j == second.count  - 1 {
                        return i + 1
                    }
                    k += 1
                } else {
                    break
                }
            }
        }
        return -1
    }
}

"Hello firends".doesContains("a")


//Remove duplicate letters from a string

extension String {
    func removeDuplicate() -> String {
        var newString = ""
        for char in self {
            var isCharAlreadyAvailable = false
            for char2 in newString {
                if char == char2 {
                    isCharAlreadyAvailable = true
                    break
                }
            }
            if !isCharAlreadyAvailable {
                newString.append(char)
            }
        }
        return newString
    }
}
"Hello firends".removeDuplicate()


//Find n smallest numbers
func findNSmallestNumbers(_ array1: [Int], count: Int) -> [Int] {
    var array = array1
    var smallestNumbersArray = [Int]()
    for i in 0..<array.endIndex  {
        for j in (i + 1)..<array.endIndex {
            if array[i] > array[j] {
                let temp = array[i]
                array[i] = array[j]
                array[j] = temp
            }
        }
        smallestNumbersArray.append(array[i])
        if smallestNumbersArray.count == count {
            break
        }
    }
    return smallestNumbersArray
}

findNSmallestNumbers([2,1,4,7,5], count: 3)
