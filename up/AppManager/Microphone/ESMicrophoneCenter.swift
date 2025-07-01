//
//  ESMicrophoneCenter.swift
//  up
//
//  Created by SINN SOKLYHOR on 28/5/24.
//

import Foundation
import AVFAudio
import AVFoundation
import UIKit
import SwiftUI

class ESPermissionCenter: NSObject, ObservableObject {
    
    public func openSetting() {
        DispatchQueue.main.async {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }
    }
}

struct AudioPreviewModel: Hashable {
    var magnitude: Float
    var color: Color
}

class ESMicrophoneCenter: ESPermissionCenter {
    
    public static let share = ESMicrophoneCenter()
    
    private var audioRecorder:AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?

    @Published public var isRecording:Bool = false
    @Published public var speakingAverage:CGFloat = 1.2
    @Published public var coutingRecord:CGFloat = 0
    @Published public var isStartRecording:Bool = false

    public var timer: Timer?
}

// MARK: Permission
extension ESPermissionCenter {
    public var isAuthorization: Bool {
        let permission = AVAudioSession.sharedInstance().recordPermission
        return permission == .granted
    }
    
    public var isUndetermined: Bool {
        let permission = AVAudioSession.sharedInstance().recordPermission
        return permission == .undetermined
    }
    
    public func requestAuthorization(completionHandler: @escaping (Bool) -> Void) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            completionHandler(true)
        case .denied:
            completionHandler(false)
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                completionHandler(granted)
            }
        @unknown default:
            completionHandler(false)
        }
    }
}

// MARK: Recorder
extension ESMicrophoneCenter {
    
    private var recordingSettings: [String: Any] {
        return [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
    }
    
    private var audioFilename: URL {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentPath.appendingPathComponent("recording.m4a")
    }
    
    private func setUpPlayAndRecordSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }
    
    private func setUpPlayBackSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }
    
    public func recording() {
        do {
            setUpPlayAndRecordSession()
            audioRecorder?.stop()
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recordingSettings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            audioRecorder?.isMeteringEnabled = true
            isRecording = true
            startUpdatingSpeakingAverage()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func stopRecording(completion: @escaping (_ url: URL)->Void) {
        isRecording = false
        audioRecorder?.stop()
        if let url = audioRecorder?.url {
            isRecording = false
            completion(url)
        }
        stopUpdatingSpeakingAverage()
    }
    
    private func startUpdatingSpeakingAverage() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            
            self.coutingRecord += 0.1
            self.isStartRecording = true

            DispatchQueue.main.async {
                self.audioRecorder?.updateMeters()
                let averagePower = self.audioRecorder?.averagePower(forChannel: 0) ?? -160
                // Normalize the power level to the range 1.0 to 1.5
                let minDb: Float = -100.0 // Minimum decibel value
                let maxDb: Float = 0.0   // Maximum decibel value
                let normalizedPower = max(0.0, min(1.0, (averagePower - minDb) / (maxDb - minDb)))
                
                // Map the normalized power to the range 1.0 to 1.5
                self.speakingAverage = CGFloat(1.0 + (normalizedPower * 3.0))
            }
        }
    }
    
    private func stopUpdatingSpeakingAverage() {
        timer?.invalidate()
        timer = nil
        speakingAverage = 1.0
        coutingRecord = 0
    }
}

// MARK: Player
extension ESMicrophoneCenter {
    
    public func resumePlayer(_ url: URL? = nil) {
        if let url = url ?? audioRecorder?.url {
            do {
                if audioPlayer?.isPlaying == true {
                    audioPlayer?.stop()
                }
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                
                setUpPlayBackSession()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func stopPlayer() {
        audioPlayer?.stop()
    }
}
