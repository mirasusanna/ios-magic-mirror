//
//  User+CoreDataProperties.swift
//  Magic Mirror
//
//  Created by Hiltunen on 29/11/2018.
//  Copyright © 2018 Hiltunen. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }


}
