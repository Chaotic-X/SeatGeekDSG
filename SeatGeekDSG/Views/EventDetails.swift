//
//  EventDetails.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/4/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventDetails: View {

    let data: Event
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var favorite: Favorites
    @State var isFavorite: Bool = false
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 8, height: 12, alignment: .leading)
                    .foregroundColor(Color.white)
            }
        }
    }
    var detailImage: some View {
        Group {
            if let urlString = data.performers.first?.image {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 220, alignment: .center)
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
            }
        }
    }
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text(data.venue.name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Spacer()
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .trailing)
                    .foregroundColor(Color.red)
                    .onTapGesture {
                        if self.favorite.contains(self.data) {
                            self.isFavorite = false
                            self.favorite.remove(self.data)
                        } else {
                            self.isFavorite = true
                            self.favorite.add(self.data)
                            
                        }
                    }
                    .onAppear(){
                        if self.favorite.contains(data) {
                            self.isFavorite = true
                        }
                    }
            }
            .padding(.horizontal, 10)
            detailImage
            VStack(alignment: .leading, spacing: 5){
                HStack{
                    Text(data.formattedDate)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    Spacer()
                }
                HStack{
                    Text("\(data.venue.city), \(data.venue.state)")
                        .font(.system(size: 18, weight: .regular, design: .default))
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            Spacer()
        }
        .padding(.vertical, 80)
        .navigationBarHidden(true)
        .overlay{
            ZStack{
                Color.darkGreen.ignoresSafeArea(edges: .top)
                HStack{
                    backButton
                        .padding(.leading)
                    Text("Details")
                        .foregroundColor(Color.white)
                        .padding(.leading, 118)
                    Spacer()
                }
                
            }
            .frame(height: 60)
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

//struct EventDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            EventDetails().environmentObject(MockData(textTitle: "This Text is some crazy Text in this label", place: "Mimai, FL", time: "Weds 12, Jul 2019 7:30 PM", imagePlace: "Audrey"))
//        }
//    }
//}
