//
//  ScanDocumentView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/4/21.
//  Credits to Stefan Blos: https://medium.com/swlh/on-device-text-recognition-on-ios-with-swiftui-dd499b9eec0b

import SwiftUI
import VisionKit
import Vision

//uses system’s native document scanner and allows to  extract data from camera feed

struct ScanDocumentView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: String

    typealias UIViewControllerType = VNDocumentCameraViewController

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        
        var recognizedText: Binding<String>
        var parent: ScanDocumentView
        
        init(recognizedText: Binding<String>, parent: ScanDocumentView) {
            self.recognizedText = recognizedText
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // do the processing of the scan
            let extractedImages = extractImages(from: scan)
            let processedText = recognizeText(from: extractedImages)
            recognizedText.wrappedValue = processedText
            parent.presentationMode.wrappedValue.dismiss()
            
        }
        
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            for index in 0..<scan.pageCount {
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else { continue }
                
                extractedImages.append(cgImage)
            }
            return extractedImages
        }
        
        fileprivate func recognizeText(from images: [CGImage]) -> String {
            var entireRecognizedText = ""
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                let maximumRecognitionCandidates = 1
                for observation in observations {
                    guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                    
                    entireRecognizedText += "\(candidate.string)\n"
                    
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
//            recognizeTextRequest.recognitionLevel = .fast

            
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                
                try? requestHandler.perform([recognizeTextRequest])
            }
            
            return entireRecognizedText
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController

        }
        
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
            // nothing to do here
    }
}
