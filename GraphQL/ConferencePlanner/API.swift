//  This file was automatically generated and should not be edited.

import Apollo

public final class ConferenceDetailsQuery: GraphQLQuery {
  public static let operationDefinition =
    "query ConferenceDetails($id: ID!) {" +
    "  conference: Conference(id: $id) {" +
    "    __typename" +
    "    ...ConferenceDetails" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(ConferenceDetails.fragmentDefinition)

  public let id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLMappable {
    public let conference: Conference?

    public init(reader: GraphQLResultReader) throws {
      conference = try reader.optionalValue(for: Field(responseName: "conference", fieldName: "Conference", arguments: ["id": reader.variables["id"]]))
    }

    public struct Conference: GraphQLMappable {
      public let __typename: String

      public let fragments: Fragments

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))

        let conferenceDetails = try ConferenceDetails(reader: reader)
        fragments = Fragments(conferenceDetails: conferenceDetails)
      }

      public struct Fragments {
        public let conferenceDetails: ConferenceDetails
      }
    }
  }
}

public final class AttendeesForConferenceQuery: GraphQLQuery {
  public static let operationDefinition =
    "query AttendeesForConference($conferenceId: ID!) {" +
    "  conference: Conference(id: $conferenceId) {" +
    "    __typename" +
    "    id" +
    "    attendees {" +
    "      __typename" +
    "      ...AttendeeDetails" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(AttendeeDetails.fragmentDefinition)

  public let conferenceId: GraphQLID

  public init(conferenceId: GraphQLID) {
    self.conferenceId = conferenceId
  }

  public var variables: GraphQLMap? {
    return ["conferenceId": conferenceId]
  }

  public struct Data: GraphQLMappable {
    public let conference: Conference?

    public init(reader: GraphQLResultReader) throws {
      conference = try reader.optionalValue(for: Field(responseName: "conference", fieldName: "Conference", arguments: ["id": reader.variables["conferenceId"]]))
    }

    public struct Conference: GraphQLMappable {
      public let __typename: String
      public let id: GraphQLID
      public let attendees: [Attendee]?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        id = try reader.value(for: Field(responseName: "id"))
        attendees = try reader.optionalList(for: Field(responseName: "attendees"))
      }

      public struct Attendee: GraphQLMappable {
        public let __typename: String

        public let fragments: Fragments

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))

          let attendeeDetails = try AttendeeDetails(reader: reader)
          fragments = Fragments(attendeeDetails: attendeeDetails)
        }

        public struct Fragments {
          public let attendeeDetails: AttendeeDetails
        }
      }
    }
  }
}

public final class AttendConferenceMutation: GraphQLMutation {
  public static let operationDefinition =
    "mutation AttendConference($conferenceId: ID!, $attendeeId: ID!) {" +
    "  addToAttendees(conferencesConferenceId: $conferenceId, attendeesAttendeeId: $attendeeId) {" +
    "    __typename" +
    "    conferencesConference {" +
    "      __typename" +
    "      id" +
    "      attendees {" +
    "        __typename" +
    "        ...AttendeeDetails" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(AttendeeDetails.fragmentDefinition)

  public let conferenceId: GraphQLID
  public let attendeeId: GraphQLID

  public init(conferenceId: GraphQLID, attendeeId: GraphQLID) {
    self.conferenceId = conferenceId
    self.attendeeId = attendeeId
  }

  public var variables: GraphQLMap? {
    return ["conferenceId": conferenceId, "attendeeId": attendeeId]
  }

  public struct Data: GraphQLMappable {
    public let addToAttendees: AddToAttendee?

    public init(reader: GraphQLResultReader) throws {
      addToAttendees = try reader.optionalValue(for: Field(responseName: "addToAttendees", arguments: ["conferencesConferenceId": reader.variables["conferenceId"], "attendeesAttendeeId": reader.variables["attendeeId"]]))
    }

    public struct AddToAttendee: GraphQLMappable {
      public let __typename: String
      public let conferencesConference: ConferencesConference?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        conferencesConference = try reader.optionalValue(for: Field(responseName: "conferencesConference"))
      }

      public struct ConferencesConference: GraphQLMappable {
        public let __typename: String
        public let id: GraphQLID
        public let attendees: [Attendee]?

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          id = try reader.value(for: Field(responseName: "id"))
          attendees = try reader.optionalList(for: Field(responseName: "attendees"))
        }

        public struct Attendee: GraphQLMappable {
          public let __typename: String

          public let fragments: Fragments

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))

            let attendeeDetails = try AttendeeDetails(reader: reader)
            fragments = Fragments(attendeeDetails: attendeeDetails)
          }

          public struct Fragments {
            public let attendeeDetails: AttendeeDetails
          }
        }
      }
    }
  }
}

public final class NotAttendConferenceMutation: GraphQLMutation {
  public static let operationDefinition =
    "mutation NotAttendConference($conferenceId: ID!, $attendeeId: ID!) {" +
    "  removeFromAttendees(conferencesConferenceId: $conferenceId, attendeesAttendeeId: $attendeeId) {" +
    "    __typename" +
    "    conferencesConference {" +
    "      __typename" +
    "      id" +
    "      attendees {" +
    "        __typename" +
    "        ...AttendeeDetails" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(AttendeeDetails.fragmentDefinition)

  public let conferenceId: GraphQLID
  public let attendeeId: GraphQLID

  public init(conferenceId: GraphQLID, attendeeId: GraphQLID) {
    self.conferenceId = conferenceId
    self.attendeeId = attendeeId
  }

  public var variables: GraphQLMap? {
    return ["conferenceId": conferenceId, "attendeeId": attendeeId]
  }

  public struct Data: GraphQLMappable {
    public let removeFromAttendees: RemoveFromAttendee?

