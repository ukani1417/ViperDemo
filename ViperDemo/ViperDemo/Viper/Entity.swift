//
//  Entity.swift
//  ViperDemo
//
//  Created by Dhruv Ukani on 21/10/23.
//

import Foundation

// MARK: - Contact
struct Contact: Decodable {
    let firstName, lastName, email: String
    let number: Int
}

// MARK: - ContactList
struct ContactList: Decodable {
    let total: Int
    let documents: [Contact]
    
    
}
