// AuthServiceProtocol.swift
import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<SimpleUser, Error>) -> Void)
//    func signOut() throws
}
