//
//  FaceRecognizerViewController.swift
//  FaceDemo
//
//  Created by Danil on 06.08.2021.
//

import UIKit
import AVKit
import Vision
import VideoToolbox


class FaceRecognizerViewController: UIViewController {
    
    @UseAutoLayout var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .orange
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.text = "No face"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupCamera()


    }
}

extension FaceRecognizerViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    fileprivate func setupLabel() {
           view.addSubview(label)
           label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
           label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
           label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
           label.heightAnchor.constraint(equalToConstant: 80).isActive = true
       }
    
    
    fileprivate func setupCamera() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: Face(configuration: MLModelConfiguration()).model) else {
                    fatalError("Unable to load model")
                }
                
        let coreMlRequest = VNCoreMLRequest(model: model) {[weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("Unexpected results")
            }

            DispatchQueue.main.async {[weak self] in
                self?.label.text = topResult.identifier
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        DispatchQueue.global().async {
            do {
                try handler.perform([coreMlRequest])
            } catch {
                print(error)
            }
        }
        
    }
       
}
