//
//  ViewDescriptionPresenter.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AlamofireImage
import Alamofire



protocol DescriptionView {
    func showProgress()
    func hideProgress()
    func getContry(annotation: MKPointAnnotation, region: MKCoordinateRegion)
    func currentError(err:String)
    func getImage(image: UIImage)
}

class DescriptionViewPresenter {
    
    var view: DescriptionView
    
    init(view: DescriptionView) {
        self.view = view
    }
    
    func search(name: String) {
        let search = MKLocalSearch.Request()
        search.naturalLanguageQuery = name
        
        let activeSearch = MKLocalSearch(request: search)
        
        activeSearch.start { (response, error) in
            if response == nil {
                print("nada")
                self.view.currentError(err: "No se encontro\(name)")
            }else{
                let latitud = response?.boundingRegion.center.latitude
                let longitud = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = name
                annotation.coordinate = CLLocationCoordinate2DMake(latitud!, longitud!)
                
                
                
                let coordenate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud!, longitud!)
                let span = MKCoordinateSpan(latitudeDelta: 30,longitudeDelta: 30)
                let region = MKCoordinateRegion(center: coordenate, span: span)
//                self.maps.setRegion(region, animated: true)
                // Pasando el annotation al viewcontroller
                self.view.getContry(annotation: annotation, region: region)
            }
        }
    }
    
    func imageData(urlData: String) {
        let imageUrl = urlData
        Alamofire.request(imageUrl).downloadProgress(closure: {
            (progrees) in
        }).responseData {(response) in
            if let data = response.result.value {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.view.getImage(image: image ?? UIImage())
                }
            }
        }
    }

}
