# CPC Mastering tools

These are some tools to make CDT and DSK files to use with Amstrad CPC
emulators.

There's also a BASIC loader that will display a loading screen and
load a program.

Both CDT and DSK will have 4 files:

 1. loader.bas: sets the palette, loads the screen and loads the game
 2. loading: the loading screen data in SCR format (160x200 pixels, mode 0)
 3. pal: the loading screen palette (16 colours, mode 0)
 3. game: the program to run

## Requirements

 - cmake
 - gcc
 - make
 - python and pillow
 - a POSIX environment, likely

In a Debian based distro:

	sudo apt-get install build-essential cmake python-pillow

And that should do it!

Run `make` to build the tools.

## Making a CDT (tape)

Create the base CDT (change "MYGAME" to whatever you want):

    2cdt -s 0 -n -r MYGAME loader.bas master.cdt

Notes:

 - 2cdt always shows the help EVEN IF IT WORKS FINE
 - You'll need to run this always first to "blank" the tape
 - I recommend using `-s 0` because the default `-s 1` is a bit too fast
   if you really plan to load the game from cassette on a real 464 that
   is 30+ years old!

Add to the base CDT the palette file (see below how to generate one):

    2cdt -s 0 -F 2 -L 0xa000 -r PAL pal master.cdt

Add the SCR:

    2cdt -s 0 -F 2 -L 0xc000 -r LOADING loading master.cdt

Finally add your program:

    2cdt -s 0 -r GAME -X EXEC -L LOAD prog.bin master.cdt

Where:

 - EXEC is the execution address in hex (eg. 0x401b)
 - LOAD is the loading address (eg. 0x4000)

## Making a DSK (disc)

Create an empty disc:

    idsk master.dsk -n

Add the loader:

    idsk master.dsk -i loader.bas

Note: you can copy `loader.bas` to `disc.bas` and import that filename.

Add the palette (seel belo how to generate one):

    idsk master.dsk -i pal -t 1 -c a000

Add the loading screen:

    idsk master.dsk -i loading -t 1 -c c000

Add the game:

    idsk master.dsk -i game -t 1 -e EXEC -c LOAD

Where:

 - EXEC is the execution address in hex (eg. 401b)
 - LOAD is the loading address (eg. 4000)

## Preparing the SCR file

Create a SCR from an indexed PNG file:

    png2crtc loading.png loading 7 0

Dump the palette:

    dump-pal.py loading.png pal

Look at the PNG sample in `example`, but the basic
requirements are:

 - Must be 160x200 pixels
 - Indexed (palette) with 16 colours from the CPC palette

The tools check that the right colours are used. You can see
`dump-pal.py` for the expected RGB values of the CPC palette.

## License

All the tools are free software and come with their own license and/or
conditions.

The tools included here for your convenience can also be found online:

 - http://cpctech.cpc-live.com/download/2cdt.zip
 - https://github.com/cpcsdk/idsk

They may include bug fixes and improvements, so go and check them out!

