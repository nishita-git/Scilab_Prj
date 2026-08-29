// PCB MENTOR - Trace Width Calculation
function [width_mm, area_mil2, width_mil] = calculate_trace_width(I, deltaT, copper_oz, layer)
//Copper thickness in mil
thickness_mil = copper_oz * 1.378;

//IPC empirical constant
if layer == 1 then
// External layer
k = 0.048;
else
// Internal layer
k = 0.024;
end

// Required copper cross-sectional area
area_mil2 = (I / (k * deltaT^0.44))^(1/0.725);
// Width in mil
width_mil = area_mil2 / thickness_mil;
// Convert mil -> mm
width_mm = width_mil * 0.0254;

endfunction
