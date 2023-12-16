game
.L00 ;  rem ----------------------------------------------------------------------------

.L01 ;  rem - JURL (2600)                                                              -

.L02 ;  rem - 2020 Tonsomo Entertainment                                               -

.L03 ;  rem ----------------------------------------------------------------------------

.L04 ;  rem - Development History                                                      -

.L05 ;  rem - V0.1     Johnny Blanchard      Initial Development     2020-04-10        -      

.L06 ;  rem ----------------------------------------------------------------------------

.
 ; 

.L07 ;  include div_mul.asm

.L08 ;  include div_mul16.asm

.
 ; 

.L09 ;  set tv pal

.L010 ;  set romsize 16k

.
 ; 

.L011 ;  set kernel_options no_blank_lines pfcolors collision(player0,playfield)

.L012 ;  set optimization speed

.L013 ;  set optimization inlinerand

.L014 ;  set smartbranching on

.
 ; 

.L015 ;  dim rand16  =  z

.
 ; 

.L016 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

	LDA #0
	STA a
	STA b
	STA c
	STA d
	STA e
	STA f
	STA g
	STA h
	STA i
.L017 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

	LDA #0
	STA j
	STA k
	STA l
	STA m
	STA n
	STA o
	STA p
	STA q
	STA r
.L018 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
	STA y
.
 ; 

.L019 ;  const font  =  .21stcentury

.
 ; 

.L020 ;  const _P_Edge_Top  =  14

.L021 ;  const _P_Edge_Bottom  =  77

.L022 ;  const _P_Edge_Left  =  21

.L023 ;  const _P_Edge_Right  =  133

.
 ; 

.L024 ;  const _B_Edge_Top  =  3

.L025 ;  const _B_Edge_Bottom  =  88

.L026 ;  const _B_Edge_Left  =  2

.L027 ;  const _B_Edge_Right  =  159

.
 ; 

.L028 ;  const pfscore  =  1

.L029 ;  const _P1_Height  =  6

.L030 ;  const _P1_Width  =  8

.L031 ;  const _numberOfDiamonds  =  34

.L032 ;  const _P_Start_X  =  76

.L033 ;  const _P_Start_Y  =  50

.L034 ;  const _P_Alien_Y  =  15

.L035 ;  const _P_Alien_X  =  25

.L036 ;  const _End_Level_Pause  =  120

.L037 ;  const _P_COLOUR  =  $2E

.
 ; 

.L038 ;  dim _P1_x  =  player0x

.L039 ;  dim _P1_y  =  player0y

.L040 ;  dim _pf_x  =  a

.L041 ;  dim _pf_y  =  b

;.rot.d.
.L042 ;  def rot = d

;.dx.f.
.L043 ;  def dx = f

;.dy.g.
.L044 ;  def dy = g

;.frameCounter.h.
.L045 ;  def frameCounter = h

;.lastMoveFrame.i.
.L046 ;  def lastMoveFrame = i

;.deBounce.j.
.L047 ;  def deBounce = j

;.diamondsLeft.k.
.L048 ;  def diamondsLeft = k

;.endLevelPause.  l.
.L049 ;  def endLevelPause  =  l

.L050 ;  dim _CurrentLevel  =  n

;.isDying.  o.
.L051 ;  def isDying  =  o

;.aX.  p.
.L052 ;  def aX  =  p

;.aY.  q.
.L053 ;  def aY  =  q

;.playerLives.  r.
.L054 ;  def playerLives  =  r

;.bX.  s.
.L055 ;  def bX  =  s

;.bY.  t.
.L056 ;  def bY  =  t

;.ballActive.  u.
.L057 ;  def ballActive  =  u

;.hasFired.  v.
.L058 ;  def hasFired  =  v

.L059 ;  dim _Ch0_Sound  =  w

.L060 ;  dim _Ch0_Duration  =  x

.
 ; 

.L061 ;  ballheight  =  2  :  rem * Ball 4 pixels high.

	LDA #2
	STA ballheight
.L062 ;  CTRLPF  =  $21  :  rem * Ball 4 pixels wide.

	LDA #$21
	STA CTRLPF
.
 ; 

.L063 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.titlescreen
 ; titlescreen

.L064 ;  _Ch0_Sound{0}  =  0

	LDA _Ch0_Sound
	AND #254
	STA _Ch0_Sound
.L065 ;  _Ch0_Sound{1}  =  0

	LDA _Ch0_Sound
	AND #253
	STA _Ch0_Sound
.
 ; 

.L066 ;  deBounce  =  0

	LDA #0
	STA j
.L067 ;  _CurrentLevel  =  1

	LDA #1
	STA _CurrentLevel
.L068 ;  playerLives = 4

	LDA #4
	STA r
.L069 ;  pfscore1  =  %10101010

	LDA #%10101010
	STA pfscore1
.L070 ;  isDying  =  0

	LDA #0
	STA o
.L071 ;  ballActive  =  0

	LDA #0
	STA u
.
 ; 

.displayTitlescreen
 ; displayTitlescreen

.
 ; 

.L072 ;  gosub titledrawscreen bank2

 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(.titledrawscreen-1)
 pha
 lda #<(.titledrawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
ret_point1
.
 ; 

.L073 ;  if joy0fire  &&  deBounce  >  5 then goto main

 bit INPT4
	BMI .skipL073
.condpart0
	LDA #5
	CMP j
     BCS .skip0then
.condpart1
 jmp .main

.skip0then
.skipL073
.L074 ;  deBounce  =  deBounce  +  1

	INC j
.
 ; 

.L075 ;  goto displayTitlescreen

 jmp .displayTitlescreen

.
 ; 

.main
 ; main

.
 ; 

.L076 ;  rem ----------------------------------------------------------------------------

.L077 ;  c{1} = 0  : rem Turned on if the last location of the joystick was UP

	LDA c
	AND #253
	STA c
.L078 ;  c{2} = 0  : rem Turned on if the last location of the joystick was DOWN

	LDA c
	AND #251
	STA c
.L079 ;  c{3} = 0  : rem Turned on if the last location of the joystick was LEFT

	LDA c
	AND #247
	STA c
.L080 ;  c{4} = 0  : rem Turned on if the last location of the joystick was RIGHT

	LDA c
	AND #239
	STA c
.L081 ;  c{5} = 0  : rem Turned on if the last location of the joystick was UP+LEFT

	LDA c
	AND #223
	STA c
.L082 ;  c{6} = 0  : rem Turned on if the last location of the joystick was UP+RIGHT

	LDA c
	AND #191
	STA c
.L083 ;  c{7} = 0  : rem Turned on if the last location of the joystick was DOWN+LEFT

	LDA c
	AND #127
	STA c
.L084 ;  c{0} = 0  : rem Turned on if the last location of the joystick was DOWN+RIGHT

	LDA c
	AND #254
	STA c
.L085 ;  rem ----------------------------------------------------------------------------

.
 ; 

.L086 ;  rem ----------------------------------------------------------------------------

.newlevel
 ; newlevel

.
 ; 

.L087 ;  if playerLives  =  0 then goto gameover

	LDA r
	CMP #0
     BNE .skipL087
.condpart2
 jmp .gameover

.skipL087
.
 ; 

.L088 ;  pfscore2  =  %00000000

	LDA #%00000000
	STA pfscore2
.
 ; 

.L089 ;  COLUP0  =  _P_COLOUR

	LDA #_P_COLOUR
	STA COLUP0
.
 ; 

.L090 ;  if _CurrentLevel  >  5 then ballActive  =  1

	LDA #5
	CMP _CurrentLevel
     BCS .skipL090
.condpart3
	LDA #1
	STA u
.skipL090
.
 ; 

.L091 ;  player0x  =  _P_Start_X

	LDA #_P_Start_X
	STA player0x
.L092 ;  player0y  =  _P_Start_Y

	LDA #_P_Start_Y
	STA player0y
.L093 ;  player1y  =  _P_Alien_Y

	LDA #_P_Alien_Y
	STA player1y
.L094 ;  player1x  =  _P_Alien_X

	LDA #_P_Alien_X
	STA player1x
