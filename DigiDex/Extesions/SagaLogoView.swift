//
//  SagaLogoView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct SagaLogoView: View {
    let saga: Saga
    var height: CGFloat = 44
    
    var body: some View {
        Group {
            if UIImage(named: saga.logo) != nil {
                HStack(spacing: 10){
                    Image(saga.logo)
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    Text(saga.name)
                        .font(.headline)
                        .foregroundStyle(saga.accentColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        //.padding(.trailing,20)
                    
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
#Preview {

    VStack(spacing: 20) {
        SagaLogoView(saga: .previewAdventure)
    }
    .padding()
    .background(Color.digidexBorder)
  
}
