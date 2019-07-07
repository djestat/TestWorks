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
    
    var weatherPoint = CLLocationCoordinate2D()
    var coordinates = [PointCoordinats]()
    
    let getWeatherOW = Networking()
    
    @IBOutlet weak var mapKitView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapKitView.delegate = self
        
        getLocation()
        
    }
    
    func getCoordinateFromMap(for mapView: MKMapView) -> CLLocationCoordinate2D {
        
        let point = mapView.center
        let centerFrame = mapView.convert(point, toCoordinateFrom: mapView)
//        print("Center of frame coordinate: \(centerFrame)")

        return centerFrame
    }
    
    func getLocation() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
//            self.removeAnnotation()
            self.weatherPoint = self.getCoordinateFromMap(for: self.mapKitView)
//            print("WeatherPoint \(self.weatherPoint))")
            let placemark = self.weatherPoint
            
            let lat = placemark.latitude
            let lon = placemark.longitude
//            print("Coordinates \(lat) and \(lon)")
            self.getWeatherFromOW(lat, lon)
            
            if self.coordinates.count != 0 {
                let newAnnotation = self.coordinates.last
                
                let annotation = MKPointAnnotation()
                annotation.title = newAnnotation!.name
                annotation.subtitle = String(format: "%.2f", newAnnotation!.main.temp - 273.15)
                annotation.coordinate.latitude = newAnnotation!.coord.lat
                annotation.coordinate.longitude = newAnnotation!.coord.lon
                
//                print("This annotation coordinates: \(annotation.coordinate)")
                
                self.mapKitView.addAnnotation(annotation)
            }
            
        }
        
    }
    
    // MARK: - Send weather get request

    func getWeatherFromOW(_ latitude: Double, _ longitude: Double ) {
        
        let lat = latitude
        let lon = longitude
        
        DispatchQueue.global().async {
            self.getWeatherOW.loadWeather(lat, lon) { result in
                print("Result \(result)")
                switch result {
                case .success(let newPoint):
                    self.coordinates.append(newPoint)
//                    print("This newPoint: \(newPoint)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
//                print("This ARRAY coordinates[]: \(self.coordinates)")
            }
        
        }
        
    }
    
    //MARK: - Annotation
    
    func removeAnnotation() {
        let annotations = mapKitView.annotations
        if annotations.count != 0  {
            mapKitView.removeAnnotations(annotations)
        }
    }
    
    @IBAction func deletAnnotation(_ sender: Any) {
        removeAnnotation()
    }
  
}


extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "")
        }
        
        /*
        if annotation.title == "Here" {
            annotationView?.image = UIImage(named: "weather")
            annotationView?.frame.size = CGSize(width: 50, height: 50)
        } else {
            annotationView?.image = UIImage(named: "weather")
            annotationView?.frame.size = CGSize(width: 50, height: 50)
        }*/
        
        for i in 0..<coordinates.count {
            if annotation.title == coordinates[i].name {
                let image = coordinates[i].weather[0].icon
                annotationView?.image = UIImage(named: image)
                annotationView?.frame.size = CGSize(width: 80, height: 80)
            }
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
}
