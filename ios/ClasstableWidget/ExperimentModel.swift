// Copyright 2023-2025 BenderBlog Rodriguez and contributors
// Copyright 2025 Traintime PDA authors.
// SPDX-License-Identifier: MPL-2.0
//
//  ExperimentModel.swift
//  ClasstableWidgetExtension
//
//  Created by BenderBlog Rodriguez on 2024/2/29.
//

import Foundation

class ExperimentData : Codable {
    var name : String
    var classroom : String
    var timeRangesMap : [[String: String]]
    var teacher : String

    private enum CodingKeys: String, CodingKey {
        case name
        case classroom
        case timeRangesMap = "timeRanges"
        case teacher
    }

    private static let localDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter
    }()

    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    private static let isoFormatterNoFraction: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    private static func parseISO8601(_ string: String) -> Date? {
        return Self.localDateFormatter.date(from: string)
            ?? Self.isoFormatter.date(from: string)
            ?? Self.isoFormatterNoFraction.date(from: string)
    }

    var timeRanges: [(Date, Date)] {
        var toReturn: [(Date, Date)] = []
        for data in timeRangesMap {
            guard let startTimeStr = data["$1"],
                  let stopTimeStr = data["$2"],
                  let startTime = Self.parseISO8601(startTimeStr),
                  let stopTime = Self.parseISO8601(stopTimeStr) else {
                continue
            }
            toReturn.append((startTime, stopTime))
        }
        return toReturn
    }
}
