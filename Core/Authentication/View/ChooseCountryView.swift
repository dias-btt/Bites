//
//  ChooseCountryView.swift
//  Bites
//
//  Created by Диас Сайынов on 02.04.2024.
//

import SwiftUI

struct ChooseCountryView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var isNextViewActive = false // Track navigation state
    let countries = ["Қазақстан", "Россия"]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("Страна")
                        .font(.custom("SF Pro Display Bold", size: 34))
                    
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(countries, id: \.self) { country in
                        HStack {
                            if country == "Қазақстан" {
                                Image("kz")
                                    .resizable()
                                    .frame(width: 32, height: 20)
                                    .scaledToFit()
                            } else if country == "Россия" {
                                Image("rus")
                                    .resizable()
                                    .frame(width: 32, height: 20)
                                    .scaledToFit()
                            }
                            Text(country)
                                .font(.custom("SF Pro Display Regular", size: 20))
                            Spacer()
                            Image(viewModel.country == country ? "check" : "uncheck")
                                .foregroundColor(Color("Primary"))
                                .onTapGesture {
                                    viewModel.country = country
                                }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: ChooseCitiesView().navigationBarBackButtonHidden(true)
                        .environmentObject(viewModel), isActive: $isNextViewActive) {
                        CustomButtonView(action: {
                            isNextViewActive = true
                        }, label: "Продолжить", isDisabled: viewModel.country.isEmpty)
                    }
                    .padding()
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ChooseCountryView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCountryView()
    }
}
