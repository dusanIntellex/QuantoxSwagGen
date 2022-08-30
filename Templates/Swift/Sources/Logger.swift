//
//  Logger.swift
//  Celsius
//
//  Created by Djuro Alfirevic on 5/17/21.
//  Copyright © 2021 Celsius Network. All rights reserved.
//

import Foundation
import os.log
import API

enum LogType: String {
    case error = "🛑"
    case info = "ℹ️"
    case debug = "💬"
    case warning = "⚠️"
    case fatal = "🔥"
    case success = "✅"
}

final class Logger {
    
    // MARK: - Properties
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = .current
        formatter.timeZone = .current
        
        return formatter
    }
    
    // MARK: - Public API
    
    static func log(message: String,
                    type: LogType,
                    fileName: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
        
        #if DEBUG
        print("\(type.rawValue) \(message)")
        #endif
    }
    
    static func log<T: Codable>(_ object: T) {
        let data = try! JSONEncoder().encode(object)
        let json = String(data: data, encoding: .utf8)
        
        #if DEBUG
        print("JSON: \(json ?? "")")
        #endif
    }
    
    static func logError(message: String, error: Error) {
        Logger.log(message: "\(message): \(error)", type: .error)
    }
    
    // MARK: - Private API
    
    private static func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    func formatted() -> String {
        return Logger.dateFormatter.string(from: self)
    }
}

extension Logger {
    static func logDataResponse<T>(_ response: APIResponse<T>) {
        
        var console = ""
        
        switch response.result {
        case .success(_):
            console.append("\n✅ \(response.request.description)")
        case .failure(let error):
            console.append("\n❌ \(response.request.description)")
            if let error = error as NSError? {
                console.append("\n‼️ [\(error.domain) \(error.code)] \(error.description)")
            } else {
                console.append("\n‼️ \(error.description)")
            }
        }
            
        console.append(contentsOf: "\n")
        console.append(contentsOf: response.description)
        
        console.append(contentsOf: "\n")
        if let headers = response.urlRequest?.allHTTPHeaderFields, headers.count > 0 {
            let headers = headers.map({ "\($0.key): \($0.value)" }).joined(separator: "\n   ")
            console.append("\n🤯 \(headers)")
        }
        if let body = response.urlRequest?.httpBody, let body = String(data: body, encoding: String.Encoding.utf8), body.count > 0 {
            console.append("\n📤 \(body)")
        }
        if let data = response.data, let payload = String(data: data, encoding: String.Encoding.utf8), payload.count > 0 {
            console.append("\n📦 \(payload)")
        }
        
        os_log("%@", log: .network, type: .default, console)
    }
}

extension OSLog {
    static let network: OSLog = {
        return OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "network")
    }()
}
