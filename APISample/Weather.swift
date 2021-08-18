//
//  Weather.swift
//  APISample
//
//  Created by Viet Le on 18/08/2021.
//

import Foundation
import UIKit

class Weather {
    var lon = ""
    var lat = ""
    var clouds = ""
    
    init(data: [String: Any]) {
        if let coordJson = data["coord"] as? [String: Any] {
            if let lon = coordJson["lon"] as? CGFloat, let lat = coordJson["lat"] as? CGFloat {
                self.lon = "\(lon)"
                self.lat = "\(lat)"
            }
            
        }
        
        if let cloudsJson = data["clouds"] as? [String: Any] {
            if let clouds = cloudsJson["all"] as? Int {
                self.clouds = "\(clouds)"
            }
        }
    }
}