.L095 ;  if ballActive  =  1 then ballx  =  30  :  bally  =  10

	LDA u
	CMP #1
     BNE .skipL095
.condpart4
	LDA #30
	STA ballx
	LDA #10
	STA bally
.skipL095
.L096 ;  rot  =  0

	LDA #0
	STA d
.L097 ;  dx  =  3

	LDA #3
	STA f
.L098 ;  dy  =  3

	LDA #3
	STA g
.L099 ;  aX  =  3

	LDA #3
	STA p
.L0100 ;  aY  =  3

	LDA #3
	STA q
.L0101 ;  frameCounter  =  0

	LDA #0
	STA h
.L0102 ;  lastMoveFrame  =  0

	LDA #0
	STA i
.
 ; 

.L0103 ;  if isDying then goto setupgame

	LDA o
	BEQ .skipL0103
.condpart5
 jmp .setupgame

.skipL0103
.
 ; 

.L0104 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000011, %11011101
	if (pfwidth>2)
	.byte %10111011, %00000001
 endif
	.byte %00000010, %01001000
	if (pfwidth>2)
	.byte %10101001, %00000000
 endif
	.byte %00000011, %11001001
	if (pfwidth>2)
	.byte %10111001, %00000000
 endif
	.byte %00000000, %01001001
	if (pfwidth>2)
	.byte %10110001, %00000000
 endif
	.byte %00000011, %01001001
	if (pfwidth>2)
	.byte %10101001, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ; 

.L0105 ;  pfcolors:

 lda # $0
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel13-132+pfres*pfwidth)
 else
 lda #>(pfcolorlabel13-84)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel13-132+pfres*pfwidth)
 else
 lda #<(pfcolorlabel13-84)
 endif
 sta pfcolortable
.
 ; 

.L0106 ;  drawscreen

 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point2
.L0107 ;  j  =  j  +  1

	INC j
.L0108 ;  if joy0fire  &&  j  >  5 then goto setupgame

 bit INPT4
	BMI .skipL0108
.condpart6
	LDA #5
	CMP j
     BCS .skip6then
.condpart7
 jmp .setupgame

.skip6then
.skipL0108
.L0109 ;  goto newlevel

 jmp .newlevel

.
 ; 

.setupgame
 ; setupgame

.L0110 ;  dx = 3

	LDA #3
	STA f
.L0111 ;  dy = 3

	LDA #3
	STA g
.L0112 ;  rot = 1

	LDA #1
	STA d
.L0113 ;  if isDying then isDying  =  0  :  goto start

	LDA o
	BEQ .skipL0113
.condpart8
	LDA #0
	STA o
 jmp .start

.skipL0113
.L0114 ;  diamondsLeft  =  _numberOfDiamonds

	LDA #_numberOfDiamonds
	STA k
.
 ; 

.L0115 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel1
PF_data1
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10010010, %10010010
	if (pfwidth>2)
	.byte %00100100, %10001001
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10010010, %00010010
	if (pfwidth>2)
	.byte %00100100, %10001001
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10010010, %00010010
	if (pfwidth>2)
	.byte %00100100, %10001001
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10010010, %10010010
	if (pfwidth>2)
	.byte %00100100, %10001001
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.
 ; 

.start
 ; start

.
 ; 

.L0116 ;  pfcolors:

 lda # $FC
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel13-131+pfres*pfwidth)
 else
 lda #>(pfcolorlabel13-83)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel13-131+pfres*pfwidth)
 else
 lda #<(pfcolorlabel13-83)
 endif
 sta pfcolortable
.
 ; 

.L0117 ;  rem if joy0fire then AUDV0=8 : AUDV1=8 : AUDC0=4 : AUDC1=4

.
 ; 

.L0118 ;  scorecolor = _P_COLOUR

	LDA #_P_COLOUR
	STA scorecolor
.L0119 ;  pfscorecolor  =  _P_COLOUR

	LDA #_P_COLOUR
	STA pfscorecolor
.
 ; 

.L0120 ;  drawscreen

 sta temp7
 lda #>(ret_point3-1)
 pha
 lda #<(ret_point3-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point3
.L0121 ;  frameCounter = frameCounter + 1

	INC h
.L0122 ;  if frameCounter  >  60 then frameCounter  =  0

	LDA #60
	CMP h
     BCS .skipL0122
.condpart9
	LDA #0
	STA h
.skipL0122
.L0123 ;  rem ---------------------------------------------------------------------------------

.L0124 ;  rem This section sets a value for the last direction the joystick was pushed

.L0125 ;  rem

.L0126 ;  rem  This determines the direction the bullet will be fired later, and also

.L0127 ;  rem  allows you to keep firing the bullet in the same direction after you

.L0128 ;  rem  have stopped moving.

.L0129 ;  rem

.L0130 ;  rem  Each time you move, each of the eight possible directions of the joystick is

.L0131 ;  rem  marked as on or off with a bit variable.

.L0132 ;  rem ---------------------------------------------------------------------------------

.
 ; 

.L0133 ;  if diamondsLeft  <=  0  ||  isDying  =  1 then goto waitforlevelend

	LDA #0
	CMP k
     BCC .skipL0133
.condpart10
 jmp .condpart11
.skipL0133
	LDA o
	CMP #1
     BNE .skip2OR
.condpart11
 jmp .waitforlevelend

.skip2OR
.
 ; 

.L0134 ;  if joy0up then c{1} = 1 : c{2} = 0 : c{3} = 0 : c{4} = 0 : c{5} = 0 : c{6} = 0 : c{7} = 0 : c{0} = 0

 lda #$10
 bit SWCHA
	BNE .skipL0134
.condpart12
	LDA c
	ORA #2
	STA c
	LDA c
	AND #251
	STA c
	LDA c
	AND #247
	STA c
	LDA c
	AND #239
	STA c
	LDA c
	AND #223
	STA c
	LDA c
	AND #191
	STA c
	LDA c
	AND #127
	STA c
	LDA c
	AND #254
	STA c
.skipL0134
.L0135 ;  if joy0down then c{1} = 0 : c{2} = 1 : c{3} = 0 : c{4} = 0 : c{5} = 0 : c{6} = 0 : c{7} = 0 : c{0} = 0

 lda #$20
 bit SWCHA
	BNE .skipL0135
.condpart13
	LDA c
	AND #253
	STA c
	LDA c
	ORA #4
	STA c
	LDA c
	AND #247
	STA c
	LDA c
	AND #239
	STA c
	LDA c
	AND #223
	STA c
	LDA c
	AND #191
	STA c
	LDA c
	AND #127
	STA c
	LDA c
	AND #254
	STA c
.skipL0135
.L0136 ;  if joy0left then c{1} = 0 : c{2} = 0 : c{3} = 1 : c{4} = 0 : c{5} = 0 : c{6} = 0 : c{7} = 0 : c{0} = 0

 bit SWCHA
	BVS .skipL0136
.condpart14
	LDA c
	AND #253
	STA c
	LDA c
	AND #251
	STA c
	LDA c
	ORA #8
	STA c
	LDA c
	AND #239
	STA c
	LDA c
	AND #223
	STA c
	LDA c
	AND #191
	STA c
	LDA c
	AND #127
	STA c
	LDA c
	AND #254
	STA c
.skipL0136
.L0137 ;  if joy0right then c{1} = 0 : c{2} = 0 : c{3} = 0 : c{4} = 1 : c{5} = 0 : c{6} = 0 : c{7} = 0 : c{0} = 0

 bit SWCHA
	BMI .skipL0137
.condpart15
	LDA c
	AND #253
	STA c
	LDA c
	AND #251
	STA c
	LDA c
	AND #247
	STA c
	LDA c
	ORA #16
	STA c
	LDA c
	AND #223
	STA c
	LDA c
	AND #191
	STA c
	LDA c
	AND #127
	STA c
	LDA c
	AND #254
	STA c
