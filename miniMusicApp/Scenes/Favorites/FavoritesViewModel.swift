//
//  FavoritesViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 29.06.2023.
//


import DataProvider
import UIComponents
import AVFoundation

protocol FavoritesDataSource {
    func cellForTrackCellItemAt(indexPath: IndexPath) -> TracksCellProtocol
    var numberOfItems: Int { get }
    var likedSongs: [Song] { get set }
}

protocol FavoritesEventSource {
    var reloadData: VoidClosure? { get set }
}

protocol FavoritesProtocol: FavoritesDataSource, FavoritesEventSource {
    func getLikedSongs()
    func didSelectRowAt(indexPath: IndexPath)
    func likeSong(song: Song)
    func unlikeSong(song: Song)
}

final class FavoritesViewModel: BaseViewModel, FavoritesProtocol {

    //Event Source
    var reloadData: VoidClosure?
    var audioPlayer: AVAudioPlayer?
  
    //Data Source
    var cellItems: [TracksCellProtocol] = []
    var likedSongs: [Song] = []
    
    func cellForTrackCellItemAt(indexPath: IndexPath) -> TracksCellProtocol {
        return cellItems[indexPath.row]
    }
    
    var numberOfItems: Int {
        return cellItems.count
     }
    
    func getLikedSongs() {
        cellItems.removeAll()
        if let data = UserDefaults.standard.object(forKey: "likedSongs") as? Data,
           let getLikedSongs = try? JSONDecoder().decode([Song].self, from: data) {
            for song in getLikedSongs {
                cellItems.append(TracksCellModel(trackImageUrl: song.trackImageUrl, trackDurationText: song.trackDurationText, trackNameText: song.trackNameText, musicUrl: song.musicUrl, musicId: song.musicId))
            }
            self.reloadData?()
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        if let url = cellItems[indexPath.row].musicUrl?.convertUrl {
            downloadAndPlayAudio(url: url)
        }
    }
    
    private func downloadAndPlayAudio(url: URL) {
        self.audioPlayer?.stop()
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading audio: \(error)")
            } else if let data = data {
                do {
                    self.audioPlayer = try AVAudioPlayer(data: data)
                    self.audioPlayer?.play()
                } catch {
                    print("Error initializing audio player: \(error)")
                }
            }
        }.resume()
    }
    
    func likeSong(song: Song) {
        if let data = UserDefaults.standard.object(forKey: "likedSongs") as? Data,
           var getLikedSongs = try? JSONDecoder().decode([Song].self, from: data) {
            if !getLikedSongs.contains(where: { $0.musicId == song.musicId }) {
                getLikedSongs.append(song)
                if let encoded = try? JSONEncoder().encode(getLikedSongs) {
                    UserDefaults.standard.set(encoded, forKey: "likedSongs")
                }
            }
        } else {
            likedSongs.append(song)
            if let encoded = try? JSONEncoder().encode(likedSongs) {
                UserDefaults.standard.set(encoded, forKey: "likedSongs")
            }
        }
    }
    
    func unlikeSong(song: Song) {
        if let data = UserDefaults.standard.object(forKey: "likedSongs") as? Data,
            var getLikedSongs = try? JSONDecoder().decode([Song].self, from: data) {
            if let index = getLikedSongs.firstIndex(where: { $0.musicId == song.musicId}) {
                getLikedSongs.remove(at: index)
                if let encoded = try? JSONEncoder().encode(getLikedSongs) {
                    UserDefaults.standard.set(encoded, forKey: "likedSongs")
                }
                if let otherIndex = cellItems.firstIndex(where: { $0.musicId == song.musicId}) {
                    cellItems.remove(at: otherIndex)
                    self.reloadData?()
                }
            }
        }
    }
}
