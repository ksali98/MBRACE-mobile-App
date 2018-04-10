//
//  backend.swift
//  MBRACE-mobile-app
//
//  Created by Dev on 4/9/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import Foundation

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
