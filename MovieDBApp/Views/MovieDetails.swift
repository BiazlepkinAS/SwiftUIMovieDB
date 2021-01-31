
import SwiftUI

struct MovieDetails: View {
    let movieID: Int
    @ObservedObject private var movieDetailsState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadView(isLoading: self.movieDetailsState.isLoading, error: self.movieDetailsState.error) {
                self.movieDetailsState.loadMovie(id: self.movieID)
            }
            if movieDetailsState.movie != nil {
                MovieDetailListView(movie: self.movieDetailsState.movie!)
                
            }
        }
        .navigationBarTitle(movieDetailsState.movie?.title ?? "" )
        .onAppear {
            self.movieDetailsState.loadMovie(id: self.movieID)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    @State private var selectTrailer: MovieVideos?
    
    private let imageLoader = ImageLoader()
    
    var body: some View {
        List {
            MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backDropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text(movie.genreText)
                Text(".")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            Text(movie.overview)
            HStack {
                if movie.raitingText.isEmpty {
                    Text(movie.durationText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            Divider()
            
            HStack(alignment: .top, spacing: 4) {
                if movie.casts != nil && movie.casts!.count > 0 {
                    VStack(alignment: .leading , spacing: 4) {
                        Text("Starring").font(.headline)
                        ForEach(self.movie.casts!.prefix(9)) { casts in
                            Text(casts.name)
                        }
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil && movie.directors!.count > 0 {
                            Text("Directors").font(.headline)
                            ForEach(self.movie.directors!.prefix(2)) {
                                crew in
                                Text(crew.name)
                            }
                        }
                        
                        if movie.produsers != nil && movie.produsers!.count > 0 {
                            Text("Produsers").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.produsers!.prefix(2)) {
                                crew in
                                Text(crew.name)
                            }
                            
                            
                            
                        }
                        
                        if movie.screeWriter != nil && movie.screeWriter!.count > 0 {
                            Text("ScreenWriters").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.screeWriter!.prefix(2)) {
                                crew in
                                Text(crew.name)
                            }
                            
                        }
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                }
            }
            Divider()
            
            if movie.youtubeTrailer != nil && movie.youtubeTrailer!.count > 0 {
                Text("Trailers").font(.headline)
                
                ForEach(movie.youtubeTrailer!) { trailer in
                    
                    Button(action: {
                        self.selectTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }
        .sheet(item: self.$selectTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
        }
        
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetails(movieID: Movie.stubbedMovie.id)
        }
    }
}
