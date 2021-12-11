//
//  File.swift
//  
//
//  Created by Igor Kulik on 10.12.2021.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func permissionDeniedAlert(sourceType: ImagePicker.SourceType,
                               isPresented: Binding<Bool>,
                               onDismiss: (() -> Void)? = nil) -> some View {
        
        self.alert(isPresented: isPresented) {
            Alert(
                title: Text(sourceType.permissionDeniedTitle),
                message: Text(sourceType.permissionDeniedMessage),
                primaryButton: .default(Text("Settings"), action: {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                          UIApplication.shared.canOpenURL(settingsUrl) else {
                              return
                          }
                    UIApplication.shared.open(settingsUrl, completionHandler: { _ in })
                }),
                secondaryButton: .cancel(Text("Not Now"), action: {
                    onDismiss?()
                })
            )
        }
    }
}

fileprivate extension ImagePicker.SourceType {
    
    var permissionDeniedTitle: String {
        switch self {
        case .photoLibrary:
            return "Please Allow the Application to Access Your Photos"
        case .camera:
            return "Please Allow the Application to Access Your Camera"
        }
    }
    
    var permissionDeniedMessage: String {
        switch self {
        case .photoLibrary:
            return Bundle.main.object(forInfoDictionaryKey: "NSPhotoLibraryUsageDescription") as? String ?? ""
        case .camera:
            return Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String ?? ""
        }
    }
}