    public init(reader: GraphQLResultReader) throws {
      removeFromAttendees = try reader.optionalValue(for: Field(responseName: "removeFromAttendees", arguments: ["conferencesConferenceId": reader.variables["conferenceId"], "attendeesAttendeeId": reader.variables["attendeeId"]]))
    }

    public struct RemoveFromAttendee: GraphQLMappable {
      public let __typename: String
      public let conferencesConference: ConferencesConference?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        conferencesConference = try reader.optionalValue(for: Field(responseName: "conferencesConference"))
      }

      public struct ConferencesConference: GraphQLMappable {
        public let __typename: String
        public let id: GraphQLID
        public let attendees: [Attendee]?

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          id = try reader.value(for: Field(responseName: "id"))
          attendees = try reader.optionalList(for: Field(responseName: "attendees"))
        }

        public struct Attendee: GraphQLMappable {
          public let __typename: String

          public let fragments: Fragments

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))

            let attendeeDetails = try AttendeeDetails(reader: reader)
            fragments = Fragments(attendeeDetails: attendeeDetails)
          }

          public struct Fragments {
            public let attendeeDetails: AttendeeDetails
          }
        }
      }
    }
  }
}

public final class AllConferencesQuery: GraphQLQuery {
  public static let operationDefinition =
    "query AllConferences {" +
    "  allConferences {" +
    "    __typename" +
    "    ...ConferenceDetails" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(ConferenceDetails.fragmentDefinition)
  public init() {
  }

  public struct Data: GraphQLMappable {
    public let allConferences: [AllConference]

    public init(reader: GraphQLResultReader) throws {
      allConferences = try reader.list(for: Field(responseName: "allConferences"))
    }

    public struct AllConference: GraphQLMappable {
      public let __typename: String

      public let fragments: Fragments

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))

        let conferenceDetails = try ConferenceDetails(reader: reader)
        fragments = Fragments(conferenceDetails: conferenceDetails)
      }

      public struct Fragments {
        public let conferenceDetails: ConferenceDetails
      }
    }
  }
}

public final class CreateAttendeeMutation: GraphQLMutation {
  public static let operationDefinition =
    "mutation CreateAttendee($name: String!) {" +
    "  createAttendee(name: $name) {" +
    "    __typename" +
    "    id" +
    "    name" +
    "  }" +
    "}"

  public let name: String

  public init(name: String) {
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["name": name]
  }

  public struct Data: GraphQLMappable {
    public let createAttendee: CreateAttendee?

    public init(reader: GraphQLResultReader) throws {
      createAttendee = try reader.optionalValue(for: Field(responseName: "createAttendee", arguments: ["name": reader.variables["name"]]))
    }

    public struct CreateAttendee: GraphQLMappable {
      public let __typename: String
      public let id: GraphQLID
      public let name: String

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        id = try reader.value(for: Field(responseName: "id"))
        name = try reader.value(for: Field(responseName: "name"))
      }
    }
  }
}

public final class UpdateAttendeeNameMutation: GraphQLMutation {
  public static let operationDefinition =
    "mutation UpdateAttendeeName($id: ID!, $newName: String!) {" +
    "  updateAttendee(id: $id, name: $newName) {" +
    "    __typename" +
    "    id" +
    "    name" +
    "  }" +
    "}"

  public let id: GraphQLID
  public let newName: String

  public init(id: GraphQLID, newName: String) {
    self.id = id
    self.newName = newName
  }

  public var variables: GraphQLMap? {
    return ["id": id, "newName": newName]
  }

  public struct Data: GraphQLMappable {
    public let updateAttendee: UpdateAttendee?

    public init(reader: GraphQLResultReader) throws {
      updateAttendee = try reader.optionalValue(for: Field(responseName: "updateAttendee", arguments: ["id": reader.variables["id"], "name": reader.variables["newName"]]))
    }

    public struct UpdateAttendee: GraphQLMappable {
      public let __typename: String
      public let id: GraphQLID
      public let name: String

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        id = try reader.value(for: Field(responseName: "id"))
        name = try reader.value(for: Field(responseName: "name"))
      }
    }
  }
}

public struct AttendeeDetails: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment AttendeeDetails on Attendee {" +
    "  __typename" +
    "  id" +
    "  name" +
    "  _conferencesMeta {" +
    "    __typename" +
    "    count" +
    "  }" +
    "}"

  public static let possibleTypes = ["Attendee"]

  public let __typename: String
  public let id: GraphQLID
  public let name: String
  /// Meta information about the query.
  public let conferencesMeta: ConferencesMetum

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    name = try reader.value(for: Field(responseName: "name"))
    conferencesMeta = try reader.value(for: Field(responseName: "_conferencesMeta"))
  }

  public struct ConferencesMetum: GraphQLMappable {
    public let __typename: String
    public let count: Int

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      count = try reader.value(for: Field(responseName: "count"))
    }
  }
}

public struct ConferenceDetails: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment ConferenceDetails on Conference {" +
    "  __typename" +
    "  id" +
    "  name" +
    "  city" +
    "  year" +
    "  attendees {" +
    "    __typename" +
    "    id" +
    "  }" +
    "}"

  public static let possibleTypes = ["Conference"]

  public let __typename: String
  public let id: GraphQLID
  public let name: String
  public let city: String
  public let year: String
  public let attendees: [Attendee]?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    name = try reader.value(for: Field(responseName: "name"))
    city = try reader.value(for: Field(responseName: "city"))
    year = try reader.value(for: Field(responseName: "year"))
    attendees = try reader.optionalList(for: Field(responseName: "attendees"))
  }

  public struct Attendee: GraphQLMappable {
    public let __typename: String
    public let id: GraphQLID

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      id = try reader.value(for: Field(responseName: "id"))
    }
  }
}