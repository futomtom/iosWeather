//
//  TodayExtensionData.swift
//  SherryWeather
//
//  Created by xiaolei on 15/12/29.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation
class TodayExtensionData{
    class func insertDataToTodayExtension(weather:CityWeatherData){
        
        let userDefault = NSUserDefaults(suiteName: "group.net.dowhile.SherryWeather")
//        使用NS User Defaults 来存储数据。
        
        //当前概况
        let currentOverview = weather.now?.condition?.txt
        //pm2.5
        let pm25            = weather.airCondition?.pm25
        //空气质量
        let airQuality      = weather.airCondition?.quality
        
        //今日概况
        let todayOver       = weather.dailyForecast[0].dailyCondition?.txt_d
        //今日预警
        let todaycaveat     = weather.alarm
        //今日建议
        let todaysugg       = weather.suggestion["comf"]

        //明日概况
        let tromOver        = weather.dailyForecast[1].dailyCondition?.txt_d
        //明日预警
        let tromCaveat      = ""
        //明日建议
        let tromSugg        = ""
        
        userDefault?.setValue(currentOverview, forKey: "currentOverview")
        userDefault?.setValue(pm25, forKey: "pm25")
        userDefault?.setValue(airQuality, forKey: "airQuality")
        userDefault?.setValue(todayOver, forKey: "todayOver")
        userDefault?.setValue(todaycaveat as? AnyObject, forKey: "todaycaveat")
        userDefault?.setValue(todaysugg as? AnyObject, forKey: "todaysugg")
        userDefault?.setValue(tromOver, forKey: "tromOver")
        userDefault?.setValue(tromCaveat, forKey: "tromCaveat")
        userDefault?.setValue(tromSugg, forKey: "tromSugg")
        //及时把数据写入到磁盘中
        userDefault?.synchronize()
  
    }
}