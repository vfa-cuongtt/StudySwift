//
//  CameraController.swift
//  CustomCamera
//
//  Created by Tuan Cuong on 3/18/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import AVFoundation
import UIKit

class CameraController {
    
    var captuureSession: AVCaptureSession?
    var currentCameraPosition: CameraPosition?
    
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureDeviceInput?
    
    var rearCamera: AVCaptureDevice?
    var rearCameraInput: AVCaptureDeviceInput?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    var flashMode = AVCaptureDevice.FlashMode.off
    
}

extension CameraController {
    /**
     Thiết lập session
     1 tạo session
     2 thu thập và cấu hình các device
     3 tạo input = cách sử dụng device
     4 cấu hình đối tượng output để xử lý ảnh đã chụp
     **/
    func prepare(completionHandler: @escaping (Error?) ->Void) {
        func createCaptureSession() {
            self.captuureSession = AVCaptureSession()
        }
        
        func configureCaptureDevices() throws{
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
            let cameras = session.devices
            if cameras.isEmpty { throw CameraControllerError.noCamerasAvailable }
            
            for camera in cameras {
                if camera.position == .front{
                    self.frontCamera = camera
                }
                if camera.position == .back {
                    self.rearCamera = camera
                    
                    try! camera.lockForConfiguration()
                    camera.focusMode = .continuousAutoFocus
                    camera.unlockForConfiguration()
                }
            }
        }
        
        func configureDeviceInputs() throws{
            // 3
            guard let captureSession = self.captuureSession else {
                throw CameraControllerError.captureSessionIsMissing
            }
            
            // 4
            if let rearCamera = self.rearCamera {
                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
                
                if captureSession.canAddInput(self.rearCameraInput!) {
                    captureSession.addInput(self.rearCameraInput!)
                }
                
                self.currentCameraPosition = .rear
            } else if let frontCamera = self.frontCamera {
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                
                if captureSession.canAddInput(self.frontCameraInput!) {
                    captureSession.addInput(self.frontCameraInput!)
                } else {
                    throw CameraControllerError.inputsAreInvalid
                }
                
                self.currentCameraPosition = .front
            } else {
                throw CameraControllerError.noCamerasAvailable
            }
            
        }
        
        
        func configurePhotoOutput() throws{
            guard let captureSession = self.captuureSession else {
                throw CameraControllerError.captureSessionIsMissing
            }
            
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecJPEG])], completionHandler: nil)
            
            if captureSession.canAddOutput(self.photoOutput!) {
                captureSession.addOutput(self.photoOutput!)
            }
            
            captureSession.startRunning()
        }
        
        
        /** chạy bất đồng bộ, chạy đa luồng
         sync (Chặn luồng đang gọi cho đến khi nó thực hiện song)
         async (Không chặn luồng đang gọi)
         **/
        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
                try configurePhotoOutput()
            }
            
            catch {
                DispatchQueue.main.async {
                    completionHandler(error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
        
    }
    
    func displayPreview(on view: UIView) throws {
        guard let captureSession = self.captuureSession, captuureSession!.isRunning else {
            throw CameraControllerError.captureSessionIsMissing
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        view.layer.insertSublayer(self.previewLayer!, at: 0)
        self.previewLayer?.frame = view.frame
    }
    
    
    func swichCameras() throws {
        // 5
        guard let currentCameraPosition = currentCameraPosition,
            let captureSession = self.captuureSession, captuureSession!.isRunning
            else {
                throw CameraControllerError.captureSessionIsMissing
            }
        // 6
        captureSession.beginConfiguration()
        
        func swichToFrontCamera() throws {
            guard let inputs = captuureSession?.inputs as? [AVCaptureInput],
                let rearCamerainput = self.rearCameraInput, inputs.contains(rearCamerainput),
                let frontCamera = self.frontCamera
                else {
                        throw CameraControllerError.invalidOperation
                }
            
            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            
            captureSession.removeInput(rearCameraInput!)
            
            if captureSession.canAddInput(self.frontCameraInput!) {
                captureSession.addInput(self.frontCameraInput!)
                
                self.currentCameraPosition = .front
            } else {
                throw CameraControllerError.invalidOperation
            }
        }
        
        func swichToRearCamera() throws {
            guard let inputs = captureSession.inputs as? [AVCaptureInput],
                let frontCameraInput = self.frontCameraInput, inputs.contains(frontCameraInput),
                let rearCamera = self.rearCamera
                else {
                    throw CameraControllerError.invalidOperation
            }
            
            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
            
            captureSession.removeInput(frontCameraInput)
            
            if captureSession.canAddInput(self.rearCameraInput!) {
                captureSession.addInput(self.rearCameraInput!)
                
                self.currentCameraPosition = .rear
            } else {
                throw CameraControllerError.invalidOperation
            }
            
            
        }
        
        //7
        switch currentCameraPosition {
        case .front:
            try swichToFrontCamera()
        case .rear:
            try swichToRearCamera()
        }
        
        // 8
        captuureSession?.commitConfiguration()
        
    }
    
    
    
}

extension CameraController {
    enum CameraControllerError: Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknow
    }
    
    public enum CameraPosition {
        case front
        case rear
    }
}
