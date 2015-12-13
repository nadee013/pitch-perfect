//
//  RecordSoundsViewController.swift
//  Pitch perfect nadee
//
//  Created by Nadee Anuththara on 11/17/15.
//  Copyright © 2015 Nadee Anuththara. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
   
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        //just after view loading
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        //just after view appear
        stopButton.hidden = true
        recordButton.enabled = true
        recordingLabel.hidden = false
        recordingLabel.text = "Tap to start recording"
    }


    @IBAction func recordAudio(sender: UIButton) {
        //just after clicking microphone button
        stopButton.hidden = false
        recordButton.enabled = false
        recordingLabel.text = "Recording"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recodingName = "my_audio.wav"
        let pathArray = [dirPath, recodingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        guard flag else {
            print("Recording was not successful");
            recordButton.enabled = true
            stopButton.hidden = true
            return
        }
        recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopAudioRecord(sender: UIButton) {
        recordingLabel.hidden = true;
        audioRecorder.stop()
        let audioSesiion = AVAudioSession.sharedInstance()
        try! audioSesiion.setActive(false)
    }
}

