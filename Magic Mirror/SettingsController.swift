//
//  SettingsController.swift
//  Magic Mirror
//
//  Created by Hiltunen on 01/11/2018.
//  Copyright © 2018 Hiltunen. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var weatherApiKeyField: UITextField!
    @IBOutlet weak var defaultCityField: UITextField!
    @IBOutlet weak var numberOfDaysField: UITextField!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var newsApiKeyField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherApiKey = defaults.string(forKey: "weather_api_key")
        weatherApiKeyField.text = weatherApiKey
        
        let defaultCity = defaults.string(forKey: "weather_api_key")
        defaultCityField.text = defaultCity
        
        let newsApiKey = defaults.string(forKey: "news_api_key")
        newsApiKeyField.text = newsApiKey
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
