//
//  LoginView.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Spacer()
                    .frame(height: 70)
                Text("로그인")
                    .font(.system(size: 28,weight: .bold))
                    .customGradient()
                
                Spacer()
                    .frame(height: 100)
                
                CustomTextField(image: "EmailLogo", text: loginViewModel.email, placehorder: "example@gmail.com")
                
                Spacer()
                    .frame(height: 30)
                
                CustomSecureField(image: "PasswordLogo", text: loginViewModel.password, placehorder: "********")
                
                Spacer()
                    .frame(height: 200)
                
                NavigationLink{
                    ReportView()
                        .navigationBarBackButtonHidden()
                }label:{
                    CustomButton(label: "로그인")
                }
                
                HStack{
                    Text("아직 계정이 없으신가요?")
                    
                    NavigationLink{
                        SignupView()
                            .navigationBarBackButtonHidden()
                    }label: {
                        Text("회원가입하기")
                            .foregroundColor(.gradient2)
                            .underline()
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
//        .environmentObject(PathModel())
}
