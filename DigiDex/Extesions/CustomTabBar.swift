    //
    //  CustomTabBarr.swift
    //  DigiDex
    //
    //  Created by Osasu sanchez on 21/07/2026.
    //

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.top, 8)
        .background(Color.digidexTabBar.ignoresSafeArea(edges: .bottom))
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color.digidexBorder)
                .frame(height: 0.5)
        }
    }
    
    private func tabButton(for tab: AppTab) -> some View {
        let isSelected = selectedTab == tab
        
        return Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Rectangle()
                    .fill(isSelected ? Color.digidexAmber : Color.clear)
                    .frame(height: 3)
                
                Image(systemName: tab.icon)
                    .font(.system(size: 20))
                Text(tab.title)
                    .font(.caption2)
            }
            .foregroundStyle(isSelected ? Color.digidexAmber : Color.digidexTextSecondary)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 6)
        }
        .buttonStyle(.plain)
    }
}
#Preview{
    VStack {
        Spacer()
        CustomTabBar(selectedTab: .constant(.favorites))
    }
    .background(Color.digidexBackground)
}
