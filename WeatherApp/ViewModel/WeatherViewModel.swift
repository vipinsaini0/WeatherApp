//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Vipin Saini on 21/05/22.
//


import Foundation
import UIKit

class WeatherViewModel {
    
    let apiService: APIServiceProtocol
    
    private var weatherList: [WeatherList] = [WeatherList]()
    
    private var weatherCity: WeatherCity?
    
    
    private var cellViewModels: [[WeatherListCellViewModel]] = [[WeatherListCellViewModel]]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    // Void closure
    var reloadTableViewClosure: (() -> ())?
    var showAlertClosure: (() -> () )?
    var updateLoadingStatus: (() -> ())?
    
    
    
    // MARK: - Init
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - Fetch Online Data
    
    func initFetchWeather(lat: String, long: String) {
        self.isLoading = true
        apiService.fetchWeather(lat: lat, long: long) { [weak self] (success, results, error) in
            if success {
                self?.isLoading = false
                if let error = error {
                    self?.alertMessage = error.localizedDescription
                } else {
                    print(results as Any)
                    
                        // Bind Weather list data
                    if let list = results?.list {
                        self?.processFetchedHospital(weatherList: list)
                    }
                    
                        // Bind City data
                    if let city = results?.city {
                        self?.weatherCity = city
                    }
                }
            } else {
                self?.alertMessage = "Something went wrong"
            }
        }
    }
    
    // MARK: - Fetch Offline Data
    
    func initFetchOfflineWeather() {
        self.isLoading = true
        apiService.fetchOfflineWeather { [weak self] (success, results, error) in
            
            if success {
                self?.isLoading = false
                if let error = error {
                    self?.alertMessage = error.localizedDescription
                } else {
                        // Bind Weather list data
                    if let list = results?.list {
                        self?.processFetchedHospital(weatherList: list)
                    }
                    
                        // Bind City data
                    if let city = results?.city {
                        self?.weatherCity = city
                    }
                }
            } else {
                self?.alertMessage = "Something went wrong"
            }
        }
    }
    
    // City details
    func getCityViewModel() -> WeatherCity {
        return self.weatherCity ?? WeatherCity(id: 792680,
                                               name: "Belgrade",
                                               coord: nil,
                                               country: "RS",
                                               population: 1273651,
                                               timezone: 7200,
                                               sunrise: 1653102236,
                                               sunset: 1653156348)
    }
    
//    selected section data
    func getCellViewModel( at indexPath: IndexPath ) -> [WeatherListCellViewModel] {
   
        return cellViewModels[indexPath.item]
    }
    
    // Adding data in new weather list model
    func createCellViewModel( weather: WeatherList ) -> WeatherListCellViewModel {
        let weatherDate = helper.convertDateFromTimestamp(timeStamp: weather.dt)
        
        return WeatherListCellViewModel(weatherDate: weatherDate,
                                        dt: weather.dt,
                                        main: weather.main,
                                        weather: weather.weather,
                                        clouds: weather.clouds,
                                        wind: weather.wind,
                                        visibility: weather.visibility,
                                        pop: weather.pop,
                                        sys: weather.sys,
                                        dtTxt: weather.dtTxt,
                                        rain: weather.rain)
    }
    
    // Bind api responce in model
    private func processFetchedHospital( weatherList: [WeatherList] ) {
        self.weatherList = weatherList
        var vms = [WeatherListCellViewModel]()
        for weather in weatherList {
            vms.append( createCellViewModel(weather: weather) )
        }
        
        let groupWeatherList = Dictionary(grouping: vms, by: {$0.weatherDate})
            .values
            .sorted(by: { $0[0].dt < $1[0].dt })
        
        self.cellViewModels = groupWeatherList
    }
}
 
struct WeatherListCellViewModel: Equatable {
    static func == (lhs: WeatherListCellViewModel, rhs: WeatherListCellViewModel) -> Bool {
       return lhs.weatherDate == rhs.weatherDate
    }
    
    let weatherDate: Date
    let dt: Int
    let main: WeatherMain?
    let weather: [Weather]?
    let clouds: WeatherClouds?
    let wind: WeatherWind?
    let visibility: Int?
    let pop: Double?
    let sys: WeatherSys?
    let dtTxt: String?
    let rain: WeatherRain?
}
 
