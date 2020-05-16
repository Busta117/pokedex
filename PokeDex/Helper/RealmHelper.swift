//
//  RealmHelper.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import Realm
import RealmSwift

extension Object {
    @objc open func save() {
        do {
            let realm = try Realm()
            do {
                try realm.write { () -> Void in
                    realm.add(self, update: .all)
                }
            } catch {
                print("REALM: impossible update object - \(error)")
            }

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }

    open func update<T: Object>(_ updates: @escaping (_ object: T) -> Void) {
        do {
            let realm = try Realm()

            do {
                try realm.write { () -> Void in
                    updates(self as! T)
                }
            } catch {
                print("REALM: impossible update object - \(error)")
            }

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }
}

public extension Realm {
    static func update(_ updateClosure: @escaping (_ realm: Realm) -> Void) {
        do {
            let realm = try Realm()
            do {
                try realm.write { () -> Void in
                    updateClosure(realm)
                }
            } catch {
                print("REALM: impossible update object - \(error)")
            }

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }

    static func query(_ queryClosure: @escaping (_ realm: Realm) -> Void) {
        do {
            let realm = try Realm()
            queryClosure(realm)

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }
}
