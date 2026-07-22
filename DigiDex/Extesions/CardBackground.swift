//
//  CardBackground.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import Foundation
import SwiftUI

struct CardBackground: ViewModifier {
    var cornerRadius: CGFloat = 12
    
    func body(content: Content) -> some View {
        content
            .background(Color.digidexSurface)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.digidexBorder, lineWidth: 0.7)
            )
    }
}

extension View {
    func digidexCardStyle(cornerRadius: CGFloat = 12) -> some View {
        modifier(CardBackground(cornerRadius: cornerRadius))
    }
}

struct CardBackground_Previews: View {

    var body: some View {
        VStack{
            Rectangle()
                .digidexCardStyle()
                .foregroundStyle(Color.digidexBorder)
        }
    }
}

#Preview {
    CardBackground_Previews().ignoresSafeArea()
}
