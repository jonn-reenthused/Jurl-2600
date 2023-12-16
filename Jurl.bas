   rem ----------------------------------------------------------------------------
   rem - JURL (2600)                                                              -
   rem - 2020 Tonsomo Entertainment                                               -
   rem ----------------------------------------------------------------------------
   rem - Development History                                                      -
   rem - V0.1     Johnny Blanchard      Initial Development     2020-04-10        -      
   rem ----------------------------------------------------------------------------
 
   include div_mul.asm
   include div_mul16.asm

   set tv pal
   set romsize 16k

   set kernel_options no_blank_lines pfcolors collision(player0,playfield)
   set optimization speed
   set optimization inlinerand
   set smartbranching on

   dim rand16 = z

   a = 0 : b = 0 : c = 0 : d = 0 : e = 0 : f = 0 : g = 0 : h = 0 : i = 0
   j = 0 : k = 0 : l = 0 : m = 0 : n = 0 : o = 0 : p = 0 : q = 0 : r = 0
   s = 0 : t = 0 : u = 0 : v = 0 : w = 0 : x = 0 : y = 0

   const font = .21stcentury

   const _P_Edge_Top = 14
   const _P_Edge_Bottom = 77
   const _P_Edge_Left = 21
   const _P_Edge_Right = 133

   const _B_Edge_Top = 3
   const _B_Edge_Bottom = 88
   const _B_Edge_Left = 2
   const _B_Edge_Right = 159

   const pfscore = 1
   const _P1_Height = 6
   const _P1_Width = 8
   const _numberOfDiamonds = 34
   const _P_Start_X = 76
   const _P_Start_Y = 50
   const _P_Alien_Y = 15
   const _P_Alien_X = 25
   const _End_Level_Pause = 120
   const _P_COLOUR = $2E

   dim _P1_x = player0x
   dim _P1_y = player0y
   dim _pf_x = a
   dim _pf_y = b
   def rot=d
   def dx=f
   def dy=g
   def frameCounter=h
   def lastMoveFrame=i
   def deBounce=j
   def diamondsLeft=k
   def endLevelPause = l
   dim _CurrentLevel = n
   def isDying = o
   def aX = p
   def aY = q
   def playerLives = r
   def bX = s
   def bY = t
   def ballActive = u
   def hasFired = v
   dim _Ch0_Sound = w
   dim _Ch0_Duration = x

   ballheight = 2 : rem * Ball 4 pixels high.
   CTRLPF = $21 : rem * Ball 4 pixels wide.

   AUDV0 = 0 : AUDV1 = 0

titlescreen
  _Ch0_Sound{0} = 0
  _Ch0_Sound{1} = 0

   deBounce = 0
   _CurrentLevel = 1
   playerLives=4
   pfscore1 = %10101010
   isDying = 0
   ballActive = 0

displayTitlescreen

 gosub titledrawscreen bank2

  if joy0fire && deBounce > 5 then goto main
  deBounce = deBounce + 1

 goto displayTitlescreen

main

   rem ----------------------------------------------------------------------------
   c{1}=0 :rem Turned on if the last location of the joystick was UP
   c{2}=0 :rem Turned on if the last location of the joystick was DOWN
   c{3}=0 :rem Turned on if the last location of the joystick was LEFT
   c{4}=0 :rem Turned on if the last location of the joystick was RIGHT
   c{5}=0 :rem Turned on if the last location of the joystick was UP+LEFT
   c{6}=0 :rem Turned on if the last location of the joystick was UP+RIGHT
   c{7}=0 :rem Turned on if the last location of the joystick was DOWN+LEFT
   c{0}=0 :rem Turned on if the last location of the joystick was DOWN+RIGHT
   rem ----------------------------------------------------------------------------

   rem ----------------------------------------------------------------------------
