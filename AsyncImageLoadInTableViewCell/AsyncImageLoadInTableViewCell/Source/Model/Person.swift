//
//  Person.swift
//  AsyncImageLoadInTableViewCell
//
//  Created by Avnish Kumar on 13/03/24.
//

import Foundation

struct Person {
    let id: UUID
    let name: String
    let emailId: String
    let imageURL: String?
}

extension Person {
    
    static let persons: [Person] = [
    Person(id: UUID(), name: "Avnish", emailId: "a@mail.com", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNLC9ul-9d6TxhoPxbrFNwQV80uRsuG8qyiJNHfID-q_uaOUpKyBnnc3wB4w&s"),
    Person(id: UUID(), name: "Manish", emailId: "m@mail.com", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmW2E6kEmSQhkB4aRJxv0xxukcCy6BhCTn9sV08tuWdgItbBDNhxvMr7FAHg&s"),
    Person(id: UUID(), name: "Nishant", emailId: "n@mail.com", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-Qsd-woCD1OynH2eSKhLc37fn7INt62gNXDNnvmgcIH7PlJn5ERQCMT8KVw&s"),
    Person(id: UUID(), name: "Nitu", emailId: "ni@mail.com", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2z5XuACvtrurYUDCAvG43JhxYVm2lvblLVChH19kJ_e-QcfDOt_xWkUvFMw&s"),
    Person(id: UUID(), name: "Satyam", emailId: "s@mail.com", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4nU_k23itBITqQBvnGgKrizwxBEV1czdNq2q5cs_nQeA-PmojlKXiFCD4RQ&s"),
    Person(id: UUID(), name: "Sumit", emailId: "su@mail.com", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIDSvc380gmEzB86geb68cQAVzXbT9biDTioG3s3ocG3aWIjrOAHZGP0_yaA&s"),
    ]
}
