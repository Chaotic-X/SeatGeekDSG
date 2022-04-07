//
//  EventsView.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/4/22.
//

import Combine
import SwiftUI

struct EventsView: View {
    //MockData 
//    @State private var searchResults = Bundle.main.decode(SearchResults.self, from: "eventsMock.json")
    @State private var searchResults = SearchResults(events: [])
    @State private var request: AnyCancellable?
    @StateObject private var search = DebouncedText()
    @ObservedObject var favorites = Favorites()
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(searchResults.events) { event in
                        ZStack{
                            ListRow(data: event)
                                .shadow(color: .gray, radius: 5, x: 5, y: 5)
                            NavigationLink(destination: EventDetails(data: event)) {
                            }
                            .opacity(0.0)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .padding(.vertical, 60)
                .ignoresSafeArea(edges: .bottom)
                .overlay{
                    ZStack{
                        Color.darkGreen.ignoresSafeArea(edges: .top)
                        HStack{
                            SearchBarView(searchText: $search.text)
                        }
                    }
                    .frame(height: 60)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .navigationBarHidden(true)
                .onChange(of: search.debouncedText, perform: runSearch)
            }
        }
        .environmentObject(favorites)
    }
    
    func runSearch(criteria: String) {
        if criteria.isEmpty {
            searchResults.events.removeAll()
        } else {
            request?.cancel()
            request = URLSession.shared.get(path: "2/events", queryItems: ["q": criteria], defaultValue: SearchResults(events: [])) { results in
                searchResults = results
            }
            
        }
    }
    
}

//struct EventsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        NavigationView{
//            EventsView()
//        }
//    }
//}
//struct EventsView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        NavigationView{
//            EventsView().environmentObject(MockData(textTitle: "This Text is some crazy Text in this label", place: "Mimai, FL", time: "Weds 12, Jul 2019 7:30 PM", imagePlace: "Audrey"))
//        }
//    }
//}
