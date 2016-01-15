//
//  LocationManager.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/30.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import Foundation
import CoreLocation
class LocationManager:NSObject,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override init() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
    }
    
    func getPermission(){
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            if status == .NotDetermined || status == .Denied{
                //允许使用定位服务
                
                //开始启动定位更新服务
                locationManager.startUpdatingLocation()
            }else{
                //请求权限
                locationManager.requestAlwaysAuthorization()
            }
    }
    
    func locationManager(manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]){
            var currlocation:CLLocation
            //获取最新坐标
            currlocation = locations.last! as CLLocation
            //获取经度
            currlocation.coordinate.longitude
            //获取纬度
            currlocation.coordinate.latitude
            //获取海拔
            currlocation.altitude
    }
}