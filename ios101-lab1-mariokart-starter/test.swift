//
//  test1.swift
//  MarioKart
//
//  Created by Ya-chen Hsieh on 2/20/25.
//  Copyright © 2025 Charles Hieger. All rights reserved.
//

var familyVehicles: [String] = ["Sedan"]

familyVehicles.append("Van")
familyVehicles.append("Sedan")
familyVehicles[0] = "SUV"
familyVehicles.remove(at: 1)
familyVehicles += ["Sports Car"]

print(familyVehicles)

let numbers = [1, 2, 3, 4]

// Transform values with map
let squares = numbers.map { $0 * $0 } // [1, 4, 9, 16]

// Filter out values
let evenNumbers = numbers.filter { $0 % 2 == 0 } // [2, 4]

// Combine elements with reduce
let sum = numbers.reduce(0) { $0 + $1 } // 10

print("numbers: \(numbers)")
print("squares: \(squares)")
print("evenNumbers: \(evenNumbers)")
print("sum: \(sum)")

