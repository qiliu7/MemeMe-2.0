//
//  ViewController.swift
//  MemeMe
//
//  Created by Kappa on 2019/11/13.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var albumButton: UIBarButtonItem!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var topToolBar: UIToolbar!
  @IBOutlet weak var bottomToolBar: UIToolbar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
      .strokeColor: UIColor.black,
      .foregroundColor: UIColor.white,
      .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      .strokeWidth: -3.0]
    
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
    super.viewWillAppear(animated)
    
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    shareButton.isEnabled = false
    
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    unsubscribeFromKeyboardNotifications()
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
  
  @IBAction private func share() {
    let memedImage = generateMemedImage()
    let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    activityController.completionWithItemsHandler = {(ativity, success, returnedItems, error) in
      if success {
        self.save()
      }
    }
    present(activityController, animated: true, completion: nil)
  }
  
  private func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    // Only move view up when editing the bottom text field
    if bottomTextField.isFirstResponder {
      view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification)  {
    // Only move view down when finish editing the bottom text field
    if bottomTextField.isFirstResponder {
      view.frame.origin.y = 0
    }
  }
  
  private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
    let info = notification.userInfo
    let keyboardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.cgRectValue.height
  }
  
  private func save() {
    let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
  }
  
  private func generateMemedImage() -> UIImage {
    
    // Hide toolbar
    topToolBar.isHidden = true
    bottomToolBar.isHidden = true
    
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    // Show toolbar
    topToolBar.isHidden = false
    bottomToolBar.isHidden = false
    return memedImage
  }
}

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      imageView.image = image
      shareButton.isEnabled = true
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
    // If user did not input anything, show default "TOP" and "BOTTOM" again
    if textField.text == "" {
      textField.text = textField == topTextField ? "TOP" : "BOTTOM"
    }
    textField.resignFirstResponder()
    return true
  }
}

