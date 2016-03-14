//
//  CounterViews.swift
//  Flo
//
//  Created by Marquis Dennis on 3/13/16.
//  Copyright © 2016 Marquis Dennis. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

@IBDesignable
class CounterView: UIView {

	@IBInspectable var counter: Int = 0 {
		didSet {
			if counter <= NoOfGlasses {
				setNeedsDisplay()
			}
		}
	}
	@IBInspectable var outlineColor:UIColor = UIColor.blueColor()
	@IBInspectable var counterColor:UIColor = UIColor.orangeColor()
	
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
		let radius:CGFloat = max(bounds.width, bounds.height)
		let arcWidth:CGFloat = 76
		let startAngle:CGFloat = 3 * π / 4
		let endAngle:CGFloat = π / 4
		
		let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		
		path.lineWidth = arcWidth
		counterColor.setStroke()
		path.stroke()
		
		//draw the outline
		let angleDiff:CGFloat = 2 * π - startAngle + endAngle
		let arcLengthPerGlass = angleDiff / CGFloat(NoOfGlasses)
		
		let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
		
		//create outer arc
		let outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width/2 - 2.5, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
		
		//add inner arc
		outlinePath.addArcWithCenter(center, radius: bounds.width/2 - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
		
		outlinePath.closePath()
		outlineColor.setStroke()
		outlinePath.lineWidth = 5.0
		outlinePath.stroke()
    }

}
