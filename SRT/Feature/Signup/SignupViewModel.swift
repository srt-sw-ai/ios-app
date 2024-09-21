//
//  SignupViewModel.swift
//  SRT
//
//  Created by 박성민 on 9/22/24.
//

import Foundation

class SignupViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""


}
