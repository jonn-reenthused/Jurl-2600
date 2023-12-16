
 ;*** The height of the displayed data...
bmp_48x2_2_window = 5

 ;*** The height of the bitmap data. This can be larger than 
 ;*** the displayed data height, if you're scrolling or animating 
 ;*** the data...
bmp_48x2_2_height = 5

   if >. != >[.+(bmp_48x2_2_height)]
      align 256
   endif
 BYTE 0 ; leave this here!


 ;*** The color of each line in the bitmap, in reverse order...
bmp_48x2_2_colors 
	BYTE $9a
	BYTE $7a
	BYTE $5a
	BYTE $3a
	BYTE $1a

 ifnconst bmp_48x2_2_PF1
bmp_48x2_2_PF1
 endif
        BYTE %00001111
 ifnconst bmp_48x2_2_PF2
bmp_48x2_2_PF2
 endif
        BYTE %11111111
 ifnconst bmp_48x2_2_background
bmp_48x2_2_background
 endif
        BYTE $c2


   if >. != >[.+bmp_48x2_2_height]
      align 256
   endif


bmp_48x1_1_00
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %00000100
	BYTE %01111101
	BYTE %01111101
	BYTE %01111101
	BYTE %00000100

   if >. != >[.+(bmp_48x1_1_height)]
      align 256
   endif

bmp_48x1_1_01
	BYTE %11110000
	BYTE %11110111
	BYTE %11110000
	BYTE %11111111
	BYTE %11110000
	BYTE %11111111
	BYTE %00010111
	BYTE %11010111
	BYTE %11010000
	BYTE %11010111
	BYTE %00010000

   if >. != >[.+(bmp_48x1_1_height)]
      align 256
   endif

bmp_48x1_1_02
	BYTE %01000001
	BYTE %11011001
	BYTE %01010101
	BYTE %01001101
	BYTE %01000001
	BYTE %11111111
	BYTE %11110111
	BYTE %11110111
	BYTE %01000001
	BYTE %01011101
	BYTE %01011101

   if >. != >[.+(bmp_48x1_1_height)]
      align 256
   endif

bmp_48x1_1_03
	BYTE %00000100
	BYTE %01111101
	BYTE %00000101
	BYTE %11110100
	BYTE %00000100
	BYTE %11111111
	BYTE %01101010
	BYTE %01011010
	BYTE %00001010
	BYTE %01101010
	BYTE %00001010

   if >. != >[.+(bmp_48x1_1_height)]
      align 256
   endif

bmp_48x1_1_04
	BYTE %00011111
	BYTE %10011111
	BYTE %01011111
	BYTE %11011111
	BYTE %00011111
	BYTE %11111111
	BYTE %00001011
	BYTE %11101011
	BYTE %11001000
	BYTE %11111011
	BYTE %00001011

   if >. != >[.+(bmp_48x1_1_height)]
      align 256
   endif

bmp_48x1_1_05
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %11111111
	BYTE %10111011
	BYTE %10111011
	BYTE %00111011
	BYTE %10111011
	BYTE %10100000

