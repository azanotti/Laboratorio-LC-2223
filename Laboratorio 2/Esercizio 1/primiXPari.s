BEGIN
	read R1;
	R2 := 0;
	R3 := 0;
	
	while R3 < R1 do
		write R2;
		R2 := R2 + 2;
		R3 := R3 + 1;
	done;
END