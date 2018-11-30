//
//  Settings.swift
//  Magic Mirror
//
//  This handles settings bundle. I have no idea if this a proper way to do this but "it works"
//

import Foundation

class Settings {
    static let shared = Settings()
    
    // Register the settings
    func registerSettingsBundle() {
        let appDefaults = ["weather_api_key": "026305de7c21b8d0a42d6274bb5025b7"]
        
        UserDefaults.standard.register(defaults: appDefaults)
        UserDefaults.standard.synchronize()
        print("REGISTERED SETTINGS BUNDLE")
    }
    
    func updateDisplayFromDefaults(){
        //Get the defaults
        let defaults = UserDefaults.standard
        let asd = defaults.string(forKey: "weather_api_key")
        print("DEFAULT BUNDLE")
        print(asd)
    }

}
