#include <cstdio>

#include "Vusb_host.h"
#include "verilated.h"
#include <verilated_vcd_c.h>

#define TRACE_ON

// 10 million clock cycles
// #define MAX_SIM_TIME 10000000LL
#define MAX_SIM_TIME 100000000LL
vluint64_t sim_time;
int main(int argc, char** argv, char** env) {
	Verilated::commandArgs(argc, argv);
	Vusb_host* top = new Vusb_host;
	#ifdef TRACE_ON
		Verilated::traceEverOn(true);
		VerilatedVcdC *m_trace = new VerilatedVcdC;
		top->trace(m_trace, 5);
		m_trace->open("waveform.vcd");
	#endif
	while (sim_time<MAX_SIM_TIME) {
		top->sys_resetn = 1;
		if(sim_time > 1 && sim_time < 5){
			top->sys_resetn = 0;
		}
		top->sys_clk ^= 1;
		top->eval(); 
		#ifdef TRACE_ON
				m_trace->dump(sim_time);
		#endif
		sim_time++;
	}	
	#ifdef TRACE_ON
		m_trace->close();
	#endif
	delete top;
	return 0;
}
