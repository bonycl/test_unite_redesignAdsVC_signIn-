//
//  AdsModel.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 21.10.23.
//

import Foundation

struct AdsModel {
    var labelName: String
    var descriptionName: String
    var agePet: Int
    var typePet: String
    var sexPet: String
    var lostPossition: (Double, Double)?
    var imagePet: [URL]?
}
