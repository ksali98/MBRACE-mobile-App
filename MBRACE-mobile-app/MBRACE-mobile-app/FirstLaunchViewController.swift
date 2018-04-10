//
//  FirstLaunchViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class FirstLaunchViewController: UIViewController {

    // Class variables
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add button effects
        appUtils.addButtonFeatures(button: self.startButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startAction(_ sender: Any) {
        // Dispatches to setup settings view controller
        let settings = self.storyboard?.instantiateViewController(withIdentifier: "SetupViewController") as! SetupViewController
        self.present(settings, animated: true, completion: nil)
    }
}
