//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Ya-chen Hsieh on 3/6/25.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forcastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
    @IBAction func didTapForwardButton(_ sender: UIButton) {
        selectedForecastIndex = min(forecasts.count - 1, selectedForecastIndex + 1) // don't go higher than the number of forecasts
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    private var forecasts = [WeatherForecast]() // track all the possible forecasts
    private var selectedForecastIndex = 0 //tracks with forecast is being shown, default to 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("New Location Updated!")
        
//       //Step5 start
//        let fakeData = WeatherForecast(weatherCode: .partlyCloudy, // match the oreder defined in WeatherForecast
//                                       temperature: 25.0,
//                                       date: Date())
//        configure(with:fakeData)
//        //Step5 end
        // Step6 start
        forecasts = createMockData()
        configure(with:forecasts[selectedForecastIndex])
        // step6 end
    }
    
//    //Step5 start
//    private func configure(with forecast: WeatherForecast){
//        descriptionLabel.text = forecast.weatherCode.description
//        forcastImageView.image = forecast.weatherCode.image
//        temperatureLabel.text = "\(forecast.temperature)"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM d, yyyy"
//        dateLabel.text = dateFormatter.string(from: forecast.date)
//    //Step5 end
    // Returns an array of fake WeatherForecast data models to show
    private func createMockData() -> [WeatherForecast] {
        // This is just using the Calendar API to get a few random dates
        let today = Date()
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)! // Calendar.current -> get current calandar System. && .date can also .year .month ...
        let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
        // Create a few mock data to show
        let mockData1 = WeatherForecast(
                                        weatherCode: .violentRainShowers,
                                        precipitation: 33.3,
                                        windSpeed: 3.3,
                                        temperature: 59.5,
                                        date:today)
        let mockData2 = WeatherForecast(
                                        weatherCode: .fog,
                                        precipitation: 13.3,
                                        windSpeed: 3.7,
                                        temperature: 65.5,
                                        date: tomorrow)
        let mockData3 = WeatherForecast(
                                        weatherCode: .partlyCloudy,
                                        precipitation: 23.3,
                                        windSpeed: 2.8,
                                        temperature: 49.5,
                                        date: dayAfterTomorrow)
        return [mockData1, mockData2, mockData3]
    }
    
    private func configure(with forecast: WeatherForecast) {
        descriptionLabel.text = forecast.weatherCode.description
        forcastImageView.image = forecast.weatherCode.image
        temperatureLabel.text = "\(forecast.temperature)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: forecast.date)
        // Comment these out temporarily until we fix the connections
         windSpeedLabel.text = "Wind Speed: \(forecast.windSpeed) mph"
         precipitationLabel.text = "Precipitation: \(Int(forecast.precipitation))%"
    }
}
