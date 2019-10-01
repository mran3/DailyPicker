//
//  JsonHelper.swift
//  DayGoodies
//
//  Created by troquer on 9/30/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import Foundation

extension JSONEncoder {
    func toJsonString<T>(_ value: T) -> String? where T : Encodable {
            let encoder = self
            encoder.outputFormatting = .prettyPrinted

            do {
                let jsonData = try encoder.encode(value)

                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                    return jsonString
                }
            } catch {
                print(error.localizedDescription)
            }
            return nil
        }
    }
