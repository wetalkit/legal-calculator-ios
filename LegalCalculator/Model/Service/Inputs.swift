//
//  Inputs.swift
//
//  Created by Dejan Atanasov on 30/09/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Inputs: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let varValue = "var"
    static let defaultValue = "default"
    static let comment = "comment"
    static let name = "name"
    static let type = "type"
    static let options = "options"
  }

  // MARK: Properties
  public var varValue: String?
  public var defaultValue: Int?
  public var comment: String?
  public var name: String?
  public var type: MainCellType?
  public var options: [Options]?

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
    varValue = json[SerializationKeys.varValue].string
    defaultValue = json[SerializationKeys.defaultValue].int
    comment = json[SerializationKeys.comment].string
    name = json[SerializationKeys.name].string
    type = MainCellType(rawValue: json[SerializationKeys.type].intValue)
    if let items = json[SerializationKeys.options].array { options = items.map { Options(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = varValue { dictionary[SerializationKeys.varValue] = value }
    if let value = defaultValue { dictionary[SerializationKeys.defaultValue] = value }
    if let value = comment { dictionary[SerializationKeys.comment] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = options { dictionary[SerializationKeys.options] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.varValue = aDecoder.decodeObject(forKey: SerializationKeys.varValue) as? String
    self.defaultValue = aDecoder.decodeObject(forKey: SerializationKeys.defaultValue) as? Int
    self.comment = aDecoder.decodeObject(forKey: SerializationKeys.comment) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? MainCellType
    self.options = aDecoder.decodeObject(forKey: SerializationKeys.options) as? [Options]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(varValue, forKey: SerializationKeys.varValue)
    aCoder.encode(defaultValue, forKey: SerializationKeys.defaultValue)
    aCoder.encode(comment, forKey: SerializationKeys.comment)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(options, forKey: SerializationKeys.options)
  }

}
