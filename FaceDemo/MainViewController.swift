//
//  ViewController.swift
//  FaceDemo
//
//  Created by Danil on 06.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - properties
    @UseAutoLayout var faceMaskButton: UIButton = {
        let btn = UIButton(buttonTitle: "Face Mask", buttonBackground: .systemOrange)
        btn.addTarget(self, action: #selector(faceMaskBtnAction), for: .touchUpInside)
        return btn
    }()
    
    @UseAutoLayout var faceDetectionButton: UIButton = {
        let btn = UIButton(buttonTitle: "Face Detection", buttonBackground: .systemRed)
        btn.addTarget(self, action: #selector(faceDetectionBtnAction), for: .touchUpInside)
        return btn
    }()
    
    @UseAutoLayout var faceRecognizeButton: UIButton = {
        let btn = UIButton(buttonTitle: "Face Recognize", buttonBackground: .systemBlue)
        btn.addTarget(self, action: #selector(faceRecognizerBtnAction), for: .touchUpInside)
        return btn
    }()

    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .systemOrange
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationItem.title = "Vision demo"
            
        setupLayout()
    }


}
// MARK: - buttons actions
extension MainViewController {
    @objc func faceMaskBtnAction() {
        navigationController?.pushViewController(FaceMaskViewController(), animated: true)
    }
    
    @objc func faceDetectionBtnAction() {
        navigationController?.pushViewController(FaceDetectionViewController(), animated: true)
    }
    
    
    @objc func faceRecognizerBtnAction() {
        navigationController?.pushViewController(FaceRecognizerViewController(), animated: true)
    }
    
}

// MARK: - setup layout
extension MainViewController {
    private func setupLayout() {
        setupFaceMaskButton()
        setupFaceDetectionButton()
        setupFaceRecognizeButton()
    }
    
    
    private func setupFaceMaskButton() {
        view.addSubview(faceMaskButton)
        NSLayoutConstraint.activate([
            faceMaskButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -45),
            faceMaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),
            faceMaskButton.widthAnchor.constraint(equalToConstant: 80),
            faceMaskButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupFaceDetectionButton() {
        view.addSubview(faceDetectionButton)
        NSLayoutConstraint.activate([
            faceDetectionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -45),
            faceDetectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70),
            faceDetectionButton.widthAnchor.constraint(equalToConstant: 80),
            faceDetectionButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupFaceRecognizeButton() {
        view.addSubview(faceRecognizeButton)
        NSLayoutConstraint.activate([
            faceRecognizeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
            faceRecognizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),
            faceRecognizeButton.widthAnchor.constraint(equalToConstant: 80),
            faceRecognizeButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

