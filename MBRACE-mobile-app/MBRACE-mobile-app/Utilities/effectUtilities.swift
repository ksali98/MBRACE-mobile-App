//
//  frontend.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import Foundation
import UIKit

class EffectUtilities {
    /*
     A collection of front end effect utilities and elements used throughout the application
     
     A list of these elements include:
        - Button effect (Adds a rounded corner blue border to buttons)
        - Activity indicator (Allows a activity indicator with text to show while background processes are occuring)
        - Progress bar (Allows a progress bar with text to show while background downloads are occuring)
     
     Feel free to load up this class with other helpful front end effect elements that may be needed throughout the application
     */
    
    // Class attributes
    private var blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    private var blurEffectView: UIVisualEffectView = UIVisualEffectView()
    private var indicatorText: UILabel = UILabel()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var progressbar: UIProgressView = UIProgressView(progressViewStyle: .bar)
    
    func start_activity_indicator(view: UIView, text: String) {
        /* Method to start an activity indicator on the view passed to this method
         
         args:
            - view (UIView)
            - text (String)
         returns:
            - void
         */
        
        // Add blur effect attributes
        blurEffectView.effect = self.blurEffect
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set up text label attributes
        indicatorText.frame = CGRect(x: 0, y: (view.frame.size.height / 2) + 10, width: view.frame.size.width, height: 100)
        indicatorText.textAlignment = .center
        indicatorText.text = text
        indicatorText.textColor = UIColor.white
        indicatorText.font = UIFont(name: "Avenir", size: 20.0)
        indicatorText.backgroundColor = UIColor.clear
        
        // Set up activity indicator attributes
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        // Add all effects above as subviews in the view
        view.addSubview(blurEffectView)
        view.addSubview(indicatorText)
        view.addSubview(activityIndicator)
        
        // Start activity indicator and stop user interaction
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stop_activity_indicator() {
        /* Method to stop the current activity indicator going
         
         args:
            None
         returns:
            - void
         */
        
        // Stop the activity indicator
        activityIndicator.stopAnimating()
        
        // Remove activity indicator, text label, and blur from the view they are currently on
        activityIndicator.removeFromSuperview()
        indicatorText.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        
        // Resume user interaction
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func start_progress_bar(view: UIView, text: String) {
        /* Method to start a progress bar for download task, on the view passed to this method
         
         args:
            - view (UIView)
            - text (String)
         returns:
            - void
         */
        
        // Set up blur effect attributes
        blurEffectView.effect = self.blurEffect
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set up text label attributes
        indicatorText.frame = CGRect(x: 0, y: (view.frame.size.height / 2) + 10, width: view.frame.size.width, height: 100)
        indicatorText.textAlignment = .center
        indicatorText.text = text
        indicatorText.textColor = UIColor.white
        indicatorText.font = UIFont(name: "Avenir", size: 20.0)
        indicatorText.backgroundColor = UIColor.clear
        
        // Set up progress bar attributes
        progressbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: 3)
        progressbar.center = view.center
        progressbar.setProgress(0.0, animated: true)
        progressbar.trackTintColor = UIColor.lightGray
        progressbar.tintColor = UIColor.orange
        
        // Add all effects and progress bar to view as subviews
        view.addSubview(blurEffectView)
        view.addSubview(indicatorText)
        view.addSubview(progressbar)
        
        // Start ignoring user interaction
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stop_progress_bar() {
        /* Method to stop the current progress bar
         
         args:
            None
         returns:
            - void
         */
        
        // Remove progress bar, text, and effect from current view they are in
        progressbar.removeFromSuperview()
        indicatorText.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        
        // Resume user interaction
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func update_progress_bar(progress: Float) {
        /* Method to update the progress of the progress bar
         
         args:
            - progress (Float)
         returns:
            - void
         */
        
        // Create a percentage of the progress
        let percent = Int(progress * 100)
        
        // Update text label with percentage and update progress bar
        indicatorText.text = "Downloading: \(percent)% Complete"
        progressbar.setProgress(progress, animated: true)
    }
    
    func addButtonFeatures(button: UIButton) {
        /* Method to add button front end effects
         
         args:
            - button (UIButton)
         returns:
            - void
         */
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
    }
    
    func showDefaultAlertWithCloseAction(controller: UIViewController, title: String, message: String) {
        /* Method to show a default style alert controller
         
         args:
            - controller (UIViewController)
            - title (String)
            - message (String)
         returns:
            - void
         */
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(closeAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
