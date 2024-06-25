//
//  ChoseDeliveryTimeView.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//

import SwiftUI

struct ChooseDeliveryTimeModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isEarlier: Bool // Binding to indicate early delivery
    @Binding var selectedTime: Date
    
    @State private var showDatePicker = false // Manage the state for showing the date picker
    
    let timeLocale = Locale(identifier: "en_US") // 12-hour format with AM/PM
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Cancel button
                }, label: {
                    Text("Отмена")
                        .foregroundColor(Color("Primary"))
                })
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Save button
                }, label: {
                    Text("Сохранить")
                        .foregroundColor(.gray)
                })
            }
            
            Text("Время доставки")
                .font(.custom("SF-Pro-Display-Bold", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 15)
            
            // Earlier delivery option
            Button(action: {
                isEarlier.toggle() // Toggle the state
            }, label: {
                HStack {
                    Text("Как можно раньше")
                        .font(.custom("SF-Pro-Display-Bold", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(isEarlier ? Color("Primary") : .black)
                    
                    Image(isEarlier ? "check" : "uncheck")
                        .resizable()
                        .frame(width: 31, height: 31)
                }
            })
            .padding(.top, 20)
            
            Divider()
                .padding(.top, 5)

            // Button to open the date picker
            Button(action: {
                showDatePicker = true // Show the date picker
            }, label: {
                HStack {
                    VStack{
                        Text("Выбрать день и время")
                            .font(.custom("SF-Pro-Display-Bold", size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Выберите время доставки")
                            .font(.custom("SF-Pro-Display-Bold", size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 9, height: 16)
                }
            })
            .padding(.top, 20)
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    DatePicker(
                        "Выберите время",
                        selection: $selectedTime,
                        in: calendar.startOfDay(for: Date()) ... calendar.date(byAdding: .day, value: 1, to: Date())!, // Changed "..<" to "..."
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .environment(\.locale, timeLocale) // Set the 12-hour locale
                    
                    Button("Сохранить") { // Save the selected time
                        showDatePicker = false // Hide the picker
                    }
                    .padding()
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            
            Divider()
                .padding(.top, 5)
            
            MyCustomButton(title: "Готово", action: {
                presentationMode.wrappedValue.dismiss()
            }, isActive: true)
            .padding(.top, 10)
        }
        .padding()
    }
}

#Preview {
    ChooseDeliveryTimeModalView(
        isEarlier: .constant(false), // Test binding
        selectedTime: .constant(Date()) // Test binding
    )
}
