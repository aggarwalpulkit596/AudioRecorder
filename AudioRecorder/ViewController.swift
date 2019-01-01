//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Pulkit Aggarwal on 26/12/18.
//  Copyright © 2018 Maxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var controls: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func play(_ sender: Any) {
    }
    @IBAction func record(_ sender: Any) {
    }
    @IBAction func stop(_ sender: Any) {
    }
    
}

