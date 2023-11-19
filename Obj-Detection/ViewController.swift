//
//  ViewController.swift
//  Obj-Detection
//
//  Created by Adonis Serrano on 11/11/23.
//

import UIKit
import SwiftUI
import AVFoundation

class ViewController: UIViewController {
    private var permissionGranted = false
    
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    private var previewLayer = AVCaptureVideoPreviewLayer()
    var screenRect: CGRect! = nil // For view dimensions
    
    override func viewDidLoad() {
        checkPermission()
        
        sessionQueue.async { [unowned self] in
            guard permissionGranted else {return}
            self.setupCaptureSession()
            self.captureSession.startRunning()
        }
    }
    
    func checkPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            permissionGranted = true
            
        case .notDetermined:
            requestPermission()
            
        default:
            permissionGranted = false
        }
    }
    
    func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {[unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        })
    }
    
    func setupCaptureSession () {
        // Access Camera
        guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera,for: .video, position: .back) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
                   
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        // Add preview layer
        screenRect = UIScreen.main.bounds
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: 0.9*screenRect.size.height)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        previewLayer.connection?.videoOrientation = .portrait
        
        // Update to UI must be on the main queue
        DispatchQueue.main.async { [weak self] in self!.view.layer.addSublayer(self!.previewLayer)
        }
    }
}

struct HostedViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // text
    }
}
