//
//  Transportation.swift
//  Magic Mirror
//
//  Created by Hiltunen on 25/11/2018.
//  Copyright © 2018 Hiltunen. All rights reserved.
//

import Foundation
import Apollo

class Transportation {
    static let shared = Transportation()
    
    var nextDepartures: [String] = ["No departures"]
    
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        let url = URL(string: "https://api.digitransit.fi/routing/v1/routers/hsl/index/graphql")!
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    func getNextDepartures(stationId: String = "HSL:1000202", numberOfDepartures: Int = 5) -> [String] {
        let nextDeparturesQuery = GetNextDeparturesQuery(stationId: stationId, numberOfDepartures: numberOfDepartures)
        apollo.fetch(query: nextDeparturesQuery) { (result, error) in
            
            guard let departures = result?.data?.station?.stoptimesWithoutPatterns else {
                print("No departures")
                self.nextDepartures = ["No departures"]
                return
            }
            
            self.nextDepartures = [String]()
            
            for departure in departures {
                //nextDepartures.append("\(departure?.scheduledDeparture)")
                if departure?.headsign != nil {
                    self.nextDepartures.append("\(departure!.headsign!)")
                }
            }
        }
        return self.nextDepartures
    }
}
