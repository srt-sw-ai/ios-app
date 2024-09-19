//
//  CustomButton.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import SwiftUI

struct CustomButton: View {
    var action: () -> Void
    var label: String
    var body: some View {
        Button(
            action: action,
            label: {
                Text(label)
                    .font(.system(size: 20,weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 350,height: 75)
                    .customGradient(style: .background)
                    .cornerRadius(28)
            }
        )
    }
}

#Preview {
    CustomButton(action: {}, label: "asdf")
}
