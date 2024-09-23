//
//  CameraModel.swift
//  SRT
//
//  Created by 박성민 on 9/22/24.
//

import Foundation
import AVFoundation
import UIKit

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var isTaken = false
    @Published var photoData: Data?
    var output = AVCapturePhotoOutput()
    
    func Check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    DispatchQueue.main.async {
                        self.setUp()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alert = true
                    }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.alert = true
            }
        default:
            break
        }
    }

    func setUp() {
        do {
            self.session.beginConfiguration()

            guard let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
                  ?? AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                print("카메라 장치를 찾을 수 없습니다.")
                return
            }

            let input = try AVCaptureDeviceInput(device: device)

            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }

            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async {
                self.session.startRunning()
            }
            
        } catch {
            print("카메라 설정 중 오류 발생: \(error)")
        }
    }

    func takePicture() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        
        self.output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("사진 처리 중 오류 발생: \(error.localizedDescription)")
            return
        }

        guard let imageData = photo.fileDataRepresentation() else {
            print("이미지 데이터를 가져올 수 없습니다.")
            return
        }

        DispatchQueue.main.async {
            self.photoData = imageData
            self.isTaken = true  // 사진이 촬영되었음을 표시
        }
    }
}
