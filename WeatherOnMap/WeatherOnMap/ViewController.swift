//
//  ViewController.swift
//  WeatherOnMap
//
//  Created by Igor on 07/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var weatherPoint = [CLLocationCoordinate2D]()
    var coordinates = [PointCoordinats]()
    
    let getWeatherOW = Networking()
    
    let latitude = 55.59179844510567
    let longitude = 37.64727898254918
    
    @IBOutlet weak var mapKitView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapKitView.delegate = self
        
//        getLocation()
        var w = getWeatherOW.loadWeather(latitude, longitude)
        print(w)

    }
    
    func getCoordinateFromMap(for mapView: MKMapView) -> [CLLocationCoordinate2D] {
        
        let point = mapView.center
        let centerFrame = mapView.convert(point, toCoordinateFrom: mapView)
        print(centerFrame)
        
        let lat = centerFrame.latitude
        let lon = centerFrame.longitude
        
//        getWeatherOW.loadWeather(lat, lon)
        
        return [centerFrame]
    }
    
    func getLocation() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            self.removeAnnotation()
            self.weatherPoint = self.getCoordinateFromMap(for: self.mapKitView)
            print("WeatherPoint \(self.weatherPoint))")
            let placemark = self.weatherPoint.first
            let annotation = MKPointAnnotation()
            annotation.title = "Here"
            annotation.coordinate.latitude = placemark!.latitude
            annotation.coordinate.longitude = placemark!.longitude
            
            print(annotation.coordinate)

            self.mapKitView.addAnnotation(annotation)
//            self.mapView.selectAnnotation(annotation, animated: true)
            
        }
        
    }
    
    func removeAnnotation() {
        let annotations = mapKitView.annotations
        if annotations.count != 0  {
            mapKitView.removeAnnotations(annotations)
        }
    }
    
    //MARK: - Annotation change image
    
    func load(url: URL) {
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
//                        self?.image = image
                        print(image.size)
                    }
                }
            }
        }
    }
    
}


extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "")
        }
        if annotation.title == "Here" {
            annotationView?.image = UIImage(named: "weather")
            annotationView?.frame.size = CGSize(width: 50, height: 50)
        }
        
//        let url = URL(fileURLWithPath: "http://openweathermap.org/img/wn/04d@2x.png")
//        let image = try! Data(contentsOf: url)
        
//        annotationView?.image = UIImage(data: image)
        
//        http://openweathermap.org/img/wn/04d@2x.png
        
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
}