.skipL0137
.L0138 ;  if joy0up  &&  joy0left then c{1} = 0 : c{2} = 0 : c{3} = 0 : c{4} = 0 : c{5} = 1 : c{6} = 0 : c{7} = 0 : c{0} = 0

 lda #$10
 bit SWCHA
	BNE .skipL0138
.condpart16
 bit SWCHA
	BVS .skip16then
.condpart17
	LDA c
	AND #253
	STA c
	LDA c
	AND #251
	STA c
	LDA c
	AND #247
	STA c
	LDA c
	AND #239
	STA c
	LDA c
	ORA #32
	STA c
	LDA c
	AND #191
	STA c
	LDA c
	AND #127
	STA c
	LDA c
	AND #254
	STA c
.skip16then
.skipL0138
.L0139 ;  if joy0up  &&  joy0right then c{1} = 0 : c{2} = 0 : c{3} = 0 : c{4} = 0 : c{5} = 0 : c{6} = 1 : c{7} = 0 : c{0} = 0

 lda #$10
 bit SWCHA
	BNE .skipL0139
.condpart18
 bit SWCHA
	BMI .skip18then
.condpart19
	LDA c
	AND #253
	STA c
	LDA c
	AND #251
	STA c
	LDA c
	AND #247
	STA c
	LDA c
	AND #239
	STA c
	LDA c
	AND #223
	STA c
	LDA c
	ORA #64
	STA c
	LDA c
	AND #127
	STA c
	LDA c
	AND #254
	STA c
.skip18then
.skipL0139
.L0140 ;  if joy0down  &&  joy0left then c{1} = 0 : c{2} = 0 : c{3} = 0 : c{4} = 0 : c{5} = 0 : c{6} = 0 : c{7} = 1 : c{0} = 0

 lda #$20
 bit SWCHA
	BNE .skipL0140
.condpart20
 bit SWCHA
	BVS .skip20then
.condpart21
	LDA c
	AND #253
	STA c
	LDA c
	AND #251
	STA c
	LDA c
	AND #247
	STA c
	LDA c
	AND #239
	STA c
	LDA c
	AND #223
	STA c
	LDA c
	AND #191
	STA c
	LDA c
	ORA #128
	STA c
	LDA c
	AND #254
	STA c
.skip20then
.skipL0140
.L0141 ;  if joy0down  &&  joy0right then c{1} = 0 : c{2} = 0 : c{3} = 0 : c{4} = 0 : c{5} = 0 : c{6} = 0 : c{7} = 0 : c{0} = 1

 lda #$20
 bit SWCHA
	BNE .skipL0141
.condpart22
 bit SWCHA
	BMI .skip22then
.condpart23
	LDA c
	AND #253
	STA c
	LDA c
	AND #251
	STA c
	LDA c
	AND #247
	STA c
	LDA c
	AND #239
	STA c
	LDA c
	AND #223
	STA c
	LDA c
	AND #191
	STA c
	LDA c
	AND #127
	STA c
	LDA c
	ORA #1
	STA c
.skip22then
.skipL0141
.
 ; 

.L0142 ;  if frameCounter  -  lastMoveFrame  <  10  &&  frameCounter  -  lastMoveFrame  >  0 then goto skipRotate

; complex condition detected
	LDA h
	SEC
	SBC i
; todo: this LDA is spurious and should be prevented ->	LDA  1,x
	CMP #10
     BCS .skipL0142
.condpart24
; complex condition detected
	LDA h
	SEC
	SBC i
  PHA
  TSX
  PLA
	LDA #0
	CMP  1,x
     BCS .skip24then
.condpart25
 jmp .skipRotate

.skip24then
.skipL0142
.
 ; 

.L0143 ;  if joy0left then rot = rot - 1  :  lastMoveFrame = frameCounter

 bit SWCHA
	BVS .skipL0143
.condpart26
	DEC d
	LDA h
	STA i
.skipL0143
.L0144 ;  if joy0right then rot = rot + 1  :  lastMoveFrame = frameCounter

 bit SWCHA
	BMI .skipL0144
.condpart27
	INC d
	LDA h
	STA i
.skipL0144
.
 ; 

.L0145 ;  if joy0fire  &&  rot = 1 then dy  =  dy  -  1

 bit INPT4
	BMI .skipL0145
.condpart28
	LDA d
	CMP #1
     BNE .skip28then
.condpart29
	DEC g
.skip28then
.skipL0145
.L0146 ;  if joy0fire  &&  rot = 2 then dy = dy  -  1  :  dx = dx  +  1

 bit INPT4
	BMI .skipL0146
.condpart30
	LDA d
	CMP #2
     BNE .skip30then
.condpart31
	DEC g
	INC f
.skip30then
.skipL0146
.L0147 ;  if joy0fire  &&  rot = 3 then dx = dx  +  1

 bit INPT4
	BMI .skipL0147
.condpart32
	LDA d
	CMP #3
     BNE .skip32then
.condpart33
	INC f
.skip32then
.skipL0147
.L0148 ;  if joy0fire  &&  rot = 4 then dy = dy  +  1  :  dx = dx  +  1

 bit INPT4
	BMI .skipL0148
.condpart34
	LDA d
	CMP #4
     BNE .skip34then
.condpart35
	INC g
	INC f
.skip34then
.skipL0148
.L0149 ;  if joy0fire  &&  rot = 5 then dy = dy  +  1

 bit INPT4
	BMI .skipL0149
.condpart36
	LDA d
	CMP #5
     BNE .skip36then
.condpart37
	INC g
.skip36then
.skipL0149
.L0150 ;  if joy0fire  &&  rot = 6 then dy = dy  +  1  :  dx = dx  -  1

 bit INPT4
	BMI .skipL0150
.condpart38
	LDA d
	CMP #6
     BNE .skip38then
.condpart39
	INC g
	DEC f
.skip38then
.skipL0150
.L0151 ;  if joy0fire  &&  rot = 7 then dx = dx  -  1

 bit INPT4
	BMI .skipL0151
.condpart40
	LDA d
	CMP #7
     BNE .skip40then
.condpart41
	DEC f
.skip40then
.skipL0151
.L0152 ;  if joy0fire  &&  rot = 8 then dy = dy  -  1  :  dx = dx  -  1

 bit INPT4
	BMI .skipL0152
.condpart42
	LDA d
	CMP #8
     BNE .skip42then
.condpart43
	DEC g
	DEC f
.skip42then
.skipL0152
.
 ; 

.L0153 ;  if joy0fire then _Ch0_Sound{0}  =  1  :  _Ch0_Duration  =  2

 bit INPT4
	BMI .skipL0153
.condpart44
	LDA _Ch0_Sound
	ORA #1
	STA _Ch0_Sound
	LDA #2
	STA _Ch0_Duration
.skipL0153
.
 ; 

.L0154 ;  if !_Ch0_Sound{0} then goto __Skip_Ch_0

	LDA _Ch0_Sound
	LSR
	BCS .skipL0154
.condpart45
 jmp .__Skip_Ch_0

.skipL0154
.
 ; 

.L0155 ;  _Ch0_Duration  =  _Ch0_Duration  -  1

	DEC _Ch0_Duration
.L0156 ;  if _Ch0_Duration  =  0 then goto __Clear_Ch_0

	LDA _Ch0_Duration
	CMP #0
     BNE .skipL0156
.condpart46
 jmp .__Clear_Ch_0

.skipL0156
.
 ; 

.L0157 ;  AUDC0  =  2  :  AUDV0  =  8  :  AUDF0  =  25

	LDA #2
	STA AUDC0
	LDA #8
	STA AUDV0
	LDA #25
	STA AUDF0
.
 ; 

.L0158 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.__Clear_Ch_0
 ; __Clear_Ch_0

.L0159 ;  _Ch0_Sound{0}  =  0  :  AUDV0  =  0

	LDA _Ch0_Sound
	AND #254
	STA _Ch0_Sound
	LDA #0
	STA AUDV0
.
 ; 

.__Skip_Ch_0
 ; __Skip_Ch_0

.
 ; 

.skipRotate
 ; skipRotate

.
 ; 

