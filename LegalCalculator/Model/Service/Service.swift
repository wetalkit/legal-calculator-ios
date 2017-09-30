//
//  Service.swift
//
//  Created by Dejan Atanasov on 30/09/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Service: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let inputs = "items"
    static let title = "title"
  }

  // MARK: Properties
  public var inputs: [Inputs]?
  public var title: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    if let items = json[SerializationKeys.inputs].array { inputs = items.map { Inputs(json: $0) } }
    title = json[SerializationKeys.title].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = inputs { dictionary[SerializationKeys.inputs] = value.map { $0.dictionaryRepresentation() } }
    if let value = title { dictionary[SerializationKeys.title] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.inputs = aDecoder.decodeObject(forKey: SerializationKeys.inputs) as? [Inputs]
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(inputs, forKey: SerializationKeys.inputs)
    aCoder.encode(title, forKey: SerializationKeys.title)
  }

}
