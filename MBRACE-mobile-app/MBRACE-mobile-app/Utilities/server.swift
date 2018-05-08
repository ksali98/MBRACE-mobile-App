//
//  backend.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import Foundation
import UIKit

struct ServerInformation {
    /* Class for storing all server information needed for successful connection
     
     Please note:
        - Port = 0, means port has not been set
        - Port = -1, means port is not being used
        - If port is set to anything else, it is being used
     
     This convention is used so we can specify whether the user is using an hostname:port connection address or domain name connnection address.
     */
    var hostname = ""
    var port = 0
}

class ServerConnection {
    /* Class for managing url session data tasks to server
     
     This class is only used for creating http data request, not file download request. Helper methods can be added, similar to `getAvailableFileList` method when needed. View this method for scheming.
     */
    
    // Class attributes
    private var session = URLSession(configuration: .default)
    
    private func send_request(path: String, completion: @escaping (_ return_data: NSDictionary?) -> Void) {
        /* Method to send a http request for a specific path on the host
         
         args:
            - path (String)
            - completion (Function -> (return_data [NSDictionary]))
         returns:
            - void
         */
        
        // Initialize url
        var url = ""
        
        // Check if port has been set or not...set url depending on case
        if (serverInfo.port == -1 || serverInfo.port == 0) {
            url = "http://\(serverInfo.hostname)/\(path)"
        } else {
            url = "http://\(serverInfo.hostname):\(serverInfo.port)/\(path)"
        }
        let nsurl = URL(string: url)
        var urlRequest = URLRequest(url: nsurl!)
        
        // Set the content and acceptance types to json, so the server can recieve it as json.
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Start data task with url Request
        self.session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            // Check if error occured
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "Can't find error description")")
                completion(nil)
                return
            }
            
            // Check if data was successfully retrieved
            guard let data = data else {
                print("No data found in response.")
                completion(nil)
                return
            }
        
            do {
                // Try to convert json to NSDictionary
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                    completion(json)
                    return
                }
            } catch let error {
                // Error while converting to json
                print("Error converting to json: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }).resume()
    }
    
    func getFileDateRange(completion: @escaping (_ date_range: NSDictionary?) -> Void) {
        /* Method to get the date range of available files on the server
         
         args:
            - completion (Function -> (date_range [NSDictionary])
         returns:
            - void
         */
        let path = "/data_collector/get_file_date_range.php"
        self.send_request(path: path, completion: {(response: NSDictionary?) -> () in
            completion(response)
        })
    }
}
