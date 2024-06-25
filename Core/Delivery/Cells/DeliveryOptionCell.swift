//
//  DeliveryOptionCell.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//
import SwiftUI

struct DeliveryOptionCell: View {
    @Binding var title: String
    @Binding var subtitle: String
    let iconName: String
    
    var isDefaultSubtitle: Bool {
        return subtitle.isEmpty || subtitle == "Особые запросы, аллергии, ограничения по диете?" // Define your default text
    }

    var body: some View {
        HStack {
            Image(iconName)
                .foregroundColor(Color("Primary"))
            VStack {
                Text(title)
                    .font(.custom("SF-Pro-Display-Regular", size: 15))
                    .foregroundColor(Color("Primary"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Text(subtitle) // Use conditional coloring
                    .font(.custom("SF-Pro-Display-Regular", size: 13))
                    .foregroundColor(isDefaultSubtitle ? Color("Primary") : .black) 
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 8)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Primary"))
        }
        .padding()
        .background(Color("Fifth"))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    DeliveryOptionCell(
        title: .constant("Добавить комментарий для ресторана"),
        subtitle: .constant("Особые запросы, аллергии, ограничения по диете?"), // Default subtitle
        iconName: "comment"
    )
}

