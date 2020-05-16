//
//  ObjectMapperRealmHelper.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import ObjectMapper
import RealmSwift

/// List of BaseMappable objects
public func <- <T: RealmCollectionValue>(left: inout List<T>, right: Map) where T: BaseMappable {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        if let objects = Mapper<T>(context: right.context).mapArray(JSONObject: right.currentValue) {
            let list = List<T>()
            list.append(objectsIn: objects)
            left = list
        }
    case .toJSON:
        left >>> right
    default: ()
    }
}

public func >>> <T: RealmCollectionValue>(left: List<T>, right: Map) where T: BaseMappable {
    if right.mappingType == .toJSON {
        let newLeft = Array(left)
        newLeft >>> right
    }
}

/// List of optional BaseMappable objects
public func <- <T: RealmCollectionValue>(left: inout List<T>?, right: Map) where T: BaseMappable {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        if let objects: [T] = Mapper(context: right.context).mapArray(JSONObject: right.currentValue) {
            let list = List<T>()
            list.append(objectsIn: objects)
            left = list
        } else {
            left = nil
        }
    case .toJSON:
        left >>> right
    default: ()
    }
}

public func >>> <T: RealmCollectionValue>(left: List<T>?, right: Map) where T: BaseMappable {
    if right.mappingType == .toJSON {
        if let left = left {
            let newLeft = Array(left)
            newLeft >>> right
        }
    }
}

// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
    /// Implicitly unwrapped optional Mappable objects
    public func <- <T: RealmCollectionValue>(left: inout List<T>!, right: Map) where T: BaseMappable {
        switch right.mappingType {
        case .fromJSON where right.isKeyPresent:
            if let objects: [T] = Mapper(context: right.context).mapArray(JSONObject: right.currentValue) {
                let list = List<T>()
                list.append(objectsIn: objects)
                left = list
            } else {
                left = nil
            }
        case .toJSON:
            left >>> right
        default: ()
        }
    }
#endif

/// List of basic objects
public func <- <T: RealmCollectionValue>(left: inout List<T>, right: Map) where T: Comparable {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        if let objects = right.currentValue as? [T] {
            let list = List<T>()
            list.append(objectsIn: objects)
            left = list
        }
    case .toJSON:
        left >>> right
    default: ()
    }
}

public func >>> <T: RealmCollectionValue>(left: List<T>, right: Map) where T: Comparable {
    if right.mappingType == .toJSON {
        let newLeft = Array(left)
        newLeft >>> right
    }
}

/// List of optional basic objects
public func <- <T: RealmCollectionValue>(left: inout List<T>?, right: Map) where T: Comparable {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        if let objects = right.currentValue as? [T] {
            let list = List<T>()
            list.append(objectsIn: objects)
            left = list
        } else {
            left = nil
        }
    case .toJSON:
        left >>> right
    default: ()
    }
}

public func >>> <T: RealmCollectionValue>(left: List<T>?, right: Map) where T: Comparable {
    if right.mappingType == .toJSON {
        if let left = left {
            let newLeft = Array(left)
            newLeft >>> right
        }
    }
}

// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
    /// Implicitly unwrapped optional Mappable objects
    public func <- <T: RealmCollectionValue>(left: inout List<T>!, right: Map) where T: Mappable {
        switch right.mappingType {
        case .fromJSON where right.isKeyPresent:
            if let objects = right.currentValue as? [T] {
                let list = List<T>()
                list.append(objectsIn: objects)
                left = list
            } else {
                left = nil
            }
        case .toJSON:
            left >>> right
        default: ()
        }
    }
#endif
