//: Playground - noun: a place where people can play

import UIKit

func mergeSort(_ array:[Int]) -> [Int] {
    /**
     If array count is 1, there is no way to split it. return the array
     */
    guard array.count > 1 else { return array }
    
    // Find the middle index
    let middleIndex = array.count / 2
    
    // Left array
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    
    // Right array
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    return merge(leftPile: leftArray, rightPile: rightArray)
}

func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
    
    var leftIndex = 0
    var rightIndex = 0
    
    //
    var orderdPile = [Int]()
    
    // Compare elements from left & right pile and
    // append them in ordered pile
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderdPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderdPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderdPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderdPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    // Left or right pile element already sorted, append rest of the elements
    while leftIndex < leftPile.count {
        orderdPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderdPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderdPile
}


let array = [2, 1, 5, 4, 9, 6, 6, 4, 0, 2, 19, 38, 8, 3]
mergeSort(array)


