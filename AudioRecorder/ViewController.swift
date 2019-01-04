//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Pulkit Aggarwal on 26/12/18.
//  Copyright © 2018 Maxx. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate  {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var controls: [UIButton]!
    
    var audioRecorder:AVAudioRecorder?
    
    var audioPlayer:AVAudioPlayer?

    
    var recordSetting = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        recordSetting = [AVEncoderAudioQualityKey:AVAudioQuality.min.rawValue,AVEncoderBitRateKey:16,AVNumberOfChannelsKey:2,AVSampleRateKey:44100.0]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

    }

    @IBAction func play(_ sender: Any) {
        if audioRecorder?.isRecording == true
        {
            audioRecorder?.stop()
        }
       try? audioPlayer = AVAudioPlayer(contentsOf: getPath(recordingName: titleLabel.text!))
        
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
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
            
            try? self.audioRecorder = AVAudioRecorder.init(url: self.getPath(recordingName: textField.text ?? "sound"), settings: self.recordSetting)
            self.audioRecorder?.delegate = self
            
            self.audioRecorder?.prepareToRecord()
            self.audioRecorder?.record()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }
    
    @IBAction func stop(_ sender: Any) {
        if audioRecorder?.isRecording == true
        {
            audioRecorder?.stop()
        }
        else{
            audioPlayer?.stop()
        }
    }
    func getPath(recordingName: String) -> URL
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let soundPath = path[0].appendingPathComponent(recordingName+".caf")
        
        return soundPath
    }
}

