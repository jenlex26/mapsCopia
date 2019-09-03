//
//  UserCurrentSession.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation

class UserCurrentSession {
    
    // MARK: - Properties
    
    private static var sharedUser: UserCurrentSession = {
        let userCurrentSession = UserCurrentSession()
        
        // Configuration
        // ...
        
        return userCurrentSession
    }()
    
    // MARK: -
    
    var name: String?
    var email: String?
    var phone: String?
    var mail: String?
    var address: String?
    var password: String?
    var token: String?
    
    // Initialization
    
    private init() {
        
    }
    // MARK: - Accessors
    
    class func shared() -> UserCurrentSession {
        return sharedUser
    }
    
}
