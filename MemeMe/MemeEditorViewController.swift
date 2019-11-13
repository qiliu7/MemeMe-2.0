//
//  ViewController.swift
//  MemeMe
//
//  Created by Kappa on 2019/11/13.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {
  
  let memeTextAttributes: [NSAttributedString.Key: Any] = [
    .strokeColor: UIColor.black,
    .foregroundColor: UIColor.white,
    .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    .strokeWidth: -3.0]

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var albumButton: UIBarButtonItem!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let textFields = [topTextField, bottomTextField]
    
    for field in textFields {
      field?.delegate = self
      field?.defaultTextAttributes = memeTextAttributes
      field?.textAlignment = .center
      field?.borderStyle = .none
    }
    topTextField.text = "TOP"
    bottomTextField.text = "BOTTOM"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
  }
  
  @IBAction private func pickAnImage(_ sender: UIBarButtonItem) {
    
    let imagePicker = UIImagePickerController()
    
    switch sender {
    case cameraButton:
      imagePicker.sourceType = .camera
    case albumButton:
      imagePicker.sourceType = .photoLibrary
    default:
      break
    }
    
    imagePicker.delegate = self
    present(imagePicker, animated: true, completion: nil)
  }
}

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      imageView.image = image
    }
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
}

extension MemeEditorViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.text == "TOP" || textField.text == "BOTTOM" {
      textField.text = ""
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

