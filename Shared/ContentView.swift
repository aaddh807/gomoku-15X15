import SwiftUI

struct ContentView: View
{
    @StateObject var gameState = GameState()
    
    var body: some View
    {
        let borderSize = CGFloat(10)
        
        Text(gameState.turnText())
            .font(.title)
            .bold()
            .padding()

        Text(String("First reach 5 in a line to win!"))
            .font(.title)
            .bold()
            .padding()
            .foregroundStyle(.red)

        
        VStack(spacing: borderSize)
        {
            ForEach(0...14, id: \.self)
            {
                row in
                HStack(spacing: borderSize)
                {
                    ForEach(0...14, id: \.self)
                    {
                        column in
                        
                        let cell = gameState.board[row][column]
                        
                        Text(cell.displayTile())
                            .font(.system(size: 15))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture {
                                gameState.placeTile(row, column)
                            }
                    }
                }
                
            }
        }
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.showAlert)
        {
            Alert(
                title: Text(gameState.alertMessage),
                dismissButton: .default(Text("Okay"))
                {
                    gameState.resetBoard()
                }
            )
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
