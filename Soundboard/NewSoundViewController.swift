//
//  NewSoundViewController.swift
//  Soundboard
//
//  Created by Abtin Mehr on 10/20/15.
//  Copyright © 2015 crazytin. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


class NewSoundViewController : UIViewController {

    required init(coder aDecoder: NSCoder){
    
       
        let baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] 
        let randomName = NSUUID().UUIDString
        self.audioURL = randomName + ".m4a"
        let pathComponents = [baseString, self.audioURL]
        let audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)!
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory( AVAudioSessionCategoryPlayAndRecord)
        
        
        var recordSettings: [String : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = NSNumber(int: Int32(kAudioFormatMPEG4AAC))
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        try!  audioRecorder = AVAudioRecorder(URL: audioNSURL, settings: recordSettings)
        
        
        
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        // Super init is below
        super.init(coder: aDecoder)!
    
}
    
    var previousViewController = SoundListViewController()
    var audioRecorder: AVAudioRecorder
    var audioURL: String
    
    
    @IBOutlet weak var soundTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
    }


    @IBAction func cancelTapped(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    @IBAction func saveTapped(sender: AnyObject) {
        
   
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //Create a sound object
        let sound = NSEntityDescription.insertNewObjectForEntityForName("Sound", inManagedObjectContext: context) as! Sound
        
        sound.name = self.soundTextField.text!
        sound.url = self.audioURL
       
        //save sound to CoreData
        do{
            
            try  context.save()
        }
        catch{
            
            print("Could Not Save")
            
        }
        
        //Dismiss this ViewController
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func recordTapped(sender: AnyObject) {
        
        
        if self.audioRecorder.recording{
        
            self.audioRecorder.stop()
            self.recordButton.setTitle("RECORD ANOTHER BITCH", forState: UIControlState.Normal)
        
        } else {
        
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(true)
        self.audioRecorder.record()
        self.recordButton.setTitle("Finish Recording", forState: UIControlState.Normal)
        
        }
    
        
    
    
    }


}