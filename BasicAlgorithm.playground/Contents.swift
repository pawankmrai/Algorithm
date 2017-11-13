//: Playground - noun: a place where people can play

import UIKit
import Foundation

// MARK: Stack
public struct Stack<T> {
    fileprivate var array = [T]()
    
    // Empty
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    // Count
    public var count: Int {
        return array.count
    }
    
    // Push
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    // Pop
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    // Top
    public var top: T? {
        return array.last
    }
}
// MARK: Test stack
var stack = Stack(array: [1 , 2, 4])
stack.pop()
stack.push(10)
stack.top
stack.pop()
stack.pop()
stack.pop()
stack.pop()

// MARK: Queue
public struct Queue<T> {
    /**
     Array store object of type T? because we need to mark array element as being empty
     */
    fileprivate var array = [T?]()
    fileprivate var head = 0
    
    // Empty
    public var isEmpty: Bool {
        return count == 0
    }
    
    // Count
    public var count: Int {
        return array.count - head
    }
    
    // Enqueue
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    // Dequeque
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        /**
         Trim down the empty space if array crosses the threshold and empty space is more the 25 % of array size
         */
        let percentage = Double(head)/Double(array.count)
        if array.count > 2 && percentage > 0.25 {
            array.removeFirst()
            head = 0
        }
        return element
    }
    
    // Front
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

//MARK: Test queue
var queue = Queue<String>()
queue.enqueue("One")
queue.enqueue("Two")
queue.enqueue("Three")
queue.array
queue.count

queue.dequeue()
queue.array
queue.count

queue.dequeue()
queue.array
queue.count

//MAR: Insertion Sort

func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && isOrderedBefore(temp, a[y - 1]) {
            a[y] = a[y - 1]
            y -= 1
        }
        a[y] = temp
    }
    return a
}

// Test insetion sort
let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
insertionSort(list, <)
insertionSort(list, >)

let strings = [ "b", "a", "d", "c", "e" ]
insertionSort(strings, <)


// MARK: Binary Search

/**
 Linear Search
 */

func lineraSearch<T: Equatable>(_ a:[T], _ key: T) -> Int? {
    for i in 0 ..< a.count {
        if a[i] == key {
            return i
        }
    }
    return nil
}

// Test linear search
let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
lineraSearch(numbers, 11)

/**
 lower bound -  0
 upper bound - given element + 1
 */
func binarySearchRecursive<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        // Calculate where to split the array
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        // If the search key in left half?
        if a[midIndex] > key {
            return binarySearchRecursive(a, key: key, range: range.lowerBound ..< midIndex)
            // Is search key in right half?
        } else if a[midIndex] < key {
            return binarySearchRecursive(a, key: key, range: midIndex +  1 ..< range.upperBound)
            // If we get there, then we've found the search key
        } else {
            return midIndex
        }
    }
}

let binaryTestNumbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
binarySearchRecursive(binaryTestNumbers, key: 43, range: 0 ..< numbers.count)  // gives 13

func binarySearchInterative<T: Comparable>(_ a:[T], key:T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

binarySearchInterative(binaryTestNumbers, key: 43)

