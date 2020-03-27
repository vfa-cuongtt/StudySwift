//
//  ViewController.swift
//  CustomCamera
//
//  Created by Tuan Cuong on 3/18/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capturePreviewView: UIView!
    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var btnCameraMode: UIButton!
    @IBOutlet weak var btnVideoMode: UIButton!
    
    
    override var prefersStatusBarHidden: Bool { return true }
    
    let cameraController = CameraController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCaptureButton()
        
        configureCameraController()
    }

    func styleCaptureButton() {
        btnCapture.layer.borderColor = UIColor.black.cgColor
        btnCapture.layer.borderWidth = 2
        
        btnCapture.layer.cornerRadius = min(btnCapture.frame.width, btnCapture.frame.height)/2
    }

    func configureCameraController() {
        cameraController.prepare { (error) in
            if let error = error {
                print("error: \(error)")
            }
            try? self.cameraController.displayPreview(on: self.capturePreviewView)
        }
    }
    @IBAction func toggleFlash(_ sender: Any) {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            btnFlash.setImage(UIImage(named: "Flash Off Icon"), for: .normal)
        } else {
            cameraController.flashMode = .on
            btnFlash.setImage(UIImage(named: "Flash On Icon"), for: .normal)
        }
    }
    
}

