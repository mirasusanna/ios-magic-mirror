//  This file was automatically generated and should not be edited.

import Apollo

public final class GetNextDeparturesQuery: GraphQLQuery {
  public let operationDefinition =
    "query getNextDepartures($stationId: String!, $numberOfDepartures: Int) {\n  station(id: $stationId) {\n    __typename\n    name\n    stoptimesWithoutPatterns(numberOfDepartures: $numberOfDepartures) {\n      __typename\n      stop {\n        __typename\n        platformCode\n      }\n      scheduledArrival\n      scheduledDeparture\n      trip {\n        __typename\n        route {\n          __typename\n          shortName\n        }\n      }\n      headsign\n    }\n  }\n}"

  public var stationId: String
  public var numberOfDepartures: Int?

  public init(stationId: String, numberOfDepartures: Int? = nil) {
    self.stationId = stationId
    self.numberOfDepartures = numberOfDepartures
  }

  public var variables: GraphQLMap? {
    return ["stationId": stationId, "numberOfDepartures": numberOfDepartures]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["QueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("station", arguments: ["id": GraphQLVariable("stationId")], type: .object(Station.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(station: Station? = nil) {
      self.init(unsafeResultMap: ["__typename": "QueryType", "station": station.flatMap { (value: Station) -> ResultMap in value.resultMap }])
    }

    /// Get a single station based on its ID, i.e. value of field `gtfsId` (format is `FeedId:StopId`)
    public var station: Station? {
      get {
        return (resultMap["station"] as? ResultMap).flatMap { Station(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "station")
      }
    }

    public struct Station: GraphQLSelectionSet {
      public static let possibleTypes = ["Stop"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("stoptimesWithoutPatterns", arguments: ["numberOfDepartures": GraphQLVariable("numberOfDepartures")], type: .list(.object(StoptimesWithoutPattern.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, stoptimesWithoutPatterns: [StoptimesWithoutPattern?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Stop", "name": name, "stoptimesWithoutPatterns": stoptimesWithoutPatterns.flatMap { (value: [StoptimesWithoutPattern?]) -> [ResultMap?] in value.map { (value: StoptimesWithoutPattern?) -> ResultMap? in value.flatMap { (value: StoptimesWithoutPattern) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Name of the stop, e.g. Pasilan asema
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Returns list of stoptimes (arrivals and departures) at this stop
      public var stoptimesWithoutPatterns: [StoptimesWithoutPattern?]? {
        get {
          return (resultMap["stoptimesWithoutPatterns"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [StoptimesWithoutPattern?] in value.map { (value: ResultMap?) -> StoptimesWithoutPattern? in value.flatMap { (value: ResultMap) -> StoptimesWithoutPattern in StoptimesWithoutPattern(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [StoptimesWithoutPattern?]) -> [ResultMap?] in value.map { (value: StoptimesWithoutPattern?) -> ResultMap? in value.flatMap { (value: StoptimesWithoutPattern) -> ResultMap in value.resultMap } } }, forKey: "stoptimesWithoutPatterns")
        }
      }

      public struct StoptimesWithoutPattern: GraphQLSelectionSet {
        public static let possibleTypes = ["Stoptime"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("stop", type: .object(Stop.selections)),
          GraphQLField("scheduledArrival", type: .scalar(Int.self)),
          GraphQLField("scheduledDeparture", type: .scalar(Int.self)),
          GraphQLField("trip", type: .object(Trip.selections)),
          GraphQLField("headsign", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(stop: Stop? = nil, scheduledArrival: Int? = nil, scheduledDeparture: Int? = nil, trip: Trip? = nil, headsign: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Stoptime", "stop": stop.flatMap { (value: Stop) -> ResultMap in value.resultMap }, "scheduledArrival": scheduledArrival, "scheduledDeparture": scheduledDeparture, "trip": trip.flatMap { (value: Trip) -> ResultMap in value.resultMap }, "headsign": headsign])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The stop where this arrival/departure happens
        public var stop: Stop? {
          get {
            return (resultMap["stop"] as? ResultMap).flatMap { Stop(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "stop")
          }
        }

        /// Scheduled arrival time. Format: seconds since midnight of the departure date
        public var scheduledArrival: Int? {
          get {
            return resultMap["scheduledArrival"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "scheduledArrival")
          }
        }

        /// Scheduled departure time. Format: seconds since midnight of the departure date
        public var scheduledDeparture: Int? {
          get {
            return resultMap["scheduledDeparture"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "scheduledDeparture")
          }
        }

        /// Trip which this stoptime is for
        public var trip: Trip? {
          get {
            return (resultMap["trip"] as? ResultMap).flatMap { Trip(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "trip")
          }
        }

        /// Vehicle headsign of the trip on this stop. Trip headsigns can change during the trip (e.g. on routes which run on loops), so this value should be used instead of `tripHeadsign` to display the headsign relevant to the user.
        public var headsign: String? {
          get {
            return resultMap["headsign"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "headsign")
          }
        }

        public struct Stop: GraphQLSelectionSet {
          public static let possibleTypes = ["Stop"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("platformCode", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(platformCode: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Stop", "platformCode": platformCode])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifier of the platform, usually a number. This value is only present for stops that are part of a station
          public var platformCode: String? {
            get {
              return resultMap["platformCode"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "platformCode")
            }
          }
        }

        public struct Trip: GraphQLSelectionSet {
          public static let possibleTypes = ["Trip"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("route", type: .nonNull(.object(Route.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(route: Route) {
            self.init(unsafeResultMap: ["__typename": "Trip", "route": route.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The route the trip is running on
          public var route: Route {
            get {
              return Route(unsafeResultMap: resultMap["route"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "route")
            }
          }

          public struct Route: GraphQLSelectionSet {
            public static let possibleTypes = ["Route"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("shortName", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(shortName: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Route", "shortName": shortName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Short name of the route, usually a line number, e.g. 550
            public var shortName: String? {
              get {
                return resultMap["shortName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "shortName")
              }
            }
          }
        }
      }
    }
  }
}