newlevel

  if playerLives = 0 then goto gameover

   pfscore2 = %00000000

   COLUP0 = _P_COLOUR

  if _CurrentLevel > 5 then ballActive = 1

   player0x = _P_Start_X
   player0y = _P_Start_Y
   player1y = _P_Alien_Y
   player1x = _P_Alien_X
   if ballActive = 1 then ballx = 30 : bally = 10
   rot = 0
   dx = 3
   dy = 3
   aX = 3
   aY = 3
   frameCounter = 0
   lastMoveFrame = 0

   if isDying then goto setupgame

  playfield:
   ................................
   ................................
   ................................
   ......XXX.XXX.XXX.XXX.XXX.......
   ......X....X..X.X.X.X..X........
   ......XXX..X..XXX.XXX..X........
   ........X..X..X.X.XX...X........
   ......XXX..X..X.X.X.X..X........
   ................................
   ................................
   ................................
end

 pfcolors:
 $0
 $0
 $0
 $42
 $42
 $42
 $42
 $42
 $42
 $0
 $0
 $0
end

  drawscreen
  j = j + 1
  if joy0fire && j > 5 then goto setupgame
  goto newlevel

setupgame
   dx=3
   dy=3
   rot=1
   if isDying then isDying = 0 : goto start
   diamondsLeft = _numberOfDiamonds

  playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   X..............................X
   X..X..X..X..X..X..X..X..X..X...X
   X..............................X
   X..X..X..X..X.....X..X..X..X...X
   X..............................X
   X..X..X..X..X.....X..X..X..X...X
   X..............................X
   X..X..X..X..X..X..X..X..X..X...X
   X..............................X
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

start

 pfcolors:
 $FC
 $FC
 $FC
 $0E
 $FC
 $0E
 $FC
 $0E
 $FC
 $0E
 $FC
 $FC
end

  rem if joy0fire then AUDV0=8 : AUDV1=8 : AUDC0=4 : AUDC1=4

   scorecolor=_P_COLOUR
   pfscorecolor = _P_COLOUR

   drawscreen
   frameCounter=frameCounter+1;
   if frameCounter > 60 then frameCounter = 0
   rem ---------------------------------------------------------------------------------
   rem This section sets a value for the last direction the joystick was pushed
   rem
   rem  This determines the direction the bullet will be fired later, and also
   rem  allows you to keep firing the bullet in the same direction after you
   rem  have stopped moving.
   rem
   rem  Each time you move, each of the eight possible directions of the joystick is
   rem  marked as on or off with a bit variable.
   rem ---------------------------------------------------------------------------------

   if diamondsLeft <= 0 || isDying = 1 then goto waitforlevelend

   if joy0up then                c{1}=1:c{2}=0:c{3}=0:c{4}=0:c{5}=0:c{6}=0:c{7}=0:c{0}=0
   if joy0down then              c{1}=0:c{2}=1:c{3}=0:c{4}=0:c{5}=0:c{6}=0:c{7}=0:c{0}=0
   if joy0left then              c{1}=0:c{2}=0:c{3}=1:c{4}=0:c{5}=0:c{6}=0:c{7}=0:c{0}=0
   if joy0right then             c{1}=0:c{2}=0:c{3}=0:c{4}=1:c{5}=0:c{6}=0:c{7}=0:c{0}=0
   if joy0up && joy0left then    c{1}=0:c{2}=0:c{3}=0:c{4}=0:c{5}=1:c{6}=0:c{7}=0:c{0}=0
   if joy0up && joy0right then   c{1}=0:c{2}=0:c{3}=0:c{4}=0:c{5}=0:c{6}=1:c{7}=0:c{0}=0
   if joy0down && joy0left then  c{1}=0:c{2}=0:c{3}=0:c{4}=0:c{5}=0:c{6}=0:c{7}=1:c{0}=0
   if joy0down && joy0right then c{1}=0:c{2}=0:c{3}=0:c{4}=0:c{5}=0:c{6}=0:c{7}=0:c{0}=1

   if frameCounter - lastMoveFrame < 10 && frameCounter - lastMoveFrame > 0 then goto skipRotate

   if joy0left then rot=rot-1 : lastMoveFrame=frameCounter
   if joy0right then rot=rot+1 : lastMoveFrame=frameCounter

   if joy0fire && rot=1 then dy = dy - 1
   if joy0fire && rot=2 then dy=dy - 1 : dx=dx + 1
   if joy0fire && rot=3 then dx=dx + 1
   if joy0fire && rot=4 then dy=dy + 1 : dx=dx + 1
   if joy0fire && rot=5 then dy=dy + 1
   if joy0fire && rot=6 then dy=dy + 1 : dx=dx - 1
   if joy0fire && rot=7 then dx=dx - 1
   if joy0fire && rot=8 then dy=dy - 1 : dx=dx - 1

   if joy0fire then _Ch0_Sound{0} = 1 : _Ch0_Duration = 2

  if !_Ch0_Sound{0} then goto __Skip_Ch_0

  _Ch0_Duration = _Ch0_Duration - 1
  if _Ch0_Duration = 0 then goto __Clear_Ch_0

  AUDC0 = 2 : AUDV0 = 8 : AUDF0 = 25

  goto __Skip_Ch_0

