//
//  ESCameraCenter.swift
//  up
//
//  Created by SINN SOKLYHOR on 28/5/24.
//

import Foundation
import AVFoundation

class ESCameraCenter: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    public static let share = ESCameraCenter()
    private var captureSession: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?
    
    public var isAuthorization: Bool {
        let permission = AVCaptureDevice.authorizationStatus(for: .video)
        return permission == .authorized
    }
    
    public var isUndetermined: Bool {
        let permission = AVCaptureDevice.authorizationStatus(for: .video)
        return permission == .notDetermined
    }
    
    // Register notification if granted
    public func requestAuthorization(completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .denied:
                completionHandler(false)
            case .restricted:
                completionHandler(false)
            case .authorized:
                completionHandler(true)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        completionHandler(granted)
                    }
                }
            @unknown default:
                completionHandler(false)
            }
        }
    }

    // Function to start the camera session
    public func startSession() {
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else { return }
        
        captureSession.beginConfiguration()
        
        // Add video input
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
            captureSession.canAddInput(videoDeviceInput) else {
            return
        }
        captureSession.addInput(videoDeviceInput)
        
        // Add photo output
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.addOutput(photoOutput)
        self.photoOutput = photoOutput
        
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }

    // Function to stop the camera session
    public func stopSession() {
        captureSession?.stopRunning()
        captureSession = nil
        photoOutput = nil
    }

    // Function to capture a photo
    public func capturePhoto(completionHandler: @escaping (Data?) -> Void) {
        guard let photoOutput = photoOutput else {
            completionHandler(nil)
            return
        }
        
        let photoSettings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
        
        self.photoCaptureCompletionHandler = completionHandler
    }

    private var photoCaptureCompletionHandler: ((Data?) -> Void)?

    // AVCapturePhotoCaptureDelegate method
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            photoCaptureCompletionHandler?(nil)
        } else {
            let imageData = photo.fileDataRepresentation()
            photoCaptureCompletionHandler?(imageData)
        }
    }
}
