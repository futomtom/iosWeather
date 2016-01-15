//
//  NetworkManager.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/15.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation

/// 网络请求管理器
class NetworkManager{
    //请求的URL
    /// 景点
    class var spotURL:NSURL {
        return NSURL(string: "http://apis.baidu.com/heweather/pro/attractions")!
    }
    /// 城市
    class var cityUrl :NSURL {
        return NSURL(string:"http://apis.baidu.com/heweather/pro/weather")!
    }
    ///APIKey
    class var apikey:String {
       return "06dea2e9c620e7b3c23bac0fb7bdc5c5"
    }
    
    //城市ID
    var cityID = "suzhou"
    //景点ID
    let spotID = "CN10101010018A"
    
    //数据数组
    var dataArray = [SpotWeatherData]()
}