//
//  utils.swift
//  Countdown Timer
//
//  Created by 张豪杰 on 2023/7/15.
//

import Foundation

func createTimerPublisher() -> Timer.TimerPublisher {
    return Timer.publish(every: 1, on: RunLoop.main, in: RunLoop.Mode.common)
}

func formatNumber(number: Int) -> String {
    return number >= 10 ? "\(number)" : "0\(number)"
}

// h / m / s
let formatRegExp = /^(\d+)(h|H|m|M|s|S)$/

func checkInput(input: String) -> Bool {
    return input.contains(formatRegExp)
}

// input -> seconds
func inputToSeconds(input: String) -> Int {
    let fm = input.firstMatch(of: formatRegExp)
    
    let num: Int = Int(fm?.output.1 ?? "")!
    
    // h / m / s
    let unit: String = String(fm?.output.2.lowercased() ?? "")
    
    if unit == "s" {
        return num
    }
    
    if unit == "m" {
        return num * 60
    }
    
    if unit == "h" {
        return num * 60 * 60
    }
    
    return 0
    
}

func getTimeText(seconds: Int) -> String {
    let hours = seconds / 60 / 60;
    if hours > 0 {
        return "\(formatNumber(number: hours)):\(formatNumber(number: seconds / 60 % 60)):\(formatNumber(number: seconds % 60))"
    }
    return "\(formatNumber(number: seconds / 60)):\(formatNumber(number: seconds % 60))"
}
