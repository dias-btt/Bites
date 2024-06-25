//
//  ContactsView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.04.2024.
//
import SwiftUI
import MapKit

struct ContactsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isMap: Bool = true
    @State private var isList: Bool = false
    @StateObject var viewModel = ChooseOptionViewModel()

    // List of cafe addresses
    let cafeAddresses = [
        CafeAddress(name: "Тауелсиздик 12", coordinate: CLLocationCoordinate2D(latitude: 51.14827, longitude: 71.459456), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
        CafeAddress(name: "Центральный парк", coordinate: CLLocationCoordinate2D(latitude: 51.155618, longitude: 71.418176), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
        CafeAddress(name: "Бейбитшилик, 39", coordinate: CLLocationCoordinate2D(latitude: 51.17742, longitude: 71.416949), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
        CafeAddress(name: "Калдаякова, 12", coordinate: CLLocationCoordinate2D(latitude: 51.118769, longitude: 71.464752), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00"),
    ]
    
    // Social media links
    let instagramLink = "https://www.instagram.com/"
    let facebookLink = "https://www.facebook.com/"
    let tiktokLink = "https://www.tiktok.com/"
    let youtubeLink = "https://www.youtube.com/"

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        isMap = true
                        isList = false
                    } label: {
                        Text("Карта")
                            .font(.custom(isMap ? "SF Pro Display Medium" : "SF Pro Display Regular", size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(isMap ? Color("Primary") : Color.clear)
                            .foregroundColor(isMap ? .white : Color("Primary"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Primary"), lineWidth: 1)
                            )
                    }
                    
                    Button {
                        isMap = false
                        isList = true
                    } label: {
                        Text("Лист")
                            .font(.custom(isList ? "SF Pro Display Medium" : "SF Pro Display Regular", size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(isList ? Color("Primary") : Color.clear)
                            .foregroundColor(isList ? .white : Color("Primary"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Primary"), lineWidth: 1)
                            )
                    }
                }
                .padding(.top, 20)
                
                if isMap {
                    ZStack{
                        Map(
                            coordinateRegion: $viewModel.mapRegion,
                            interactionModes: .all,
                            //showsUserLocation: true,
                            userTrackingMode: .constant(.follow),
                            annotationItems: cafeAddresses
                        ) { address in
                            MapAnnotation(coordinate: address.coordinate) {
                                VStack {
                                    Image("cafe_point")
                                        .resizable()
                                        .frame(width: 34, height: 55)
                                        .foregroundColor(Color("Primary"))
                                    Text(address.name)
                                        .font(.caption)
                                }
                            }
                        }
                        .edgesIgnoringSafeArea(.all)
                    }
                    .onAppear {
                        viewModel.setMapRegionToShowCafe(cafeAddress: cafeAddresses.first)
                    }
                }
                
                if isList {
                    VStack(spacing: 30) {
                        ForEach(contacts) { contact in
                            ContactView(contact: contact)
                        }
                        
                        HStack {
                            // Social media links
                            Button(action: {
                                openURL(instagramLink)
                            }) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color("ProfileBack"))
                                        .cornerRadius(11)
                                        .frame(width: 62, height: 62)
                                    Image("whatsapp")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                }
                            }
                            
                            Button(action: {
                                openURL(facebookLink)
                            }) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color("ProfileBack"))
                                        .cornerRadius(11)
                                        .frame(width: 62, height: 62)
                                    Image("instagram")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                }
                            }
                            
                            Button(action: {
                                openURL(tiktokLink)
                            }) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color("ProfileBack"))
                                        .cornerRadius(11)
                                        .frame(width: 62, height: 62)
                                    Image("tiktok")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                }
                            }
                            
                            Button(action: {
                                openURL(youtubeLink)
                            }) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color("ProfileBack"))
                                        .cornerRadius(11)
                                        .frame(width: 62, height: 62)
                                    Image("youtube")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
            }
            .padding()  // Padding for the main content
        }
    }
    
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ContactsView()
}
