

 ; *** if you want to modify the bitmap color on the fly, just dim a
 ; *** variable in bB called "bmp_48x1_2_color", and use it to set the
 ; *** color.


 ;*** this is the height of the displayed data
bmp_48x1_2_window = 11

 ;*** this is the height of the bitmap data
bmp_48x1_2_height = 11

 ifnconst bmp_48x1_2_color
bmp_48x1_2_color
 endif
	.byte $4a

 ifnconst bmp_48x1_2_PF1
bmp_48x1_2_PF1
 endif
        BYTE %00000000
 ifnconst bmp_48x1_2_PF2
bmp_48x1_2_PF2
 endif
        BYTE %00000000
 ifnconst bmp_48x1_2_background
bmp_48x1_2_background
 endif
        BYTE $00

   if >. != >[.+bmp_48x1_2_height]
      align 256
   endif

bmp_48x1_2_00
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %11111011
	BYTE %10000010
	BYTE %10000010
	BYTE %10000010
	BYTE %11111011

   if >. != >[.+(bmp_48x1_2_height)]
      align 256
   endif

bmp_48x1_2_01
	BYTE %00001111
	BYTE %00001000
	BYTE %00001111
	BYTE %00000000
	BYTE %00001111
	BYTE %00000000
	BYTE %11101000
	BYTE %00101000
	BYTE %00101111
	BYTE %00101000
	BYTE %11101111

   if >. != >[.+(bmp_48x1_2_height)]
      align 256
   endif

bmp_48x1_2_02
	BYTE %10111110
	BYTE %00100110
	BYTE %10101010
	BYTE %10110010
	BYTE %10111110
	BYTE %00000000
	BYTE %00001000
	BYTE %00001000
	BYTE %10111110
	BYTE %10100010
	BYTE %10100010

   if >. != >[.+(bmp_48x1_2_height)]
      align 256
   endif

bmp_48x1_2_03
	BYTE %11111011
	BYTE %10000010
	BYTE %11111010
	BYTE %00001011
	BYTE %11111011
	BYTE %00000000
	BYTE %10010101
	BYTE %10100101
	BYTE %11110101
	BYTE %10010101
	BYTE %11110101

   if >. != >[.+(bmp_48x1_2_height)]
      align 256
   endif

bmp_48x1_2_04
	BYTE %11100000
	BYTE %01100000
	BYTE %10100000
	BYTE %00100000
	BYTE %11100000
	BYTE %00000000
	BYTE %11110100
	BYTE %00010100
	BYTE %00110111
	BYTE %00000100
	BYTE %11110100

   if >. != >[.+(bmp_48x1_2_height)]
      align 256
   endif

bmp_48x1_2_05
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %00000000
	BYTE %01000100
	BYTE %01000100
	BYTE %11000100
	BYTE %01000100
	BYTE %01011111

