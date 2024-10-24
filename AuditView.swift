//
//  AuditView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/20/24.
//

import Foundation
import SwiftUI

struct AuditView: View {
    @State var audits = [Audit]()
    
    var body: some View {
        NavigationView {
            List(audits){ audit in
                Text(audit.entity)
                    .font(.custom("Arial", size: 14))
                HStack{
                    Text(audit.actionType)
                        .font(.custom("Arial", size: 14))
                    Spacer()
                    Text(audit.action)
                        .font(.custom("Arial", size: 14))
                    }
                
            }
        }
        .navigationBarTitle(Text("Audit").font(.subheadline), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
        //.navigationTitle(Text("Audit").font(.subheadline))
        .onAppear(){
            AuditViewModel().getAllAudit(){ audits in
                self.audits = audits
            }
        }
    }
}

struct AduitView_Previews: PreviewProvider {
    static var previews: some View {
        AuditView()
    }
}
