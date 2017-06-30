//
//  RestAPI.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/23/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import TRON
import Alamofire


struct BASE_URL {
     static let Base_Url = [51, 57, 1, 3, 26, 89, 112, 70, 60, 54, 77, 32, 0, 7, 89, 34, 63, 63, 73, 13, 121, 66, 74, 88, 81, 113, 1, 42, 33, 65, 39, 26, 6, 25, 30, 120, 10, 10, 26, 108, 14, 30, 29, 93] as [UInt8]
}

class RestAPI {
    
    fileprivate var tron : TRON!
    fileprivate let obfs : Obfuscator!
    static let rest = RestAPI()
    
    public init(){
        obfs = Obfuscator.init(withSalt: [RestAPI.self,LoginViewController.self,Obfuscator.self])
        print(obfs.reveal(key: BASE_URL.Base_Url))
        tron = TRON(baseURL: obfs.reveal(key: BASE_URL.Base_Url))
    }
    
}

extension RestAPI {
    func signUp(firstName : String!, lastName : String, email : String!, Password : String!, Profile: String!, gender : String!, completion : @escaping () -> Void) {
        let request : APIRequest<User,APIError> = RestAPI.rest.tron.request("signup")
        request.method = .post
        request.parameters = ["fname" : firstName, "lname" : lastName, "gender" : gender , "pPicture" : Profile, "email" : email, "password" : Password]
        request.perform(withSuccess: { (user) in
            completion()
            print(user)
        }) { (error) in
            print(error)
        }
    }
    
    func login(email : String!, password : String! , completion : @escaping (String) -> Void) {
        let request : APIRequest<User,APIError> = RestAPI.rest.tron.request("login")
        request.method = .post
        request.parameters = ["email" : email, "password" : password]
        request.perform(withSuccess: { (user) in
            if user.token != ""{
               completion(user.token)
            }
        }) { (error) in
            print(error)
        }
    }
}

protocol ErrorHandlingDataResponseSerializerProtocol : DataResponseSerializerProtocol {
    associatedtype SerializedError
    
    var serializeError: (Result<SerializedObject>?, URLRequest?, HTTPURLResponse?, Data?, Error?) -> APIError { get }
}
