# I was not able to compile latest version of verilator, so I am using this docker version:
# docker run -ti verilator/verilator:latest --version

V_FILES := $(abspath $(wildcard ../src_v/*.v)) $(abspath $(wildcard ../nestang_usb/src/*.v))
V_INC   := -I$(abspath ../src_v) -I$(abspath ../nestang_usb/src)

.PHONY: all clean

all: Vusb_host

obj_dir/Vusb_host.mk: $(V_FILES)
	mkdir -p obj_dir
	cd obj_dir
	verilator --top-module usb_host --trace  --trace-depth 1 -cc -O3 --exe $(V_INC) $(V_FILES) ../sim_main.cpp

Vusb_host: obj_dir/Vusb_host.mk
	make -C obj_dir -f Vusb_host.mk Vusb_host

all: Vusb_host
	@cd obj_dir && ./Vusb_host

clean:
	rm -rf obj_dir