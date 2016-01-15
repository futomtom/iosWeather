//
//  CityWeather.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/15.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//enum AlarmType:StringLiteralConvertible{
//    init(unicodeScalarLiteral value: Self.UnicodeScalarLiteralType) {
//
//    }
//}


/**
 *  警报
 */
struct Alarm {
    let level:String?  //预警等级
    let stat:String?  //预警状态
    let title:String?  //预警信息标题
    let txt:String?  //预警信息详情
    let type:String?  //预警天气类型
    
    init(alarm:[String:JSON]){
        self.level = alarm["level"]?.string  //预警等级
        self.stat = alarm["stat"]?.string  //预警状态
        self.title = alarm["title"]?.string  //预警信息标题
        self.txt = alarm["txt"]?.string  //预警信息详情
        self.type = alarm["type"]?.string  //预警天气类型
    }
}

/**
 *  请求时间
 */
struct time {
    let loc:String?  //当地时间，如无特殊说明，以下时间均为当地时间
    let utc:String? //UTC时间
    init(time:[String:JSON]){
        self.loc = time["loc"]?.string
        self.utc = time["utc"]?.string
    }
}

/**
 *  基本信息
 */
struct BasicInfo {
    let city:String?  //城市名称
    let cnty:String?  //国家
    let id:String?  //城市ID，所有城市ID请参见 http://www.heweather.com/documents/cn-city-list
    let lat:String?  //城市纬度
    let lon:String?  //城市经度
    let update:time?
    
    init(basicInfo:[String:JSON]){
        self.city = basicInfo["city"]?.string
        self.cnty = basicInfo["cnty"]?.string
        self.id = basicInfo["id"]?.string
        self.lat = basicInfo["lat"]?.string
        self.lon = basicInfo["lon"]?.string
        self.update = time(time: (basicInfo["update"]?.dictionary)!)
    }
}

/**
 *  空气质量
 */
struct AirCondition {
    ///空气质量指数
    let airQualityIndex:String?
    ///一氧化碳1小时平均值(ug/m³)
    let co:String?
    ///二氧化氮1小时平均值(ug/m³)
    let no2:String?
    ///臭氧1小时平均值(ug/m³)
    let o3:String?
    ///PM10 1小时平均值(ug/m³)
    let pm10:String?
    ///PM2.5 1小时平均值(ug/m³)
    let pm25:String?
    ///空气质量类别
    let quality:String?
    ///二氧化硫1小时平均值(ug/m³)
    let so2:String?
    init(airCondition:[String:JSON]){
        self.airQualityIndex = airCondition["aqi"]?.string
        self.co = airCondition["co"]?.string
        self.no2 = airCondition["no2"]?.string
        self.o3 = airCondition["o3"]?.string
        self.pm10 = airCondition["pm10"]?.string
        self.pm25 = airCondition["pm25"]?.string
        self.quality = airCondition["qlty"]?.string
        self.so2 = airCondition["so2"]?.string
    }
}

/**
 *  简要情况
 */
struct minWeatherCondition {
    let code:String?  //天气状况代码，所有天气代码和中英文对照以及图标请参见http://www.heweather.com/documents/condition-code
    let txt:String? //天气状况描述
    init(minWeatherCondition:[String:JSON]){
        self.code = minWeatherCondition["code"]?.string
        self.txt = minWeatherCondition["txt"]?.string
    }
}

/**
*  风
*/
struct Wind {
    let deg:String? //风向（360度）
    let dir:String?  //风向
    let sc:String?  //风力
    let spd:String? //风速（kmph）
    init(wind:[String:JSON]){
        self.deg = wind["deg"]?.string
        self.dir = wind["dir"]?.string
        self.sc = wind["sc"]?.string
        self.spd = wind["spd"]?.string
    }
}

/**
 *  即时数据
 */
struct NowWeatherCondition {
    /// 天气情况
    let condition:minWeatherCondition?
    ///体感温度
    let fl:String?
    ///相对湿度（%）
    let hum:String?
    ///降水量（mm）
    let pcpn:String?
    ///气压
    let pres:String?
    ///温度
    let tmp:String?
    ///能见度（km）
    let vis:String?
    /// 风
    let wind:Wind?
    init(nowWeatherCondition:[String:JSON]){
        self.condition = minWeatherCondition(minWeatherCondition: (nowWeatherCondition["cond"]?.dictionary)!)
        self.fl = nowWeatherCondition["fl"]?.string
        self.hum = nowWeatherCondition["hum"]?.string
        self.pcpn = nowWeatherCondition["pcpn"]?.string
        self.pres = nowWeatherCondition["pres"]?.string
        self.tmp = nowWeatherCondition["tmp"]?.string
        self.vis = nowWeatherCondition["vis"]?.string
        self.wind = Wind(wind: (nowWeatherCondition["wind"]?.dictionary)!)
    }
    
}
/**
 *  日出日落时间
 */
struct SunTime {
    /// 日出时间
    let raise:String?
    /// 日落时间
    let sunSet:String?
    init(sunTime:[String:JSON]){
        self.raise = sunTime["raise"]?.string
        self.sunSet = sunTime["sunSet"]?.string
    }
}

/**
*  基本温度信息
*/
struct Temp {
    let max:String?
    let min:String?
    init(temp:[String:JSON]){
        self.max = temp["max"]?.string
        self.min = temp["min"]?.string
    }
    //计算平均温度
    var avgTemp:String?{
        get{
            return String(Int(max!)!+Int(min!)!/2)
        }
    }
}
/**
 *  小时天气
 */
