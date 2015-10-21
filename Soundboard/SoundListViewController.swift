//
//  SoundListViewController.swift
//  Soundboard
//
//  Created by crazytin on 10/14/15.
//  Copyright © 2015 crazytin. All rights reserved.
//

import UIKit
import AVFoundation

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer =  AVAudioPlayer()
    
    var sounds: [Sound] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.tableView.dataSource = self
        self.tableView.delegate = self
    
        
        let  soundPath = NSBundle.mainBundle().pathForResource("chaching", ofType: "m4a")
        let  soundURL = NSURL.fileURLWithPath(soundPath!)
        
        
        let sound1 = Sound()
        sound1.name = "KEY SHAKE"
        sound1.URL = soundURL
        
        
        let sound2 = Sound()
        sound2.name = "FUCK"
        sound2.URL = soundURL
        
        self.sounds.append(sound1)
        self.sounds.append(sound2)
       
    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return self.sounds.count
      
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sound = self.sounds[indexPath.row]
        let  cell = UITableViewCell()
        cell.textLabel!.text = sound.name
        return cell
        
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sound = self.sounds[indexPath.row]
        
        
        self.audioPlayer =  try! AVAudioPlayer(contentsOfURL: sound.URL)
        self.audioPlayer.play()
    
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       let nextViewController = segue.destinationViewController as! NewSoundViewController
        
       nextViewController.previousViewController = self
     
        
    
    }
    








}

