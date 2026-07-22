//
//  SagaLogoView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct SagaLogoView: View {
    let saga: Saga
    var height: CGFloat = 52
    
    
    var body: some View {
        Group {
            if UIImage(named: saga.logo) != nil {
                HStack(spacing: 20){
                    VStack{
                        Image(saga.logo)
                            .resizable()
                            .scaledToFit()
                    }
                    .padding(10)
                    .frame(width: 80, height: 80)
                   
                    
                    Text(saga.name)
                        .font(.headline)
                        .foregroundStyle(saga.accentColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        //.padding(.trailing,20)
                    Spacer()
                }
            } else {
                Text(saga.name)
                    .font(.headline)
                    .foregroundStyle(saga.accentColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .frame(height: height)
    }
}
#Preview {
    
    ZStack() {
        Color.digidexBackground.ignoresSafeArea()
        VStack(spacing: 20) {
            SagaLogoView(saga: .previewAdventure)
        }
        .background(Color.digidexBorder)
    }
   
    
}
#if DEBUG
extension Saga {
    static let previewAdventure = Saga(
        id: 1,
        name: "Digimon Adventure",
        season: 1,
        logo: "logo_adventure",
        year: 1999,
        featured: []
    )
}
#endif
