//
//  ResponseModel.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import ObjectMapper

class ConfigResponse: Mappable {
    required init?(map: Map) {
        
    }
    
    var result: [String: [[String: Any]]] = [:]
    
    func mapping(map: Map) {
        result <- map["results"]
    }
}

class ConfigModel: ConfigResponse {
    
    var alreadyPay: Bool?
    var message: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        alreadyPay <- map["alreadyPay"]
        message <- map["message"]
    }
}

class userResponse: Mappable {
    var result: String?
    var errors: [[String: String]]?
    var success: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        errors <- map["errors"]
        success <- map["success"]
    }
}

class LoginResponse: Mappable {
    var result: [String: Any]?
    var errors: [[String: String]]?
    var success: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        errors <- map["errors"]
        success <- map["success"]
    }
}

class MapResponse: Mappable {
    var country: [MapCountry]!
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        country <- map["results"]
    }
}

class MapCountry: Mappable {
    var objectId: String?
    var name: String?
    var description: String?
    var image: ImageModel?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        objectId <- map["objectId"]
        name <- map["name"]
        description <- map["description"]
        image <- map ["image"]
    }
}

class ImageModel: Mappable {
    var name: String?
    var url: String?

 
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        name <- map["name"]
        url <- map["url"]
 
    }
}
