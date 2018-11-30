//
//  SettingsController.swift
//  Magic Mirror
//
//  Created by Hiltunen on 01/11/2018.
//  Copyright © 2018 Hiltunen. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var weatherApiKey: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
