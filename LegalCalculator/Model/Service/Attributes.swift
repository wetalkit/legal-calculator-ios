//
//  Attributes.swift
//
//  Created by Dejan Atanasov on 30/09/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Attributes: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let placeholder = "placeholder"
    static let options = "options"
  }

  // MARK: Properties
  public var placeholder: String?
  public var options: [String]?

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
    placeholder = json[SerializationKeys.placeholder].string
    if let items = json[SerializationKeys.options].array { options = items.map { $0.stringValue } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = placeholder { dictionary[SerializationKeys.placeholder] = value }
    if let value = options { dictionary[SerializationKeys.options] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.placeholder = aDecoder.decodeObject(forKey: SerializationKeys.placeholder) as? String
    self.options = aDecoder.decodeObject(forKey: SerializationKeys.options) as? [String]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(placeholder, forKey: SerializationKeys.placeholder)
    aCoder.encode(options, forKey: SerializationKeys.options)
  }

}
