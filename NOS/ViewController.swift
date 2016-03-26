//
//  ViewController.swift
//  NOS
//
//  Created by Philip Webster on 3/23/16.
//  Copyright © 2016 phil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!

    let sonos = SonosController()

    var volume: Int = 5 {
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                self.volumeLabel.text = "\(self.volume)%"
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sonos.getVolume { (volume) in
            if volume != nil {
                self.volume = volume!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func downButtonTapped(sender: UIButton) {
        volume = volume - 1
        sonos.setVolume(volume)
    }
    
    @IBAction func upButtonTapped(sender: UIButton) {
        volume = volume + 1
        sonos.setVolume(volume)
    }

}

