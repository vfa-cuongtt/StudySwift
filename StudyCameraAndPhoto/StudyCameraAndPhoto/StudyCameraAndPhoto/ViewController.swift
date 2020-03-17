//
//  ViewController.swift
//  StudyCameraAndPhoto
//
//  Created by Tuan Cuong on 3/16/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func chooseImage(_ sender: AnyObject) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
//            imgPicker.sourceType = UIImagePickerController.SourceType.camera
//            imgPicker.mediaTypes = ["public.image", "public.movie"]
//            imgPicker.allowsEditing = true
//            self.present(imgPicker, animated: true, completion: nil)
//        }
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                imgPicker.sourceType = .camera
                self.present(imgPicker, animated: true, completion: nil)
            } else {
                print("Camera is available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imgPicker.sourceType = .photoLibrary
            self.present(imgPicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.contentMode = .scaleAspectFill
            imgView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
   @IBAction func saveImage(_ sender: AnyObject) {
        guard let selectImage = imgView.image else {
            print("Image not found")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(selectImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let action = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            action.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            let action = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            action.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(action, animated: true, completion: nil)
        }
    }
}

