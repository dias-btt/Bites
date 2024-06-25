//
//  TrackingView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.05.2024.
//

import SwiftUI
import MapKit
import CoreLocation

enum Option {
    case delivery
    case pickup
    case table
}

struct TrackingView: View {
    @StateObject var viewModel = ChooseOptionViewModel()
    @StateObject var orderViewModel = OrderViewModel()
    var option: Option
    let cafeAddress: CafeAddress
    
    @Environment(\.presentationMode) var presentationMode
    @State private var userLocation: CLLocationCoordinate2D?
    
    @State private var orderStatus: Int = 0
    let statusUpdateInterval: TimeInterval = 20
        
    // List of cafe addresses
    let cafeAddresses = [
        CafeAddress(name: "Тауелсиздик 12", coordinate: CLLocationCoordinate2D(latitude: 51.14827, longitude: 71.459456), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
        CafeAddress(name: "Центральный парк", coordinate: CLLocationCoordinate2D(latitude: 51.155618, longitude: 71.418176), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
        CafeAddress(name: "Бейбитшилик, 39", coordinate: CLLocationCoordinate2D(latitude: 51.17742, longitude: 71.416949), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
        CafeAddress(name: "Калдаякова, 12", coordinate: CLLocationCoordinate2D(latitude: 51.118769, longitude: 71.464752), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Full-screen map
                Map(
                    coordinateRegion: $viewModel.mapRegion,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow),
                    annotationItems: cafeAddresses
                ) { address in
                    MapAnnotation(coordinate: address.coordinate) {
                        VStack {
                            Image(systemName: "mug.fill") // Coffee mug icon
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.brown)
                            Text(address.name)
                                .font(.caption)
                                .background(Color.white.opacity(0.7))
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    viewModel.checkIfLocationIsEnabled()
                    orderViewModel.setCurrentOrder()
                    startTimer()
                })
                
                VStack{
                    //Back button
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
                        Spacer()
                    }
                    .padding(.top, 50)
                    .padding(.horizontal, 15)
                    
                    Spacer(minLength: 350)
                    
                    //Tracking details
                    ZStack{
                        Rectangle()
                            .edgesIgnoringSafeArea(.all)
                            .foregroundStyle(Color.white)
                            .cornerRadius(10)
                        VStack{
                            Text(option == .delivery ? "Заказ в пути" : "Заказ готовится")
                                .font(.custom("SF Pro Display Regular", size: 26))
                            Text("№\(String(orderViewModel.currentOrder?.id.suffix(4) ?? ""))")
                                .font(.custom("SF Pro Display Bold", size: 20))
                                .foregroundStyle(Color("Primary"))
                            HStack{
                                ZStack{
                                    Rectangle()
                                        .foregroundStyle(Color("Forth"))
                                        .cornerRadius(20)
                                        .frame(width: 190, height: 82)
                                    HStack{
                                        Image("location")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                        VStack{
                                            Text(option == .delivery ? "Дистанция" : "Адрес")
                                                .font(.custom("SF Pro Display Bold", size: 14))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text(option == .delivery ? "0,22 км" : cafeAddress.name)
                                                .font(.custom("SF Pro Display Bold", size:20))
                                                .foregroundStyle(Color("Primary"))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .padding()
                                
                                ZStack{
                                    Rectangle()
                                        .foregroundStyle(Color("Forth"))
                                        .cornerRadius(20)
                                        .frame(width: 190, height: 82)
                                    HStack{
                                        Image("time")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                        VStack{
                                            Text(option == .delivery ? "Время назначения" : (option == .pickup ? "Время самовывоза" : "Время заказа"))
                                                .font(.custom("SF Pro Display Bold", size: 14))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text(option == .delivery ? formattedDeliveryTimeDifference(date: orderViewModel.currentOrder?.deliveryTime, currentTime: Date()) : formattedPickupOrTableTime())
                                                .font(.custom("SF Pro Display Bold", size:20))
                                                .foregroundStyle(Color("Primary"))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding()
                                }
                            }
                            
                            Text(option == .delivery ? "Если не успеем до 17:50 - подарим 500 бонусов" : "")
                                .font(.custom("SF Pro Display Regular", size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.bottom)
                            
                            HStack {
                                ForEach(0..<4) { index in
                                    VStack{
                                        HStack{
                                            if index < 3{
                                                Circle()
                                                    .foregroundColor(orderStatus >= index ? Color("Primary") : .gray)
                                                    .frame(width: 16, height: 16)
                                                    .padding(.horizontal, 4)
                                            } else {
                                                Image("finish")
                                                    .resizable()
                                                    .frame(width: 14, height: 14)
                                            }
                                            
                                            if index < 3{
                                                Rectangle()
                                                    .foregroundColor(orderStatus >= index ? Color("Primary") : .gray)
                                                    .frame(width: 50, height: 4)
                                                    .padding(.horizontal, 2)
                                            }
                                        }
                                        switch index {
                                        case 0:
                                            Text("Приняли")
                                                .font(.custom("SF Pro Display Regular", size: 16))
                                        case 1:
                                            Text("В процессе")
                                                .font(.custom("SF Pro Display Regular", size: 16))
                                        case 2:
                                            Text("Доставляется")
                                                .font(.custom("SF Pro Display Regular", size: 16))
                                        case 3:
                                            Text("Закончен")
                                                .font(.custom("SF Pro Display Regular", size: 16))
                                        default:
                                            Text("")
                                        }
                                        
                                        switch index {
                                        case 0:
                                            Text("17:00")
                                                .font(.custom("SF Pro Display Bold", size: 14))
                                        case 1:
                                            Text("17:15")
                                                .font(.custom("SF Pro Display Bold", size: 14))
                                        case 2:
                                            Text("17:30")
                                                .font(.custom("SF Pro Display Bold", size: 14))
                                        case 3:
                                            Text("17:45")
                                                .font(.custom("SF Pro Display Bold", size: 14))
                                        default:
                                            Text("")
                                        }
                                    }
                                }
                            }
                            HStack{
                                MyCustomButton(title: "Звонок курьеру", action: {
                                    //
                                }, isActive: true)
                                
                                ZStack{
                                    Rectangle()
                                        .foregroundStyle(Color("Forth"))
                                        .cornerRadius(20)
                                        .frame(width: 55, height: 55)
                                    Image("message")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                }
                            }
                            .padding(.vertical)
                            
                            Text("")
                                .padding(.bottom, 50)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.bottom, -20)
                    }
                } // main vstack
                .edgesIgnoringSafeArea(.all)
            } // zstack
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: statusUpdateInterval, repeats: true) { timer in
            if orderStatus < 3 {
                orderStatus += 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func formattedDeliveryTimeDifference(date: Date?, currentTime: Date) -> String {
        guard let deliveryTime = date else {
            return ""
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: currentTime, to: deliveryTime)
        
        if let minutes = components.minute, minutes > 0 {
            return "Через \(minutes) мин"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone.current
            
            return dateFormatter.string(from: deliveryTime)
        }
    }
    
    private func formattedPickupOrTableTime() -> String {
        let currentTime = Date()
        let calendar = Calendar.current
        let pickupOrTableTime = calendar.date(byAdding: .minute, value: 30, to: currentTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        
        if let time = pickupOrTableTime {
            return dateFormatter.string(from: time)
        } else {
            return ""
        }
    }
}

#Preview{
    TrackingView(option: .delivery, cafeAddress: CafeAddress(name: "Sample Cafe", coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"))
}
