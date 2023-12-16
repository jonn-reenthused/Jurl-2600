
 ; *** if you want to modify the bitmap color on the fly, just dim a
 ; *** variable in bB called "bmp_96x2_1_color", and use it to set the
 ; *** color.


 ;*** this is the height of the displayed data
bmp_96x2_1_window = 11

 ;*** this is the height of the bitmap data
bmp_96x2_1_height = 11

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif
 
 ;*** this is the color of each line in the bitmap data
bmp_96x2_1_colors 
	BYTE $3f
	BYTE $3f
	BYTE $3f
	BYTE $3f
	BYTE $2f
	BYTE $2f
	BYTE $2f
	BYTE $2f
	BYTE $2f
	BYTE $1f
	BYTE $1f
	BYTE $1f
	BYTE $1f

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_00
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_01
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_02
	BYTE %00000000
	BYTE %00000110
	BYTE %00000110
	BYTE %00000110
	BYTE %00000110
	BYTE %00000110
	BYTE %00000110
	BYTE %00000110
	BYTE %00111111
	BYTE %00111111
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_03
	BYTE %00000000
	BYTE %00011111
	BYTE %00111111
	BYTE %00110000
	BYTE %00110000
	BYTE %01110000
	BYTE %00110000
	BYTE %00110000
	BYTE %11111111
	BYTE %11011111
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_04
	BYTE %00000000
	BYTE %10011000
	BYTE %11011000
	BYTE %11011001
	BYTE %11011011
	BYTE %11111011
	BYTE %11011111
	BYTE %11011110
	BYTE %11011100
	BYTE %10011100
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_05
	BYTE %00000000
	BYTE %11100111
	BYTE %11101111
	BYTE %11101100
	BYTE %11100000
	BYTE %01100111
	BYTE %01101111
	BYTE %01101100
	BYTE %01101111
	BYTE %01101111
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_06
	BYTE %00000000
	BYTE %11000111
	BYTE %11101111
	BYTE %01101100
	BYTE %11101100
	BYTE %11011100
	BYTE %00001100
	BYTE %01101100
	BYTE %11101111
	BYTE %11000111
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_07
	BYTE %00000000
	BYTE %11100110
	BYTE %11110110
	BYTE %00110110
	BYTE %00110110
	BYTE %00111111
	BYTE %00110111
	BYTE %00110111
	BYTE %11110111
	BYTE %11100111
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_08
	BYTE %00000000
	BYTE %11101100
	BYTE %11101100
	BYTE %11111101
	BYTE %11111101
	BYTE %10111101
	BYTE %10011101
	BYTE %10011101
	BYTE %00011100
	BYTE %00001100
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_09
	BYTE %00000000
	BYTE %11111100
	BYTE %11111110
	BYTE %11000111
	BYTE %10000011
	BYTE %10000011
	BYTE %10000011
	BYTE %11000111
	BYTE %11111110
	BYTE %11111100
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_10
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000

   if >. != >[.+(bmp_96x2_1_height)]
      align 256
   endif

bmp_96x2_1_11
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000

