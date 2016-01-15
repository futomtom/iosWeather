//
//  CollectionViewMethods.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/27.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import UIKit
extension ViewController {
    
    //UICollectionViewDataSource Method
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! WeatherCollectionViewCell
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        /**
        *  小时天气
        */
        if indexPath.section == 0{
            (cell as! WeatherCollectionViewCell).time.text = convertDate(getDateFromString((cityWeatherData?.hourlyForecast[indexPath.row].date)!), template: "HH:mm")
            (cell as! WeatherCollectionViewCell).image.image = chooseImage(weatherCode: "100")
            (cell as! WeatherCollectionViewCell).temp.text = (cityWeatherData?.hourlyForecast[indexPath.row].tmp)!+"℃"
        }
        /**
        *  每日天气
        */
        if indexPath.section == 1{
            (cell as! WeatherCollectionViewCell).time.text = convertDate(getDateFromString((cityWeatherData?.dailyForecast[indexPath.row].date)!,template: "yyyy-MM-dd"), template: "E")
            (cell as! WeatherCollectionViewCell).image.image = chooseImage(weatherCode: cityWeatherData?.dailyForecast[indexPath.row].dailyCondition?.code_d)
            (cell as! WeatherCollectionViewCell).temp.text = (cityWeatherData?.dailyForecast[indexPath.row].temp?.max)!+"℃"+"\n"+(cityWeatherData?.dailyForecast[indexPath.row].temp?.min)!+"℃"
        }
        //调整布局
        cell.layoutIfNeeded()
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cityWeatherData?.status != "ok"{
            return 0
        }
        return 6
        //return (cityWeatherData?.dailyForecast.count)!
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier, forIndexPath: indexPath) as UICollectionReusableView
        let label = view.viewWithTag(1) as! UILabel
        if indexPath.section == 0 {
            label.text = "今日天气"
        }else{
            label.text = "本周天气"
        }
        return headerView
    }
    
    /**
     根据天气代码选择图片
     
     - parameter code: 天气代码
     
     - returns: 天气图片
     */
    func chooseImage(weatherCode code:String?)->UIImage?{
        if let str = code{
            return UIImage(named: str)
        }else {
            return nil
        }
    }
    

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        if indexPath.section == 1{
            return CGSizeMake(self.view.frame.width/6 ,self.view.frame.width/3)
        }
        return CGSizeMake(self.view.frame.width/6 ,self.view.frame.width/4)
    }
    
    
}