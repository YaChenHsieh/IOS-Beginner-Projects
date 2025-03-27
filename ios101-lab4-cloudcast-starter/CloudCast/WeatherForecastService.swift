//
//  WeatherForecastService.swift
//  CloudCast
//
//  Created by Ya-chen Hsieh on 3/20/25.
//
// WeatherForecastService.swift -> responsible for API requesting
// CurrentWeatherForecast.swift -> store the return weather API info

import Foundation // for req for web service, json processing and URLSession to send API request

class WeatherForecastService { // create a class for requesting weather inforamtion
    static func fetchForecast(latitude: Double, // static->can get the data directly, no need to make instance first
                              longitude: Double,
                              completion: ((CurrentWeatherForecast) -> Void)? = nil) { //(? = nil) selectable closeure
        // CurrentWeatherForecast -> a struct to store API return value
        let parameters = "latitude=\(latitude)&longitude=\(longitude)&current_weather=true&temperature_unit=fahrenheit&timezone=auto&windspeed_unit=mph"
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?\(parameters)")!
        
        // create API req
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // make sure no error
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            
            // decode API request
            let decoder = JSONDecoder() // auto decode JSON to Swift struct
//            let forecast = parse(data: data)
//            // this response will be used to change the UI, so it must happen on the main thread
//            DispatchQueue.main.async {
//                completion?(forecast) // call the completion closure and pass in the forecast data model
//            }
            let response = try! decoder.decode(WeatherAPIResponse.self, from: data)
            //WeatherAPIResponse.self -> tell Swift to decode to WeatherAPIResponse this struct
            // from: data -> returned JSON info from API
            // Swift will automaticaly transfer JSON to WeatherAPIResponse struct
            
            DispatchQueue.main.async {
              completion?(response.currentWeather)
            }
        }//let task
        
        
        task.resume() // Start API req
    }
    
    private static func parse(data: Data) -> CurrentWeatherForecast {
        // transform the data we received into a dictionary [String: Any]
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let currentWeather = jsonDictionary["current_weather"] as! [String: Any]
        // wind speed
        let windSpeed = currentWeather["windspeed"] as! Double
        // wind direction
        let windDirection = currentWeather["winddirection"] as! Double
        // temperature
        let temperature = currentWeather["temperature"] as! Double
        // weather code
        let weatherCodeRaw = currentWeather["weathercode"] as! Int
        return CurrentWeatherForecast(windSpeed: windSpeed,
                                      windDirection: windDirection,
                                      temperature: temperature,
                                      weatherCodeRaw: weatherCodeRaw)
      }
    
    
}
    
    

    
