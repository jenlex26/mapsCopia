//
//  Global.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import  UIKit
struct Globals {
    static let genericError = "Error en el servicio, !porfavor intente mas tarde!"
    
    static func modalPreferredContentSize() -> CGSize {
        let currentHeight = UIScreen.main.bounds.height - 100
        return CGSize(width: 550, height: currentHeight > 760 ? 760 : currentHeight)
    }
}

public extension UIViewController {
    
    static var typeName: String {
        return String(describing: self)
    }
}

extension UIColor {
    static let greenDRD = UIColor.init(red: 0.0/255.0, green: 153.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    static let blueDRD = UIColor.init(red: 0.0/255.0, green: 84.0/255.0, blue: 163.0/255.0, alpha: 1.0)
}

public func debugError(error: Error?, type: Any, fileName: String = #file, lineNumber: Int = #line) {
    if let error = error {
        let log = "\n<\((fileName as NSString).lastPathComponent)> [#\(lineNumber)] ‼️\nError \(type): \(error.localizedDescription)\n"
        print(log)
    }
}

public func debug(info: Any, fileName: String = #file, lineNumber: Int = #line, detailed: Bool = true) {
    if detailed {
        let log = "\n<\((fileName as NSString).lastPathComponent)> [#\(lineNumber)] ✳️\n\(info)\n"
        print(log)
    } else {
        print("\n\(info)\n")
    }
    
}

public func debug(info: Any, fileName: String = #file, lineNumber: Int = #line) {
    print("")
    print("<\((fileName as NSString).lastPathComponent)> [#\(lineNumber)] ✳️")
    print(info)
    print("")
}

enum MapsStoryboard: String {
    case settings = "Settings"
    case login = "LoginAndRegister"
    case branches = "BranchesAndServices"
    case formats = "Formats"
    case scheduled = "Scheduled"
    case Facebook = "Facebook"
}
