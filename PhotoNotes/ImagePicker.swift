//
//  ImagePicker.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 07.01.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import UIKit
import AVFoundation

public protocol ImagePickerDelegate: class {
    func didSelect(image:UIImage?)
}

open class ImagePicker: NSObject {
    
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController ,delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        self.presentationController?.modalPresentationStyle = .overFullScreen
        self.presentationController = presentationController
        
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    

    @IBAction private func appendPhotoButtonDidTapped( _ sender: UIButton? = nil) {
        
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .authorized, .notDetermined:
            return
        case .denied, .restricted:
            showPhotoPermissionMessage()
        @unknown default:
            fatalError()
        }
    }
    
    // - MARK проверка
    private func showPhotoPermissionMessage() {
        let alert = UIAlertController(title: "Добавить фото",
                                      message: "Для добавление фото к сообщению, необходимо разрешить приложению доступ к камере телефона в настройках приложения", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "В настройки", style: .default, handler: { (action) in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            } else {
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            }
        }))
        
        self.presentationController?.present(alert, animated: true, completion: nil)
    }
    

    
    private func action( for type:UIImagePickerController.SourceType, title:String) -> UIAlertAction?{
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
            }
        return UIAlertAction(title: title, style: .default){ [unowned self] _ in
            self.pickerController.sourceType = type
            self.pickerController.modalPresentationStyle = .fullScreen
            self.presentationController?.present(self.pickerController,animated: true)
        }
    }
    
    public func present(from sourceView: UIView){
        appendPhotoButtonDidTapped()
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //надр же их всех описать
        
        if let action = self.action(for: .camera, title: "Take photo"){
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Camera roll"){
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Photo library"){
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //выводим
        
        self.presentationController?.present(alertController,animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image)
       }
    
}

extension ImagePicker: UIImagePickerControllerDelegate{
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}
extension ImagePicker: UINavigationControllerDelegate{
    
}
