//
//  PokemonDetail.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift

class PokemonDetail: Object, Mappable {
    @objc dynamic var id = 0
    @objc dynamic var url = ""
    @objc dynamic var mainImageUrl = ""
    @objc dynamic var sprites: Sprites? = Sprites()
    var types = List<Type>()

    override static func primaryKey() -> String? {
        return "url"
    }

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        id <- map["id"]
        mainImageUrl = "https://pokeres.bastionbot.org/images/pokemon/\(id).png"
        types <- map["types"]
        sprites <- map["sprites"]
        sprites?.id = id
    }

    class func chache(forUrl url: String) -> PokemonDetail? {
        do {
            let realm = try Realm()
            let details = realm.objects(PokemonDetail.self).filter("url = %@", url)
            if details.count > 0 {
                return details.first!
            }
            return nil
        } catch _ {
            return nil
        }
    }

    class func get(forUrl url: String, complete: @escaping (PokemonDetail?, AFError?) -> Void) {
//        if let cached = chache(forUrl: url) {
//            complete(cached, nil)
//        }

        AF.request(url).validate().responseObject { (response: DataResponse<PokemonDetail, AFError>) in
            if let value = response.value {
                value.url = url
                value.save()
                complete(value, nil)
            } else {
                complete(nil, response.error)
            }
        }
    }
}
