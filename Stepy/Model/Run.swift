//
//  Run.swift
//  Stepy
//
//  Created by Sherif Kamal on 11/6/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var date = NSDate()
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    public private(set) var locations = List<Location>()
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["pace", "date", "duration"]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.duration = duration
        self.distance = distance
        self.locations = locations
    }
    
    static func addRunToRealm(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        REALM_QUEUE.sync {
            let run = Run(pace: pace, distance: distance, duration: duration, locations: locations)
            do {
                let realm = try Realm(configuration: RealmConfig.runDataConfig)
                try realm.write {
                    realm.add(run)
                    try realm.commitWrite()
                }
            } catch {
                print("Error adding run to Realm")
            }
        }
    }
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            return runs
        } catch {
            return nil
        }
    }
    
    static func getRun(byId id: String) -> Run? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)
            return realm.object(ofType: Run.self, forPrimaryKey: id)
        } catch {
            print("Error getting data")
            return nil
        }
    }
}
