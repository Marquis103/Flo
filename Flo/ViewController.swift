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
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var graphView: GraphView!
	
	var isGraphShowing = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	@IBAction func counterViewTapped(sender: UITapGestureRecognizer?) {
		if isGraphShowing {
			//hide graph
			UIView.transitionFromView(graphView, toView: counterView, duration: 1.0, options: [.TransitionFlipFromLeft, .ShowHideTransitionViews], completion: nil)
		} else {
			//show graph
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

}

