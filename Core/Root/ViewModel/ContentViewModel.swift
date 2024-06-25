//
//  ContentViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 03.04.2024.
//
import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject{
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        setupSubscribers()
    }
    
    func setupSubscribers(){
        service.$userSession.sink{[weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink{[weak self] currentUser in
            self?.currentUser = currentUser
            print("here is current user \(currentUser)")
        }
        .store(in: &cancellables)
    }
}
