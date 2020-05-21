//
//  PhotoViewController.swift
//  vietagreport
//  Edit image, Capture camera with vintage effect photo
//
//
//  Created by Hoi Dang Quoc on 5/20/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

/// https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/capturing_photos_with_depth
/// https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/avcamfilter_applying_filters_to_a_capture_stream

protocol PhotoDisplayLogic {
    
}

class PhotoViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    lazy var photoView: PhotoView = { [unowned self] in
        let view = PhotoView()
        view.backgroundColor = UIColor.white
        view.capturePhotoButton.addTarget(self, action: #selector(capturePhotoButtonPressed(_:)), for: .touchUpInside)
        return view
    }()
    
    var captureSession: AVCaptureSession?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var captureDevice: AVCaptureDevice?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    deinit {
        debugPrint("PhotoViewController deinit")
    }
    
    
    override func loadView() {
        view = photoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWhenLoad()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
    }
    
    func configureWhenLoad() {
        self.captureSession = AVCaptureSession()
        self.captureSession?.sessionPreset = .photo
        self.capturePhotoOutput = AVCapturePhotoOutput()
        self.captureDevice = AVCaptureDevice.default(for: .video)
        
        let input = try! AVCaptureDeviceInput(device: self.captureDevice!)
        self.captureSession?.addInput(input)
        self.captureSession?.addOutput(self.capturePhotoOutput!)
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
        self.previewLayer?.frame = self.view.bounds
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        self.previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.view.layer.addSublayer(self.previewLayer!)
        
        self.captureSession?.startRunning()
    }

    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        
    }

    @IBAction func capturePhotoButtonPressed(_ sender: UIButton) {
        let confirmController = UIAlertController(title: nil,
                                                  message: nil,
                                                  preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: "camera"), style: .default) { _ in
            self.prepareTakePhotoFromCamera()
        }
        
        let photoAction = UIAlertAction(title: NSLocalizedString("Photo", comment: "photo"), style: .default) { _ in
            self.prepareTakePhotoFromGallery()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "cancel action"), style: .cancel)
        
        confirmController.addAction(cameraAction)
        confirmController.addAction(photoAction)
        confirmController.addAction(cancelAction)
        self.present(confirmController, animated: true, completion: nil)
    }
    
    func prepareTakePhotoFromCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
    }
    
    func prepareTakePhotoFromGallery() {
        
    }
}
