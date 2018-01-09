//
//  DeckCollectionViewController.swift
//  BenkyoSpike
//
//  Created by Jason Cheladyn on 9/23/16.
//  Copyright © 2016 Liyicky. All rights reserved.
//

import UIKit
import AVFoundation

class DeckCollectionViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    //#MARK: IB Outlets
    @IBOutlet var cardsCV:UICollectionView?
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    
    //#MARK: Properties
    
    var layout = DeckCollectionViewLayout()
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var synth: AVSpeechSynthesizer!
    var recordFile: URL!
    

    
    //#MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardsCV!.register(DeckCardCell.nib, forCellWithReuseIdentifier: DeckCardCell.identifier)
        cardsCV!.delegate = self
        cardsCV!.dataSource = self
        cardsCV!.collectionViewLayout = layout
        
        self.listenButton.addTarget(self, action: #selector(self.listenTapped), for: .touchUpInside)
        self.quizButton.addTarget(self, action: #selector(self.startQuiz), for: .touchUpInside)
        
        recordingSession = AVAudioSession.sharedInstance()
        synth = AVSpeechSynthesizer()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            try recordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
 
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordButton.isUserInteractionEnabled = true
                        self.recordButton.isEnabled = true
                        self.recordButton.addTarget(self, action: #selector(self.recordTapped), for: .touchUpInside)
                    } else {
                        // failed to record!
                        NSLog("Failed to Record!")
                    }
                }
            }
        } catch let error as NSError {
            NSLog("Failed to Record!")
            NSLog("audioSession error: \(error.localizedDescription)")
        }
    }
    
    @objc func recordTapped() {
        NSLog("Record Tapped")
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func startRecording() {
        let recordFile = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: recordFile, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordButton.setTitle("Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        
        if success {
            recordButton.setTitle("Play", for: .normal)
            recordButton.removeTarget(self, action: #selector(recordTapped), for: .allEvents)
            recordButton.addTarget(self, action: #selector(playRecording), for: .touchUpInside)
        } else {
            
        }
    }
    
    @objc func playRecording() {
        
        do {
            let sound = try AVAudioPlayer(contentsOf: audioRecorder.url)
            audioPlayer = sound
            sound.play()
        } catch {
            NSLog("Couldn't play recording")
        }
        audioRecorder = nil
        recordButton.setTitle("Record", for: .normal)
        recordButton.removeTarget(self, action: #selector(playRecording), for: .allEvents)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
    }
    
    @objc func listenTapped() {
        
        let testUtterance = AVSpeechUtterance(string: "僕の海は猫になるだ")
        testUtterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        testUtterance.rate = 0.3
        synth.speak(testUtterance)
    }
    
    @objc func startQuiz() {
//        cardsCV?.scrollToItem(at: IndexPath(row: 0, section: 0),
//                                          at: .top,
//                                          animated: true)
//        cardsCV?.contentOffset.x = 0
        cardsCV?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }

}

extension DeckCollectionViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog(String(indexPath.item))
    }
}

extension DeckCollectionViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Deck.shared.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCardCell.identifier, for: indexPath as IndexPath) as! DeckCardCell
        //if cell.flipped { cell.flipCard() }
        cell.cardFront.frontText.text = Deck.shared.cards[indexPath.item].frontText
        return cell
    }
}
