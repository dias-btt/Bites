//
//  ChooseOptionView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.05.2024.
//
import SwiftUI
import MapKit
import CoreLocation

struct ChooseOptionView: View {
    @StateObject var viewModel = ChooseOptionViewModel()

    @Binding var isDelivery: Bool
    @Binding var isPickup: Bool
    @Binding var isTable: Bool
    
    //for table option
    @State private var isCafeSelected = false
    @State private var isTableSelected = false
    @Binding var tableNumber: String
    var dismissAction: (() -> Void)?
    
    //for delivery option
    @State private var isAddressSelected = false
    @Binding var selectedAddress: Address?
    
    //for pickup option
    @Binding var selectedCafe: CafeAddress?

    @Environment(\.presentationMode) var presentationMode
    @State private var userLocation: CLLocationCoordinate2D?
        
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
                })

                // Top buttons in an HStack
                VStack {
                    HStack(spacing: 0) {
                        Button(action: {
                            // Logic for map view
                            isDelivery = true
                            isPickup = false
                            isTable = false
                        }) {
                            Text("Доставка")
                                .font(.custom(isDelivery ? "SF Pro Display Bold" : "SF Pro Display Regular", size: 16))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(isDelivery ? Color("Primary") : Color.clear)
                                .foregroundColor(isDelivery ? .white : Color("Primary"))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("Primary"), lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            // Logic for list view
                            isDelivery = false
                            isPickup = true
                            isTable = false
                        }) {
                            Text("Самовывоз")
                                .font(.custom(isPickup ? "SF Pro Display Bold" : "SF Pro Display Regular", size: 16))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(isPickup ? Color("Primary") : Color.clear)
                                .foregroundColor(isPickup ? .white : Color("Primary"))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("Primary"), lineWidth: 1)
                                )
                        }
                        
                        // Third button for a different action
                        Button(action: {
                            isDelivery = false
                            isPickup = false
                            isTable = true
                        }) {
                            Text("За столик")
                                .font(.custom(isTable ? "SF Pro Display Bold" : "SF Pro Display Regular", size: 16))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(isTable ? Color("Primary") : Color.clear)
                                .foregroundColor(isTable ? .white : Color("Primary"))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("Primary"), lineWidth: 1)
                                )
                        }
                    }
                    .padding()
                    //If table option is selected
                    Spacer()
                    if (isTable){
                        TableCafeView(isCafeSelected: $isCafeSelected, selectedCafe: $selectedCafe, isTableSelected: $isTableSelected, cafeAddresses: cafeAddresses, viewModel: viewModel, tableNumber: $tableNumber) {
                            // Dismiss action closure
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                    //If delivery option is selected
                    if (isDelivery){
                        DeliveryOptionView(viewModel: viewModel, isAddressSelected: $isAddressSelected, selectedAddress: $selectedAddress){
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                    //If pickup option is selected
                    if (isPickup){
                        PickupView(isCafeSelected: $isCafeSelected, selectedCafe: $selectedCafe, cafeAddresses: cafeAddresses, viewModel: viewModel){
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}
