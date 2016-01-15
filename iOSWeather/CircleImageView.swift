//
//  CircleImageView.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/26.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
        */
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorderAndCorner()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        setBorderAndCorner()
    }
    func setBorderAndCorner(){
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
        self.borderColor = UIColor.whiteColor().CGColor
        self.borderWidth = 3
    }

}
