//
//  Logger.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 9/22/15.
//  Copyright (c) 2015 SnackpackGames. All rights reserved.
//

import UIKit

enum LogLevel {
    case Debug, Info, Warning, Error
    
    private func shouldLog(level: LogLevel) -> Bool {
        switch (self) {
        case .Debug:
            return true
        case .Info:
            switch (level) {
            case .Debug:
                return false
            case .Info, .Warning, .Error:
                return true
            }
        case .Warning:
            switch (level) {
            case .Debug, .Info:
                return false
            case .Warning, .Error:
                return true
            }
        case .Error:
            switch (level) {
            case .Debug, .Info, .Warning:
                return false
            case .Error:
                return true
            }
        }
    }
}

class Logger: NSObject {
    var logLevel: LogLevel
    
    override init() {
        logLevel = .Debug
    }
    
    init(logLevel: LogLevel) {
        self.logLevel = logLevel
    }
    
    func log(message: String) {
        self.log(message, level: .Debug)
    }
    
    func log(message: String, level: LogLevel) {
        if self.logLevel.shouldLog(level) {
            switch logLevel {
            case .Debug:
                print("[debug]: \(message)")
            case .Info:
                print("[info]: \(message)")
            case .Warning:
                print("[warning]: \(message)")
            case .Error:
                print("[error]: \(message)")
            }
        }
    }
}
