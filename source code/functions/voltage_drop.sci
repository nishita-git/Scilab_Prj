// PCB MENTOR - VOLTAGE DROP CALCULATIONS

function Vdrop = calculate_voltage_drop(I, R)
    Vdrop = I * R;
endfunction

function P = calculate_power_loss(I, R)
    P = I * I * R;
endfunction

function [currents, drops] = voltage_drop_curve(R, maxCurrent)
    currents = 0.1:0.1:maxCurrent;
    drops = currents .* R;
endfunction
