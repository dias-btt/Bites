//
//  SplashView.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                Rectangle()
                    .fill(Color("Forth"))
                    .edgesIgnoringSafeArea(.all)
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 343, height: 100)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
