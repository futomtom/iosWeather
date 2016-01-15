//
//  ViewController.swift
//  SherryWeather
//
//  Created by xiaolei on 15/10/31.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    /// 背景图片
    @IBOutlet weak var mainBackGroundImage: UIImageView!
    /// CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// 当前天气图片
    @IBOutlet weak var currentImage: UIImageView!
    /// 当前天气容器View
    @IBOutlet weak var currentImageContainerView: UIView!
    ///当前时间
    @IBOutlet weak var currentTime: UILabel!
    /// 当前天气Label
    @IBOutlet weak var currentWeather: UILabel!
    /// 容器View左侧约束
    @IBOutlet weak var LeftConstranintOfCurrentView: NSLayoutConstraint!
    /// 纬度
    @IBOutlet weak var latitude: UILabel!
    /// 经度
    @IBOutlet weak var longitude: UILabel!
    /// 城市
    @IBOutlet weak var city: UILabel!
    /// 国家
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var leftLine: UIView!
    
    @IBOutlet weak var rightLine: UIView!
    
    ///城市ID
    var cityID = "suzhou"
    ///景点ID
    let spotID = "CN10101010018A"
    ///数据数组
    lazy var cityWeatherData = CityWeatherData?()
    ///CellIdentifier
    let identifier = "CollectionViewCellIdentifier"
    /// HeaderIdentifier
    let headerViewIdentifier = "headerViewIdentifier"
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //点击刷新
        currentImageContainerView.userInteractionEnabled = true
        currentImageContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("requestDataAndRefresh")))
//        collectionView.pagingEnabled = true
//        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = 0;
//        flowLayout.minimumInteritemSpacing = 0;
//        collectionView.collectionViewLayout = flowLayout

        
        //更新StatusBar
        self.setNeedsStatusBarAppearanceUpdate()
        //设置初始位置
        setCurrentWeather(tempText: "",weatherCondition:"", weatherCode: "", weatherTime: "00:00",animated: false)
        //请求数据
        requestDataAndRefresh()
    }
    
    //设置StatusBarStyle
    override func preferredStatusBarStyle() -> UIStatusBarStyle{
        return .LightContent
    }
    
    func requestDataAndRefresh(){
        //请求数据
        NetworkManager.getCityWeatherDataWithUrl(cityID: cityID) { (data) -> Void in
            //更新数据
            self.cityWeatherData = data
            TodayExtensionData.insertDataToTodayExtension(self.cityWeatherData!)
            self.collectionView.reloadData()
            //现在天气
            self.setCurrentWeather(tempText: (self.cityWeatherData?.now?.tmp)!,weatherCondition:(self.cityWeatherData?.now?.condition?.txt)!
                ,weatherCode: (self.cityWeatherData?.now?.condition?.code!)!,weatherTime:convertDate(getDateFromString(self.cityWeatherData?.hourlyForecast[0].date), template: "HH:mm")! ,animated: true)
            //更新经纬度
            
            // TODO: 精度位数处理
            self.latitude.text = self.cityWeatherData?.basic?.lat?.substringToIndex((self.cityWeatherData?.basic?.lat?.startIndex.advancedBy(5))!)
            self.longitude.text = self.cityWeatherData?.basic?.lon?.substringToIndex((self.cityWeatherData?.basic?.lon?.startIndex.advancedBy(6))!)
        }
        
    }

    
    /**
     设置当前天气
     
     - parameter tempText: 温度文本
     - parameter weatherCondition: 天气文本
     - parameter weatherCode: 天气Code
     - parameter weatherTime: 当前时间
     - parameter animated:    是否动画
     */
    func setCurrentWeather(tempText tempText:String,weatherCondition:String ,weatherCode:String ,weatherTime:String,animated:Bool = true){
        currentWeather.text = weatherCondition+" "+tempText+"℃"
        currentImage.image = chooseImage(weatherCode: weatherCode)
        currentTime.text = weatherTime
        let pos = Int(convertDate(getDateFromString(weatherTime,template: "HH:mm"), template: "HH")!)!
        //设置位置
        setCurrentPosition(Position: pos,animated: animated)
    }
    
    

    /**
     设置当前天气位置
     
     - parameter Position: 位置，Int型数据，1-24
     - parameter animated: 是否使用动画
     */
    func setCurrentPosition(Position Position:Int,animated:Bool){
        print(LeftConstranintOfCurrentView.constant)
        let fullWidth = (self.view.frame.width - self.currentImageContainerView.frame.width)
        LeftConstranintOfCurrentView.constant = fullWidth * CGFloat(Position)/25.0
        print(LeftConstranintOfCurrentView.constant)
        if animated {
            UIView.animateWithDuration(3, delay: 0, options: [.CurveEaseInOut], animations: { () -> Void in
                // TO DO:动画BUG
//                self.leftLine.layoutIfNeeded()
//                self.rightLine.layoutIfNeeded()
                self.view.layoutIfNeeded()
                self.currentImageContainerView.layoutIfNeeded()
            }, completion: nil)
        }else{
            self.leftLine.layoutIfNeeded()
            self.rightLine.layoutIfNeeded()
            self.currentImageContainerView.layoutIfNeeded()
        }
    }
}

