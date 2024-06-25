//
//  AddCourierCommentModalView.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//

//
//  AddCommentModalView.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//

import SwiftUI

struct AddCourierCommentModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var commentText: String
    
    var body: some View {
        VStack {
            Text("Добавьте комментарий для ресторана")
                .font(.custom("SF-Pro-Display-Regular", size: 24))
                .multilineTextAlignment(.center)
            
            Text("Напишите комментарий")
                .font(.custom("SF-Pro-Display-Regular", size: 15))
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)

            TextField("", text: $commentText)
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            MyCustomButton(title: "Сохранить", action: {
                presentationMode.wrappedValue.dismiss()
            }, isActive: !commentText.isEmpty)
            .padding(.top, 20)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}


#Preview {
    AddCourierCommentModalView(commentText: .constant(""))
}

