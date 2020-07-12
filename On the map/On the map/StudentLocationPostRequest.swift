//
//  StudentLocationPostRequest.swift
//  On the map
//
//  Created by Bharani Nammi on 7/2/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//
import Foundation

// MARK: - Welcome
struct StudentLocationPostRequest: Codable {
    let uniqueKey, firstName, lastName, mapString: String
    let mediaURL: String
    let latitude, longitude: Double
}
