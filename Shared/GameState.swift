import Foundation

class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross

    @Published var showAlert = false
    @Published var alertMessage = "Draw"
    
    
    
    init()
    {
        resetBoard()
    }
    
    func turnText() -> String
    {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    func placeTile(_ row: Int,_ column: Int)
    {
        if(board[row][column].tile != Tile.Empty)
        {
            return
        }
        
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        
        if(checkForVictory(row,column))
        {

            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"


            
            showAlert = true
        }
        else
        {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        if(checkForDraw())
        {
            alertMessage = "Draw"
            showAlert = true
        }
    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if cell.tile == Tile.Empty
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func checkForVictory(_ row: Int,_ column: Int) -> Bool
    {
        if (checkDiagonalVictory(row, column) == true) {
            return true
        }
        if (checkVerticalVictory(row, column) == true) {
            return true
        }
        if (checkHorizontalVictory(row, column) == true) {
            return true
        }
        return false
    }
    
    func isTurnTile(_ row: Int,_ column: Int) -> Bool
    {
        if (row < 0) {
            return false
        }
        if (column < 0) {
            return false
        }
        return board[row][column].tile == turn
    }
    func checkDiagonalVictory(_ row: Int,_ column: Int) -> Bool
    {
        var num = 0
        for i in 0...8 {
            if (isTurnTile(row-4+i,column-4+i) == true)
            {
                num += 1
                if (num > 4) {
                    return true
                }
            }
            else {
                num = 0
            }
        }
        return false
    }
    func checkHorizontalVictory(_ row : Int,_ column: Int) -> Bool {
        var num = 0
        for i in 0...8 {
            if (isTurnTile(row, column-4+i) == true) {
                num += 1
                if (num > 4) {
                    return true
                }
            }
        }
        return false
    }
    func checkVerticalVictory(_ row : Int,_ column: Int) -> Bool {
        var num = 0
        for i in 0...8 {
            if (isTurnTile(row-4+i, column) == true) {
                num += 1
                if (num > 4) {
                    return true
                }
            }
        }
        return false
    }

    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...14
        {
            var row = [Cell]()
            for _ in 0...14
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard

    }
}
