//
//  SonosController.swift
//  NOS
//
//  Created by Philip Webster on 3/24/16.
//  Copyright © 2016 phil. All rights reserved.
//

import UIKit

class SonosController: NSObject {
    
    func setVolume(volume: Int) {
        let components = NSURLComponents(string: "http://10.0.1.2:1400/MediaRenderer/RenderingControl/Control")
        let request = NSMutableURLRequest(URL: (components?.URL)!)

        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "CONTENT-TYPE")
        request.addValue("urn:schemas-upnp-org:service:RenderingControl:1#SetVolume", forHTTPHeaderField: "SOAPACTION")
        request.HTTPMethod = "POST"
        
        let postString = "<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:SetVolume xmlns:u=\"urn:schemas-upnp-org:service:RenderingControl:1\"><InstanceID>0</InstanceID><Channel>Master</Channel><DesiredVolume>\(volume)</DesiredVolume></u:SetVolume></s:Body></s:Envelope>"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        print("post: \(request)")
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            print("response: \(response)")
        }.resume()
        
    }
}
