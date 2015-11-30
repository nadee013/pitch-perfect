//
//  PlaySoundsViewController.swift
//  Pitch perfect nadee
//
//  Created by Nadee Anuththara on 11/18/15.
//  Copyright © 2015 Nadee Anuththara. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            let filePathUrl = NSURL.fileURLWithPath(filePath)
//           
//        } else {
//            print("Error")
//        }
        audioEngine = AVAudioEngine()
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true

        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupPlay(rate: Float) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func audioSnail(sender: UIButton) {
        setupPlay(0.5)
    }

    @IBAction func audioRabbit(sender: UIButton) {
       setupPlay(1.5)
    }

    @IBAction func playChipmonkAudio(sender: AnyObject) {
       playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        _ = try? audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func playDarthVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-100)
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }

}
