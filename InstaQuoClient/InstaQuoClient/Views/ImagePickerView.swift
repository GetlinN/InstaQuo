//
//  ImagePicker.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/31/21.
//  Credits to Mohammad Azam https://www.youtube.com/watch?v=Y-65T0YBOm4

import Foundation
import SwiftUI


// coordinator - helps with different delegate functions provided bu UIImagePickerControllerDelegate.
// Coordinator class for fetching the captured image from the camera or selected in photo library. It acts as a bridge between the UIKit and SwiftUI.

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//    takes in image and source type
    @Binding var imageSelected: UIImage?
    @Binding var isShown: Bool
    
//    is where we are defining whether the image is taken from the photo library or camera.
//    var sourceType: UIImagePickerController.SourceType = .camera
    
    init(imageSelected: Binding<UIImage?>, isShown: Binding<Bool>) {
        _imageSelected = imageSelected
        _isShown = isShown
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageSelected = uiImage
            isShown = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    // ImagePicker is responsible for delegating the task to coordinator. The coordinator will do the work and give me an image. This helps us to use UIKit in SwiftUI) protocol.
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    @Binding var imageSelected: UIImage?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return ImagePickerCoordinator(imageSelected: $imageSelected, isShown: $isShown)
    }
    
//   used to configure the view and responds to any changes.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
        
    }
    
    
}
