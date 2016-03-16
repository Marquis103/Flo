//
//  ViewController.swift
//  Flo
//
//  Created by Marquis Dennis on 3/13/16.
//  Copyright © 2016 Marquis Dennis. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

	@IBOutlet weak var counterLabel: UILabel!
	@IBOutlet weak var counterView: CounterView!
	@IBOutlet weak var containervarw: UIView!
	@IBOutlet weak var graphView: GraphView!
	@IBOutlet weak var averageWaterdrunk: UILabel!
	@IBOutlet weak var maxLabel: UILabel!
	
	var isGraphShowing = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	
	@IBAction func counterViewTapped(sender: UITapGestureRecognizer?) {
		if isGraphShowing {
			//hide graph
			UIView.transitionFromView(graphView, toView: counterView, duration: 1.0, options: [.TransitionFlipFromLeft, .ShowHideTransitionViews], completion: nil)
		} else {
			//show graph
			setupGraphDisplay()
			UIView.transitionFromView(counterView, toView: graphView, duration: 1.0, options: [.TransitionFlipFromRight, .ShowHideTransitionViews], completion: nil)
		}
		
		isGraphShowing = !isGraphShowing
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	@IBAction func btnPushButton(sender: PushButtonView) {
		if sender.isAddButton {
			if counterView.counter < 8 {
				counterView.counter++
			}
		} else {
			if counterView.counter > 0 {
				counterView.counter--
			}
		}
		
		counterLabel.text = "\(counterView.counter)"
		
		//show counter view if graph is showing while add button is pressed
		if isGraphShowing {
			counterViewTapped(nil)
		}
	}
	
	func setupGraphDisplay() {
		
		//Use 7 days for graph - can use any number,
		//but labels and sample data are set up for 7 days
		let noOfDays:Int = 7
		
		//replace last day with today's actual data
		graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
		
		//indicate that the graph needs to be redrawn
		graphView.setNeedsDisplay()
		
		maxLabel.text = "\(graphView.graphPoints.maxElement())"
		
		//calculate average from graphPoints
		let average = graphView.graphPoints.reduce(0, combine: +) / graphView.graphPoints.count
		averageWaterdrunk.text = "\(average)"
		
		//set up labels
		//day of week labels are set up in storyboard with tags
		//today is last day of the array need to go backwards
		
		//get today's day number
		let dateFormatter = NSDateFormatter()
		let calendar = NSCalendar.currentCalendar()
		let componentOptions:NSCalendarUnit = .NSWeekdayCalendarUnit
		let components = calendar.components(componentOptions, fromDate: NSDate())
		
		var weekday = components.weekday
		
		let days = ["S", "S", "M", "T", "W", "T", "F"]
		
		//set up the day name labels with correct day
		for i in days.count.stride(to: 1, by: -1) {
			if let labelView = graphView.viewWithTag(i) as? UILabel {
				if weekday == 7 {
					weekday = 0
				}
				
				labelView.text = days[weekday--]
				
				if weekday < 0 {
					weekday = days.count - 1
				}
			}
		}
	}
}

