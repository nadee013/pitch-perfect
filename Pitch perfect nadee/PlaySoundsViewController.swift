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
        audioEngine = AVAudioEngine()
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true

        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupPlay(rate: Float) {
        resetAudioPlay()
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
        resetAudioPlay()
        
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
    
    func resetAudioPlay() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playDarthVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }

}
