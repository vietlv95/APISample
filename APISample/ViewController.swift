//
//  ViewController.swift
//  APISample
//
//  Created by Viet Le on 18/08/2021.
//

import UIKit
import Alamofire
import ProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func currentWeatherButtonDidTap(_ sender: Any) {
        testWithAlamofire(city: "hanoi", appid: "2709af9ee3a443c96e5c8a30ac695658")
    }
    
    func testWithAlamofire(city: String, appid: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather"
        let params: [String:Any] = ["q": city, "appid": appid]
        ProgressHUD.show()
        AF.request(urlString, parameters: params).responseJSON { response in
            if let data = response.data {
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let weather = Weather.init(data: responseJSON)
                    self.latLabel.text = "lat = " + weather.lat
                    self.lonLabel.text = "long = " + weather.lon
                    self.cloudsLabel.text = "clouds = " + weather.clouds
                }
                ProgressHUD.dismiss()
            }
        }
    }
        
    func testPostWithAlamofire(){
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "3e7f8cb028mshe045b87845bd6cep1794dfjsn7dbb90b9b555",
            "x-rapidapi-host": "adduser2.p.rapidapi.com",
            "content-type": "application/json"
        ]
        let parameters = [
            "name": "value",
            "phone": "value"
        ] as [String : Any]
        
        let urlString = "https://adduser2.p.rapidapi.com/"
        AF.request(urlString, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            if let data = response.data, let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
            }
        }
    }
    
    func testPostMethod() {
        let headers = [
            "x-rapidapi-key": "3e7f8cb028mshe045b87845bd6cep1794dfjsn7dbb90b9b555",
            "x-rapidapi-host": "adduser2.p.rapidapi.com",
            "content-type": "application/json"
        ]
        
        let parameters = [
            "name": "value",
            "phone": "value"
        ] as [String : Any]

        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://adduser2.p.rapidapi.com/")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as? Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let data = data {
                    if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(responseJSON)
                    }
                }
            }
        })

        dataTask.resume()
    }
    
    func testAPI(city: String, appid: String) {
        var urlString = "https://api.openweathermap.org/data/2.5/weather"
        urlString += "?"
        urlString += "q=\(city)"
        urlString += "&"
        urlString += "appid=\(appid)"
        let url = URL.init(string: urlString)
        var request = URLRequest.init(url: url!)
        
        //ProgressHud.show
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(responseJSON)
                }
                DispatchQueue.main.async {
                    self.view.backgroundColor = .yellow
                }
            }
        }
        task.resume()
    }
}

