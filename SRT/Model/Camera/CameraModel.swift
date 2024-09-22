//
//  CameraModel.swift
//  SRT
//
//  Created by 박성민 on 9/22/24.
//

import Foundation
import AVFoundation
import UIKit

class CameraModel: NSObject, ObservableObject {
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var isTaken = false
    @Published var photoData: Data?

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

            let output = AVCapturePhotoOutput()
            if self.session.canAddOutput(output) {
                self.session.addOutput(output)
            }

            self.session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async {
                self.session.startRunning()  // 세션 시작
            }
            
        } catch {
            print("카메라 설정 중 오류 발생: \(error)")
        }
    }

    func takePicture() {
        // 사진 촬영 로직 추가 가능
    }
}
