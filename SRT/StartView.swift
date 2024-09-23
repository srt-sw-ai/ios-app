//
//  StartView.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                    .frame(height: 100)
                Image("SRTLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230)
                
                Spacer()
                    .frame(height: 200)
                
                HStack{
                    Text("Safety Report")
                        .font(.system(size: 32,weight: .bold))
                    
                    Text("SRT")
                        .font(.system(size: 32,weight: .bold))
                        .customGradient(style: .foreground)
                }
                
                NavigationLink{
                    LoginView()
                        .navigationBarBackButtonHidden()
                }label:{
                    CustomButton(label: "시작하기")
                }
                
                Spacer()
                    .frame(height: 50)
                
                Button(
                    action: {},
                    label: {
                        Text("도움말 보기")
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                )
            }
        }
    }
}

#Preview {
    StartView()
}
