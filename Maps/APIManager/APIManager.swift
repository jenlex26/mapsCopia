//
//  APIManager.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import ObjectMapper

enum EndpointsURLS: String {
//    case getConfig  = "https://parseapi.back4app.com/classes/configuration"
//    case login = "http://18.216.100.245:83/api/login/authenticate"
//    case register = "http://18.216.100.245:83/api/users/create"
    case forgot = "https://parseapi.back4app.com/classes/Countries"
}

class APIManager {
    
    static func performGetConfigurations(type: EndpointsURLS, completion:  @escaping (_ err: Error?, _ config: ConfigModel?) -> Void) {
        let parameters = getParameters(type: type)
        ServiceCall.initWithURl(url: type.rawValue, headers: parameters, parameters: nil, info: [:], type: .get) { (error, response) in
            if error != nil {
                completion(error, nil)
            } else {
                guard let response = response else {
                    debugError(error: error, type: "Congigurations")
                    return
                }
                
                let results = response["results"] as? NSArray
                guard let dataJSON = results![0] as? NSDictionary else {
                    debugError(error: error, type: "Congigurations---error to get dataJSON")
                    return
                }
                let config = Mapper<ConfigModel>().map(JSON: dataJSON as? [String : Any] ?? [:])
                completion(nil, config)
                
            }
        }
    }
    
    static func performRegister(type: EndpointsURLS, user: UserModel, password: String, completion:  @escaping (_ err: Error?, _ config: userResponse?) -> Void) {
        let headers = getParameters(type: type)
        
        let json: [String: Any] = [EndpointParams.userName: user.name ?? "",
                                   EndpointParams.userFirstName: "XX", EndpointParams.userLastName: "XX",EndpointParams.userMail: user.mail ?? "", EndpointParams.userPassword: password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        ServiceCall.initWithURl(url: type.rawValue, headers: headers, parameters: jsonData, info: [:], type: .post) { (error, response) in
            if error != nil {
                completion(error, nil)
            } else {
                let userResponse = Mapper<userResponse>().map(JSON: response as? [String : Any] ?? [:])
                completion(nil, userResponse)
            }
            
        }
    }
    
    static func performLogin(type: EndpointsURLS, mail: String, password: String, completion:  @escaping (_ err: Error?, _ config: LoginResponse?) -> Void) {
        
        let json: [String: Any] = [EndpointParams.userEmail: mail , EndpointParams.userPass: password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        ServiceCall.initWithURl(url: type.rawValue, headers: getParameters(type: type), parameters: jsonData, info: [: ], type: .post) { (error, response) in
            if error != nil {
                completion(error, nil)
            } else {
                let userResponse = Mapper<LoginResponse>().map(JSON: response as? [String : Any] ?? [:])
                completion(nil, userResponse)
            }
        }
    }
    
    
    static func performMaps( type: EndpointsURLS, completion:  @escaping (_ err: Error?, _ config: MapResponse?) -> Void) {
        
        ServiceCall.initWithURl(url: type.rawValue, headers: getParameters(type: type), parameters: nil, info: [: ], type: .get) { (error, response) in
            if error != nil {
                completion(error, nil)
            } else {
                let userResponse = Mapper<MapResponse>().map(JSON: response as? [String : Any] ?? [:])
                completion(nil, userResponse)
            }
        }
    }
    
    static func getParameters(type: EndpointsURLS) -> [String: String] {
        switch type {
//        case .getConfig:
//            return ["X-Parse-Application-Id":"ZYBTIpej4EmFzJpuPe5ZPwzlP35jOU6v83tpwbpd", "X-Parse-REST-API-Key": "jqDh1D5EMi92893qWzytVwA3OMbDyW5OB3nTJYXm"]
//        case .register:
//            return ["User-Agent":"Fiddler","Host":"18.216.100.245:83","Content-Type":"application/json", "Content-Length":"64"]
        case .forgot:
            return ["X-Parse-Application-Id":"0uJjBWAsp0EoVy67qLlyURkrpS3mhwyngreFRpzo","X-Parse-REST-API-Key":"l2gayQt4fBTtxWJW64TaKjpjXSYscv25OBb7Jzvl"]
//        case .login:
//            return ["Content-Type":"application/json"]
        default:
            return [:]
        }
    }
    
}
