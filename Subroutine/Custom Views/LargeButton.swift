//
//  LargeButton.swift
//  Subroutine
//
//  Created by Joss Manger on 7/3/18.
//  Copyright © 2018 Joss Manger. All rights reserved.
//

import UIKit

@IBDesignable
class LargeButton: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        let bez = UIBezierPath.init(ovalIn: self.bounds)
        context?.setFillColor(UIColor.green.cgColor)
        
        context?.fillEllipse(in: self.bounds)
        
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
        self.setNeedsDisplay()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layoutSubviews()
    }

}
