//
//  OnboardingView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.04.2024.
//
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(imageName: "onb1", text: "Добро пожаловать в Bites!", subText: "Мы рады приветствовать вас в мире вкусных десертов, ароматного кофе и неповторимых сладких радостей."),
        OnboardingPage(imageName: "onb2", text: "Удобный способ заказа", subText: "Вы можете выбрать в приложении любой способ получения заказа: доставка, самовывоз или в зале!"),
        OnboardingPage(imageName: "onb3", text: "Программа лояльности", subText: "Каждый ваш заказ приносит вам бонусные баллы, которые можно потратить на другие вкусности!")
    ]
    
    var body: some View {
        NavigationStack{
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count) { index in
                        VStack {
                            VStack {
                                Image(pages[index].imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 380, height: 380)
                                HStack{
                                    ForEach(0..<pages.count) {index in
                                        Circle()
                                            .fill(currentPage == index ? Color("Secondary") : .clear)
                                            .frame(width: 22, height: 22)
                                            .overlay(
                                                Text("\(index + 1)")
                                                    .foregroundColor(currentPage == index ? .white : Color("Secondary"))
                                            )
                                            .overlay(
                                                Circle()
                                                    .stroke(Color("Secondary"), lineWidth: 1)
                                            )
                                            .padding(.bottom, 8)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Text(pages[index].text)
                                .font(.custom("SF Pro Display Black", size: 34))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("Primary"))
                            
                            Text(pages[index].subText)
                                .font(.custom("SF Pro Display Regular", size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("Primary"))
                                .padding(.top, 15)
                        }
                        .tag(index)
                    }
                }
                
                if currentPage < pages.count - 1 {
                    Button(action: {
                        currentPage += 1
                    }) {
                        Text("Продолжить")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 100)
                            .font(.custom("SF Pro Display Bold", size: 17))
                            .background(Color("Primary"))
                            .cornerRadius(20)
                            .frame(maxWidth: .infinity)
                    }
                } else {
                    NavigationLink(destination: LoginView()
                        .navigationBarBackButtonHidden(true)) {
                            Text("Вперед за сладостями!")
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, 60)
                                .font(.custom("SF Pro Display Bold", size: 17))
                                .background(Color("Primary"))
                                .cornerRadius(20)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct OnboardingPage {
    let imageName: String
    let text: String
    let subText: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
