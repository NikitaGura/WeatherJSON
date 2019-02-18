//
//  ViewController.swift
//  WeatherJSON
//
//  Created by Nikita Gura on 26.11.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
   
    //MARK: outlets
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelDegre: UILabel!
    @IBOutlet weak var pressuerLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
       self.viewWillAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.alpha = 0.6
        }
        
        loadJSON()
        
    }

    

    //MARK: - method
    
    func loadJSON(){
        let sj = ServiceJSON(URL: url, APIKey: key, city: city)
        sj.getJSON { (jsonDictionary) in
            if let currentWeatherDictionary = jsonDictionary?["main"] as?
                [String : Any]{
                let cw = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                DispatchQueue.main.async {
                if let t = cw.temp{
                        self.labelDegre.text = String(format:"%.0f", t) + "˚"
                        self.labelCity.text =  city
                    }
                    self.humidityLabel.text = "Humidity: " + String(format:"%.0f", cw.humidity ?? 0)
                    self.pressuerLabel.text = "Pressuer: " + String(format:"%.0f", cw.pressuer ?? 0)
                }
                
            }
        }
        
    }

}

