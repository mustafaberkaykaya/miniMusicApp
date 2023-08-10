//
//  AlbumViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 26.07.2023.
//

import DataProvider
import UIComponents
import AVFoundation

protocol AlbumDataSource {
    func cellForTrackCellItemAt(indexPath: IndexPath) -> TracksCellProtocol
    var numberOfItems: Int { get }
    var likedSongs: [Song] { get set }
}

protocol AlbumEventSource {
    var reloadData: VoidClosure? { get set }
}

protocol AlbumProtocol: AlbumDataSource, AlbumEventSource {
    func didLoad()
    func didSelectRowAt(indexPath: IndexPath)
    func likeSong(song: Song)
    func unlikeSong(song: Song)
}

final class AlbumViewModel: BaseViewModel, AlbumProtocol {
    
    //Event Source
    var reloadData: VoidClosure?
    var audioPlayer: AVAudioPlayer?
  
    //Data Source
    let album: AlbumData
    var musicRepository: MusicRepositoryProtocol
    var cellItems: [TracksCellProtocol] = []
    var likedSongs: [Song] = []
    
    func cellForTrackCellItemAt(indexPath: IndexPath) -> TracksCellProtocol {
        return cellItems[indexPath.row]
    }
    
    var numberOfItems: Int {
        return cellItems.count
     }
    
    init(album: AlbumData, musicRepository: MusicRepositoryProtocol) {
        self.album = album
        self.musicRepository = musicRepository
    }
    
    func didLoad() {
        self.showLoading?()
        guard let id = album.id else { return }
        musicRepository.getTrackList(id: id) { result in
            switch result {
            case .success(let response):
                guard let tracks = response.tracks?.data else { return }
                self.cellItems = tracks.map({ track in
                    return TracksCellModel(trackImageUrl: self.album.coverMedium, trackDurationText: track.duration?.secondsToMinutes(seconds: track.duration ?? 0), trackNameText: track.title, musicUrl: track.preview, musicId: track.id)
                })
                self.reloadData?()
                self.hideLoading?()
            case .failure(let err):
                print(err.localizedDescription)
                self.hideLoading?()
            }
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
            }
        }
    }
}

