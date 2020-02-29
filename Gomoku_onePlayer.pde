/*
 *  Vaccant  = 0
 *  User     = 1
 *  Computer = 2
 */
final int SIZE=16;
int pieceNow, mX, mY;
int[][] piece = new int[SIZE][SIZE];
PImage blackPiece, whitePiece, blackPieceCursor, blackWin, whiteWin, end;

void setup()
{
  blackPiece = loadImage("piece_black.png");
  whitePiece = loadImage("piece_white.png");
  blackPieceCursor = loadImage("cursor_black.png");
  blackWin = loadImage("blackWin.png");
  whiteWin = loadImage("whiteWin.png");
  end = loadImage("end.png");
  background(255, 204, 0);
  size(800, 900);
  cursor(blackPieceCursor);
  stroke(47, 131, 4);
  
  for(int i=0; i<SIZE; i++)
    for(int j=0; j<SIZE; j++)
      piece[i][j] = 0;
  
  for(int i=10; i<width; i+=50)
     line(i, 0, i, height);
     
  for(int i=10; i<height; i+=50)
     line(0, i, width, i);
  
  pieceNow = 1;
  blackPieceForUser();
  writeOnScreen("Welcome to Gomoku for one player.  You(Black) first.");
}

void draw()
{
  //Empty.
}

void mouseClicked()
{
  if(pieceNow != 1)
    return ;
  
  int result = newPiece(mouseX, mouseY);
  
  if(result == 1)
    whitePieceForComputer();
  else
  { }
}

void checkWin()
{
  int total;
  //Check row - blackPiece
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE-5; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if(piece[i][j+k] == 1)
          total++;
      }
      
      if(total == 5)
        win(1);
    }
  }
  
  //Check col - blackPiece
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE-5; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if(piece[j+k][i] == 1)
          total++;
      }
      
      if(total == 5)
        win(1);
    }
  }
  
  //Check row - whitePiece
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE-5; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if(piece[i][j+k] == 2)
          total++;
      }
      
      if(total == 5)
        win(2);
    }
  }
  
  //Check col - whitePiece
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE-5; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if(piece[j+k][i] == 2)
          total++;
      }
      
      if(total == 5)
        win(2);
    }
  }
  
  //Check \ - blackPiece
  for(int i=0; i<12; i++)
  {
    for(int j=0; j<12; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if(piece[i+k][j+k] == 1)
          total++;
      }
      
      if(total == 5)
        win(1);
    }
  }
  
  //Check / - blackPiece
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if((i-k)>=0 && (j+k)<SIZE && piece[i-k][j+k]==1)
          total++;
      }
      
      if(total == 5)
        win(1);
    }
  }
  
  //Check \ - whitePiece
  for(int i=0; i<12; i++)
  {
    for(int j=0; j<12; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if(piece[i+k][j+k] == 2)
          total++;
      }
      
      if(total == 5)
        win(2);
    }
  }
  
  //Check / - whitePiece
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      total = 0;
      for(int k=0; k<5; k++)
      {
        if((i-k)>=0 && (j+k)<SIZE && piece[i-k][j+k]==2)
          total++;
      }
      
      if(total == 5)
        win(2);
    }
  }
}

