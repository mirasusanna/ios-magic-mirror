//
//  ViewController.swift
//  Magic Mirror
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var departureTable: UITableView!
    
    var clockTimer: Timer?
    var weatherTimer: Timer?
    var transportTimer: Timer?
    var newsTimer: Timer?
    let weatherApiKey = "026305de7c21b8d0a42d6274bb5025b7"
    let newsApiKey = "9c52eb29685d4e8c873bcb2a18f56122"
    let clock = Clock()
    let weather = Weather()
    var departures: [String] = []
    var news: [String] = []
    
    // set Helsinki coordinates as default for weather
    var lat = 60.192059
    var lon = 24.945831
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersistenceManager.shared.saveContext()
        // Register settings
        Settings.shared.registerSettingsBundle()
        Settings.shared.updateDisplayFromDefaults()
        
        createUser()
        getUsers()
        
        // Update clock and date
        self.currentTime.text = "\(Helpers.getFormattedDate(day:clock.currentTime, format:"hh:mm"))"
        self.day.text = Helpers.getFormattedDate(day: Date(), format:"EEEE, MMM d")
        
        // Request access to location and update weather
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        getWeather(lat:lat, lon:lon)
        
        // Get weather forecasts
        Weather.shared.getCurrentWeather(lat: lat, lon: lon)
        Weather.shared.getWeatherForecast(lat: lat, lon: lon)
        
        // Get news
        getNews(newsCountry: "us")
        
        // Handle public transport schedules
        self.departures = Transportation.shared.getNextDepartures()
        departureTable.dataSource = self
        departureTable.delegate = self
        departureTable.register(UITableViewCell.self, forCellReuseIdentifier: "departureCell")
        
        // Update next departures once a minute
        transportTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.updateTransport), userInfo: nil, repeats: true)
        
        // Update news once every 30 minutes
        newsTimer = Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(self.updateNews), userInfo: nil, repeats: true)
        
        // Update clock every second
        clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimeLabel), userInfo: nil, repeats: true)
        
        // Update weather every hour
        weatherTimer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(updateWeather), userInfo: nil, repeats: true)
    }
    
    deinit {
        // Make sure timers aren't running forever or crash the app
        clockTimer?.invalidate()
        transportTimer?.invalidate()
        weatherTimer?.invalidate()
        newsTimer?.invalidate()
    }
    
    // Get location and update latitude and longitude accordingly
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        // Stop tracking location for preserving battery life
        self.locationManager.stopUpdatingLocation()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = departureTable.dequeueReusableCell(withIdentifier: "departureCell", for: indexPath)
        cell.textLabel?.text = self.departures[indexPath.item]
        return cell
    }
    
    // Update current time to the clock
    @objc func updateTimeLabel() {
        self.currentTime.text = Helpers.getFormattedDate(day: Date(), format: "hh:mm")
    }
    
    // Update weather information
    @objc func updateWeather() {
        getWeather(lat: lat, lon: lon)
    }
    
    // Update current time to the clock
    @objc func updateNews() {
        getNews(newsCountry: "us")
    }
    
    // Update public transportation info
    @objc func updateTransport() {
        self.departures = Transportation.shared.getNextDepartures()
        self.departureTable.reloadData()
        print(Transportation.shared.getNextDepartures())
    }
    
    func getWeather(lat:Double, lon:Double) {
        // Get weather data from Open Weather Map API and display data in the view
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(weatherApiKey)&units=metric").responseJSON {
            response in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                self.location.text = jsonResponse["name"].stringValue
                // change image
                self.weatherIcon.image = UIImage( named: iconName )
                self.condition.text = jsonResponse["main"].stringValue
                self.temperature.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
            }
        }
    }
    
    func getNews(newsCountry:String) {
        // Get latest headlines from News API
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=\(newsCountry)&pageSize=3&apiKey=\(newsApiKey)").responseJSON {
            response in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                for item in jsonResponse["articles"].arrayValue {
                    print(item["title"].stringValue)
                }
            }
        }
    }
    
    func createUser() {
        let user = User(context: PersistenceManager.shared.context)
        user.name = "Riku"
        PersistenceManager.shared.saveContext()
    }
    
    func getUsers() {
        let users = PersistenceManager.shared.fetch(User.self)
        users.forEach({ print($0.name) })
    }
}
