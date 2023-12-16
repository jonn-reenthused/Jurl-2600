
 ;*** The height of the displayed data...
bmp_48x1_3_window = 11

 ;*** The height of the bitmap data. This can be larger than 
 ;*** the displayed data height, if you're scrolling or animating 
 ;*** the data...
bmp_48x1_3_height = 11

 ifnconst bmp_48x1_3_PF1
bmp_48x1_3_PF1
 endif
        BYTE %00001111
 ifnconst bmp_48x1_3_PF2
bmp_48x1_3_PF2
 endif
        BYTE %11111111
 ifnconst bmp_48x1_3_background
bmp_48x1_3_background
 endif
        BYTE $00

 ifnconst bmp_48x1_3_color
bmp_48x1_3_color
 endif
 ; *** this is the bitmap color. If you want to change it in a 
 ; *** variable instead, dim one in bB called "bmp_48x1_3_color"
	.byte $0f


   if >. != >[.+bmp_48x1_3_height]
	align 256
   endif

bmp_48x1_3_00
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

   if >. != >[.+(bmp_48x1_3_height)]
      align 256
   endif

bmp_48x1_3_01
	BYTE %00111110
	BYTE %00000010
	BYTE %00111110
	BYTE %00110000
	BYTE %00111110
	BYTE %00000000
	BYTE %00100000
	BYTE %00100000
	BYTE %00111110
	BYTE %00100110
	BYTE %00111110

   if >. != >[.+(bmp_48x1_3_height)]
      align 256
   endif

bmp_48x1_3_02
	BYTE %00100010
	BYTE %00100010
	BYTE %00100011
	BYTE %00110010
	BYTE %11111011
	BYTE %00000000
	BYTE %10011011
	BYTE %10100010
	BYTE %11111011
	BYTE %10011011
	BYTE %11111011

   if >. != >[.+(bmp_48x1_3_height)]
      align 256
   endif

bmp_48x1_3_03
	BYTE %00101001
	BYTE %00101010
	BYTE %11101111
	BYTE %01101001
	BYTE %11101111
	BYTE %00000000
	BYTE %11101111
	BYTE %00000000
	BYTE %11001111
	BYTE %00001100
	BYTE %11101111

   if >. != >[.+(bmp_48x1_3_height)]
      align 256
   endif

bmp_48x1_3_04
	BYTE %10001000
	BYTE %00001000
	BYTE %10001000
	BYTE %10001100
	BYTE %10111110
	BYTE %00000000
	BYTE %10111110
	BYTE %10000010
	BYTE %10111110
	BYTE %00110000
	BYTE %10111110

   if >. != >[.+(bmp_48x1_3_height)]
      align 256
   endif

bmp_48x1_3_05
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

