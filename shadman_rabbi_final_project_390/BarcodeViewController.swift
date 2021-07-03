//
//  BarcodeViewController.swift
//  shadman_rabbi_final_project_390
//
//  Created by Shadman UR Rabbi on 7/2/21.
//

import UIKit
import Vision
import AVFoundation

class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var camerafeedback = AVCaptureVideoPreviewLayer()
    var captureSession = AVCaptureSession()
    
    /**
     Get the  Vision Request
     */
    lazy var detectBarcodeRequest = VNDetectBarcodesRequest { request, error in
      guard error == nil else {
        self.showAlert(
          withTitle: "Barcode error",
          message: error?.localizedDescription ?? "error")
        return
      }
      self.processClassification(request)
    }
    
    
    /**
            view Load func
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissions()
        setupCameraLiveView()
        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    /**live camera Setup*/
    
    private func setupCameraLiveView() {
      // TODO: Setup captureSession
      captureSession.sessionPreset = .hd1280x720

      // TODO: Add input
      let videoDevice = AVCaptureDevice
        .default(.builtInWideAngleCamera, for: .video, position: .back)

      guard
        let device = videoDevice,
        let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
        captureSession.canAddInput(videoDeviceInput) else {
          showAlert(
            withTitle: "Cannot Find Camera",
            message: "There seems to be a problem with the camera on your device.")
          return
        }

      captureSession.addInput(videoDeviceInput)

      // TODO: Add output
      let captureOutput = AVCaptureVideoDataOutput()
      // TODO: Set video sample rate
      captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
      captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
      captureSession.addOutput(captureOutput)

      configurePreviewLayer()

      // TODO: Run session
      captureSession.startRunning()
    }
    
    private func configurePreviewLayer() {
      let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      cameraPreviewLayer.videoGravity = .resizeAspectFill
      cameraPreviewLayer.connection?.videoOrientation = .portrait
      cameraPreviewLayer.frame = view.frame
      view.layer.insertSublayer(cameraPreviewLayer, at: 0)
    }
    
    /**
            Vision Request Handler
     */
    
    func processClassification(_ request: VNRequest) {
      // TODO: Main logic
      guard let barcodes = request.results else { return }
      DispatchQueue.main.async { [self] in
        if captureSession.isRunning {
          view.layer.sublayers?.removeSubrange(1...)

          for barcode in barcodes {
            guard
              // TODO: Check for QR Code symbology and confidence score
              let potentialQRCode = barcode as? VNBarcodeObservation,
              potentialQRCode.symbology == .QR,
              potentialQRCode.confidence > 0.9
              else { return }

            
          }
        }
      }
    }

    /**
            Observation Handler
     */
    
    
    /**
     check permission
     */
    private func checkPermissions() {
      // TODO: Checking permissions
      switch AVCaptureDevice.authorizationStatus(for: .video) {
      case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { [self] granted in
          if !granted {
            self.showPermissionsAlert()
          }
        }
      case .denied, .restricted:
        showPermissionsAlert()
      default:
        return
      }
    }
    
    
    
    private func showAlert(withTitle title: String, message: String) {
      DispatchQueue.main.async {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
      }
    }

    private func showPermissionsAlert() {
      showAlert(
        withTitle: "Camera Permissions",
        message: "Please open Settings and grant permission for this app to use your camera.")
    }

}
