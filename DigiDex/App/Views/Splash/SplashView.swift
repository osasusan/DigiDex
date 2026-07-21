//
//  SplashView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct SplashView: View {
    @Binding var isShowing: Bool
    @State private var progress: Double = 0
    var body: some View {
      ZStack {
          Color.digidexBackground.ignoresSafeArea()
          
          VStack (spacing:35){
              Spacer()
              
              VStack(spacing: 8) {
                  Text("DIGIDEX")
                      .font(.system(size: 42,weight: .heavy,design: .rounded))
                      .foregroundStyle(.white)
                  Text("EVOLUTIVA")
                      .font(.system(size: 18,weight: .semibold,design: .rounded))
                      .foregroundStyle(.digidexAmber)
                      .tracking(4)
              }
              Spacer()
              VStack(spacing: 10) {
                  ProgressView(value: progress)
                      .tint(.digidexAmber)
                      .frame(width: 200)
                  Text("Cargando...")
                      .font(.caption)
                      .foregroundStyle(.digidexTextSecondary)
              }
              .padding(.bottom,60)
          }
        }
      .task{
          await simulatedLoading()
      }
        
    }
    private func simulatedLoading() async {
        let totalSteps  = 20
        for step in 1...totalSteps {
            try? await Task.sleep(for: .microseconds(50))
            progress = Double(step) / Double(totalSteps)
        }
        try? await Task.sleep(for: .milliseconds(200))
        withAnimation(.easeInOut) {
            isShowing = false
        }
       
    }
}

#Preview {
    SplashView(isShowing: .constant(true))
}
