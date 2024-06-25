//
//  ContactView.swift
//  Bites
//
//  Created by Диас Сайынов on 03.05.2024.
//

import SwiftUI

struct ContactView: View {
    let contact: Contact
    var body: some View {
        HStack{
            Image(contact.image)
                .resizable()
                .frame(width: 187, height: 115)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    Image("location")
                        .resizable()
                        .frame(width: 19, height: 19)
                    Text(contact.address)
                        .font(.custom("SF Pro Display Regular", size: 15))
                }
                
                HStack{
                    Image("time")
                        .resizable()
                        .frame(width: 19, height: 19)
                    Text(contact.workingTime)
                        .font(.custom("SF Pro Display Regular", size: 15))
                }
                
                HStack{
                    Image("phone")
                        .resizable()
                        .frame(width: 19, height: 19)
                    Text(contact.phone)
                        .font(.custom("SF Pro Display Regular", size: 15))
                }
            }
        }
    }
}
