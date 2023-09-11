function rF = rotateFrame(wRi)
zero = [0,0,0];
x = [1,0,0];
y = [0,1,0];
z = [0,0,1];

xr = wRi * x';
yr = wRi * y';
zr = wRi * z';

rF = [xr'; yr'; zr'; zero];
end