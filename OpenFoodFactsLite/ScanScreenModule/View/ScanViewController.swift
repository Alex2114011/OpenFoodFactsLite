//
//  ScanViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 22.09.2021.
//

import UIKit
import AVFoundation
// swiftlint:disable all


class ScanViewController: UIViewController {

    var presenter: ScanViewPresenterProtocol?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var metadataOutput = AVCaptureMetadataOutput()
    var backCamera: AVCaptureDevice!
    var backInput: AVCaptureInput!

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Сканер", image: UIImage(named: "barcode"), tag: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupAndStartCaptureSession()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    func setupAndStartCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async { // нужен так как startRunning блокирует очередь в которой запускается
            // инициализируем сессию
            self.captureSession = AVCaptureSession()
            // начало конфигурации
            self.captureSession.beginConfiguration()

            // тут чего то будем конфигурировать

            // делаем пресет на самое лучшее качество фото и если ок то устанавливаем его
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }

            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true // включаем широкое цветовое пространство

            // настраиваем входы
            self.setupInputs()

            // настраиваем выходы
            self.setupOutputs()

            // фиксируем конфигурацию
            self.captureSession.commitConfiguration()

            // настраиваем превью слой который будет нам отображать данные с камеры
            self.setupPreviewLayer()

            // запускаем конфигурацию
            self.captureSession.startRunning()
        }
    }


    func setupInputs() {
        // получаем заднюю камеру
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            self.backCamera = device
        } else {
            fatalError("No back camera")
        }

        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else  { return } // нужно теперь нашу камеру превратить в объект ввода

        backInput = bInput

        if !captureSession.canAddInput(backInput) {
            fatalError("Не могу добавить к сессии вход задней камеры")
        }
        captureSession.addInput(backInput)
    }

    func setupOutputs() {

        if !captureSession.canAddOutput(self.metadataOutput) {
            fatalError("не могу добавить выход ")
        }

        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.upce, // типы кодов для распознования
                                              .code39,
                                              .code39Mod43,
                                              .code93,
                                              .code128,
                                              .ean8,
                                              .ean13,
                                              .pdf417,
                                              .itf14,
                                              .interleaved2of5]
    }

    func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) // передаем в previewLayer сессию
        previewLayer.videoGravity = .resizeAspectFill // указываем как растягивать изображение с камеры
        DispatchQueue.main.async {
            let heightTabBar = self.tabBarController?.tabBar.frame.height ?? 50
            self.previewLayer.frame = CGRect(x: 0,
                                             y: 0,
                                             width: self.view.bounds.width,
                                             height: self.view.bounds.height - heightTabBar)
            self.view.layer.addSublayer(self.previewLayer)

        }
    }
}

extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {



        if let metadataObjects = metadataObjects.first {
            guard let readableObject = metadataObjects as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            presenter?.goToDetailModal(barCode: stringValue)
            self.captureSession.stopRunning()
        }
    }
}

extension ScanViewController: ScanViewProtocol {

}
