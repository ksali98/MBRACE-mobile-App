//
//  SelectDateViewController.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/21/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController, UIPickerViewDelegate, URLSessionDelegate, URLSessionDownloadDelegate {
    /* View controller class to select a date from available dates, and download file from server corresponding to that date */
    
    // View controller outlets
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var viewGraphButton: UIButton!
    
    // Class attributes
    var progressview: UIProgressView!
    var selectedDate: Date!
    var availableDates: [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Date"
        
        // Add button features
        effectUtils.addButtonFeatures(button: self.viewGraphButton)
        
        // Connect date picker onValueChange method
        self.datepicker.addTarget(self, action: #selector(SelectDateViewController.selectedDateChanged(_:)), for: .valueChanged)
        self.datepicker.datePickerMode = .date
        
        // Get date range from server
        effectUtils.start_activity_indicator(view: (self.navigationController?.view)!, text: "Getting Available Dates")
        serverConn.getFileDateRange(completion: { date_range in
            DispatchQueue.main.async {
                effectUtils.stop_activity_indicator()
                if (date_range != nil) {
                    // Success
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    // Set max date for date picker
                    let maxDate = dateFormatter.date(from: date_range?.value(forKey: "max_date") as! String)
                    self.datepicker.maximumDate = maxDate
                    
                    // Set min date for date picker
                    let minDate = dateFormatter.date(from: date_range?.value(forKey: "min_date") as! String)
                    self.datepicker.minimumDate = minDate
                    
                    // Set current date to min date
                    self.datepicker.date = minDate!
                    self.selectedDate = minDate!
                } else {
                    // Error
                    let alertvc = UIAlertController(title: "Error", message: "Could not get available dates. Try again.", preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertvc.addAction(closeAction)
                    self.present(alertvc, animated: true, completion: nil)
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewGraphAction(_ sender: Any) {
        /* Method to view the graph for the currently selected date
         
         args:
            - sender (Any)
         returns:
            - void
         */
        
        // Set up date formatter to read from server
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        // Create file name for date
        let filename = "\(serverDataFilePrefix)_\(dateformatter.string(from: self.selectedDate)).csv"
        
        var url = ""
        if (serverInfo.port == 0 || serverInfo.port == -1) {
            url = "http://\(serverInfo.hostname)/data_collector/\(filename)"
        } else {
            url = "http://\(serverInfo.hostname)/data_collector/\(filename)"
        }
        let nsurl = URL(string: url)
        let urlRequest = URLRequest(url: nsurl!)
        
        // Create new session
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        // Start progress bar and download task
        effectUtils.start_progress_bar(view: (self.navigationController?.view)!, text: "Downloading data")
        let downloadTask = session.downloadTask(with: urlRequest)
        downloadTask.resume()
    }
    
    @objc func selectedDateChanged(_ picker: UIDatePicker) {
        /* Method to save the selected date when its changed
         
         args:
            - picker (UIDatePicker)
         returns:
            - void
         */
        self.selectedDate = picker.date
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        /* URLSession delegate method called when new data has been written
         
         args:
            - session (URLSession)
            - downloadTask (URLSessionDownloadTask)
            - bytesWritten (Int)
            - totalBytesWritten (Int)
            - totalBytesExpectedToWrite (Int)
         returns:
            - void
         */
        
        // Update progress bar for session progress
        DispatchQueue.main.async {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            effectUtils.update_progress_bar(progress: progress)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        /* URLSession delegate method called when task has completed with error
         
         args:
            - session (URLSession)
            - task (URLSessionTask)
            - error (Error)
         returns:
            - void
         */
        
        // Check if error has occurred
        DispatchQueue.main.async {
            effectUtils.stop_progress_bar()
            if error != nil {
                let alertvc = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alertvc.addAction(closeAction)
                self.present(alertvc, animated: true, completion: nil)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        /* URLSession delegate method called when a task has successfully downloaded the file
         
         args:
            - session (URLSession)
            - downloadTask (UTLSessionDownloadTask)
            - location (URL)
         returns:
            - void
         */
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsDirectoryURL.appendingPathComponent("tempdata.csv")
        
        // Check if file already exists at destination
        do {
            if FileManager.default.fileExists(atPath: destinationFileUrl.path) {
                try FileManager.default.removeItem(at: destinationFileUrl)
            }
        } catch let error {
            print("Error removing file: \(error.localizedDescription)")
        }
        
        // Try to copy file from temp location to destination url
        do {
            try FileManager.default.copyItem(at: location, to: destinationFileUrl)
        } catch let error {
            print("Error copying file: \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            effectUtils.stop_progress_bar()
            let selectObjectvc = self.storyboard?.instantiateViewController(withIdentifier: "SelectObjectViewController") as! SelectObjectViewController
            selectObjectvc.filepath = destinationFileUrl.path
            self.navigationController?.pushViewController(selectObjectvc, animated: true)
        }
    }
}
