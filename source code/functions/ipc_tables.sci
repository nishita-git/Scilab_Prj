// PCB MENTOR - Reference Data
function [name, length_mm, width_mm] = footprint_data(index)
    names = ["0402"; "0603"; "0805"; "1206"];
    lengths = [1.0; 1.6; 2.0; 3.2];
    widths = [0.5; 0.8; 1.25; 1.6];
    name = names(index);
    length_mm = lengths(index);
    width_mm = widths(index);
endfunction