.L0160 ;  if dx  <  2 then temp3  =  temp3  +  1

	LDA f
	CMP #2
     BCS .skipL0160
.condpart47
	INC temp3
.skipL0160
.L0161 ;  if dx  >  4 then temp3  =  temp3  -  1

	LDA #4
	CMP f
     BCS .skipL0161
.condpart48
	DEC temp3
.skipL0161
.L0162 ;  if dy  <  2 then temp4  =  temp4  +  1

	LDA g
	CMP #2
     BCS .skipL0162
.condpart49
	INC temp4
.skipL0162
.L0163 ;  if dy  >  4 then temp4  =  temp4  -  1

	LDA #4
	CMP g
     BCS .skipL0163
.condpart50
	DEC temp4
.skipL0163
.
 ; 

.L0164 ;  _pf_x  =   ( _P1_x  -  14 )   /  4

; complex statement detected
	LDA _P1_x
	SEC
	SBC #14
	lsr
	lsr
	STA _pf_x
.L0165 ;  _pf_y  =   ( _P1_y  -   ( _P1_Height  -  6 )  )   /  8

; complex statement detected
	LDA _P1_y
	PHA
	LDA #_P1_Height
	SEC
	SBC #6
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	lsr
	lsr
	lsr
	STA _pf_y
.
 ; 

.L0166 ;  if !collision(playfield,player0) then goto noPlayfieldCollision

	bit 	CXP0FB
	BMI .skipL0166
.condpart51
 jmp .noPlayfieldCollision

.skipL0166
.
 ; 

.L0167 ;  if !pfread ( _pf_x ,  _pf_y )  then goto noPlayfieldCollision

	LDA _pf_x
	LDY _pf_y
 sta temp7
 lda #>(ret_point4-1)
 pha
 lda #<(ret_point4-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point4
	BEQ .skipL0167
.condpart52
 jmp .noPlayfieldCollision

.skipL0167
.
 ; 

.L0168 ;  score  =  score  +  1

	SED
	CLC
	LDA score+2
	ADC #$01
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.L0169 ;  pfpixel _pf_x _pf_y off

	LDX #1
	LDY _pf_y
	LDA _pf_x
 sta temp7
 lda #>(ret_point5-1)
 pha
 lda #<(ret_point5-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point5
.L0170 ;  diamondsLeft  =  diamondsLeft  -  1

	DEC k
.
 ; 

.L0171 ;  if diamondsLeft  <=  0 then isDying  =  0  :  endLevelPause  =  0  :  goto waitforlevelend

	LDA #0
	CMP k
     BCC .skipL0171
.condpart53
	LDA #0
	STA o
	STA l
 jmp .waitforlevelend

.skipL0171
.
 ; 

.noPlayfieldCollision
 ; noPlayfieldCollision

.
 ; 

.L0172 ;  if !collision(player0,player1) then goto noAlienCollision

	bit 	CXPPMM
	BMI .skipL0172
.condpart54
 jmp .noAlienCollision

.skipL0172
.L0173 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.L0174 ;  playerLives  =  playerLives  -  1

	DEC r
.L0175 ;  pfscore1  =  pfscore1 / 4

	LDA pfscore1
	lsr
	lsr
	STA pfscore1
.L0176 ;  pfscore2  =  %00000000

	LDA #%00000000
	STA pfscore2
.
 ; 

.L0177 ;  endLevelPause  =  0

	LDA #0
	STA l
.L0178 ;  isDying  =  1

	LDA #1
	STA o
.L0179 ;  goto waitforlevelend

 jmp .waitforlevelend

.
 ; 

.noAlienCollision
 ; noAlienCollision

.
 ; 

.L0180 ;  if !collision(player0,ball) then goto noBallCollision

	bit 	CXP0FB
	BVS .skipL0180
.condpart55
 jmp .noBallCollision

.skipL0180
.L0181 ;  if ballActive  =  0 then goto noBallCollision

	LDA u
	CMP #0
     BNE .skipL0181
.condpart56
 jmp .noBallCollision

.skipL0181
.
 ; 

.L0182 ;  playerLives  =  playerLives  -  1

	DEC r
.L0183 ;  pfscore1  =  pfscore1 / 4

	LDA pfscore1
	lsr
	lsr
	STA pfscore1
.L0184 ;  pfscore2  =  %00000000

	LDA #%00000000
	STA pfscore2
.
 ; 

.L0185 ;  endLevelPause  =  0

	LDA #0
	STA l
.L0186 ;  isDying  =  1

	LDA #1
	STA o
.L0187 ;  goto waitforlevelend

 jmp .waitforlevelend

.
 ; 

.noBallCollision
 ; noBallCollision

.L0188 ;  if dy  <  1 then dy  =  1

	LDA g
	CMP #1
     BCS .skipL0188
.condpart57
	LDA #1
	STA g
.skipL0188
.L0189 ;  if dx  <  1 then dx  =  1

	LDA f
	CMP #1
     BCS .skipL0189
.condpart58
	LDA #1
	STA f
.skipL0189
.L0190 ;  if dy  >  5 then dy  =  5

	LDA #5
	CMP g
     BCS .skipL0190
.condpart59
	LDA #5
	STA g
.skipL0190
.L0191 ;  if dx  >  5 then dx  =  5

	LDA #5
	CMP f
     BCS .skipL0191
.condpart60
	LDA #5
	STA f
.skipL0191
.
 ; 

.L0192 ;  if rot < 1 then rot = 8

	LDA d
	CMP #1
     BCS .skipL0192
.condpart61
	LDA #8
	STA d
.skipL0192
.L0193 ;  if rot > 8 then rot = 1

	LDA #8
	CMP d
     BCS .skipL0193
.condpart62
	LDA #1
	STA d
.skipL0193
.
 ; 

.L0194 ;  if _P1_y  <  _P_Edge_Top then dy  =  4

	LDA _P1_y
	CMP #_P_Edge_Top
     BCS .skipL0194
.condpart63
	LDA #4
	STA g
.skipL0194
.L0195 ;  if _P1_y  >  _P_Edge_Bottom then dy  =  2

	LDA #_P_Edge_Bottom
	CMP _P1_y
     BCS .skipL0195
.condpart64
	LDA #2
	STA g
.skipL0195
.L0196 ;  if _P1_x  <  _P_Edge_Left then dx  =  4

	LDA _P1_x
	CMP #_P_Edge_Left
     BCS .skipL0196
.condpart65
	LDA #4
	STA f
.skipL0196
.L0197 ;  if _P1_x  >  _P_Edge_Right then dx  =  2

	LDA #_P_Edge_Right
	CMP _P1_x
     BCS .skipL0197
.condpart66
	LDA #2
	STA f
.skipL0197
.
 ; 

.L0198 ;  goto moveAliens

 jmp .moveAliens

.
 ; 

.waitforlevelend
 ; waitforlevelend

.L0199 ;  dx  =  3 :  dy  =  3

	LDA #3
	STA f
	STA g
.L0200 ;  _P1_y  =  _P_Start_Y

	LDA #_P_Start_Y
	STA _P1_y
.L0201 ;  _P1_x  =  _P_Start_X

	LDA #_P_Start_X
	STA _P1_x
.L0202 ;  if endLevelPause  >  _End_Level_Pause  &&  isDying  =  0 then _CurrentLevel  =  _CurrentLevel  +  1  :  goto newlevel

	LDA #_End_Level_Pause
	CMP l
     BCS .skipL0202
.condpart67
	LDA o
	CMP #0
     BNE .skip67then
.condpart68
	INC _CurrentLevel
 jmp .newlevel

.skip67then
.skipL0202
.L0203 ;  if endLevelPause  >  _End_Level_Pause  &&  isDying  =  1 then lives  =  lives  -  1  :  goto newlevel

	LDA #_End_Level_Pause
	CMP l
     BCS .skipL0203
.condpart69
	LDA o
	CMP #1
     BNE .skip69then
.condpart70
	DEC lives
 jmp .newlevel

.skip69then
.skipL0203
.
 ; 

.L0204 ;  if isDying  =  0 then score  =  score  +  1

	LDA o
	CMP #0
     BNE .skipL0204
