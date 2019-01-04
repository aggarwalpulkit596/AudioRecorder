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
    
    var timer:Timer?

    
    var recordSetting = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in controls
        {
            button.layer.cornerRadius = 35
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 5
            button.clipsToBounds = true
        }
        titleLabel.text = UserDefaults.standard.object(forKey: "title") as? String ?? "No Recordings"
        
        progressView.progress = 0
        
        recordSetting = [AVEncoderAudioQualityKey:AVAudioQuality.min.rawValue,AVEncoderBitRateKey:16,AVNumberOfChannelsKey:2,AVSampleRateKey:44100.0]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try? audioSession.overrideOutputAudioPort(.speaker)

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
        
        progressView.progress = 0
        startTimer()
        
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
            UserDefaults.standard.set(textField.text, forKey: "title")
            
            try? self.audioRecorder = AVAudioRecorder.init(url: self.getPath(recordingName: textField.text ?? "sound"), settings: self.recordSetting)
            self.audioRecorder?.delegate = self
            
            self.audioRecorder?.prepareToRecord()
            self.progressView.progress = 0
            self.audioRecorder?.record()
            
            self.startTimer()
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
        if timer != nil
        {
         timer?.invalidate()
            timer = nil
        }
        
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
        }
    }
    func getPath(recordingName: String) -> URL
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let soundPath = path[0].appendingPathComponent(recordingName+".caf")
        
        return soundPath
    }
    
    func startTimer()
    {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseProgress), userInfo:nil, repeats: true)
    }
    
    @objc func increaseProgress()
    {
        progressView.progress = progressView.progress + 0.1
        timeLabel.text = "\(Int(progressView.progress * 10))s"
    }
    
    
}

