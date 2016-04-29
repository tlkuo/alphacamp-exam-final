//: Playground - noun: a place where people can play

import UIKit

func twoSum(numbers: [Int], target: Int) -> (Int?, Int?) {
    
    for i in 0..<numbers.count-1 {
        
        for j in i..<numbers.count {

            if (numbers[i] + numbers[j]) == target {
                return (i + 1, j + 1)
            }
        }
    }
    
    return (nil, nil)
}

var (index1, index2) = twoSum([2, 7, 11, 15], target: 9)

if index1 != nil && index2 != nil {
    print("index1=\(index1!), index2=\(index2!)")
}
