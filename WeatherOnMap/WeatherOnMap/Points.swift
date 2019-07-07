//
//  Points.swift
//  WeatherOnMap
//
//  Created by Igor on 07/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import Foundation

struct PointCoordinats: Codable {
    var base: String
    var clouds: Clouds
    var cod: Int
    var coord: Coord
    var dt: Int
    var id: Int?
    var main: Temperatyre
    var name: String
    var sys: Sys
    var timezone: Int
    var visibility: Int?
    var weather: [Weather]
    var wind: Wind
}

struct Clouds: Codable {
    var all: Int
}

struct Coord: Codable {
    var lat: Double
    var lon: Double
}

struct Temperatyre: Codable {
    var humidity: Int
    var pressure: Double
    var temp: Double
    var tempMax: Double
    var tempMin: Double
    
    enum CodingKeys: String, CodingKey {
        case humidity
        case pressure
        case temp
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}

struct Sys: Codable {
    var country: String
    var id: Int?
    var message: Double
    var sunrise: Int
    var sunset: Int
    var type: Int?
}

struct Weather: Codable {
    var description: String
    var icon: String
    var id: Int
    var main: String
}

struct Wind: Codable {
    var deg: Double?
    var speed: Double
}

/*
 − 273,15
 
base = stations;
clouds = {
            all = 75;
        };
cod = 200;
coord =     {
            lat = "55.59";
            lon = "37.65";
                };
dt = 1562516340;
id = 541406;
main =     {
    humidity = 67;
    pressure = 1001;
    temp = "290.95";
    "temp_max" = "292.15";
    "temp_min" = "289.15";
};
name = "Biryul\U00ebvo Zapadnoye";
sys =     {
    country = RU;
    id = 9029;
    message = "0.008800000000000001";
    sunrise = 1562460959;
    sunset = 1562523126;
    type = 1;
};
timezone = 10800;
visibility = 10000;
weather =     (
    {
        description = "broken clouds";
        icon = 04d;
        id = 803;
        main = Clouds;
    }
*/