__Clear_Ch_0
  _Ch0_Sound{0} = 0 : AUDV0 = 0
  
__Skip_Ch_0

skipRotate

   if dx < 2 then temp3 = temp3 + 1
   if dx > 4 then temp3 = temp3 - 1
   if dy < 2 then temp4 = temp4 + 1
   if dy > 4 then temp4 = temp4 - 1

   _pf_x = (_P1_x - 14) / 4
   _pf_y = (_P1_y - (_P1_Height - 6))  / 8

   if !collision(playfield, player0) then goto noPlayfieldCollision

   if !pfread(_pf_x, _pf_y) then goto noPlayfieldCollision

   score = score + 1
   pfpixel _pf_x _pf_y off
   diamondsLeft = diamondsLeft - 1

   if diamondsLeft <= 0 then isDying = 0 : endLevelPause = 0 : goto waitforlevelend

noPlayfieldCollision

  if !collision(player0, player1) then goto noAlienCollision
  AUDV0 = 0 : AUDV1 = 0

  playerLives = playerLives - 1
  pfscore1 = pfscore1/4
  pfscore2 = %00000000

  endLevelPause = 0
  isDying = 1
  goto waitforlevelend

noAlienCollision

  if !collision(player0, ball) then goto noBallCollision
  if ballActive = 0 then goto noBallCollision

  playerLives = playerLives - 1
  pfscore1 = pfscore1/4
  pfscore2 = %00000000

  endLevelPause = 0
  isDying = 1
  goto waitforlevelend

noBallCollision
   if dy < 1 then dy = 1
   if dx < 1 then dx = 1
   if dy > 5 then dy = 5
   if dx > 5 then dx = 5

   if rot<1 then rot=8
   if rot>8 then rot=1

   if _P1_y < _P_Edge_Top then dy = 4
   if _P1_y > _P_Edge_Bottom then dy = 2
   if _P1_x < _P_Edge_Left then dx = 4
   if _P1_x > _P_Edge_Right then dx = 2

   goto moveAliens

waitforlevelend
  dx = 3: dy = 3
  _P1_y = _P_Start_Y
  _P1_x = _P_Start_X
  if endLevelPause > _End_Level_Pause && isDying = 0 then _CurrentLevel = _CurrentLevel + 1 : goto newlevel
  if endLevelPause > _End_Level_Pause && isDying = 1 then lives = lives - 1 : goto newlevel

  if isDying = 0 then score = score + 1

  temp1 = (_End_Level_Pause / 5)
  temp2 = temp1 * 2
  temp3 = temp1 * 3
  temp4 = temp1 * 4
  temp5 = temp1 * 5

  endLevelPause = endLevelPause + 1

  if endLevelPause < temp1 then COLUP0 = $2A : goto showGraphics
  if endLevelPause < temp2 then COLUP0 = $26 : goto showGraphics
  if endLevelPause < temp3 then COLUP0 = $22 : goto showGraphics
  if endLevelPause < temp4 then COLUP0 = $20 : goto showGraphics
  if endLevelPause < temp5 then COLUP0 = $00 : goto showGraphics

  temp5 = 1
