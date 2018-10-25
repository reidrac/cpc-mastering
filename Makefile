BIN=idsk 2cdt png2crtc

all: $(BIN)

idsk:
	mkdir iDSK/build
	cd iDSK/build && cmake ../
	make -C iDSK/build
	cp iDSK/build/iDSK idsk
	rm -rf iDSK/build

2cdt:
	make -C 2CDT
	cp 2CDT/2cdt .

png2crtc:
	make -C gfx2crtc
	cp gfx2crtc/png2crtc .

.PHONY: clean
clean:
	make -C 2CDT clean
	make -C gfx2crtc clean
	rm -f $(BIN)