.condpart71
	SED
	CLC
	LDA score+2
	ADC #$01
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.skipL0204
.
 ; 

.L0205 ;  temp1  =   ( _End_Level_Pause  /  5 ) 

; complex statement detected
	LDA #_End_Level_Pause
	LDY #5
 jsr div8
	STA temp1
.L0206 ;  temp2  =  temp1  *  2

	LDA temp1
	asl
	STA temp2
.L0207 ;  temp3  =  temp1  *  3

	LDA temp1
	asl
	clc
	adc temp1
	STA temp3
.L0208 ;  temp4  =  temp1  *  4

	LDA temp1
	asl
	asl
	STA temp4
.L0209 ;  temp5  =  temp1  *  5

	LDA temp1
	asl
	asl
	clc
	adc temp1
	STA temp5
.
 ; 

.L0210 ;  endLevelPause  =  endLevelPause  +  1

	INC l
.
 ; 

.L0211 ;  if endLevelPause  <  temp1 then COLUP0  =  $2A  :  goto showGraphics

	LDA l
	CMP temp1
     BCS .skipL0211
.condpart72
	LDA #$2A
	STA COLUP0
 jmp .showGraphics

.skipL0211
.L0212 ;  if endLevelPause  <  temp2 then COLUP0  =  $26  :  goto showGraphics

	LDA l
	CMP temp2
     BCS .skipL0212
.condpart73
	LDA #$26
	STA COLUP0
 jmp .showGraphics

.skipL0212
.L0213 ;  if endLevelPause  <  temp3 then COLUP0  =  $22  :  goto showGraphics

	LDA l
	CMP temp3
     BCS .skipL0213
.condpart74
	LDA #$22
	STA COLUP0
 jmp .showGraphics

.skipL0213
.L0214 ;  if endLevelPause  <  temp4 then COLUP0  =  $20  :  goto showGraphics

	LDA l
	CMP temp4
     BCS .skipL0214
.condpart75
	LDA #$20
	STA COLUP0
 jmp .showGraphics

.skipL0214
.L0215 ;  if endLevelPause  <  temp5 then COLUP0  =  $00  :  goto showGraphics

	LDA l
	CMP temp5
     BCS .skipL0215
.condpart76
	LDA #$00
	STA COLUP0
 jmp .showGraphics

.skipL0215
.
 ; 

.L0216 ;  temp5  =  1

	LDA #1
	STA temp5
.moveAliens
 ; moveAliens

.
 ; 