struct HourlyForecast {
    ///气压
    let pres:String?
    ///风
    let wind:Wind?
    ///湿度
    let hum:String?
    ///温度
    let tmp:String?
    ///降水概率
    let pop:String?
    ///更新时间
    let date:String?
    
    var dateData:NSDate{
       return getDateFromString(self.date!)!
    }
    
    init(hourlyForecast:[String:JSON]){
        self.pres = hourlyForecast["pres"]?.string
        self.wind = Wind(wind: (hourlyForecast["wind"]?.dictionary)!)
        self.hum = hourlyForecast["hum"]?.string
        self.tmp = hourlyForecast["tmp"]?.string
        self.pop = hourlyForecast["pop"]?.string
        self.date = hourlyForecast["date"]?.string
    }
}

/**
 * 每日天气状况
 */
struct DailyCondition { //天气状况
    ///白天天气状况代码
    let code_d:String?
    ///夜间天气状况代码
    let code_n:String?
    ///白天天气状况描述
    let txt_d:String?
    ///夜间天气状况描述
    let txt_n:String?
    
    init(dailyCondition:[String:JSON]){
        self.code_d = dailyCondition["code_d"]?.string
        self.code_n = dailyCondition["code_n"]?.string
        self.txt_d = dailyCondition["txt_d"]?.string
        self.txt_n = dailyCondition["txt_n"]?.string
    }

}

/**
 *  天气预报，国内7天，国际10天
 */
struct DailyForecast {
    /// 日期
    let date:String?
    /// 天文数值
    let sunTime:SunTime?
    /// 日天气状况
    let dailyCondition:DailyCondition?
    ///相对湿度（%）
    let hum:String?
    ///降水量（mm）
    let pcpn:String?
    ///降水概率
    let pop:String?
    ///气压＝
    let pres:String?
    ///温度
    let temp:Temp?
    ///能见度（km）
    let vis:String?
    ///风
    let wind:Wind?
    
    init(dailyForecast:[String:JSON]){
        self.date = dailyForecast["date"]?.string
        self.sunTime = SunTime(sunTime: (dailyForecast["astro"]?.dictionary)!)
        self.dailyCondition = DailyCondition(dailyCondition: (dailyForecast["cond"]?.dictionary)!)
        self.hum = dailyForecast["hum"]?.string
        self.pcpn = dailyForecast["pcpn"]?.string
        self.pop = dailyForecast["pop"]?.string
        self.pres = dailyForecast["pres"]?.string
        self.temp = Temp(temp: (dailyForecast["tmp"]?.dictionary)!)
        self.vis = dailyForecast["vis"]?.string
        self.wind = Wind(wind:(dailyForecast["wind"]?.dictionary)!)
    }
}

struct Suggestion{
    let brf:String
    let txt:String
    init(suggestion:[String:JSON]){
        self.brf = suggestion["brf"]!.string!
        self.txt = suggestion["txt"]!.string!
    }
}

/**
 *  城市天气信息数据
 */
struct CityWeatherData{
    let status:String?
    var alarm = [Alarm]()
    var hourlyForecast = [HourlyForecast]()
    var dailyForecast = [DailyForecast]()
    let now:NowWeatherCondition?
    let airCondition:AirCondition?
    let basic:BasicInfo?
    var suggestion = [String:Suggestion]()
    
    init(JSONData:[String:JSON]){
        self.status = JSONData["status"]?.string
        if let alarms = JSONData["alarms"]?.array  {
            for(var i=0;i<alarms.count;i+=1){
                let data = Alarm(alarm: alarms[i].dictionary!)
                alarm.append(data)
            }
        }
        self.airCondition = AirCondition(airCondition: (JSONData["aqi"]!["city"].dictionary)!)
        
        let hourlyForecastArray = JSONData["hourly_forecast"]?.array
        for(var i=0;i<hourlyForecastArray?.count;i+=1){
            let data = HourlyForecast(hourlyForecast: hourlyForecastArray![i].dictionary!)
            hourlyForecast.append(data)
            //只接受未过期的数据
            hourlyForecast = hourlyForecast.filter({ (HourlyForecast) -> Bool in
                return HourlyForecast.dateData.timeIntervalSinceNow > -60*60
            })
        }
        
        let dailyForecastArray = JSONData["daily_forecast"]?.array
        for(var i=0;i<dailyForecastArray?.count;i+=1){
            let data = DailyForecast(dailyForecast: dailyForecastArray![i].dictionary!)
            dailyForecast.append(data)
        }
        self.now = NowWeatherCondition(nowWeatherCondition: (JSONData["now"]?.dictionary)!)
        self.basic = BasicInfo(basicInfo: (JSONData["basic"]?.dictionary)!)
        
        /// 建议
        let suggestionDic = JSONData["suggestion"]?.dictionary
        for (key,value) in suggestionDic!{
            self.suggestion[key] =  Suggestion(suggestion: value.dictionary!)
        }
        print(self.suggestion)
    }
}



extension NetworkManager{
    class func getCityWeatherDataWithUrl(url:NSURL = NetworkManager.cityUrl,apiKey:String = NetworkManager.apikey,cityID:String,processData:(CityWeatherData)->Void){

        Alamofire.request(.GET, url, parameters: ["city":cityID], encoding: .URL , headers: ["apikey":apiKey]).responseJSON(){(result) in
            //转化为JSON
            let JSONData = JSON(data: result.data!)
            let data = JSONData["HeWeather data service 3.0"][0]
            let cityWeatherData = CityWeatherData(JSONData: data.dictionary!)
            processData(cityWeatherData)
        }

    }
}