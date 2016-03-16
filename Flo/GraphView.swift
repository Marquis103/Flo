//
//  GraphView.swift
//  Flo
//
//  Created by Marquis Dennis on 3/13/16.
//  Copyright © 2016 Marquis Dennis. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {

	@IBInspectable var startColor: UIColor = UIColor.redColor()
	@IBInspectable var endColor: UIColor = UIColor.greenColor()
	
	var graphPoints:[Int] = [4, 2, 6, 4, 5, 8, 3]
	
    override func drawRect(rect: CGRect) {
		let width = rect.width
		let height = rect.height
		
		//set up background clipping area
		let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
		path.addClip()
		
        //get the current context
		let context = UIGraphicsGetCurrentContext()
		let colors = [startColor.CGColor, endColor.CGColor]
		
		//set up colorspace
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		
		//set up color stops
		let colorLocations:[CGFloat] = [0.0, 1.0]
		
		//create gradient
		let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
		
		//draw the gradient
		let startPoint = CGPoint.zero
		let endPoint = CGPoint(x: 0, y: bounds.height)
		
		CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, .DrawsBeforeStartLocation)
		
		let margin:CGFloat = 20.0
		let columnXPoint = { (column:Int) -> CGFloat in
			//calculate gap between points
			let spacer = (width - margin * 2 - 4) / CGFloat((self.graphPoints.count - 1))
			var x:CGFloat = CGFloat(column) * spacer
			x += margin + 2
			return x
		}
		
		let topBorder:CGFloat = 60
		let bottomBorder:CGFloat = 50
		let graphHeight = height - topBorder - bottomBorder
		let maxValue = self.graphPoints.maxElement()!
		
		let columnYPoint = { (graphPoint:Int) -> CGFloat in
			var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
			y = graphHeight + topBorder - y
			return y
		}
		
		UIColor.whiteColor().setFill()
		UIColor.whiteColor().setStroke()
		
		let graphPath = UIBezierPath()
		graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
		
		for i in 1..<graphPoints.count {
			let nextPoint = CGPoint(x:columnXPoint(i), y: columnYPoint(graphPoints[i]))
			graphPath.addLineToPoint(nextPoint)
		}
		
		//save the sate of the context
		CGContextSaveGState(context)
		
		//make a copy of the path
		let clippingPath = graphPath.copy() as! UIBezierPath
		
		//add lines to the copied path to complete the clip area
		clippingPath.addLineToPoint(CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
		clippingPath.addLineToPoint(CGPoint(x: columnXPoint(0), y: height))
		clippingPath.closePath()
		
		//add clipping path to context
		clippingPath.addClip()
		
		let highestYPoint = columnYPoint(maxValue)
		let sPoint = CGPoint(x: margin, y: highestYPoint)
		let ePoint = CGPoint(x: margin, y: bounds.height)
		
		CGContextDrawLinearGradient(context, gradient, sPoint, ePoint, .DrawsBeforeStartLocation)
		CGContextRestoreGState(context)
		
		graphPath.lineWidth = 2.0
		graphPath.stroke()

		for i in 0..<graphPoints.count {
			var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
			point.x -= 5.0/2
			point.y -= 5.0/2
			
			let circle = UIBezierPath(ovalInRect: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
			circle.fill()
		}
		
		//draw horizontal lines on the top of everything
		let linePath = UIBezierPath()
		
		//top line
		linePath.moveToPoint(CGPoint(x: margin, y: topBorder))
		linePath.addLineToPoint(CGPoint(x: width - margin, y: topBorder))
		
		//center line
		linePath.moveToPoint(CGPoint(x: margin, y: graphHeight/2 + topBorder))
		linePath.addLineToPoint(CGPoint(x: width - margin, y: graphHeight/2 + topBorder))
		
		//bottom line
		linePath.moveToPoint(CGPoint(x: margin, y: height - bottomBorder))
		linePath.addLineToPoint(CGPoint(x: width - margin, y: height - bottomBorder))
		
		let color = UIColor(white: 1.0, alpha: 0.3)
		color.setStroke()
		
		linePath.lineWidth = 1.0
		linePath.stroke()
    }
}
