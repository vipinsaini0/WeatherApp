//
//  APIService.swift
//  WeatherApp
//
//  Created by Vipin Saini on 21/05/22.
//


import Foundation
import Alamofire

protocol APIServiceProtocol {
    // Live
    func fetchWeather(lat: String, long: String, complete: @escaping ( _ success: Bool, _ allDeliveryList: WeatherBaseModel?, _ error: Error? )->() )
    
    // Offline
    func fetchOfflineWeather(complete: @escaping ( _ success: Bool, _ allDeliveryList: WeatherBaseModel?, _ error: Error? )->() )
}


class APIService: APIServiceProtocol {
    
// MARK: - Weather fetch Live Data
    func fetchWeather(lat: String,
                      long: String,
                      complete: @escaping ( _ success: Bool,
                                            _ allDeliveryList: WeatherBaseModel?,
                                            _ error: Error? )->() ) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=553626bed26b25f56af0d6fa3890d1c5&units=Metric"
        
        let request = self.setRequest(requestType: "GET", components: URLComponents(string: url)!)
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 60
        AF.request(request as URLRequestConvertible).responseJSON() { response in
            switch response.result {
                case .success :
                    if let serviceMap = try? JSONDecoder().decode(WeatherBaseModel.self, from: response.data!) {
                        complete( true, (serviceMap), nil )
                    } else {
                        complete( false, nil, nil )
                    }
                case .failure(let error):
                    print("error_Weather:-", error)
                    complete( false, nil, nil )
            }
        }
        .cURLDescription { description in
            print("API_cURLDescription:- ", description)
        }
    }
    
// MARK: - Weather fetch Offline Data
    func fetchOfflineWeather(complete: @escaping ( _ success: Bool, _ allDeliveryList: WeatherBaseModel?, _ error: Error? )->() ) {
        
        if let localData = self.readLocalFile(forName: "weatherData") {
            let tasks = self.parse(jsonData: localData)
            print("fetchOfflineWeather")
            if tasks != nil {
                complete( true, (tasks)!, nil )
            } else {
                complete( false, nil, nil )
            }
        }
    } 
}

extension APIService {
    
    func setRequest(requestType: String, components: URLComponents) -> URLRequest {
        var request = URLRequest(url: components.url!)
        request.httpMethod = requestType
        return request
    }
    
    internal func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    internal func parse(jsonData: Data) -> WeatherBaseModel? {
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            let data = (jsonResponse as! [String: Any])
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let weatherData = try JSONDecoder().decode(WeatherBaseModel.self, from: jsonData)
             
            return weatherData
        } catch {
            print("parse decode error")
            return nil
        }
    }
}
