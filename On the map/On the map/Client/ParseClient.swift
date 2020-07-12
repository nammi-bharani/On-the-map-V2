//
//  ParseClient.swift
//  On the map
//
//  Created by Bharani Nammi on 6/30/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import CoreLocation



class ParseClient{
    
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/StudentLocation"
        
        case studentLocation
        
        var stringValue: String {
            switch self {
            
            case .studentLocation:
                return Endpoints.base
           
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                //print(responseObject)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                 
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
            }
        }
        task.resume()
        
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
         task.resume()
        }
       

    class func getStudentLocation(completion: @escaping ([Result], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.studentLocation.url, responseType: StudentLocation.self) { response, error in
            if let response = response {
                StudentLocationModel.result = response.results
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }

    class func postStudentLocation(location: String, mediaUrl: String, completion: @escaping (Bool, Error?) -> Void) {
        
        
        var lat: Double = 0
        var lon: Double = 0
        let address = location

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                print("location not found")
                return
            }

           

            print(location.coordinate.latitude)
            lat = location.coordinate.latitude

            print(location.coordinate.longitude)
            lon = location.coordinate.longitude


        }
        
        MyLocation.firstName = "AAAAA"
        MyLocation.lastName = "BBBBB"
        MyLocation.lat = lat
        MyLocation.log = lon
        MyLocation.mediaUrl = mediaUrl
        MyLocation.alreadyPosted = false
        
         let body = StudentLocationPostRequest(uniqueKey: UdacityClient.Auth.key, firstName: "AAAAA", lastName: "BBBBB", mapString: location, mediaURL: mediaUrl, latitude: lat, longitude: lon)
        
        taskForPOSTRequest(url: Endpoints.studentLocation.url, responseType: StudentLocationResponse.self, body: body) { response, error in
            if let response = response {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
