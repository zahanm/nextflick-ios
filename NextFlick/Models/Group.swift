//
//  Group.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/30/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation
import GRDB

struct Group: Identifiable {
    let id = UUID()
    let members: [Person]

    init(_ members: [Person]) {
        self.members = members
    }
}

struct GroupV2: Identifiable, Codable {
    var id: Int64?
}

/// The database setup for this model is less straightforward than the others.
/// Namely, I'm going to store this "assoc" style, with a (group-id, member-id) table.
/// Then, I'll have to query from that to build up this model.
extension GroupV2: FetchableRecord, MutablePersistableRecord {
    mutating func didInsert(with rowID: Int64, for _: String?) {
        id = rowID
    }

    static let memberships = hasMany(PersonGroupMembership.self)
    static let members = hasMany(Person.self, through: memberships, using: PersonGroupMembership.person)
    var members: QueryInterfaceRequest<Person> {
        return request(for: GroupV2.members)
    }
}

struct PersonGroupMembership: Codable, MutablePersistableRecord {
    var personId: Int64
    static let person = belongsTo(Person.self)
    var groupId: Int64
    static let group = belongsTo(GroupV2.self)
}

extension Person {
    static let memberships = hasMany(PersonGroupMembership.self)
    static let groups = hasMany(GroupV2.self, through: memberships, using: PersonGroupMembership.group)
    var groups: QueryInterfaceRequest<GroupV2> {
        return request(for: Person.groups)
    }
}
