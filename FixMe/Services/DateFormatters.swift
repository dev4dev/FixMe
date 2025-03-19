//
//  DateFormatters.swift
//  FixMe
//
//  Created by Alex Antonyuk on 19.03.2025.
//

import Foundation

final class DateFormatters {
    private var cache: [String: DateFormatter] = [:]

    func formatter(for format: String) -> DateFormatter {
        if let f = cache[format] {
            return f
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        cache[format] = formatter
        return formatter
    }
}
