//
//  PushButtonView.swift
//  Flo
//
//  Created by Marquis Dennis on 3/13/16.
//  Copyright © 2016 Marquis Dennis. All rights reserved.
//

import UIKit

@IBDesignable
class PushButtonView: UIButton {
	
	@IBInspectable var fillColor: UIColor = UIColor.greenColor()
	@IBInspectable var isAddButton:Bool = true
	
    override func drawRect(rect: CGRect) {
		
		//button outline
        let path = UIBezierPath(ovalInRect: rect)
		fillColor.setFill()
		path.fill()
		
		//set up the wdith and height variables for horizontal stroke
		let plusHeight: CGFloat = 3.0
		let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
		
		//create path
		let plusPath = UIBezierPath()
		
		//set the path's line width to the height of the stroke
		plusPath.lineWidth = plusHeight
		
		//move the initial point of the path to the start of the horizontal stroke
		plusPath.moveToPoint(CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5, y: bounds.height / 2 + 0.5))
		
		//add a point to the path at the end of the stroke
		plusPath.addLineToPoint(CGPoint(x: bounds.width/2 + plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
		
		if isAddButton {
			plusPath.moveToPoint(CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 - plusWidth/2 + 0.5))
			plusPath.addLineToPoint(CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 + plusWidth/2 + 0.5))
		}
		
		//stroke color
		UIColor.whiteColor().setStroke()
		
		//stroke
		plusPath.stroke()
    }

}
