//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lbTimer: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Create a dictionary
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var player: AVAudioPlayer!
    var timer: Timer?
    var totalTime = 0
    var secondsRemaing = 0
    func startOtpTimer(time: Int) {
            self.secondsRemaing = time
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }

    @objc func updateTimer() {
        //print(self.secondsRemaing)
        let pct = Float(secondsRemaing)/Float(totalTime)
        progressBar.progress = 1 - pct
        self.lbTimer.text = self.timeFormatted(self.secondsRemaing) // will show timer
        if secondsRemaing != 0 {
            secondsRemaing -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                titleLabel.text = "Done!"
                playAlarm()
            }
        }
        }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        startOtpTimer(time: totalTime)
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

