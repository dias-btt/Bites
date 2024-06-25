//
//  ButtonView.swift
//  Bites
//
//  Created by Диас Сайынов on 25.04.2024.
import SwiftUI

struct ButtonView: View {
    var iconName: String
    var title: String
    var action: () -> Void
    var showToggle: Bool = false
    @State private var internalToggleValue: Bool = false  // Local state for the toggle
    
    var body: some View {
        Button(action: action) {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("ProfileBack"))
                        .frame(width: 31, height: 31)
                        .cornerRadius(11)
                    Image(iconName)
                        .font(.system(size: 24))
                        .foregroundColor(Color("Primary"))
                }
                
                Text(title)
                    .font(.custom("SF Pro Display Medium", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                    .foregroundColor(.black)
                
                if showToggle {
                    Toggle("", isOn: $internalToggleValue)  // Local toggle
                        .labelsHidden()
                        .tint(Color("Primary"))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Primary"))
                }
            }
            .padding()
            .background(Color("ProfileBack"))
            .cornerRadius(20)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ButtonView(
        iconName: "prof-btn-3",
        title: "Уведомления о скидках",
        action: {
            print("Toggle clicked!")
        }
    )
}
