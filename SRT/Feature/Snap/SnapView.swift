import SwiftUI
import AVFoundation

struct SnapView: View {
    @StateObject var camera = CameraModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showCapturedImage = false
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 15,height: 30)
                            .foregroundStyle(.black)
                    }
                    .padding(.leading,30)
                    
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
                    Image("SRTLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .padding()
                }
                .onReceive(camera.$photoData) { photoData in
                    if photoData != nil {
                        self.showCapturedImage = true
                    }
                }
            }
            .background(Color.white.ignoresSafeArea())
            .alert(isPresented: $camera.alert) {
                Alert(title: Text("카메라 접근이 거부되었습니다"), message: Text("설정에서 카메라 접근 권한을 허용해 주세요."), dismissButton: .default(Text("확인")))
            }
            NavigationLink(
                destination: CapturedImageView(imageData: camera.photoData ?? Data()),
                isActive: $showCapturedImage,
                label: {
                    EmptyView()
                }
            )
        }
    }
}

struct CameraPreviewLayer: UIViewRepresentable {
    var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct SnapView_Previews: PreviewProvider {
    static var previews: some View {
        SnapView()
    }
}
