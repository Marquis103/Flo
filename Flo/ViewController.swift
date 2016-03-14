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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
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
	}

}

