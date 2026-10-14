// Copyright 2023-2025 BenderBlog Rodriguez and contributors
// Copyright 2025 Traintime PDA authors.
// SPDX-License-Identifier: MPL-2.0
//
//  ExamModule.swift
//  ClasstableWidgetExtension
//
//  Created by BenderBlog Rodriguez on 2024/1/18.
//
//  Refrence to /lib/model/xidian_ids/exam.dart
//

import Foundation

struct ExamData : Codable {
    let subject : [Subject]
    let toBeArranged : [ToBeArranged]
}

class Subject : Codable {
    let subject : String
    let typeStr : String
    let startTimeStr : String
    let endTimeStr : String
    let time : String
    let place : String
    let seat : String?
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var startTime : Date {
        get {
            return Self.dateFormatter.date(from: startTimeStr) ?? Date(timeIntervalSince1970: 0)
        }
    }
    
    var endTime : Date {
        get {
            return Self.dateFormatter.date(from: endTimeStr) ?? Date(timeIntervalSince1970: 0)
        }
    }
    
    var type : String {
        get {
            if (typeStr.contains("期末考试")) { return "期末考试"; }
            if (typeStr.contains("期中考试")) { return "期中考试"; }
            if (typeStr.contains("结课考试")) { return "结课考试"; }
            if (typeStr.contains("入学")) { return "入学考试"; }
            return typeStr;
        }
    }
}

struct ToBeArranged : Codable {
    let subject : String
    let id : String
}
