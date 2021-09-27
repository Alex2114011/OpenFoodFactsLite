//
//  ScanScreenAVExtension.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 26.09.2021.
//

import AVFoundation
extension ScanScreenViewController {
    func setupAndStartCaptureSession() {
        // DispatchQueue нужен так как startRunning блокирует очередь в которой запускается
        DispatchQueue.global(qos: .userInitiated).async { // swiftlint:this line_length
            // инициализируем сессию
            self.captureSession = AVCaptureSession()
            // начало конфигурации
            self.captureSession.beginConfiguration()

            // делаем пресет на самое лучшее качество фото и если ок то устанавливаем его
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            // включаем широкое цветовое пространство
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true // swiftlint:this line_length

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

        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
            return } // нужно теперь нашу камеру превратить в объект ввода

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
            self.view.layer.insertSublayer(self.previewLayer, below: self.rootStackView.layer)
        }
    }
}
