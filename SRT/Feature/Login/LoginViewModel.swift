//
//  LoginViewModel.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
}
