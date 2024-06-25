//
//  ConfirmOrderView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.05.2024.
//

import SwiftUI
import CoreLocation

struct ConfirmOrderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isTrackingViewActive = false

    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss() // Back button
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text("Заказ оформлен")
                        .font(.custom("SF-Pro-Display-Bold", size: 34))
                    Spacer()
                }
                .padding()
                
                Image("confirm")
                    .resizable()
                    .frame(width: 360, height: 360)
                Text("Благодарим за заказ!")
                    .font(.custom("SF-Pro-Display-Bold", size: 30))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("Primary"))
                Text("Код заказа №15616")
                    .font(.custom("SF-Pro-Display-Bold", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("Primary"))
                    .padding(.top, 10)

                Text("Нажмите на кнопку, чтобы отслеживать свой заказ")
                    .font(.custom("SF-Pro-Display-Bold", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("Primary"))
                    .padding(.top, 15)
                    .padding(.horizontal)
                MyCustomButton(title: "Отслеживать заказ", action: {
                    isTrackingViewActive = true
                    }, isActive: true)
                .padding(.top, 20)

                NavigationLink(
                    destination: TrackingView(option: .delivery, cafeAddress: CafeAddress(name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), weekDayTime: "", weekEndTime: "")).navigationBarBackButtonHidden(true),
                    isActive: $isTrackingViewActive,
                    label: {
                        EmptyView()
                    }
                )
                Spacer()
            }
        }
    }
}

#Preview {
    ConfirmOrderView()
}
