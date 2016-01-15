//
//  CommonTool.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/30.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation
func getDateFromString(str:String?,template:String = "yyyy-MM-dd HH:mm")->NSDate?{
    let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = template
        dateFormatter.locale = NSLocale(localeIdentifier: "ch_zn")
    if str == nil {
        return nil
    }
    return dateFormatter.dateFromString(str!)
}

func convertDate(date:NSDate?,template:String = "yyyy-MM-dd HH:mm")->String?{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = template
    dateFormatter.locale = NSLocale(localeIdentifier: "ch_zn")
    if date == nil {
        return nil
    }
    return dateFormatter.stringFromDate(date!)
}


