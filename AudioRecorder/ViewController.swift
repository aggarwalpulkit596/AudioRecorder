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
        let alert  = UIAlertController(title: "Recording Title", message: "Please enter a name for this recording", preferredStyle: .alert)
        
        alert.addTextField { (nameTextField:UITextField) in
            nameTextField.textAlignment = .center
            nameTextField.placeholder = "Recording Name"
            nameTextField.keyboardAppearance =  UIKeyboardAppearance.dark
        }
        
        let okAction = UIAlertAction.init(title: "OK", style: .default,handler: { (action:UIAlertAction!) ->Void in
            let textField = alert.textFields![0] as UITextField
    
            self.titleLabel.text = textField.text
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true˚˚)
    }
    
    @IBAction func stop(_ sender: Any) {
    }
    
}

