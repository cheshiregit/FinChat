//
//  ViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 07/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var newImageView: UIView!
    @IBOutlet weak var newImageButton: UIButton!
    
    @IBAction func clickNewImageButton(_ sender: Any) {
        print("Выбери изображение профиля")
        let alertController = UIAlertController(title: "Выберете фото", message: nil, preferredStyle: .actionSheet)
        
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
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLogging()
        newImageView.layer.cornerRadius = newImageView.frame.size.width / 2
        userImage.layer.cornerRadius = 50
        userImage.clipsToBounds = true
        imagePicker.delegate = self
        print("ViewDidLoad Frame кнопки 'Редактировать': \(editButton.frame)")
        //Здесь контроллер загрузился в память, у элементов, в частности кнопки, есть начальная позиция (initial position)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isLogging()
        print("ViewDidAppear Frame кнопки 'Редактировать': \(editButton.frame)")
        //Здесь уже были закончены все расчеты точного расположения элементов и метод вызван после того как View отобразилась
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //print("Init Frame кнопки 'Редактировать': \(editButton.frame)")
        print("Init - проблема в том, что в момент инициализации еще не созданы объекты")
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
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

extension UIViewController {
    func isLogging(_ function: String = #function) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            appDelegate.loggingOn
            else {
                return
        }
        print(function)
    }
}
