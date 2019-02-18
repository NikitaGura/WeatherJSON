//
//  ServiceJSON.swift
//  WeatherJSON
//
//  Created by Nikita Gura on 27.11.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import Foundation

final class ServiceJSON{
    
    private let url: String
    private let APIKey: String
    private let city: String
    
    typealias JSONDictionaryHandler = (([String : Any]?) -> Void)
    
    init(URL: String, APIKey: String, city: String){
        self.url = URL
        self.APIKey = APIKey
        self.city = city
        }
   
    public func getJSON(_ completion: @escaping JSONDictionaryHandler){
        guard let url = URL(string: self.url+city+APIKey)  else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse?.statusCode)
            guard let data = data else {return}
            do{
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                completion(jsonDictionary as? [String : Any])
                
            }catch let jsonErr{
                print("Error serilizing json: ", jsonErr)
            }
        }.resume()
    }
}