.L0217 ;  temp6  =   ( _CurrentLevel  //  5 ) 

; complex statement detected
	LDA _CurrentLevel
	LDY #5
 jsr div16
	STA temp6
.L0218 ;  temp6  =  temp1

	LDA temp1
	STA temp6
.
 ; 

.L0219 ;  if temp6  =  2 then goto alien2

	LDA temp6
	CMP #2
     BNE .skipL0219
.condpart77
 jmp .alien2

.skipL0219
.L0220 ;  if temp6  =  3 then goto alien3

	LDA temp6
	CMP #3
     BNE .skipL0220
.condpart78
 jmp .alien3

.skipL0220
.L0221 ;  if temp6  =  4 then goto alien4

	LDA temp6
	CMP #4
     BNE .skipL0221
.condpart79
 jmp .alien4

.skipL0221
.L0222 ;  if temp6  =  5 then goto alien5

	LDA temp6
	CMP #5
     BNE .skipL0222
.condpart80
 jmp .alien5

.skipL0222
.
 ; 

.L0223 ;  temp1  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp1
.L0224 ;  temp2  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp2
.L0225 ;  temp5  =  1

	LDA #1
	STA temp5
.
 ; 

.L0226 ;  if temp1  <  100 then aX  =  aX  -  1

	LDA temp1
	CMP #100
     BCS .skipL0226
.condpart81
	DEC p
.skipL0226
.L0227 ;  if temp1  >  156 then aX  =  aX  +  1

	LDA #156
	CMP temp1
     BCS .skipL0227
.condpart82
	INC p
.skipL0227
.
 ; 

.L0228 ;  if temp2  <  100 then aY  =  aY  -  1

	LDA temp2
	CMP #100
     BCS .skipL0228
.condpart83
	DEC q
.skipL0228
.L0229 ;  if temp2  >  156 then aY  =  aY  +  1

	LDA #156
	CMP temp2
     BCS .skipL0229
.condpart84
	INC q
.skipL0229
.
 ; 

.L0230 ;  goto applyAlienMovement

 jmp .applyAlienMovement

.
 ; 

.alien2
 ; alien2

.
 ; 

.L0231 ;  temp1  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp1
.L0232 ;  temp2  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp2
.L0233 ;  temp5  =  2

	LDA #2
	STA temp5
.
 ; 

.L0234 ;  if temp1  <  100 then aX  =  aX  -  1

	LDA temp1
	CMP #100
     BCS .skipL0234
.condpart85
	DEC p
.skipL0234
.L0235 ;  if temp1  >  156 then aX  =  aX  +  1

	LDA #156
	CMP temp1
     BCS .skipL0235
.condpart86
	INC p
.skipL0235
.
 ; 

.L0236 ;  if temp2  <  100 then aY  =  aY  -  1

	LDA temp2
	CMP #100
     BCS .skipL0236
.condpart87
	DEC q
.skipL0236
.L0237 ;  if temp2  >  156 then aY  =  aY  +  1

	LDA #156
	CMP temp2
     BCS .skipL0237
.condpart88
	INC q
.skipL0237
.
 ; 

.L0238 ;  goto applyAlienMovement

 jmp .applyAlienMovement

.
 ; 

.alien3
 ; alien3

.L0239 ;  temp1  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp1
.L0240 ;  temp2  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp2
.L0241 ;  temp5  =  1

	LDA #1
	STA temp5
.
 ; 

.L0242 ;  if temp1  <  100 then aX  =  aX  -  1

	LDA temp1
	CMP #100
     BCS .skipL0242
.condpart89
	DEC p
.skipL0242
.L0243 ;  if temp1  >  156 then aX  =  aX  +  1

	LDA #156
	CMP temp1
     BCS .skipL0243
.condpart90
	INC p
.skipL0243
.
 ; 

.L0244 ;  if temp2  <  100 then aY  =  aY  -  1

	LDA temp2
	CMP #100
     BCS .skipL0244
.condpart91
	DEC q
.skipL0244
.L0245 ;  if temp2  >  156 then aY  =  aY  +  1

	LDA #156
	CMP temp2
     BCS .skipL0245
.condpart92
	INC q
.skipL0245
.
 ; 

.L0246 ;  temp3  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp3
.L0247 ;  if temp3  <  130 then goto applyAlienMovement

	LDA temp3
	CMP #130
     BCS .skipL0247
.condpart93
 jmp .applyAlienMovement

.skipL0247
.
 ; 

.L0248 ;  if player0x  <  player1x then aX  =  aX  -  1

	LDA player0x
	CMP player1x
     BCS .skipL0248
.condpart94
	DEC p
.skipL0248
.L0249 ;  if player0x  >  player1x then aX  =  aX  +  1

	LDA player1x
	CMP player0x
     BCS .skipL0249
.condpart95
	INC p
.skipL0249
.
 ; 

.L0250 ;  if player0y  <  player1y then aY  =  aY  -  1

	LDA player0y
	CMP player1y
     BCS .skipL0250
.condpart96
	DEC q
.skipL0250
.L0251 ;  if player0y  >  player1y then aY  =  aY  +  1

	LDA player1y
	CMP player0y
     BCS .skipL0251
.condpart97
	INC q
.skipL0251
.
 ; 

.L0252 ;  goto applyAlienMovement

 jmp .applyAlienMovement

.
 ; 

.alien4
 ; alien4

.L0253 ;  temp1  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp1
.L0254 ;  temp2  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp2
.L0255 ;  temp5  =  2

	LDA #2
	STA temp5
.
 ; 

.L0256 ;  if temp1  <  100 then aX  =  aX  -  1

	LDA temp1
	CMP #100
     BCS .skipL0256
.condpart98
	DEC p
.skipL0256
.L0257 ;  if temp1  >  156 then aX  =  aX  +  1

	LDA #156
	CMP temp1
     BCS .skipL0257
.condpart99
	INC p
.skipL0257
.
 ; 

.L0258 ;  if temp2  <  100 then aY  =  aY  -  1

	LDA temp2
	CMP #100
     BCS .skipL0258
.condpart100
	DEC q
.skipL0258
.L0259 ;  if temp2  >  156 then aY  =  aY  +  1

	LDA #156
	CMP temp2
     BCS .skipL0259
.condpart101
	INC q
.skipL0259
.
 ; 

.L0260 ;  temp3  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp3
.L0261 ;  if temp3  <  130 then goto applyAlienMovement

	LDA temp3
	CMP #130
     BCS .skipL0261
.condpart102
 jmp .applyAlienMovement

.skipL0261
.
 ; 

.L0262 ;  if player0x  <  player1x then aX  =  aX  -  1

	LDA player0x
	CMP player1x
     BCS .skipL0262
.condpart103
	DEC p
.skipL0262
.L0263 ;  if player0x  >  player1x then aX  =  aX  +  1

	LDA player1x
	CMP player0x
     BCS .skipL0263
.condpart104
	INC p
.skipL0263
.
 ; 

.L0264 ;  if player0y  <  player1y then aY  =  aY  -  1

	LDA player0y
	CMP player1y
     BCS .skipL0264
.condpart105
	DEC q
.skipL0264
.L0265 ;  if player0y  >  player1y then aY  =  aY  +  1

	LDA player1y
	CMP player0y
     BCS .skipL0265
.condpart106
	INC q
.skipL0265
.
 ; 

.L0266 ;  goto applyAlienMovement

 jmp .applyAlienMovement

.
 ; 

.alien5
 ; alien5

.L0267 ;  if player0x  <  player1x then aX  =  aX  -  1

	LDA player0x
	CMP player1x
     BCS .skipL0267
.condpart107
	DEC p
.skipL0267
.L0268 ;  if player0x  >  player1x then aX  =  aX  +  1

	LDA player1x
	CMP player0x
     BCS .skipL0268
.condpart108
	INC p
.skipL0268
.
 ; 

.L0269 ;  if player0y  <  player1y then aY  =  aY  -  1

	LDA player0y
	CMP player1y
     BCS .skipL0269
.condpart109
	DEC q
.skipL0269
.L0270 ;  if player0y  >  player1y then aY  =  aY  +  1

	LDA player1y
	CMP player0y
     BCS .skipL0270
.condpart110
	INC q
.skipL0270
.
 ; 

.L0271 ;  goto applyAlienMovement

 jmp .applyAlienMovement

.
 ; 

.
 ; 

.applyAlienMovement
 ; applyAlienMovement

.L0272 ;  if aX  <  2 then aX  =  2

	LDA p
	CMP #2
     BCS .skipL0272
.condpart111
	LDA #2
	STA p
.skipL0272
.L0273 ;  if aX  >  4 then aX  =  4

	LDA #4
	CMP p
     BCS .skipL0273
.condpart112
	LDA #4
	STA p
.skipL0273
.L0274 ;  if aY  <  2 then aY  =  2

	LDA q
	CMP #2
     BCS .skipL0274
.condpart113
	LDA #2
	STA q
.skipL0274
.L0275 ;  if aY  >  4 then aY  =  4

	LDA #4
	CMP q
     BCS .skipL0275
.condpart114
	LDA #4
	STA q
.skipL0275
.
 ; 

.L0276 ;  if player1y  <  _P_Edge_Top then aY  =  4

	LDA player1y
	CMP #_P_Edge_Top
     BCS .skipL0276
.condpart115
	LDA #4
	STA q
.skipL0276
.L0277 ;  if player1y  >  _P_Edge_Bottom then aY  =  2

	LDA #_P_Edge_Bottom
	CMP player1y
     BCS .skipL0277
.condpart116
	LDA #2
	STA q
.skipL0277
.L0278 ;  if player1x  <  _P_Edge_Left then aX  =  4

	LDA player1x
	CMP #_P_Edge_Left
     BCS .skipL0278
.condpart117
	LDA #4
	STA p
.skipL0278
.L0279 ;  if player1x  >  _P_Edge_Right then aX  =  2

	LDA #_P_Edge_Right
	CMP player1x
     BCS .skipL0279
.condpart118
	LDA #2
	STA p
.skipL0279
.
 ; 

.L0280 ;  if aX  <  3 then player1x  =  player1x  -  temp5

	LDA p
	CMP #3
     BCS .skipL0280
.condpart119
	LDA player1x
	SEC
	SBC temp5
	STA player1x
.skipL0280
.L0281 ;  if aX  >  3 then player1x  =  player1x  +  temp5

	LDA #3
	CMP p
     BCS .skipL0281
.condpart120
	LDA player1x
	CLC
	ADC temp5
	STA player1x
.skipL0281
.L0282 ;  if aY  <  3 then player1y  =  player1y  -  temp5

	LDA q
	CMP #3
     BCS .skipL0282
.condpart121
	LDA player1y
	SEC
	SBC temp5
	STA player1y
.skipL0282
.L0283 ;  if aY  >  3 then player1y  =  player1y  +  temp5

	LDA #3
	CMP q
     BCS .skipL0283
.condpart122
	LDA player1y
	CLC
	ADC temp5
	STA player1y
.skipL0283
.
 ; 

.ballMovement
 ; ballMovement

.L0284 ;  if ballActive  =  0 then ballx  =  200  :  bally  =  200

	LDA u
	CMP #0
     BNE .skipL0284
.condpart123
	LDA #200
	STA ballx
	STA bally
.skipL0284
.L0285 ;  if ballActive  =  0 then goto showGraphics

	LDA u
	CMP #0
     BNE .skipL0285
.condpart124
 jmp .showGraphics

.skipL0285
.
 ; 

.L0286 ;  temp1  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp1
.L0287 ;  temp2  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp2
.L0288 ;  temp5  =  1

	LDA #1
	STA temp5
.
 ; 

.L0289 ;  if temp1  <  100 then bX  =  bX  -  1

	LDA temp1
	CMP #100
     BCS .skipL0289
.condpart125
	DEC s
.skipL0289
.L0290 ;  if temp1  >  156 then bX  =  bX  +  1

	LDA #156
	CMP temp1
     BCS .skipL0290
.condpart126
	INC s
.skipL0290
.
 ; 

.L0291 ;  if temp2  <  100 then bY  =  bY  -  1

	LDA temp2
	CMP #100
     BCS .skipL0291
.condpart127
	DEC t
.skipL0291
.L0292 ;  if temp2  >  156 then bY  =  bY  +  1

	LDA #156
	CMP temp2
     BCS .skipL0292
.condpart128
	INC t
.skipL0292
.
 ; 

.L0293 ;  temp3  =  rand

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA temp3
.L0294 ;  if temp3  <  130 then goto applyBallMovement

	LDA temp3
	CMP #130
     BCS .skipL0294
.condpart129
 jmp .applyBallMovement

.skipL0294
.
 ; 

.L0295 ;  if player0x  <  ballx then bX  =  bX  -  1

	LDA player0x
	CMP ballx
     BCS .skipL0295
.condpart130
	DEC s
.skipL0295
.L0296 ;  if player0x  >  ballx then bX  =  bX  +  1

	LDA ballx
	CMP player0x
     BCS .skipL0296
.condpart131
	INC s
.skipL0296
.
 ; 

.L0297 ;  if player0y  <  bally then bY  =  bY  -  1

	LDA player0y
	CMP bally
     BCS .skipL0297
.condpart132
	DEC t
.skipL0297
.L0298 ;  if player0y  >  bally then bY  =  bY  +  1

	LDA bally
	CMP player0y
     BCS .skipL0298
.condpart133
	INC t
.skipL0298
.
 ; 

.applyBallMovement
 ; applyBallMovement

.
 ; 

.L0299 ;  if bX  <  3 then ballx  =  ballx  -  temp5

	LDA s
	CMP #3
     BCS .skipL0299
.condpart134
	LDA ballx
	SEC
	SBC temp5
	STA ballx
.skipL0299
.L0300 ;  if bX  >  3 then ballx  =  ballx  +  temp5

	LDA #3
	CMP s
     BCS .skipL0300
.condpart135
	LDA ballx
	CLC
	ADC temp5
	STA ballx
.skipL0300
.L0301 ;  if bY  <  3 then bally  =  bally  -  temp5

	LDA t
	CMP #3
     BCS .skipL0301
.condpart136
	LDA bally
	SEC
	SBC temp5
	STA bally
.skipL0301
.L0302 ;  if bY  >  3 then bally  =  bally  +  temp5

	LDA #3
	CMP t
     BCS .skipL0302
.condpart137
	LDA bally
	CLC
	ADC temp5
	STA bally
.skipL0302
.
 ; 

.L0303 ;  if ballx  <  _P_Edge_Top then aY  =  4

	LDA ballx
	CMP #_P_Edge_Top
     BCS .skipL0303
.condpart138
	LDA #4
	STA q
.skipL0303
.L0304 ;  if bally  >  _P_Edge_Bottom then aY  =  2

	LDA #_P_Edge_Bottom
	CMP bally
     BCS .skipL0304
.condpart139
	LDA #2
	STA q
.skipL0304
.L0305 ;  if ballx  <  _P_Edge_Left then aX  =  4

	LDA ballx
	CMP #_P_Edge_Left
     BCS .skipL0305
.condpart140
	LDA #4
	STA p
.skipL0305
.L0306 ;  if bally  >  _P_Edge_Right then aX  =  2

	LDA #_P_Edge_Right
	CMP bally
     BCS .skipL0306
.condpart141
	LDA #2
	STA p
.skipL0306
.
 ; 

.showGraphics
 ; showGraphics

.
 ; 

.L0307 ;  rem ------------------------------------------------------------------

.L0308 ;  rem Player Animation

.L0309 ;  rem   Y is the counter for the player animation.  You can change the

.L0310 ;  rem   animation rate by changing the 30,20,10 to a different 

.L0311 ;  rem   sequence of numbers.

.L0312 ;  rem ------------------------------------------------------------------

.
 ; 

.L0313 ;  if dx  <  3 then _P1_x  =  _P1_x  -   ( 3  -  dx ) 

	LDA f
	CMP #3
     BCS .skipL0313
.condpart142
; complex statement detected
	LDA _P1_x
	PHA
	LDA #3
	SEC
	SBC f
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA _P1_x
.skipL0313
.L0314 ;  if dx  >  3 then _P1_x  =  _P1_x  +  dx  -  3

	LDA #3
	CMP f
     BCS .skipL0314
.condpart143
; complex statement detected
	LDA _P1_x
	CLC
	ADC f
	SEC
	SBC #3
	STA _P1_x
.skipL0314
.L0315 ;  if dy  <  3 then _P1_y  =  _P1_y  -   ( 3  -  dy ) 

	LDA g
	CMP #3
     BCS .skipL0315
.condpart144
; complex statement detected
	LDA _P1_y
	PHA
	LDA #3
	SEC
	SBC g
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA _P1_y
.skipL0315
.L0316 ;  if dy  >  3 then _P1_y  =  _P1_y  +  dy  -  3

	LDA #3
	CMP g
     BCS .skipL0316
.condpart145
; complex statement detected
	LDA _P1_y
	CLC
	ADC g
	SEC
	SBC #3
	STA _P1_y
.skipL0316
.
 ; 

.L0317 ;  if rot = 1 then player0: 

	LDA d
	CMP #1
     BNE .skipL0317
.condpart146
	LDX #<player146then_0
	STX player0pointerlo
	LDA #>player146then_0
	STA player0pointerhi
	LDA #4
	STA player0height
.skipL0317
.
 ; 

.L0318 ;  if rot = 2 then player0:

	LDA d
	CMP #2
     BNE .skipL0318
.condpart147
	LDX #<player147then_0
	STX player0pointerlo
	LDA #>player147then_0
	STA player0pointerhi
	LDA #4
	STA player0height
.skipL0318
.
 ; 

.L0319 ;  if rot = 3 then player0:

	LDA d
	CMP #3
     BNE .skipL0319
.condpart148
	LDX #<player148then_0
	STX player0pointerlo
	LDA #>player148then_0
	STA player0pointerhi
	LDA #5
	STA player0height
.skipL0319
.
 ; 

.L0320 ;  if rot = 4 then player0:  

	LDA d
	CMP #4
     BNE .skipL0320
.condpart149
	LDX #<player149then_0
	STX player0pointerlo
	LDA #>player149then_0
	STA player0pointerhi
	LDA #4
	STA player0height
.skipL0320
.
 ; 

.L0321 ;  if rot = 5 then player0:

	LDA d
	CMP #5
     BNE .skipL0321
.condpart150
	LDX #<player150then_0
	STX player0pointerlo
	LDA #>player150then_0
	STA player0pointerhi
	LDA #4
	STA player0height
.skipL0321
.
 ; 

.L0322 ;  if rot = 6 then player0:

	LDA d
	CMP #6
     BNE .skipL0322
.condpart151
	LDX #<player151then_0
	STX player0pointerlo
	LDA #>player151then_0
	STA player0pointerhi
	LDA #4
	STA player0height
.skipL0322
.
 ; 

.L0323 ;  if rot = 7 then player0:

	LDA d
	CMP #7
     BNE .skipL0323
.condpart152
	LDX #<player152then_0
	STX player0pointerlo
	LDA #>player152then_0
	STA player0pointerhi
	LDA #5
	STA player0height
.skipL0323
.
 ; 

.L0324 ;  if rot = 8 then player0:

	LDA d
	CMP #8
     BNE .skipL0324
.condpart153
	LDX #<player153then_0
	STX player0pointerlo
	LDA #>player153then_0
	STA player0pointerhi
	LDA #4
	STA player0height
.skipL0324
.
 ; 

.L0325 ;  temp6  =   ( _CurrentLevel  //  5 ) 

; complex statement detected
	LDA _CurrentLevel
	LDY #5
 jsr div16
	STA temp6
.L0326 ;  temp6  =  temp1

	LDA temp1
	STA temp6
.
 ; 

.L0327 ;  if temp6  >  1 then goto level2

	LDA #1
	CMP temp6
     BCS .skipL0327
.condpart154
 jmp .level2

.skipL0327
.L0328 ;  player1:

	LDX #<playerL0328_1
	STX player1pointerlo
	LDA #>playerL0328_1
	STA player1pointerhi
	LDA #4
	STA player1height
.L0329 ;  COLUP1  =  $5A

	LDA #$5A
	STA COLUP1
.
 ; 

.L0330 ;  goto skipref

 jmp .skipref

.
 ; 

.level2
 ; level2

.L0331 ;  if temp6  >  2 then goto level3

	LDA #2
	CMP temp6
     BCS .skipL0331
.condpart155
 jmp .level3

.skipL0331
.L0332 ;  player1:

	LDX #<playerL0332_1
	STX player1pointerlo
	LDA #>playerL0332_1
	STA player1pointerhi
	LDA #4
	STA player1height
.L0333 ;  COLUP1  =  $56

	LDA #$56
	STA COLUP1
.
 ; 

.L0334 ;  goto skipref

 jmp .skipref

.
 ; 

.level3
 ; level3

.L0335 ;  if temp6  >  3 then goto level4

	LDA #3
	CMP temp6
     BCS .skipL0335
.condpart156
 jmp .level4

.skipL0335
.L0336 ;  player1:

	LDX #<playerL0336_1
	STX player1pointerlo
	LDA #>playerL0336_1
	STA player1pointerhi
	LDA #4
	STA player1height
.L0337 ;  COLUP1  =  $9A

	LDA #$9A
	STA COLUP1
.
 ; 

.L0338 ;  goto skipref

 jmp .skipref

.
 ; 

.level4
 ; level4

.L0339 ;  if temp6  >  4 then goto level5

	LDA #4
	CMP temp6
     BCS .skipL0339
.condpart157
 jmp .level5

.skipL0339
.L0340 ;  player1:

	LDX #<playerL0340_1
	STX player1pointerlo
	LDA #>playerL0340_1
	STA player1pointerhi
	LDA #4
	STA player1height
.L0341 ;  COLUP1  =  $96

	LDA #$96
	STA COLUP1
.
 ; 

.L0342 ;  goto skipref

 jmp .skipref

.
 ; 

.level5
 ; level5

.L0343 ;  if temp6  =  5 then goto skipref

	LDA temp6
	CMP #5
     BNE .skipL0343
.condpart158
 jmp .skipref

.skipL0343
.L0344 ;  player1:

	LDX #<playerL0344_1
	STX player1pointerlo
	LDA #>playerL0344_1
	STA player1pointerhi
	LDA #4
	STA player1height
.L0345 ;  COLUP1  =  $A6

	LDA #$A6
	STA COLUP1
.
 ; 

.L0346 ;  goto skipref

 jmp .skipref

.
 ; 

.skipref
 ; skipref

.
 ; 

.L0347 ;  goto start

 jmp .start

.
 ; 

.gameover
 ; gameover

.
 ; 

.L0348 ;  COLUP0  =  $00

	LDA #$00
	STA COLUP0
.L0349 ;  COLUP1  =  $00

	LDA #$00
	STA COLUP1
.L0350 ;  player0x  =  200

	LDA #200
	STA player0x
.L0351 ;  player1x  =  200

	LDA #200
	STA player1x
.
 ; 

.L0352 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel2
PF_data2
	.byte %00000111, %11111011
	if (pfwidth>2)
	.byte %01101101, %00001111
 endif
	.byte %00000100, %10001000
	if (pfwidth>2)
	.byte %01010101, %00000000
 endif
	.byte %00000100, %11111011
	if (pfwidth>2)
	.byte %01000101, %00001111
 endif
	.byte %00000100, %10001010
	if (pfwidth>2)
	.byte %01000101, %00000000
 endif
	.byte %00000111, %10001011
	if (pfwidth>2)
	.byte %01000101, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %10001011
	if (pfwidth>2)
	.byte %01111101, %00001111
 endif
	.byte %00000100, %10001010
	if (pfwidth>2)
	.byte %01000001, %00001000
 endif
	.byte %00000100, %10001010
	if (pfwidth>2)
	.byte %01111101, %00001111
 endif
	.byte %00000100, %01010010
	if (pfwidth>2)
	.byte %01000001, %00000010
 endif
	.byte %00000111, %00100011
	if (pfwidth>2)
	.byte %01111101, %00001100
 endif
pflabel2
	lda PF_data2,x
	sta playfield,x
	dex
	bpl pflabel2
.
 ; 

.L0353 ;  pfcolors:

 lda # $42
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel13-130+pfres*pfwidth)
 else
 lda #>(pfcolorlabel13-82)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel13-130+pfres*pfwidth)
 else
 lda #<(pfcolorlabel13-82)
 endif
 sta pfcolortable
.
 ; 

.L0354 ;  drawscreen

 sta temp7
 lda #>(ret_point6-1)
 pha
 lda #<(ret_point6-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point6
.L0355 ;  j  =  j  +  1

	INC j
.L0356 ;  if joy0fire  &&  j  >  5 then goto titlescreen

 bit INPT4
	BMI .skipL0356
.condpart159
	LDA #5
	CMP j
     BCS .skip159then
.condpart160
 jmp .titlescreen

.skip159then
.skipL0356
.L0357 ;  goto gameover

 jmp .gameover

.
 ; 

.L0358 ;  bank 2

 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $9FF4-bscode_length
start_bank1 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $1FFC
 RORG $9FFC
 .word (start_bank1 & $ffff)
 .word (start_bank1 & $ffff)
 ORG $2000
 RORG $B000
.L0359 ;  rem *** We're putting the title kernel here, but it can go in any bank you

.L0360 ;  rem *** like. Just don't let your program flow accidentally fall into the

.L0361 ;  rem *** line below.

.L0362 ;  asm

 include "titlescreen/asm/titlescreen.asm"

.
 ; 

.L0363 ;  bank 3

 if ECHO2
 echo "    ",[(start_bank2 - *)]d , "bytes of ROM space left in bank 2")
 endif
