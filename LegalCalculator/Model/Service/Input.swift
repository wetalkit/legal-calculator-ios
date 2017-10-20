//
//  Input.swift
//
//  Created by Dejan Atanasov on 30/09/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Input: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let varValue = "var"
    static let name = "name"
    static let comment = "comment"
    static let attributes = "attributes"
    static let type = "type"
    static let isMandatory = "is_mandatory"
  }

  // MARK: Properties
  public var varValue: String = ""
  public var name: String?
  public var comment: String?
  public var attributes: Attributes?
  public var type: MainCellType?
  public var isMandatory: Int?

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
    varValue = json[SerializationKeys.varValue].stringValue
    name = json[SerializationKeys.name].string
    comment = json[SerializationKeys.comment].string
    attributes = Attributes(json: json[SerializationKeys.attributes])
    type = MainCellType(rawValue: json[SerializationKeys.type].intValue)
    isMandatory = json[SerializationKeys.isMandatory].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.varValue] = varValue
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = comment { dictionary[SerializationKeys.comment] = value }
    if let value = attributes { dictionary[SerializationKeys.attributes] = value.dictionaryRepresentation() }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = isMandatory { dictionary[SerializationKeys.isMandatory] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.varValue = aDecoder.decodeObject(forKey: SerializationKeys.varValue) as! String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.comment = aDecoder.decodeObject(forKey: SerializationKeys.comment) as? String
    self.attributes = aDecoder.decodeObject(forKey: SerializationKeys.attributes) as? Attributes
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? MainCellType
    self.isMandatory = aDecoder.decodeObject(forKey: SerializationKeys.isMandatory) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(varValue, forKey: SerializationKeys.varValue)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(comment, forKey: SerializationKeys.comment)
    aCoder.encode(attributes, forKey: SerializationKeys.attributes)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(isMandatory, forKey: SerializationKeys.isMandatory)
  }

}
