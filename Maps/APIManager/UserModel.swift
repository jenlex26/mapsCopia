//
//  UserModel.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel: Mappable {
    var name: String?
    var firstName: String?
    var lastName: String?
    var mail: String?

    
    init(name: String, firstName: String, lastName: String, mail: String) {
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.mail = mail
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["nombre"]
        firstName <- map["apellidoPaterno"]
        lastName <- map["apellidoMaterno"]
        mail <- map["correo"]

    }
}
