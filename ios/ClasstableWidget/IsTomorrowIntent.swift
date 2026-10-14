// Copyright 2023-2025 BenderBlog Rodriguez and contributors
// Copyright 2025 Traintime PDA authors.
// SPDX-License-Identifier: MPL-2.0
//
//  IsTomorrowIntent.swift
//  ClasstableWidgetExtension
//
//  Created by BenderBlog Rodriguez on 2024/3/1.
//

import Foundation
import AppIntents
import WidgetKit

private let widgetGroupId = "group.xyz.superbart.xdyou"
private let isTomorrowKey = "IsTomorrow"

@available(iOS 17.0, macOS 13.0, tvOS 17.0, watchOS 10.0, *)
struct IsTomorrowManager {
    private static var defaults: UserDefaults? {
        UserDefaults(suiteName: widgetGroupId)
    }

    static var value: Bool {
        get { defaults?.bool(forKey: isTomorrowKey) ?? false }
        set { defaults?.set(newValue, forKey: isTomorrowKey) }
    }
}

@available(iOS 17.0, macOS 13.0, tvOS 17.0, watchOS 10.0, *)
struct IsTomorrowIntent: AppIntent {
    
    static var title: LocalizedStringResource = "IsTomorrow Task"
    static var description: IntentDescription = IntentDescription("IsTomorrow Task")
    
    init() { }
    
    func perform() async throws -> some IntentResult {
        IsTomorrowManager.value = !IsTomorrowManager.value
        WidgetCenter.shared.reloadTimelines(ofKind: "ClasstableWidget")
        return .result()
    }
}
