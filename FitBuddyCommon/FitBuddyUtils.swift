//
//  FitBuddyUtils.swift
//  FitBuddy
//
//  Created by john.neyer on 5/7/15.
//  Copyright (c) 2015 jneyer.com. All rights reserved.
//

import Foundation


public class FitBuddyUtils {
    
    static var me : FitBuddyUtils?
    
    public static func defaultUtils() -> FitBuddyUtils {
        
        if  me == nil {
            me = FitBuddyUtils()
        }
        return me!
    }
    
    public static func dateFromNSDate (date: NSDate?, format: String) -> String {
        
        if date != nil {
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = format
            
            return dateFormatter.stringFromDate(date!)
            
        }
        
        return ""
    }
    
    public static func shortDateFromNSDate (date: NSDate?) -> String {
        
        if date != nil {
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            
            return dateFormatter.stringFromDate(date!)
            
        }
        
        return ""
    }
    
    lazy public var sharedUserDefaults: NSUserDefaults? = {
        let defaults = NSUserDefaults(suiteName: FBConstants.kGROUPPATH)
        return defaults!
        }()
    
    public static func twoDecimalFormat(number: NSNumber?) -> String? {
        
        if number != nil {
            
            let twodec = String(format: "%.2f", number!.floatValue)
            let newval = NSString(string: twodec).floatValue * 1.0
            return NSNumber(float: newval).stringValue
        }
        
        return nil
    }
    
    public static func calculateDistance(pace: Float, minutes: Float) -> Float {
        if minutes > 0 {
            let value = pace * (minutes / 60.0)
            let str = NSString(format: "%.2f", value)
            return str.floatValue
        }
        
        return 0
    }
    
    public static func calculatePace(distance: Float, minutes: Float) -> Float {
        
        if minutes > 0 {
            let value = distance / (minutes / 60.0)
            let str = NSString(format: "%.2f", value)
            return str.floatValue
        }
        
        return 0
    }
    
    public static func calculateMinutes(pace: Float, distance:Float) -> Float {
        
        if (pace > 0) {
            let value = (distance / pace) * 60.0
            let str = NSString(format: "%.2f", value)
            return str.floatValue
        }
        
        return 0
    }
    
    public static func isCloudOn() -> Bool {
        return FitBuddyUtils.getDefault(FBConstants.kUSEICLOUDKEY) == FBConstants.kYES
    }
    
    public static func setCloudOn(value: Bool) {
        FitBuddyUtils.setDefault(FBConstants.kUSEICLOUDKEY, value: value ? FBConstants.kYES : FBConstants.kNO)
        FitBuddyUtils.saveDefaults()
    }
    
    public static func setDefault(key: String, value: String) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: key)
        FitBuddyUtils.defaultUtils().sharedUserDefaults!.setValue(value, forKey: key)
    }
    
    public static func getDefault(key: String) -> String? {
        if let value = NSUserDefaults.standardUserDefaults().stringForKey(key) {
            return value
        }
        return FitBuddyUtils.defaultUtils().sharedUserDefaults!.stringForKey(key)
    }
    
    public static func saveDefaults () {
        NSUserDefaults.standardUserDefaults().synchronize()
        FitBuddyUtils.defaultUtils().sharedUserDefaults!.synchronize()
    }
}