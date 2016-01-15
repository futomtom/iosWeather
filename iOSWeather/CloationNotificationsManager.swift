//
//  CloationNotificationsManager.swift
//  SherryWeather
//
//  Created by xiaolei on 15/12/30.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation
import UIKit
class CloationNotificationsManager {
    //提示用户打开消息提示
    class func setupNotificationSettings(){
        //规定通知类型
        let notificationTypes:UIUserNotificationType = [.Alert,.Sound,.Badge]
        //注册通知
        let notificationSettings                     = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    /**
    注册通知
    
    - parameter notification: 通知模型
    */
    class func scheduleLocalNotification(notification:LocalNotificationModel){
        let localNotification        = UILocalNotification()
        //自定义
        localNotification.alertTitle = notification.title
        localNotification.alertBody  = notification.body
        localNotification.fireDate   = notification.date
         //默认属性
        localNotification.soundName  = UILocalNotificationDefaultSoundName

        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
}