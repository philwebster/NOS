//
//  InterfaceController.swift
//  Sonos Watch Extension
//
//  Created by Philip Webster on 3/25/16.
//  Copyright © 2016 phil. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var volumeLabel: WKInterfaceLabel!
    @IBOutlet var volumeSlider: WKInterfaceSlider!
    let sonos = SonosController()
    
    var volume = 0 {
        didSet {
            volumeSlider.setValue(Float(volume))
            dispatch_async(dispatch_get_main_queue()) { 
                self.volumeLabel.setText("\(self.volume)%")
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        sonos.getVolume { (volume) in
            self.volume = volume!
        }
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func volumeChanged(value: Float) {
        sonos.setVolume(Int(value))
        volume = Int(value)
    }
}
