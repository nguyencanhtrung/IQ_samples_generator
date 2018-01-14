function [ ] = float2q( a, b, format, in_file, sheet, range_i, range_q, i_out, q_out)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Nguyen Canh Trung
% Convert floating point number to fix-point number (HEX or BIN format)
% And generate *.COE for BRAM initialization (Xilinx)
%  a        : number of integer part (not including sign-bit)
%  b        : number of fractional part
%  format   : 'bin' or 'hex'
%  in_file  : excel file includes floating-point data
%  sheet    : excel sheet has needed data
%  range_i  : column of in-phase part. Example: 'D2:D5121'
%  range_q  : column of quadrature part
%  i_out    : output file includes ONLY in-phase part in HEX or BIN format
%  q_out    : output file includes ONLY quadrature part in HEX or BIN format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read data from excel file
fileID_i = fopen(i_out,'w');
fileID_q = fopen(q_out,'w');
fileName    = in_file;
%i_samples   = xlsread(fileName, sheet, 'D2:D5121');
%q_samples   = xlsread(fileName, sheet, 'E2:E5121');
i_samples   = xlsread(fileName, sheet, range_i);
q_samples   = xlsread(fileName, sheet, range_q);

len         = length( i_samples );

% Convert floating-point number to fix-point number (format 0q31)
for n = 1 : len-1
    i = dec2q( i_samples(n, 1), a, b, format );
    q = dec2q( q_samples(n, 1), a, b, format );
    fprintf(fileID_i, '%s,\n', i);
    fprintf(fileID_q, '%s,\n', q);
end;

i = dec2q( i_samples(len, 1), a, b, format );
q = dec2q( q_samples(len, 1), a, b, format );
fprintf(fileID_i, '%s', i);
fprintf(fileID_q, '%s', q);
    
fclose(fileID_i);
fclose(fileID_q);
end

