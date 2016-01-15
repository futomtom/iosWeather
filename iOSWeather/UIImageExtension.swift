//
//  UIImageExtension.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/26.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import UIKit
extension UIImageView{
    /// 边框宽度
    var borderWidth:CGFloat{
        get{
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    /// 边框颜色
    var borderColor:CGColor?{
        get{
            return layer.borderColor
        }
        set{
            layer.borderColor = newValue
        }
    }
    
    
    
}