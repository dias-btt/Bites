import SwiftUI

struct MyDataView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = "Ayana"
    @State private var email: String = "qwerty123@gmail.com"
    @State private var phone: String = "+7 777 365 8945"
    @State private var birthDate: Date = Date()
    @State private var showDatePicker: Bool = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
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
                                        
                    Text("Мои данные")
                        .font(.custom("SF-Pro-Display-Bold", size: 34))
                    
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 20) {
                    LabelledTextField(label: "Name", text: $name)
                    LabelledTextField(label: "Email", text: $email, keyboardType: .emailAddress)
                    LabelledTextField(label: "Phone", text: $phone, keyboardType: .phonePad)
                    
                    LabelledDateTextField(label: "Birth Date", date: $birthDate, dateFormatter: dateFormatter)
                        .onTapGesture {
                            showDatePicker = true
                        }
                }
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showDatePicker) {
            DatePicker("Select Birth Date", selection: $birthDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Done") {
                            showDatePicker = false
                        }
                    }
                }
        }
    }
}

struct LabelledTextField: View {
    var label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.custom("SF Pro Display Regular", size: 15))
                .foregroundColor(.gray)
            
            TextField("", text: $text)
                .keyboardType(keyboardType)
                .padding(.vertical, 5)
            
            Divider()
        }
    }
}

struct LabelledDateTextField: View {
    var label: String
    @Binding var date: Date
    var dateFormatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.custom("SF Pro Display Regular", size: 15))
                .foregroundColor(.gray)
            
            Text(dateFormatter.string(from: date))
                .padding(.vertical, 5)
            
            Divider()
        }
    }
}



#Preview {
    MyDataView()
}
