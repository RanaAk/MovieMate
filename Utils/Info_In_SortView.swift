//
//  Info_In_SortView.swift
//  Movie Database App
//
//  Created by RANA  on 4/7/24.
//

import SwiftUI

struct Info_In_SortView: View {
   
    @State var movie : Movie
    @State private var id : Int = 0
    var body: some View {
        VStack{

                ZStack{
                    RoundedRectangle(cornerRadius: 15)

                        .fill(Color(red: 55/255, green: 55/255, blue: 55/255))
                      

                    VStack{
                        HStack(alignment : .top){
                            Text(movie.title)
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 21))
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                            HStack(alignment : .top, spacing: 3){
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow.opacity(0.9))
                                
                                VStack(alignment: .leading, spacing: 7){
                                    Text(String(format : "%.1f", movie.voteAverage ))
                                        .foregroundStyle(.white)
                                        .bold()
                                    +
                                    Text("/10")
                                        .foregroundStyle(.white)
                                        .bold()
                                        .font(.system(size: 9))
                                    
                                    Text(movie.voteCount ?? 0, format: .number)
                                        .foregroundStyle(.white.opacity(0.7))
                                        .font(.system(size: 11))
                                        
                                    
                                }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
//                        Spacer()
                        HStack {
                            VerticalLabeledContent(label: "Year", content: String(movie.Year ?? "Not Found"))
                            Spacer()
                            VerticalLabeledContent(label: "Genre", content: String(movie.firstGenre ?? ""))
                            Spacer()

                            VerticalLabeledContent(label: "Duration", content: movie.Hour ?? "")

                            Spacer()

                            VerticalLabeledContent(label: "Budget", content: movie.Budget ?? "nil")

                        }
                        .padding()
                        .background(Color.black.opacity(0.4))
                        .foregroundColor(.white.opacity(0.8))
//                        .padding(.bottom, 2)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                        
                }
                .frame(width: 330, height: 150)
//            }
        }
        .task {
            self.id = movie.id
            Task{
                self.movie =  try await movieDBViewModel().movieDetails(movieID: id)!
            }
        }
    }
}

#Preview {
    ContentView()
}



struct VerticalLabeledContent: View {
    var label: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(label)
                .font(.headline)
            Text(content)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
        }
    }
}

