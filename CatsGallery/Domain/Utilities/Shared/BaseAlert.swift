//
//  BaseAlert.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import SwiftUI

struct BaseAlert: Identifiable {
    
    var title: String

    var message: String?

    var primaryButton: Alert.Button?

    var secondaryButton: Alert.Button?

    var id: String = UUID().uuidString

    func buildView() -> Alert {
        if let message = message {
            if let primaryButton = primaryButton, let secondaryButton = secondaryButton {
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            } else if let button = primaryButton ?? secondaryButton {
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: button
                )
            } else {
                return Alert(
                    title: Text(title),
                    message: Text(message)
                )
            }
        } else {
            if let primaryButton = primaryButton, let secondaryButton = secondaryButton {
                return Alert(
                    title: Text(title),
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            } else if let button = primaryButton ?? secondaryButton {
                return Alert(
                    title: Text(title),
                    dismissButton: button
                )
            } else {
                return Alert(
                    title: Text(title)
                )
            }
        }
    }
}

extension BaseAlert {
    init(
        error: BaseError,
        primaryAction: Alert.Button? = .default(Text(SharedKey.ok.localized()), action: nil),
        secondaryButton: Alert.Button? = nil
    ) {
        self.title = error.title ?? SharedKey.error.localized()
        self.message = error.message
        self.primaryButton = primaryAction
        self.secondaryButton = secondaryButton
    }
}
