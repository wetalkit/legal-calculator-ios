//
//  Costs.swift
//
//  Created by Dejan Atanasov on 01/10/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Costs: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cost = "cost"
    static let name = "name"
  }

  // MARK: Properties
  public var cost: Int = 0
  public var name: String = ""

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
    cost = Int(ceil(json[SerializationKeys.cost].doubleValue))
    name = json[SerializationKeys.name].stringValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.cost] = cost
    dictionary[SerializationKeys.name] = name
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cost = aDecoder.decodeObject(forKey: SerializationKeys.cost) as! Int
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as! String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cost, forKey: SerializationKeys.cost)
    aCoder.encode(name, forKey: SerializationKeys.name)
  }

}
