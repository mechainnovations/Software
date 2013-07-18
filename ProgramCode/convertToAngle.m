function [ outputAngle ] = convertToAngle( inputAngle )
% Convert 8-byte data to angle in degrees


ang3 = dec2bin(inputAngle(5),8);
ang2 = dec2bin(inputAngle(6),8);
ang1 = dec2bin(inputAngle(7),8);
ang0 = dec2bin(inputAngle(8),8);

binAngle = [ang3 ang2 ang1 ang0];

outputAngle = typecast( uint32( bin2dec( binAngle ) ), 'single');

end

