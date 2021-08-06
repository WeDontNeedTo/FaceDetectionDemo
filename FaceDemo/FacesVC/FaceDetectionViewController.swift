//
//  FaceDetectionViewController.swift
//  FaceDemo
//
//  Created by Danil on 06.08.2021.
//

import UIKit
import ARKit

class FaceDetectionViewController: UIViewController {

    @UseAutoLayout var numberOfFaces: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .orange
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Face detection"
        setupLayout()
        setupCamera()
    }
}

// MARK: - setup layout
extension FaceDetectionViewController {
    private func setupLayout() {
        setupFacesCountLabel()
        self.numberOfFaces.text = "0 face(s)"
    }
    
    private func setupFacesCountLabel() {
        view.addSubview(numberOfFaces)
        NSLayoutConstraint.activate([
            numberOfFaces.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberOfFaces.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}

// MARK: - camera
extension FaceDetectionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    private func setupCamera() {
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
        let request = VNDetectFaceRectanglesRequest { req, err in
            if let err = err {
                debugPrint("error in \(#function) -->>>", err)
                return
            }
            
            DispatchQueue.main.async {
                if let results = req.results {
                    self.numberOfFaces.text = "\(results.count) face(s)"
                }
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                try handler.perform([request])
            } catch {
                debugPrint("failed to perform request in \(#function)")
            }
        }
    }
}

