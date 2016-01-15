//
//  menuTableViewCell.swift
//  SherryWeather
//
//  Created by 王卓 on 15/12/30.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import UIKit

class menuTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonImage: UIImageView!
    
    @IBOutlet weak var buttonLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
