//
//  SonosController.swift
//  NOS
//
//  Created by Philip Webster on 3/24/16.
//  Copyright © 2016 phil. All rights reserved.
//

import UIKit

class SonosController: NSObject, NSXMLParserDelegate {
    var parsingVolume = false
    var parsedVolume: Int = 0

    func getVolume(completionHandler: (volume: Int?) -> ()) {
        let components = NSURLComponents(string: "http://10.0.1.2:1400/MediaRenderer/RenderingControl/Control")
        let request = NSMutableURLRequest(URL: (components?.URL)!)
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "CONTENT-TYPE")
        request.addValue("urn:schemas-upnp-org:service:RenderingControl:1#GetVolume", forHTTPHeaderField: "SOAPACTION")
        request.HTTPMethod = "POST"
        
        let postString = "<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:GetVolume xmlns:u=\"urn:schemas-upnp-org:service:RenderingControl:1\"><InstanceID>0</InstanceID><Channel>Master</Channel></u:GetVolume></s:Body></s:Envelope>"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if data == nil {
                print("empty response")
                return
            }

            let xmlParser = NSXMLParser(data: data!)
            xmlParser.delegate = self
            xmlParser.parse()
            
            completionHandler(volume: self.parsedVolume)
            }.resume()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {

        if elementName == "CurrentVolume" {
            parsingVolume = true
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if parsingVolume {
            parsedVolume = Int(string)!
            parsingVolume = false
        }
    }
    
    func setVolume(volume: Int) {
        let components = NSURLComponents(string: "http://10.0.1.2:1400/MediaRenderer/RenderingControl/Control")
        let request = NSMutableURLRequest(URL: (components?.URL)!)

        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "CONTENT-TYPE")
        request.addValue("urn:schemas-upnp-org:service:RenderingControl:1#SetVolume", forHTTPHeaderField: "SOAPACTION")
        request.HTTPMethod = "POST"
        
        let postString = "<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:SetVolume xmlns:u=\"urn:schemas-upnp-org:service:RenderingControl:1\"><InstanceID>0</InstanceID><Channel>Master</Channel><DesiredVolume>\(volume)</DesiredVolume></u:SetVolume></s:Body></s:Envelope>"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in

            }.resume()
        
    }
}