moveAliens

  temp6 = (_CurrentLevel // 5);
  temp6 = temp1

  if temp6 = 2 then goto alien2
  if temp6 = 3 then goto alien3
  if temp6 = 4 then goto alien4
  if temp6 = 5 then goto alien5

  temp1 = rand
  temp2 = rand
  temp5 = 1

  if temp1 < 100 then aX = aX - 1
  if temp1 > 156 then aX = aX + 1

  if temp2 < 100 then aY = aY - 1
  if temp2 > 156 then aY = aY + 1

  goto applyAlienMovement

alien2

  temp1 = rand
  temp2 = rand
  temp5 = 2

  if temp1 < 100 then aX = aX - 1
  if temp1 > 156 then aX = aX + 1

  if temp2 < 100 then aY = aY - 1
  if temp2 > 156 then aY = aY + 1

  goto applyAlienMovement

alien3
  temp1 = rand
  temp2 = rand
  temp5 = 1

  if temp1 < 100 then aX = aX - 1
  if temp1 > 156 then aX = aX + 1

  if temp2 < 100 then aY = aY - 1
  if temp2 > 156 then aY = aY + 1

  temp3 = rand
  if temp3 < 130 then goto applyAlienMovement

  if player0x < player1x then aX = aX - 1
  if player0x > player1x then aX = aX + 1

  if player0y < player1y then aY = aY - 1
  if player0y > player1y then aY = aY + 1

  goto applyAlienMovement

alien4
  temp1 = rand
  temp2 = rand
  temp5 = 2

  if temp1 < 100 then aX = aX - 1
  if temp1 > 156 then aX = aX + 1

  if temp2 < 100 then aY = aY - 1
  if temp2 > 156 then aY = aY + 1

  temp3 = rand
  if temp3 < 130 then goto applyAlienMovement

  if player0x < player1x then aX = aX - 1
  if player0x > player1x then aX = aX + 1

  if player0y < player1y then aY = aY - 1
  if player0y > player1y then aY = aY + 1

  goto applyAlienMovement

alien5
  if player0x < player1x then aX = aX - 1
  if player0x > player1x then aX = aX + 1

  if player0y < player1y then aY = aY - 1
  if player0y > player1y then aY = aY + 1

  goto applyAlienMovement


applyAlienMovement
  if aX < 2 then aX = 2
  if aX > 4 then aX = 4
  if aY < 2 then aY = 2
  if aY > 4 then aY = 4 

  if player1y < _P_Edge_Top then aY = 4
  if player1y > _P_Edge_Bottom then aY = 2
  if player1x < _P_Edge_Left then aX = 4
  if player1x > _P_Edge_Right then aX = 2

  if aX < 3 then player1x = player1x - temp5;
  if aX > 3 then player1x = player1x + temp5;
  if aY < 3 then player1y = player1y - temp5;
  if aY > 3 then player1y = player1y + temp5;

ballMovement
  if ballActive = 0 then ballx = 200 : bally = 200
  if ballActive = 0 then goto showGraphics

  temp1 = rand
  temp2 = rand
  temp5 = 1

  if temp1 < 100 then bX = bX - 1
  if temp1 > 156 then bX = bX + 1

  if temp2 < 100 then bY = bY - 1
  if temp2 > 156 then bY = bY + 1

  temp3 = rand
  if temp3 < 130 then goto applyBallMovement

  if player0x < ballx then bX = bX - 1
  if player0x > ballx then bX = bX + 1

  if player0y < bally then bY = bY - 1
  if player0y > bally then bY = bY + 1

applyBallMovement

  if bX < 3 then ballx = ballx - temp5;
  if bX > 3 then ballx = ballx + temp5;
  if bY < 3 then bally = bally - temp5;
  if bY > 3 then bally = bally + temp5;

  if ballx < _P_Edge_Top then aY = 4
  if bally > _P_Edge_Bottom then aY = 2
  if ballx < _P_Edge_Left then aX = 4
  if bally > _P_Edge_Right then aX = 2

showGraphics

   rem ------------------------------------------------------------------
   rem Player Animation
   rem   Y is the counter for the player animation.  You can change the
   rem   animation rate by changing the 30,20,10 to a different 
   rem   sequence of numbers.
   rem ------------------------------------------------------------------

   if dx < 3 then _P1_x = _P1_x - (3 - dx)
   if dx > 3 then _P1_x = _P1_x + dx - 3
   if dy < 3 then _P1_y = _P1_y - (3 - dy)
   if dy > 3 then _P1_y = _P1_y + dy - 3

   if rot=1 then player0: 
        %00100100
        %01011010
        %01011010
        %00100100
        %00011000
end

  if rot=2 then player0:
        %00011000
        %00110100
        %01111000
        %01010100 
        %00101100
end

  if rot=3 then player0:
        %00011000
        %00100100
        %00011010
        %00011010
        %00100100
        %00011000
end

  if rot=4 then player0:  
        %00101100
        %01010100
        %01111000
        %00110100
        %00011000
end

  if rot=5 then player0:
        %00011000
        %00100100
        %01011010
        %01011010
        %00100100
end

  if rot=6 then player0:
        %00110100
        %00101010
        %00011110
        %00101100
        %00011000
end

  if rot=7 then player0:
        %00110000
        %01001000
        %10110000
        %10110000
        %01001000
        %00110000
end

  if rot=8 then player0:
        %00011000
        %00101100
        %00011110
        %00101010
        %00110100  
end

  temp6 = (_CurrentLevel // 5);
  temp6 = temp1

  if temp6 > 1 then goto level2
  player1:
        %00011000
        %01100110
        %10010001
        %01111110
        %00000000
end
  COLUP1 = $5A

  goto skipref

level2
  if temp6 > 2 then goto level3
  player1:
        %00011000
        %01100110
        %10010001
        %01111110
        %00000000
end
  COLUP1 = $56

  goto skipref

level3
  if temp6 > 3 then goto level4
  player1:
        %00011000
        %01100110
        %00111100
        %01100110
        %00011000
end
  COLUP1 = $9A

  goto skipref

level4
  if temp6 > 4 then goto level5
  player1:
        %00011000
        %01100110
        %00111100
        %01100110
        %00011000
end
  COLUP1 = $96

  goto skipref

level5
  if temp6 = 5 then goto skipref
  player1:
        %00011000
        %00100100
        %01011010
        %00100100
        %00011000
end
  COLUP1 = $A6

  goto skipref

skipref

 goto start 

gameover

  COLUP0 = $00
  COLUP1 = $00
  player0x = 200
  player1x = 200

  playfield:
   .....XXXXX.XXXXX.XX.XX.XXXXX....
   .....X.....X...X.X.X.X.X........
   .....X..XX.XXXXX.X...X.XXXXX....
   .....X...X.X...X.X...X.X........
   .....XXXXX.X...X.X...X.XXXXX....
   ................................
   .....XXXXX.X...X.XXXXX.XXXXX....
   .....X...X.X...X.X.....X...X....
   .....X...X.X...X.XXXXX.XXXXX....
   .....X...X..X.X..X.....X.X......
   .....XXXXX...X...XXXXX.X..XX....
end

 pfcolors:
 $42
 $42
 $42
 $42
 $42
 $42
 $42
 $42
 $42
 $42
 $42
 $42
end

  drawscreen
  j = j + 1
  if joy0fire && j > 5 then goto titlescreen
  goto gameover

 bank 2
 rem *** We're putting the title kernel here, but it can go in any bank you
 rem *** like. Just don't let your program flow accidentally fall into the
 rem *** line below.
 asm
 include "titlescreen/asm/titlescreen.asm"
end
 
 bank 3

