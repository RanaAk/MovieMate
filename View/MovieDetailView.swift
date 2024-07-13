//
//  MovieDetailView.swift
//  Movie Database App
//
//  Created by RANA  on 3/7/24.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) private var dismiss
   

    @State var movie : Movie
    @State private var id : Int = 0
    @State private var showWEbView : Bool = false
    @State var videoId : String = ""
 

//    let movie : Movie
    var body: some View {
        NavigationStack {
            LazyVStack{

                    AsyncImage(url: movie.backdropURL){ movieImage in
                        movieImage
                            .resizable()
                            .frame(height : 330)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(alignment: .bottom) {
                                Info_In_SortView(movie: movie)
                                    .offset(y : 70)
                            }
                            .ignoresSafeArea(.all)


                    } placeholder: {
                        ProgressView()
                    }

                ScrollView {
                    VStack(alignment: .leading, spacing: 20){
                        
                        Button(action: {
                            Task {
                                videoId = try await YoutubeViewModel(Id: movie.id).fetchYoutubeVideo(Id: movie.id)
                            }
                            showWEbView.toggle()

                        }, label: {
                            HStack {
                                Image(systemName: "play.circle")
                                     .foregroundColor(.purple)
                                     .imageScale(.large)
                                Text("Watch Trailer")
                                    .foregroundColor(.purple)
                             }
                        })
                        .offset(y: 10)

                        
                        Text("Plot Summary")
                            .foregroundStyle(.white)
                        
                        Text(String(movie.overview ?? "No Informative OverView found. We are Sorry for These Fault"))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                            .foregroundStyle(.white.opacity(0.7))
                        
                        HStack(spacing: 15){
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    if (movie.genres != nil) {
                                        ForEach(movie.genres ?? [Genre(id: 1, name: "Classic")]){ genre in
                                            GenresView(name: genre.name)
                                        }
                                    }

                                }
                            }
                        }
                        
                        Text("Cast")
                            .foregroundStyle(.gray)
                          
     
                        CastView(movieID: movie.id)
                            .offset(y: -18)
                        
                        

                        
                    }

                }
                .offset(y: -25)
               .padding(.leading, 10)
  
            }
         


            .navigationBarBackButtonHidden(true)
            .background(Color(red : 49/255 , green: 61/255, blue: 88/255))
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundStyle(.white)
//                                    Text("Hi")
                })
                .offset(y : -10)
            }
        })
        .task {
            self.id = movie.id
            Task{
                self.movie =  try await movieDBViewModel().movieDetails(movieID: id)!
            }
        }
        .sheet(isPresented: $showWEbView, content: {
            GeometryReader { geometry in
                    YouTubeWebView(videoID: videoId)
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.width * 1.1
                        )
                        .clipped()
                
            }
        })
    }
    
    
}

// #Preview {
//  ContentView()
    
// }
