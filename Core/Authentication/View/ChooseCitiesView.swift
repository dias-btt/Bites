//
//  ChooseCitiesView.swift
//  Bites
//
//  Created by Диас Сайынов on 02.04.2024.
//

import SwiftUI

struct ChooseCitiesView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var isNextViewActive = false
    let cities = ["Астана", "Алматы", "Шымкент"]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text("Город")
                        .font(.custom("SF Pro Display Bold", size: 34))
                    
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(cities, id: \.self) { city in
                        HStack {
                            Text(city)
                                .font(.custom("SF Pro Display Regular", size: 20))
                            Spacer()
                            Image(viewModel.city == city ? "check" : "uncheck")
                                .foregroundColor(Color("Primary"))
                                .onTapGesture {
                                    viewModel.city = city
                                }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: NameBirthView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(viewModel), isActive: $isNextViewActive) {
                        CustomButtonView(action: {
                            isNextViewActive = true
                        }, label: "Продолжить", isDisabled: viewModel.city.isEmpty)
                    }
                    .padding()
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ChooseCitiesView()
}