ECHO2 = 1
 ORG $2FF4-bscode_length
 RORG $BFF4-bscode_length
start_bank2 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $2FFC
 RORG $BFFC
 .word (start_bank2 & $ffff)
 .word (start_bank2 & $ffff)
 ORG $3000
 RORG $D000
.
 ; 

 if ECHO3
 echo "    ",[(start_bank3 - *)]d , "bytes of ROM space left in bank 3")
 endif
ECHO3 = 1
 ORG $3FF4-bscode_length
 RORG $DFF4-bscode_length
start_bank3 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $3FFC
 RORG $DFFC
 .word (start_bank3 & $ffff)
 .word (start_bank3 & $ffff)
 ORG $4000
 RORG $F000
; bB.asm file is split here
 ifconst pfres
 if (<*) > (254-pfres*pfwidth)
	align 256
	endif
 if (<*) < (136-pfres*pfwidth)
	repeat ((136-pfres*pfwidth)-(<*))
	.byte 0
	repend
	endif
 else
 if (<*) > 206
	align 256
	endif
 if (<*) < 88
	repeat (88-(<*))
	.byte 0
	repend
	endif
 endif
pfcolorlabel13
 .byte  $0, $FC, $42,0
 .byte  $0, $FC, $42,0
 .byte  $42, $0E, $42,0
 .byte  $42, $FC, $42,0
 .byte  $42, $0E, $42,0
 .byte  $42, $FC, $42,0
 .byte  $42, $0E, $42,0
 .byte  $42, $FC, $42,0
 .byte  $0, $0E, $42,0
 .byte  $0, $FC, $42,0
 .byte  $0, $FC, $42,0
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player146then_0
	.byte         %00100100
	.byte         %01011010
	.byte         %01011010
	.byte         %00100100
	.byte         %00011000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player147then_0
	.byte         %00011000
	.byte         %00110100
	.byte         %01111000
	.byte         %01010100 
	.byte         %00101100
 if (<*) > (<(*+5))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player148then_0
	.byte         %00011000
	.byte         %00100100
	.byte         %00011010
	.byte         %00011010
	.byte         %00100100
	.byte         %00011000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player149then_0
	.byte         %00101100
	.byte         %01010100
	.byte         %01111000
	.byte         %00110100
	.byte         %00011000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player150then_0
	.byte         %00011000
	.byte         %00100100
	.byte         %01011010
	.byte         %01011010
	.byte         %00100100
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player151then_0
	.byte         %00110100
	.byte         %00101010
	.byte         %00011110
	.byte         %00101100
	.byte         %00011000
 if (<*) > (<(*+5))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player152then_0
	.byte         %00110000
	.byte         %01001000
	.byte         %10110000
	.byte         %10110000
	.byte         %01001000
	.byte         %00110000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player153then_0
	.byte         %00011000
	.byte         %00101100
	.byte         %00011110
	.byte         %00101010
	.byte         %00110100  
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0328_1
	.byte         %00011000
	.byte         %01100110
	.byte         %10010001
	.byte         %01111110
	.byte         %00000000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0332_1
	.byte         %00011000
	.byte         %01100110
	.byte         %10010001
	.byte         %01111110
	.byte         %00000000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0336_1
	.byte         %00011000
	.byte         %01100110
	.byte         %00111100
	.byte         %01100110
	.byte         %00011000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0340_1
	.byte         %00011000
	.byte         %01100110
	.byte         %00111100
	.byte         %01100110
	.byte         %00011000
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0344_1
	.byte         %00011000
	.byte         %00100100
	.byte         %01011010
	.byte         %00100100
	.byte         %00011000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
