//
//  TopRatedMoviesView.swift
//  Movie Database App
//
//  Created by RANA  on 9/7/24.
//

import SwiftUI


struct TopRatedMoviesView: View {
    @StateObject private var viewModel = movieDBViewModel()
    var body: some View {
        NavigationStack{
            ScrollView(.horizontal){
                LazyHStack(alignment: .firstTextBaseline, spacing: 10){
                    ForEach(viewModel.topRatedMovies){movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 10){
                                AsyncImage(url: movie.backdropURL){ image in
                                        image
                                        .resizable()
                                        .frame(width: 250, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(alignment: .bottomLeading) {
                                            VStack(alignment: .leading, spacing: 3){
                                                
                                                
                                                Text(movie.title)
                                                    .font(.system(size: 18))
                                                    .foregroundStyle(.white)
                                                    .bold()
                                                TG(newMovie: movie)
                                            }
                                            .padding(.leading, 10)
                                            
                                            
                                        }
                                    
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 250, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(alignment: .bottomLeading) {
                                            VStack(alignment: .leading, spacing: 3){
                                                
                                                
                                                Text(movie.title)
                                                    .font(.system(size: 18))
                                                    .foregroundStyle(.white)
                                                    .bold()
                                                TG(newMovie: movie)
                                            }
                                            .padding(.leading, 10)
                                            
                                            
                                        }
                            }
                                Spacer()
                                
                            }

                            .frame( height: 240)
                        }

                       
                    }
                   

                }
            }
            .scrollIndicators(.hidden)
            
        
        }
    }
}

#Preview {
   TopRatedMoviesView()
}

struct TG : View {
    @State var newMovie : Movie
    @State private var nid : Int = 0
    var body: some View {
        HStack{
            Text(newMovie.Hour ?? "")
                .font(.system(size: 15))
                .foregroundStyle(.white.opacity(0.9))
            
            Image(systemName: "dot.circle")
            Text(newMovie.genres?.first?.name ?? "")
        }
        .foregroundStyle(.white.opacity(0.9))
        .fontWeight(.semibold)
        .task {
            nid = newMovie.id
            Task{
                newMovie = try await movieDBViewModel().movieDetails(movieID: nid)!
            }
        }
    }
}
