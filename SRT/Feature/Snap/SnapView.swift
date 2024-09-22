import SwiftUI
import AVFoundation

struct SnapView: View {
    @StateObject var camera = CameraModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // 메뉴 버튼 액션
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
            }

            Spacer()

            ZStack{
                Rectangle()
                    .frame(width: 400, height: 450)
                CameraPreviewLayer(session: camera.session)
                    .frame(height: 400)
                    .cornerRadius(10)
                    .onAppear {
                        camera.Check() 
                    }
            }

            Spacer()
            
    
            Button(action: {
                camera.takePicture()
            }) {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .background(Color.white.ignoresSafeArea())  // 전체 배경 검은색
        .alert(isPresented: $camera.alert) {
            Alert(title: Text("카메라 접근이 거부되었습니다"), message: Text("설정에서 카메라 접근 권한을 허용해 주세요."), dismissButton: .default(Text("확인")))
        }
    }
}

struct CameraPreviewLayer: UIViewRepresentable {
    var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        // 카메라 미리보기 레이어 추가
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // 필요 시 업데이트 처리
    }
}

struct SnapView_Previews: PreviewProvider {
    static var previews: some View {
        SnapView()
    }
}
