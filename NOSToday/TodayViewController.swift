//
//  TodayViewController.swift
//  NOSToday
//
//  Created by Philip Webster on 3/24/16.
//  Copyright © 2016 phil. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
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
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
}
