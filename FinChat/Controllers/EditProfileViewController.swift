//
//  EditProfileViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 12/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var aboutUserTextView: UITextView!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var gcdButton: UIButton!
    @IBOutlet var operationButton: UIButton!
    @IBOutlet var newImageButton: UIButton!
    
    private var dataManager: DataManager = GCDDataManager()
    
    var imagePickerTwo = UIImagePickerController()
    
    @IBAction func newImageButton(_ sender: Any) {
        print("Выбери изображение профиля")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let openGalleryAction = UIAlertAction(title: "Установить из галереи", style: .default) { (action: UIAlertAction) -> Void in
            alertController.dismiss(animated: true, completion: nil)
            self.openGallary()
        }
        let openCameraAction = UIAlertAction(title: "Сделать фото", style: .default) { (action: UIAlertAction) -> Void in
            alertController.dismiss(animated: true, completion: nil)
            self.openCamera()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (action: UIAlertAction) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(openGalleryAction)
        alertController.addAction(openCameraAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gcdButtonPressed(_ sender: Any) {
        dataManager = GCDDataManager()
        saveUserData()
        startSaving()
        
    }
    
    @IBAction func operationButtonPressed(_ sender: Any) {
        dataManager = OperationDataManager()
        saveUserData()
        startSaving()
    }
    
    func saveUserData() {
        let userProfile = Profile.init(userName: userNameTextField.text, aboutUser: aboutUserTextView.text, userImage: userImage.image)
        print(userProfile)
        dataManager.saveData(profile: userProfile, response: {(response) in
            if response == SuccessStatus.Success {
                DispatchQueue.main.async(execute: {
                    self.finishSaving()
                    self.showSuccessAlert()
                })
            }
            else {
                DispatchQueue.main.async(execute: {
                    self.finishSaving()
                    self.showErrorAlert(savingFunc: self.saveUserData)
                })
            }
        })
    }
    
    func startSaving() {
        activityIndicator.isHidden = false
        gcdButton.isEnabled = false
        operationButton.isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func finishSaving() {
        activityIndicator.stopAnimating()
        gcdButton.isEnabled = true
        operationButton.isEnabled = true
        activityIndicator.isHidden = true
    }
    
    func showSuccessAlert() {
        let successAlert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in self.dismiss(animated: true, completion: nil)}
        
        successAlert.addAction(okAction)
        
        present(successAlert, animated: true, completion: nil)
    }
    
    func showErrorAlert(savingFunc: @escaping () -> ()) {
        let errorAlert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        let repeatAction = UIAlertAction(title: "Повторить", style: .destructive) {
            (alert: UIAlertAction!) -> Void in
            savingFunc()
        }
        
        errorAlert.addAction(okAction)
        errorAlert.addAction(repeatAction)
        
        present(errorAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        imagePickerTwo.delegate = self
        userImage.layer.cornerRadius = 50
        userImage.clipsToBounds = true
        newImageButton.layer.cornerRadius = newImageButton.frame.size.width / 2
        newImageButton.clipsToBounds = true
    }
    
    func openGallary()
    {
        imagePickerTwo.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePickerTwo, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePickerTwo.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePickerTwo, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Error: \(info)")
            return
        }
        userImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
