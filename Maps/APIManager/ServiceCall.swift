//
//  ServiceCall.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import UIKit

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

class ServiceCall: NSObject {
    
    class func initWithURl(url: String, headers: [String: String], parameters: Data?, info: [String: String], type: RequestType, completion:  @escaping (_ err: Error?, _ obj: NSDictionary?) -> Void){
        var urlForm = url
        if let params = info["mail"] {
            urlForm = "\(url)?email=\(params)"
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: urlForm)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 15.0)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        request.httpMethod = type.rawValue
        if let data = parameters {
            request.httpBody = data
        }
        print(logNetworkRequest(request as URLRequest))
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(error! as Error, nil)
            } else {
                guard let statusCode = response as? HTTPURLResponse  else {
                    return
                }
                if statusCode.statusCode == 401 {
                    completion(nil, nil)
                    return
                }
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print(dataString!)
                let datas = dataString?.data(using: .utf8)
                
                let json: NSDictionary = try! JSONSerialization.jsonObject(with: datas!) as! NSDictionary
                completion(nil, json)
            }
        })
        
        dataTask.resume()
    }
}

private extension ServiceCall {
    
    class func format(_ loggerId: String, identifier: String, message: String) -> String {
        return "\(loggerId): \(identifier): \(message)"
    }
    
    class func logNetworkRequest(_ request: URLRequest?) -> [String] {
        
        var output = [String]()
        
        output += [format("Logger", identifier: "Request", message: request?.description ?? "(invalid request)")]
        
        if let headers = request?.allHTTPHeaderFields {
            output += [format("Logger", identifier: "Request Headers", message: headers.description)]
        }
        
        if let httpMethod = request?.httpMethod {
            output += [format("Logger", identifier: "HTTP Request Method", message: httpMethod)]
        }
        
        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            output += [format("Logger", identifier: "Request Body", message: stringOutput)]
        }
        
        return output
    }
    
    func logNetworkResponse(_ response: HTTPURLResponse?, data: Data?, type: EndpointsURLS) -> [String] {
        
        guard let response = response else {
            return [ServiceCall.format("Logger", identifier: "Response", message: "Received empty network response for \(type).")]
        }
        
        var output = [String]()
        
        if let data = data, let stringData = String(data: data , encoding: String.Encoding.utf8) {
            output += [ServiceCall.format("Logger", identifier: "Response \(response.statusCode) \(response.url?.absoluteString ?? "") ", message: stringData)]
        }
        
        return output
    }
}

struct globals {
    
    static var brandmeLogin = "http://api.brandme.la/api/v1/login"
    static var brandmeContrys = "http://api.brandme.la/api/v1/get/paises"
    static var brandmeSignup = "http://api.brandme.la/api/v1/registro"
    static var brandmeCampaigns = "http://api.brandme.la/api/v1/get/campanas"
    static var brandmeProposal = "http://api.brandme.la/api/v1/campana/id/enviar/propuesta"
    static var brandmeGetProposals = "http://api.brandme.la/api/v1/get/propuestas/"
    static var brandmeGetInformation = "http://api.brandme.la/api/v1/usuario/informacion"
    static var brandmeGetNetworks = "http://api.brandme.la/api/v1/get/redes"
    static var brandmeGetProfiles = "http://api.brandme.la/api/v1/get/redes-conectadas"
    static var brandmeGetAudience = "http://api.brandme.la/api/v1/get/segmentacion/audiencia"
    static var brandmeGetInterests = "http://api.brandme.la/api/v1/get/segmentacion/intereses"
    static var brandmeGetUrlSocial = "http://api.brandme.la/api/v1/link/oauth"
    static var brandmeGetUrlLoginSocial = "http://api.brandme.la/api/v1/login/social/facebook"
    static var brandmePostSegmentacion = "http://api.brandme.la/api/v1/guardar/segmentacion/network/audiencia"
    static var brandmePostTemas = "http://api.brandme.la/api/v1/guardar/segmentacion/network/temas"
    
    
    
}
