//
//  ViewDescriptionVC.swift
//  Maps
//
//  Created by Alejandro Hernandez on 8/29/19.
//  Copyright © 2019 Alejandro Hernandez. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MapKit

class ViewDescriptionVC: BaseViewController {
    
    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelDescription: UITextView!
    @IBOutlet weak var maps: MKMapView!
    
    var DescriptionPresenter: DescriptionViewPresenter?
    var index: Int = 0
    var nameData: String = ""
    var urlData: String = ""
    var descriptionData: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionPresenter = DescriptionViewPresenter(view: self as DescriptionView,vc: self)
        dataService()
        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonFormats(_ sender: Any) {
        self.backAction(sender)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func dataService(){
        nameCountry.text = nameData
        labelDescription.text = descriptionData
        imageData()
    
        let search = MKLocalSearch.Request()
        search.naturalLanguageQuery = nameData
        
        let activeSearch = MKLocalSearch(request: search)
        
        activeSearch.start { (response, error) in
            if response == nil{
                print("nada")
            }else{
                let annotations = self.maps.annotations
                self.maps.removeAnnotations(annotations)
                
                let latitud = response?.boundingRegion.center.latitude
                let longitud = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = self.nameData
                annotation.coordinate = CLLocationCoordinate2DMake(latitud!, longitud!)
                self.maps.addAnnotation(annotation)
                
                let coordenate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud!, longitud!)
                let span = MKCoordinateSpan(latitudeDelta: 30,longitudeDelta: 30)
                let region = MKCoordinateRegion(center: coordenate, span: span)
                self.maps.setRegion(region, animated: true)
            }
        }
        
        
    }
    func imageData () {
        let imageUrl = urlData
        Alamofire.request(imageUrl).downloadProgress(closure: {
            (progrees) in
        }).responseData {(response) in
            if let data = response.result.value {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
}
extension ViewDescriptionVC: DescriptionView {
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
    
    
}
