//
//  NetworkManager.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/15.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 *  景点天气数据
 */
struct SpotWeatherData{
    //城市名
    let cityName:String?
    //时间
    let time:String?
    
    //最高温度
    let hTemp:String?
    //最低温度
    let lTemp:String?
    
    //天气
    let conditionD:String?
    let conditionDCode:Int?
    let conditionN:String?
    let conditionNCode:Int?
    
    //风向
    let windDirection:String?
    let windForce:String?
    //平均温度
    var avgTemp:String?{
        get{
            guard hTemp == nil else { return nil }
            guard lTemp == nil else { return nil }
            return String(Int(hTemp!)!+Int(lTemp!)!/2)
        }
    }
    //显示的时间
    var displayTime:String?{
        get{
            guard time != nil else { return nil }
            return time?.substringFromIndex(time!.endIndex.advancedBy(-5))
        }
    }
    /**
     从JSON初始化
     
     - parameter cityName:   城市名
     - parameter dayForcast: JSON
     
     - returns: 初始化
     */
    init(cityName:String,dayForcast:JSON){
        self.cityName = cityName
        time = dayForcast["date"].string
        
        //最高温度
        hTemp = dayForcast["tmp"]["max"].string
        //最低温度
        lTemp = dayForcast["tmp"]["min"].string
        
        //天气
        conditionD = dayForcast["cond"]["txt_d"].string
        //BUG:无法获取code
        conditionDCode = dayForcast["cond"]["code_d"].int
        conditionN = dayForcast["cond"]["txt_n"].string
        conditionNCode = dayForcast["cond"]["code_n"].int
        //风向
        windDirection = dayForcast["wind"]["dir"].string
        windForce = dayForcast["wind"]["sc"].string
    }
    
}

extension NetworkManager{
    /**
     获取天气数据
     
     - parameter url:         请求的URL
     - parameter apiKey:      apiKey
     - parameter cityID:      城市ID
     - parameter processData: 回调函数
     */
    class func getSpotWeatherDataWithUrl(url:NSURL = NetworkManager.spotURL,apiKey:String = NetworkManager.apikey,spotID:String,processData:([SpotWeatherData]?)->Void){
        var dataArray = [SpotWeatherData]()
    
        Alamofire.request(.GET, url, parameters: ["cityid":spotID], encoding: .URL , headers: ["apikey":apiKey]).responseJSON(){(result) in
            
            let JSONData = JSON(data: result.data!)
            //景点名
            let cityName = JSONData["HeWeather data service 3.0"][0]["basic"]["cnty"].string
            //每日数据数组
            let dailyForecast = JSONData["HeWeather data service 3.0"][0]["daily_forecast"].array
            
            //获取每日数据
            for(var i=0;i<dailyForecast!.count;i++){
                let dayForcast = dailyForecast![i]
                let tempData = SpotWeatherData(cityName: cityName!,dayForcast: dayForcast)
                dataArray.append(tempData)
            }
            //回调函数
            processData(dataArray)
        }
    }
    //函数结束
}