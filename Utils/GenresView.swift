//
//  GenresView.swift
//  Movie Database App
//
//  Created by RANA  on 5/7/24.
//

import SwiftUI

struct GenresView: View {
    var name : String
    var body: some View {
        VStack{
            Text(name)
                .foregroundStyle(.white.opacity(0.8))
                .buttonStyle(.borderedProminent)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(Color(red: 43/255, green: 43/255, blue: 43/255))
                                            .frame( height: 35)
                
                    
                )
        }
        
    }
}

#Preview {
    GenresView(name: "Science")
}
