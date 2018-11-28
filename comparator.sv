module comparator( 
			input logic [4:0] RN, 
			input logic [4:0] RD,
			input logic        Regwrite,
			output logic      selectSignal);

	logic [4:0] temp;
	
	logic signal; // compare signal
	
		genvar k;
	
	generate
	
	for (k = 0; k < 5; k++) begin :	Adder64
			xor xor1(temp[k], RN[k], RD[k]) ;
		end
	endgenerate
	
	nor nor1(signal, temp[0], temp[1], temp[2], temp[3], temp[4]);
	and and1(selectSignal, Regwrite, signal);
endmodule
