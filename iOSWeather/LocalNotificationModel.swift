//
//  LocalNotificationModel.swift
//  SherryWeather
//
//  Created by xiaolei on 15/12/30.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation
struct LocalNotificationModel {
    let title:String
    let body:String
    let date:NSDate
    /**
     通知配置
     
     - parameter title: 通知的标题
     - parameter body:  通知的主要内容
     - parameter date:  通知的时间
     
     - returns: Viod
     */
    init( title:String,body:String,date:NSDate){
        self.title = title
        self.body  = body
        self.date  = date
    }
}