function [ result ] = fip_converter( a )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIXED_POINT_CONVERTER 
%   Author: Nguyen Canh Trung
%   Convert a floating point number into fixed-point (default format: 8Q23)
%   Can be used to calculate CONSTANT in FPGA dev
%   Input: a < 256.0 by default 
%   Output: FIP  nQm format (total length = n + m + 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% By default. Can change to adjust your format
num_frac = 31;  %m
num_int  = 0;   %n
%---------------------------------------------
    if a >= 0 
        integer_temp = abs( floor( a ));
    else
        integer_temp = abs( ceil( a ));
    end
    
    frac_temp    = abs( a ) - integer_temp;
    s = '';
    %Fractional bits
    for i=1:num_frac
        frac_temp = frac_temp * 2.0;
        if frac_temp >= 1.0 
            s           = strcat(s,'1');
            frac_temp   = frac_temp - 1.0;
        else
            s           = strcat(s,'0');
        end
    end
    
    %Integer bits
    for i=1:num_int
        b = mod(integer_temp, 2);
        s = strcat(num2str(b), s);
        integer_temp = floor(integer_temp / 2.0);
    end
    
    %Sign bit
    s = strcat('0', s);
    
    %Take 2's complement if a < 0
    if a < 0.0
        first_one = false;
        for i= 32:-1:1
            if (first_one == true)
                if ( s(i:i) == '1' )
                    s(i:i) = '0';
                else
                    s(i:i) = '1';
                end
            end
            if ( s(i:i) == '1' ) & (first_one == false)
                first_one = true;
            end
        end
    end
    result = s;
end