void whitePieceForComputer()
{
  if(pieceNow == 0) return ;
  
  pieceNow = 2;
  cursor(3);
  writeOnScreen("White: thinking");
  println("White: thinking");
  
  //General variable init.
  int total, foreBlackPiece, backBlackPiece, avaPiece, countContinuousWhite, foreWhitePiece, backWhitePiece, foreAvaPiece, backAvaPiece, countWhite;
  int count[] = new int[4];
  
  //[Attack] One piece remaining - col
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(j+k<SIZE && piece[i][j+k]==2)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(j-1>=0 && piece[i][j-1] == 0)
        {
          println("White: [Attack] One piece remaining - col");
          newPiece(i*50+10, (j-1)*50+10);
          return ;
        }
        else if(j+4<SIZE && piece[i][j+4] == 0)
        {
          println("White: [Attack] One piece remaining - col");
          newPiece(i*50+10, (j+4)*50+10);
          return ;
        }
      }
    }
  }
  
  //[Attack] One piece remaining - row
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(i+k<SIZE && piece[i+k][j]==2)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(i-1>=0 && piece[i-1][j] == 0)
        {
          println("White: [Attack] One piece remaining - row");
          newPiece((i-1)*50+10, j*50+10);
          return ;
        }
        else if(i+4<SIZE && piece[i+4][j] == 0)
        {
          println("White: [Attack] One piece remaining - row");
          newPiece((i+4)*50+10, j*50+10);
          return ;
        }
      }
    }
  }
  
  //[Attack] One piece remaining - \
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(i+k<SIZE && j+k<SIZE && piece[i+k][j+k]==2)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(i-1>=0 && j-1>=0 && piece[i-1][j-1] == 0)
        {
          println("White: [Attack] One piece remaining - \\");
          newPiece((i-1)*50+10, (j-1)*50+10);
          return ;
        }
        else if(i+4<SIZE && j+4<SIZE && piece[i+4][j+4] == 0)
        {
          println("White: [Attack] One piece remaining - \\");
          newPiece((i+4)*50+10, (j+4)*50+10);
          return ;
        }
      }
    }
  }
  
  //[Attack] One piece remaining - /
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(i-k>=0 && j+k<SIZE && piece[i-k][j+k]==2)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(i+1<SIZE && j-1>=0 && piece[i+1][j-1] == 0)
        {
          println("White: [Attack] One piece remaining - /");
          newPiece((i+1)*50+10, (j-1)*50+10);
          return ;
        }
        else if(i-4>=0 && j+4<SIZE && piece[i-4][j+4] == 0)
        {
          println("White: [Attack] One piece remaining - /");
          newPiece((i-4)*50+10, (j+4)*50+10);
          return ;
        }
      }
    }
  }
  
  /* special1
       1           1 1
      101    OR     0
       1           1 1
  */
  //[Defend] special1 +
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] != 0)
        continue;
      
      if((j-1>=0 && piece[i][j-1]==1) && (j+1<SIZE && piece[i][j+1]==1) && (i-1>=0 && piece[i-1][j]==1) && (i+1<SIZE && piece[i+1][j]==1))
      {
        avaPiece = 1;
        for(int k=1; k<5; k++)
        {
          if(j-k>=0 && piece[i][j-k]!=2)
            avaPiece++;
          else
            break;
        }
        
        for(int k=1; k<5; k++)
        {
          if(j+k<SIZE && piece[i][j+k]!=2)
            avaPiece++;
          else
            break;
        }
        
        if(avaPiece < 5)
          continue;
        
        avaPiece = 1;
        for(int k=1; k<5; k++)
        {
          if(i-k>=0 && piece[i-k][j]!=2)
            avaPiece++;
          else
            break;
        }
        
        for(int k=1; k<5; k++)
        {
          if(i+k<SIZE && piece[i+k][j]!=2)
            avaPiece++;
          else
            break;
        }
        
        if(avaPiece >= 5)
        {
          println("White: [Defend] special1 +");
          newPiece(i*50+10, j*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] special1 x
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] != 0)
        continue;
      
      if((i-1>=0 && j-1>=0 && piece[i-1][j-1]==1) && (i-1>=0 && j+1<SIZE && piece[i-1][j+1]==1) && (i+1<SIZE && j-1>=0 && piece[i+1][j-1]==1) && (i+1<SIZE && j+1<SIZE && piece[i+1][j+1]==1))
      {
        avaPiece = 1;
        for(int k=1; k<5; k++)
        {
          if(i-k>=0 && j-k>=0 && piece[i-1][j-k]!=2)
            avaPiece++;
          else
            break;
        }
        
        for(int k=1; k<5; k++)
        {
          if(i+k<SIZE && j+k<SIZE && piece[i+k][j+k]!=2)
            avaPiece++;
          else
            break;
        }
        
        if(avaPiece < 5)
          continue;
        
        avaPiece = 1;
        for(int k=1; k<5; k++)
        {
          if(i+k<SIZE && j-k>=0 && piece[i+k][j-k]!=2)
            avaPiece++;
          else
            break;
        }
        
        for(int k=1; k<5; k++)
        {
          if(i-k>=0 && j+k<SIZE && piece[i-k][j+k]!=2)
            avaPiece++;
          else
            break;
        }
        
        if(avaPiece >= 5)
        {
          println("White: [Defend] special1 x");
          newPiece(i*50+10, j*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] ?1111? - col
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(j+k<SIZE && piece[i][j+k]==1)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(j-1>=0 && piece[i][j-1]==0)
        {
          println("White: [Defend] 01111? - col");
          newPiece(i*50+10, (j-1)*50+10);
          blackPieceForUser();
          return ;
        }
        else if(j+4<SIZE && piece[i][j+4]==0)
        {
          println("White: [Defend] ?11110 - col");
          newPiece(i*50+10, (j+4)*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] ?1111? - row
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(i+k<SIZE && piece[i+k][j]==1)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(i-1>=0 && piece[i-1][j]==0)
        {
          println("White: [Defend] 01111? - row");
          newPiece((i-1)*50+10, j*50+10);
          blackPieceForUser();
          return ;
        }
        else if(i+4<SIZE && piece[i+4][j]==0)
        {
          println("White: [Defend] ?11110 - row");
          newPiece((i+4)*50+10, j*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] ?1111? - \
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(i+k<SIZE && j+k<SIZE && piece[i+k][j+k]==1)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(i-1>=0 && j-1>=0 && piece[i-1][j-1]==0)
        {
          println("White: [Defend] 01111? - \\");
          newPiece((i-1)*50+10, (j-1)*50+10);
          blackPieceForUser();
          return ;
        }
        else if(i+4<SIZE && j+4<SIZE && piece[i+4][j+4]==0)
        {
          println("White: [Defend] ?11110 - \\");
          newPiece((i+4)*50+10, (j+4)*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] ?1111? - /
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      total = 0;
      for(int k=0; k<4; k++)
      {
        if(i-k>=0 && j+k<SIZE && piece[i-k][j+k]==1)
          total++;
        else
          break;
      }
      
      if(total == 4)
      {
        if(i+1<SIZE && j-1>=0 && piece[i+1][j-1]==0)
        {
          println("White: [Defend] 01111? - /");
          newPiece((i+1)*50+10, (j-1)*50+10);
          blackPieceForUser();
          return ;
        }
        else if(i-4>=0 && j+4<SIZE && piece[i-4][j+4]==0)
        {
          println("White: [Defend] ?11110 - /");
          newPiece((i-4)*50+10, (j+4)*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] 01110 - col
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(j-1>=0 && piece[i][j-1]==0)
        total = 0;
      else
        continue;
      
      for(int k=0; k<3; k++)
      {
        if(j+k<SIZE && piece[i][j+k]==1)
          total++;
        else
          break;
      }
      
      if(total == 3)
      {
        if(j+3<SIZE && piece[i][j+3] == 0)
        {
          if(j-2>=0 && piece[i][j-2] == 1)
          {
            println("White: [Defend] 01110 - col");
            newPiece(i*50+10, (j-1)*50+10);
            blackPieceForUser();
            return ;
          }
          else
          {
            println("White: [Defend] 01110 - col");
            newPiece(i*50+10, (j+3)*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //[Defend] 01110 - row
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(i-1>=0 && piece[i-1][j]==0)
        total = 0;
      else
        continue;
      
      for(int k=0; k<3; k++)
      {
        if(i+k<SIZE && piece[i+k][j]==1)
          total++;
        else
          break;
      }
      
      if(total == 3)
      {
        if(i+3<SIZE && piece[i+3][j] == 0)
        {
          if(i-2>=0 && piece[i-2][j] == 1)
          {
            println("White: [Defend] 01110 - row");
            newPiece((i-1)*50+10, (j)*50+10);
            blackPieceForUser();
            return ;
          }
          else
          {
            println("White: [Defend] 01110 - row");
            newPiece((i+3)*50+10, j*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //[Defend] 01110 - \
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(i-1>=0 && j-1>=0 && piece[i-1][j-1]==0)
        total = 0;
      else
        continue;
      
      for(int k=0; k<3; k++)
      {
        if(i+k<SIZE && j+k<SIZE && piece[i+k][j+k]==1)
          total++;
        else
          break;
      }
      
      if(total == 3)
      {
        if(i+3<SIZE && j+3<SIZE && piece[i+3][j+3] == 0)
        {
          if(i-2>=0 && j-2>=0 && piece[i-2][j-2] == 1)
          {
            println("White: [Defend] 01110 - \\");
            newPiece((i-1)*50+10, (j-1)*50+10);
            blackPieceForUser();
            return ;
          }
          else
          {
            println("White: [Defend] 01110 - \\");
            newPiece((i+3)*50+10, (j+3)*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //[Defend] 01110 - /
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(i+1<SIZE && j-1>=0 && piece[i+1][j-1]==0)
        total = 0;
      else
        continue;
      
      for(int k=0; k<3; k++)
      {
        if(i-k>=0 && j+k<SIZE && piece[i-k][j+k]==1)
          total++;
        else
          break;
      }
      
      if(total == 3)
      {
        if(i-3>=0 && j+3<SIZE && piece[i-3][j+3] == 0)
        {
          if(i+2<SIZE && j-2>=0 && piece[i+2][j-2] == 1)
          {
            println("White: [Defend] 01110 - /");
            newPiece((i+1)*50+10, (j-1)*50+10);
            blackPieceForUser();
            return ;
          }
          else
          {
            println("White: [Defend] 01110 - /");
            newPiece((i-3)*50+10, (j+3)*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //[Defend] multipath
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] != 0)
        continue;
      
      count[0] = count_black_pieces_in_column(i, j);
      count[1] = count_black_pieces_in_row(i, j);
      count[2] = count_black_pieces_in_slash(i, j);
      count[3] = count_black_pieces_in_backslash(i, j);
      countWhite = 0;
      for(int m=0; m<4; m++)
      {
        for(int n=m+1; n<4; n++)
        {
          if(count[m] + count[n] >= 5)
          {
            if(count[m]==1 || count[n]==1)
              continue;
            
            println("White: [Defend] multipath");
            newPiece(i*50+10, j*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //[Defend] -101- -col
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(piece[i][j] == 1)
      {
        foreBlackPiece = 1;
        backBlackPiece = 0;
        avaPiece = -1;
      }
      else
        continue;
      
      for(int k=1; ; k++)
      {
        if(j+k >= SIZE)
          break;
        
        if(piece[i][j+k]==1)
        {
          if(avaPiece == -1)
          {
            foreBlackPiece++;
          }
          else
          {
            backBlackPiece++;
          }
        }
        else if(piece[i][j+k] == 2)
        {
          break;
        }
        else
        {
          if(avaPiece == -1)
            avaPiece = k;
          else
          {
            if(k-1 == avaPiece)
              avaPiece = -1;
            
            break;
          }
        }
      }
      
      if(avaPiece!=-1 && backBlackPiece!=0)
      {
        if(foreBlackPiece + backBlackPiece >= 3)
        {
          println("White: [Defend] -101- -col");
          newPiece(i*50+10, (j+avaPiece)*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] -101- -row
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(piece[i][j] == 1)
      {
        foreBlackPiece = 1;
        backBlackPiece = 0;
        avaPiece = -1;
      }
      else
        continue;
      
      for(int k=1; ; k++)
      {
        if(i+k >= SIZE)
          break;
        
        if(piece[i+k][j] == 1)
        {
          if(avaPiece == -1)
          {
            foreBlackPiece++;
          }
          else
          {
            backBlackPiece++;
          }
        }
        else if(piece[i+k][j] == 2)
        {
          break;
        }
        else
        {
          if(avaPiece == -1)
            avaPiece = k;
          else
          {
            if(k-1 == avaPiece)
              avaPiece = -1;
            
            break;
          }
        }
      }
      
      if(avaPiece!=-1 && backBlackPiece!=0)
      {
        if(foreBlackPiece + backBlackPiece >= 3)
        {
          println("White: [Defend] -101- -row");
          newPiece((i+avaPiece)*50+10, j*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] -101- -\
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(piece[i][j] == 1)
      {
        foreBlackPiece = 1;
        backBlackPiece = 0;
        avaPiece = -1;
      }
      else
        continue;
      
      for(int k=1; ; k++)
      {
        if(j+k>=SIZE || i+k>=SIZE)
          break;
        
        if(piece[i+k][j+k]==1)
        {
          if(avaPiece == -1)
          {
            foreBlackPiece++;
          }
          else
          {
            backBlackPiece++;
          }
        }
        else if(piece[i+k][j+k] == 2)
        {
          break;
        }
        else
        {
          if(avaPiece == -1)
            avaPiece = k;
          else
          {
            if(k-1 == avaPiece)
              avaPiece = -1;
            
            break;
          }
        }
      }
      
      if(avaPiece!=-1 && backBlackPiece!=0)
      {
        if(foreBlackPiece + backBlackPiece >= 3)
        {
          println("White: [Defend] -101- -\\");
          newPiece((i+avaPiece)*50+10, (j+avaPiece)*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Defend] -101- -/
  for(int i=SIZE-1; i>=0; i--)
  {
    for(int j=SIZE-1; j>=0; j--)
    {
      if(piece[i][j] == 1)
      {
        foreBlackPiece = 1;
        backBlackPiece = 0;
        avaPiece = -1;
      }
      else
        continue;
      
      for(int k=1; ; k++)
      {
        if(i-k<0 || j+k>=SIZE)
          break;
        
        if(piece[i-k][j+k]==1)
        {
          if(avaPiece == -1)
          {
            foreBlackPiece++;
          }
          else
          {
            backBlackPiece++;
          }
        }
        else if(piece[i-k][j+k] == 2)
        {
          break;
        }
        else
        {
          if(avaPiece == -1)
            avaPiece = k;
          else
          {
            if(k-1 == avaPiece)
              avaPiece = -1;
            
            break;
          }
        }
      }
      
      if(avaPiece!=-1 && backBlackPiece!=0)
      {
        if(foreBlackPiece + backBlackPiece >= 3)
        {
          println("White: [Defend] -101- -/");
          newPiece((i-avaPiece)*50+10, (j+avaPiece)*50+10);
          blackPieceForUser();
          return ;
        }
      }
    }
  }
  
  //[Attack] ?222? - col
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] == 2)
      {
        countContinuousWhite = 0;
        for(int k=0; (j+k)<SIZE; k++)
        {
          if(piece[i][j+k] == 2)
            countContinuousWhite++;
          else
            break;
        }
        
        if(countContinuousWhite == 3)
        {
          foreWhitePiece = 0;
          for(int k=1; (j-k)>=0; k++)
          {
            if(piece[i][j-k] != 1)
              foreWhitePiece++;
            else
              break;
          }
          
          backWhitePiece = 0;
          for(int k=countContinuousWhite; (j+k)<SIZE; k++)
          {
            if(piece[i][j+k] != 1)
              backWhitePiece++;
            else
              break;
          }
          
          if(foreWhitePiece + backWhitePiece >= 2)
          {
            if(foreWhitePiece > backWhitePiece)
            {
              println("White: [Attack] ?222? - up");
              newPiece(i*50+10, (j-1)*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?222? - down");
              newPiece(i*50+10, (j+countContinuousWhite)*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
        
        j += countContinuousWhite - 1;
      }
    }
  }
  
  //[Attack] ?222? - row
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[j][i] == 2)
      {
        countContinuousWhite = 0;
        for(int k=0; (j+k)<SIZE; k++)
        {
          if(piece[j+k][i] == 2)
            countContinuousWhite++;
          else
            break;
        }
        
        if(countContinuousWhite == 3)
        {
          foreWhitePiece = 0;
          for(int k=1; (j-k)>=0; k++)
          {
            if(piece[j-k][i] != 1)
              foreWhitePiece++;
            else
              break;
          }
          
          backWhitePiece = 0;
          for(int k=countContinuousWhite; (j+k)<SIZE; k++)
          {
            if(piece[j+k][i] != 1)
              backWhitePiece++;
            else
              break;
          }
          
          if(foreWhitePiece + backWhitePiece >= 2)
          {
            if(foreWhitePiece > backWhitePiece)
            {
              println("White: [Attack] ?222? - left");
              newPiece((j-1)*50+10, i*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?222? - right");
              newPiece((j+countContinuousWhite)*50+10, i*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
        
        j += countContinuousWhite - 1;
      }
    }
  }
  
  //[Attack] ?222? - \
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] == 2)
      {
        countContinuousWhite = 0;
        for(int k=0; (i+k<SIZE)&&(j+k<SIZE); k++)
        {
          if(piece[i+k][j+k] == 2)
            countContinuousWhite++;
          else
            break;
        }
        
        if(countContinuousWhite == 3)
        {
          foreWhitePiece = 0;
          for(int k=1; (i-k>=0)&&(j-k>=0); k++)
          {
            if(piece[i-k][j-k] != 1)
              foreWhitePiece++;
            else
              break;
          }
          
          backWhitePiece = 0;
          for(int k=countContinuousWhite; (i+k<SIZE)&&(j+k<SIZE); k++)
          {
            if(piece[i+k][j+k] != 1)
              backWhitePiece++;
            else
              break;
          }
          
          if(foreWhitePiece + backWhitePiece >= 2)
          {
            if(foreWhitePiece > backWhitePiece)
            {
              println("White: [Attack] ?222? - left up");
              newPiece((i-1)*50+10, (j-1)*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?222? - right down");
              newPiece((i+countContinuousWhite)*50+10, (j+countContinuousWhite)*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
      }
    }
  }
  
  //[Attack] ?222? - /
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] == 2)
      {
        countContinuousWhite = 0;
        for(int k=0; (i-k>=0)&&(j+k<SIZE); k++)
        {
          if(piece[i-k][j+k] == 2)
            countContinuousWhite++;
          else
            break;
        }
        
        if(countContinuousWhite == 3)
        {
          foreWhitePiece = 0;
          for(int k=1; (i+k<SIZE)&&(j-k>=0); k++)
          {
            if(piece[i+k][j-k] != 1)
              foreWhitePiece++;
            else
              break;
          }
          
          backWhitePiece = 0;
          for(int k=countContinuousWhite; (i-k>=0)&&(j+k<SIZE); k++)
          {
            if(piece[i-k][j+k] != 1)
              backWhitePiece++;
            else
              break;
          }
          
          if(foreWhitePiece + backWhitePiece >= 2)
          {
            if(foreWhitePiece > backWhitePiece)
            {
              println("White: [Attack] ?222? - right up");
              newPiece((i+1)*50+10, (j-1)*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?222? - left down");
              newPiece((i-countContinuousWhite)*50+10, (j+countContinuousWhite)*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
      }
    }
  }
  
  //[Defend] multipath 4-4
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] != 0)
        continue;
      
      count[0] = count_black_pieces_in_column(i, j);
      count[1] = count_black_pieces_in_row(i, j);
      count[2] = count_black_pieces_in_slash(i, j);
      count[3] = count_black_pieces_in_backslash(i, j);
      countWhite = 0;
      for(int m=0; m<4; m++)
      {
        for(int n=m+1; n<4; n++)
        {
          if(count[m]==2 && count[n]==2)
          {
            println("White: [Defend] multipath - 4-4");
            newPiece(i*50+10, j*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //[Attack] multipath
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] != 0)
        continue;
      
      count[0] = count_white_pieces_in_column(i, j);
      count[1] = count_white_pieces_in_row(i, j);
      count[2] = count_white_pieces_in_slash(i, j);
      count[3] = count_white_pieces_in_backslash(i, j);
      countWhite = 0;
      for(int m=0; m<4; m++)
      {
        for(int n=m+1; n<4; n++)
        {
          if(count[m] + count[n] >= 5)
          {
            if(count[m]==1 || count[n]==1)
              continue;
            
            println("White: [Attack] multipath");
            newPiece(i*50+10, j*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //[Attack] ?202? - col
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE-5; j++)
    {
      if(piece[j][i]!=1 && piece[j+1][i]==2 && piece[j+2][i]==0 && piece[j+3][i]==2 && piece[j+4][i]!=1)
      {
        println("White: [Attack] ?202? - col");
        newPiece((j+2)*50+10, i*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
  //[Attack] ?202? - row
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE-5; j++)
    {
      if(piece[i][j]!=1 && piece[i][j+1]==2 && piece[i][j+2]==0 && piece[i][j+3]==2 && piece[i][j+4]!=1)
      {
        println("White: [Attack] ?202? - row");
        newPiece(i*50+10, (j+2)*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
  //[Attack] ?202? - \
  for(int i=0; i<SIZE-5; i++)
  {
    for(int j=0; j<SIZE-5; j++)
    {
      if(piece[i][j]!=1 && piece[i+1][j+1]==2 && piece[i+2][j+2]==0 && piece[i+3][j+3]==2 && piece[i+4][j+4]!=1)
      {
        println("White: [Attack] ?202? - \\");
        newPiece((i+2)*50+10, (j+2)*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
  //[Attack] ?202? - /
  for(int i=0; i<SIZE-5; i++)
  {
    for(int j=4; j<SIZE; j++)
    {
      if(piece[i][j]!=1 && piece[i+1][j-1]==2 && piece[i+2][j-2]==0 && piece[i+3][j-3]==2 && piece[i+4][j-4]!=1)
      {
        println("White: [Attack] ?202? - /");
        newPiece((i+2)*50+10, (j-2)*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
  //[Attack] ?22? - col
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] == 2)
      {
        if(j+1<SIZE && piece[i][j+1]==2)
        {
          foreAvaPiece = 0;
          for(int k=1; k<4; k++)
          {
            if(j-k>=0 && piece[i][j-k]==0)
              foreAvaPiece++;
            else
              break;
          }
          
          backAvaPiece = 0;
          for(int k=2; k<5; k++)
          {
            if(j+k<SIZE && piece[i][j+k]==0)
              backAvaPiece++;
            else
              break;
          }
          
          if(foreAvaPiece + backAvaPiece >= 3)
          {
            if(foreAvaPiece > backAvaPiece)
            {
              println("White: [Attack] ?22? - col - up");
              newPiece(i*50+10, (j-1)*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?22? - col - down");
              newPiece(i*50+10, (j+2)*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
      }
    }
  }
  
  //[Attack] ?22? - row
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[j][i] == 2)
      {
        if(j+1<SIZE && piece[j+1][i]==2)
        {
          foreAvaPiece = 0;
          for(int k=1; k<4; k++)
          {
            if(j-k>=0 && piece[j-k][i]==0)
              foreAvaPiece++;
            else
              break;
          }
          
          backAvaPiece = 0;
          for(int k=2; k<5; k++)
          {
            if(j+k<SIZE && piece[j+k][i]==0)
              backAvaPiece++;
            else
              break;
          }
          
          if(foreAvaPiece + backAvaPiece >= 3)
          {
            if(foreAvaPiece > backAvaPiece)
            {
              println("White: [Attack] ?22? - row - left");
              newPiece((j-1)*50+10, i*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?22? - row - right");
              newPiece((j+2)*50+10, i*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
      }
    }
  }
  
  //[Attack] ?22? - \
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] == 2)
      {
        if(i+1<SIZE && j+1<SIZE && piece[i+1][j+1]==2)
        {
          foreAvaPiece = 0;
          for(int k=1; k<4; k++)
          {
            if(i-k>=0 && j-k>=0 && piece[i-k][j-k]==0)
              foreAvaPiece++;
            else
              break;
          }
          
          backAvaPiece = 0;
          for(int k=2; k<5; k++)
          {
            if(i+k<SIZE && j+k<SIZE && piece[i+k][j+k]==0)
              backAvaPiece++;
            else
              break;
          }
          
          if(foreAvaPiece + backAvaPiece >= 3)
          {
            if(foreAvaPiece > backAvaPiece)
            {
              println("White: [Attack] ?22? - \\ - left up");
              newPiece((i-1)*50+10, (j-1)*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?22? - \\ - right down");
              newPiece((i+2)*50+10, (j+2)*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
      }
    }
  }
  
  //[Attack] ?22? - /
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] == 2)
      {
        if(i-1>=0 && j+1<SIZE && piece[i-1][j+1]==2)
        {
          foreAvaPiece = 0;
          for(int k=1; k<4; k++)
          {
            if(i+k<SIZE && j-k>=0 && piece[i+k][j-k]==0)
              foreAvaPiece++;
            else
              break;
          }
          
          backAvaPiece = 0;
          for(int k=2; k<5; k++)
          {
            if(i-k>=0 && j+k<SIZE && piece[i-k][j+k]==0)
              backAvaPiece++;
            else
              break;
          }
          
          if(foreAvaPiece + backAvaPiece >= 3)
          {
            if(foreAvaPiece > backAvaPiece)
            {
              println("White: [Attack] ?22? - \\ - right up");
              newPiece((i+1)*50+10, (j-1)*50+10);
              blackPieceForUser();
              return ;
            }
            else
            {
              println("White: [Attack] ?22? - \\ - left down");
              newPiece((i-2)*50+10, (j+2)*50+10);
              blackPieceForUser();
              return ;
            }
          }
        }
      }
    }
  }
  
  //Find a free place near known piece.
  for(int i=0; i<SIZE; i++)
  {
    for(int j=0; j<SIZE; j++)
    {
      if(piece[i][j] == 2)
      {
        if(i-1>=0 && piece[i-1][j]==0)
        {
          avaPiece = 0;
          for(int k=1; (i-1-k)>=0; k++)
          {
            if(piece[i-1-k][j] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (i-1+k)<SIZE; k++)
          {
            if(piece[i-1+k][j] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching left border.
          {
            println("White: Find a free place near known piece. -left");
            newPiece((i-1)*50+10, j*50+10);
            blackPieceForUser();
            return ;
          }
        }
        else if(j+1<SIZE && piece[i][j+1]==0)
        {
          avaPiece = 0;
          for(int k=1; (j+1-k)>=0; k++)
          {
            if(piece[i][j+1-k] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (j+1+k)<SIZE; k++)
          {
            if(piece[i][j+1+k] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching bottom border.
          {
            println("White: Find a free place near known piece. -down");
            newPiece(i*50+10, (j+1)*50+10);
            blackPieceForUser();
            return ;
          }
        }
        else if(i+1<SIZE && piece[i+1][j]==0)
        {
          avaPiece = 0;
          for(int k=1; (i+1-k)>=0; k++)
          {
            if(piece[i+1-k][j] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (i+1+k)<SIZE; k++)
          {
            if(piece[i+1+k][j] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching right border.
          {
            println("White: Find a free place near known piece. -right");
            newPiece((i+1)*50+10, j*50+10);
            blackPieceForUser();
            return ;
          }
        }
        else if(j-1>=0 && piece[i][j-1]==0)
        {
          avaPiece = 0;
          for(int k=1; (j-1-k)>=0; k++)
          {
            if(piece[i][j-1-k] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (j-1+k)<SIZE; k++)
          {
            if(piece[i][j-1+k] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching top border.
          {
            println("White: Find a free place near known piece. -up");
            newPiece(i*50+10, (j-1)*50+10);
            blackPieceForUser();
            return ;
          }
        }
        else if(i-1>=0 && j-1>=0 && piece[i-1][j-1]==0)
        {
          avaPiece = 0;
          for(int k=1; (i-1-k)>=0&&(j-1-k)>=0; k++)
          {
            if(piece[i-1-k][j-1-k] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (i-1+k)<SIZE&&(j-1+k)<SIZE; k++)
          {
            if(piece[i-1+k][j-1+k] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching up left border.
          {
            println("White: Find a free place near known piece. -up -left");
            newPiece((i-1)*50+10, (j-1)*50+10);
            blackPieceForUser();
            return ;
          }
        }
        else if(i-1>=0 && j+1<SIZE && piece[i-1][j+1]==0)
        {
          avaPiece = 0;
          for(int k=1; (i-1-k)>=0&&(j+1-k)<SIZE; k++)
          {
            if(piece[i-1-k][j+1-k] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (i-1+k)<SIZE&&(j+1-k)>=0; k++)
          {
            if(piece[i-1+k][j+1-k] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching bottom left border.
          {
            println("White: Find a free place near known piece. -down -left");
            newPiece((i-1)*50+10, (j+1)*50+10);
            blackPieceForUser();
            return ;
          }
        }
        else if(i+1<SIZE && j+1<SIZE && piece[i+1][j+1]==0)
        {
          avaPiece = 0;
          for(int k=1; (i+1+k)<SIZE&&(j+1+k)<SIZE; k++)
          {
            if(piece[i+1+k][j+1+k] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (i+1-k)>=0&&(j+1-k)>=0; k++)
          {
            if(piece[i+1-k][j+1-k] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching down right border.
          {
            println("White: Find a free place near known piece. -down -right");
            newPiece((i+1)*50+10, (j+1)*50+10);
            blackPieceForUser();
            return ;
          }
        }
        else if(i+1<SIZE && j-1>=0 && piece[i+1][j-1]==0)
        {
          avaPiece = 0;
          for(int k=1; (i+1+k)<SIZE&&(j-1-k)>=0; k++)
          {
            if(piece[i+1+k][j-1-k] == 1)
              break;
            avaPiece++;
          }
          
          for(int k=1; (i+1-k)>=0&&(j-1+k)<SIZE; k++)
          {
            if(piece[i+1-k][j-1+k] == 1)
              break;
            avaPiece++;
          }
          
          if(avaPiece+1 >= 5) //Prevent non-sense piece - touching up left border.
          {
            println("White: Find a free place near known piece. -up -right");
            newPiece((i+1)*50+10, (j-1)*50+10);
            blackPieceForUser();
            return ;
          }
        }
      }
    }
  }
  
  //Find a free place near center. -left -up
  for(int i=8; i>=0; i--)
  {
    for(int j=8; j>=0; j--)
    {
      if(piece[i][j] == 0)
      {
        println("White: Find a free place near center. -left -up");
        newPiece(i*50+10, j*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
  //Find a free place near center. -right -up
  for(int i=9; i<SIZE; i++)
  {
    for(int j=8; j>=0; j--)
    {
      if(piece[i][j] == 0)
      {
        println("White: Find a free place near center. -right -up");
        newPiece(i*50+10, j*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
  //Find a free place near center. -left -down
  for(int i=8; i>=0; i--)
  {
    for(int j=9; j<SIZE; j++)
    {
      if(piece[i][j] == 0)
      {
        println("White: Find a free place near center. -left -down");
        newPiece(i*50+10, j*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
  //Find a free place near center. -right -down
  for(int i=9; i<SIZE; i++)
  {
    for(int j=9; j<SIZE; j++)
    {
      if(piece[i][j] == 0)
      {
        println("White: Find a free place near center. -left -down");
        newPiece(i*50+10, j*50+10);
        blackPieceForUser();
        return ;
      }
    }
  }
  
}

void blackPieceForUser()
{
  if(pieceNow == 0) return ;
  
  pieceNow = 1;
  cursor(blackPieceCursor);
  writeOnScreen("Black: thinking");
  println("Black: thinking");
}

int newPiece(int mX, int mY)
{
  if((mX-10)%50 < 25)
    mX = (mX-10)/50*50+10;
  else
    mX = (mX-10)/50*50+10+50;
  
  if((mY-10)%50 < 25)
    mY = (mY-10)/50*50+10;
  else
    mY = (mY-10)/50*50+10+50;
  
  if((mX-10)/50>=SIZE || (mY-10)/50>=SIZE)
  {
    writeOnScreen("Error place.  Retry!");
    println("Error place.  Retry!");
    return -1;
  }
  
  if(piece[(mX-10)/50][(mY-10)/50] == 0)
    piece[(mX-10)/50][(mY-10)/50] = pieceNow;
  else
  {
    writeOnScreen("Error place.  Retry!");
    println("Error place.  Retry!");
    return -1;
  }
  
  if(pieceNow == 1)
  {
    writeOnScreen("blackPiece: " + (mX-10)/50 + ", " + (mY-10)/50);
    println("blackPiece: " + (mX-10)/50 + ", " + (mY-10)/50);
    image(blackPiece, mX-20, mY-20);
  }
  else if(pieceNow == 2)
  {
    writeOnScreen("whitePiece: " + (mX-10)/50 + ", " + (mY-10)/50);
    println("whitePiece: " + (mX-10)/50 + ", " + (mY-10)/50);
    image(whitePiece, mX-20, mY-20);
  }
  else
  {
    writeOnScreen("Stop!");
    println("Stop!");
  }
  
  checkWin();
  return pieceNow;
}

void win(int who)
{
  if(who == 1)
  {
    writeOnScreen("Black win!");
    println("Black win!");
    //image(blackWin, width/2-blackWin.width/2, height/2-blackWin.height/2);
    pieceNow = 0;
  }
  else if(who == 2)
  {
    writeOnScreen("White win!");
    println("White win!");
    //image(whiteWin, width/2-whiteWin.width/2, height/2-whiteWin.height/2);
    pieceNow = 0;
  }
  
  cursor(end);
}

void writeOnScreen(String input)
{
  fill(0);
  rect(0, 800, width-1, 94);
  fill(47, 131, 4);
  textFont(createFont("Arial Bold", 30));
  text(input, 10, 850);
}

//Computer solving helping functions.
int count_black_pieces_in_column(int x, int y)
{
  int countBlack=0, countAva=0;
  
  //Up.
  for(int i=1; i<5; i++)
  {
    if(y-i >= 0)
    {
      if(piece[x][y-i] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x][y-i] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  //Down.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(y+i < SIZE)
    {
      if(piece[x][y+i] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x][y+i] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  if(countBlack > 0)
    return countBlack;
  else
    return 0;
}

int count_black_pieces_in_row(int x, int y)
{
  int countBlack=0, countAva=0;
  
  //Left.
  for(int i=1; i<5; i++)
  {
    if(x-i >= 0)
    {
      if(piece[x-i][y] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x-i][y] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  //Right.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(x+i < SIZE)
    {
      if(piece[x+i][y] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x+i][y] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  if(countBlack > 0)
    return countBlack;
  else
    return 0;
}

int count_black_pieces_in_slash(int x, int y)
{
  int countBlack=0, countAva=0;
  
  //Left-Up.
  for(int i=1; i<5; i++)
  {
    if(x-i>=0 && y-i>=0)
    {
      if(piece[x-i][y-i] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x-i][y-i] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  //Right-Down.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(x+i<SIZE && y+i<SIZE)
    {
      if(piece[x+i][y+i] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x+i][y+i] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  if(countBlack > 0)
    return countBlack;
  else
    return 0;
}

int count_black_pieces_in_backslash(int x, int y)
{
  int countBlack=0, countAva=0;
  
  //Right-Up.
  for(int i=1; i<5; i++)
  {
    if(x+i<SIZE && y-i>=0)
    {
      if(piece[x+i][y-i] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x+i][y-i] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  //Left-Down.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(x-i>=0 && y+i<SIZE)
    {
      if(piece[x-i][y+i] == 0)
      {
        if(countBlack > 0)
          return countBlack;
        else
          countAva++;
      }
      else if(piece[x-i][y+i] == 1)
        countBlack++;
      else
        break;
    }
    else
      break;
  }
  
  if(countBlack > 0)
    return countBlack;
  else
    return 0;
}

int count_white_pieces_in_column(int x, int y)
{
  int countWhite=0, countAva=0;
  
  //Up.
  for(int i=1; i<5; i++)
  {
    if(y-i >= 0)
    {
      if(piece[x][y-i] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x][y-i] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  //Down.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(y+i < SIZE)
    {
      if(piece[x][y+i] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x][y+i] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  if(countWhite > 0)
    return countWhite;
  else
    return 0;
}

int count_white_pieces_in_row(int x, int y)
{
  int countWhite=0, countAva=0;
  
  //Left.
  for(int i=1; i<5; i++)
  {
    if(x-i >= 0)
    {
      if(piece[x-i][y] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x-i][y] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  //Right.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(x+i < SIZE)
    {
      if(piece[x+i][y] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x+i][y] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  if(countWhite > 0)
    return countWhite;
  else
    return 0;
}

int count_white_pieces_in_slash(int x, int y)
{
  int countWhite=0, countAva=0;
  
  //Left-Up.
  for(int i=1; i<5; i++)
  {
    if(x-i>=0 && y-i>=0)
    {
      if(piece[x-i][y-i] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x-i][y-i] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  //Right-Down.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(x+i<SIZE && y+i<SIZE)
    {
      if(piece[x+i][y+i] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x+i][y+i] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  if(countWhite > 0)
    return countWhite;
  else
    return 0;
}

int count_white_pieces_in_backslash(int x, int y)
{
  int countWhite=0, countAva=0;
  
  //Right-Up.
  for(int i=1; i<5; i++)
  {
    if(x+i<SIZE && y-i>=0)
    {
      if(piece[x+i][y-i] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x+i][y-i] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  //Left-Down.
  countAva = 0;
  for(int i=1; i<5; i++)
  {
    if(x-i>=0 && y+i<SIZE)
    {
      if(piece[x-i][y+i] == 0)
      {
        if(countWhite > 0)
          return countWhite;
        else
          countAva++;
      }
      else if(piece[x-i][y+i] == 2)
        countWhite++;
      else
        break;
    }
    else
      break;
  }
  
  if(countWhite > 0)
    return countWhite;
  else
    return 0;
}
