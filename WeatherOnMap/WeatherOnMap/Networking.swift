//
//  Networking.swift
//  WeatherOnMap
//
//  Created by Igor on 07/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import Foundation

class Networking {
    
    public func loadWeather(_ lat: Double, _ lon: Double, completion: ((Swift.Result<PointCoordinats, Error>) -> Void)? = nil) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "APPID", value: "5c1e4eb39849b5315ae8376ba2a8a44e")
        ]
        
        guard let url = urlComponents.url else { fatalError("URL is badly formatted.")}
//        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        let session = URLSession(configuration: configuration)
        
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
//            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)

//            print(json ?? "")
//            print(data)

            let decoder = JSONDecoder()
            
            do {
                let weather = try decoder.decode(PointCoordinats.self, from: data)
                completion?(Result.success(weather))
//                print("This do print \(weather)")
            } catch {
                completion?(Result.failure(error))
//                print("This error print \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
}
