//
//  ComplicationController.swift
//  Sonos Watch Extension
//
//  Created by Philip Webster on 3/25/16.
//  Copyright © 2016 phil. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler(CLKComplicationTimeTravelDirections(rawValue: 0))
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        let sonos = SonosController()
        sonos.getVolume { (volume) in
            var entry : CLKComplicationTimelineEntry?

            if complication.family == .ModularSmall {
                let textProvider = CLKSimpleTextProvider(text: "\(volume!)%")
                let template = CLKComplicationTemplateModularSmallSimpleText()
                template.textProvider = textProvider
                entry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
                handler(entry)
                return
            }
            handler(nil)
        }
        
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
//        let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Circular")!)
//        let template = CLKComplicationTemplateCircularSmallSimpleImage()
        if complication.family == .ModularSmall {

        let textProvider = CLKSimpleTextProvider(text: "14%")
        let template = CLKComplicationTemplateModularSmallSimpleText()
        template.textProvider = textProvider
//        template.imageProvider = imageProvider
        handler(template)
            return
        }
        handler(nil)
    }
    
}
