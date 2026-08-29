// PCB MENTOR - VOLTAGE DROP ANALYZER
global VM_current VM_resistance VM_voltage VM_power VM_ax VM_figure
VM_figure = figure( ...
    "figure_name", "PCB Mentor - Voltage Drop Analyzer", ...
    "figure_position", [80 40], ...
    "axes_size", [1100 700], ...
    "backgroundcolor", [0.94 0.95 0.97], ...
    "menubar", "none", ...
    "toolbar", "none", ...
    "resize", "off");

f = VM_figure;

uicontrol(f, "style", "text", "position", [40 640 1020 40], ...
    "string", "VOLTAGE DROP ANALYZER", "fontsize", 22, ...
    "fontweight", "bold", "horizontalalignment", "center");

uicontrol(f, "style", "frame", "position", [40 360 320 250], ...
    "backgroundcolor", [1 1 1]);

uicontrol(f, "style", "text", "position", [60 560 280 30], ...
    "string", "CIRCUIT PARAMETERS", "fontsize", 14, "fontweight", "bold");

uicontrol(f, "style", "text", "position", [60 510 120 30], ...
    "string", "Current (A)", "fontsize", 12);

VM_current = uicontrol(f, "style", "edit", "position", [190 510 120 32], ...
    "string", "2");

uicontrol(f, "style", "text", "position", [60 460 120 30], ...
    "string", "Resistance (ohm)", "fontsize", 12);

VM_resistance = uicontrol(f, "style", "edit", "position", [190 460 120 32], ...
    "string", "0.15");

uicontrol(f, "style", "pushbutton", "position", [80 395 230 40], ...
    "string", "CALCULATE & SIMULATE", "fontsize", 12, ...
    "callback", "voltage_calculate()");

uicontrol(f, "style", "frame", "position", [40 120 320 210], ...
    "backgroundcolor", [0.88 0.94 0.98]);

uicontrol(f, "style", "text", "position", [60 285 280 30], ...
    "string", "RESULTS", "fontsize", 14, "fontweight", "bold");

VM_voltage = uicontrol(f, "style", "text", "position", [60 230 280 40], ...
    "string", "Voltage Drop: -- V", "fontsize", 17, "fontweight", "bold", ...
    "backgroundcolor", [0.88 0.94 0.98]);

VM_power = uicontrol(f, "style", "text", "position", [60 180 280 40], ...
    "string", "Power Loss: -- W", "fontsize", 15, ...
    "backgroundcolor", [0.88 0.94 0.98]);

VM_ax = newaxes(f);
VM_ax.axes_bounds = [0.40 0.18 0.54 0.58];
VM_ax.background = -2;
VM_ax.grid = [2 2];

uicontrol(f, "style", "pushbutton", "position", [40 55 320 40], ...
    "string", "BACK TO DASHBOARD", "fontsize", 12, ...
    "callback", "close(winsid()); exec(""gui/dashboard.sce"",-1)");

function voltage_calculate()
    global VM_current VM_resistance VM_voltage VM_power VM_ax VM_figure

    I = strtod(get(VM_current, "string"));
    R = strtod(get(VM_resistance, "string"));

    if isnan(I) | isnan(R) | I <= 0 | R <= 0 then
        set(VM_voltage, "string", "Voltage Drop: invalid");
        set(VM_power, "string", "Enter positive numbers");
        return
    end

    Vdrop = calculate_voltage_drop(I, R);
    P = calculate_power_loss(I, R);

    set(VM_voltage, "string", msprintf("Voltage Drop: %.3f V", Vdrop));
    set(VM_power, "string", msprintf("Power Loss: %.3f W", P));

    maxCurrent = max(5, I * 1.5);
    plot_voltage_curve(VM_ax, R, maxCurrent);
endfunction

voltage_calculate();
