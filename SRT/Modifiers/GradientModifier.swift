//
//  GradientModifier.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import SwiftUI

enum GradientStyle {
    case foreground
    case background
}

struct GradientModifier: ViewModifier {
    var style: GradientStyle
    
    func body(content: Content) -> some View {
        switch style{
        case .foreground:
            content
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [.gradient1,.gradient2]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        case .background:
            content
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.gradient1, .gradient2]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
    }
}

extension View {
    func customGradient(style: GradientStyle = .foreground) -> some View {
        self.modifier(GradientModifier(style: style))
    }
}
