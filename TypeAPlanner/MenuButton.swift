//
//  MenuButton.swift
//  TypeAPlanner
//
//  Created by Katie on 5/13/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit

class MenuButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red:0.41, green:0.08, blue:0.05, alpha:1.0).CGColor
        layer.cornerRadius = 5.0
    }

}
