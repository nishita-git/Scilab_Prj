// PCB MENTOR - TRACE WIDTH SIMULATOR
global TW_current TW_temp TW_copper TW_layer TW_result TW_detail TW_ax TW_figure
TW_figure = figure( ...
    "figure_name", "PCB Mentor - Trace Width Simulator", ...
    "figure_position", [80 40], ...
    "axes_size", [1200 720], ...
    "backgroundcolor", [0.94 0.96 0.98], ...
    "menubar", "none", "toolbar", "none", "resize", "off");

f = TW_figure;

uicontrol(f, "style", "text", "position", [30 655 850 45], ...
    "string", "Trace Width Simulator", "fontsize", 26, "fontweight", "bold");

uicontrol(f, "style", "text", "position", [30 620 850 30], ...
    "string", "Estimate required copper width for a given current and temperature rise.", ...
    "fontsize", 12);

panel = uicontrol(f, "style", "frame", "position", [30 310 350 280], ...
    "backgroundcolor", [1 1 1]);

uicontrol(panel, "style", "text", "position", [20 230 300 30], ...
    "string", "Design Parameters", "fontsize", 17, "fontweight", "bold");

uicontrol(panel, "style", "text", "position", [20 185 150 25], ...
    "string", "Current (A)", "fontsize", 12);

TW_current = uicontrol(panel, "style", "edit", "position", [180 180 130 35], "string", "3");

uicontrol(panel, "style", "text", "position", [20 135 150 25], ...
    "string", "Temp. Rise (C)", "fontsize", 12);

TW_temp = uicontrol(panel, "style", "edit", "position", [180 130 130 35], "string", "10");

uicontrol(panel, "style", "text", "position", [20 85 150 25], ...
    "string", "Copper (oz)", "fontsize", 12);

TW_copper = uicontrol(panel, "style", "popupmenu", "position", [180 80 130 35], ...
    "string", ["0.5 oz";"1 oz";"2 oz"], "value", 2);

uicontrol(panel, "style", "text", "position", [20 35 150 25], ...
    "string", "PCB Layer", "fontsize", 12);

TW_layer = uicontrol(panel, "style", "popupmenu", "position", [180 30 130 35], ...
    "string", ["External";"Internal"], "value", 1);

uicontrol(f, "style", "pushbutton", "position", [30 265 350 40], ...
    "string", "CALCULATE & SIMULATE", "fontsize", 13, ...
    "callback", "tracewidth_calculate()");

resultPanel = uicontrol(f, "style", "frame", "position", [30 105 350 145], ...
    "backgroundcolor", [0.88 0.94 0.98]);

TW_result = uicontrol(resultPanel, "style", "text", ...
    "position", [20 75 300 40], "string", "Width: -- mm", ...
    "fontsize", 22, "fontweight", "bold", "backgroundcolor", [0.88 0.94 0.98]);

TW_detail = uicontrol(resultPanel, "style", "text", ...
    "position", [20 20 300 45], "string", "Enter values and simulate.", ...
    "fontsize", 11, "backgroundcolor", [0.88 0.94 0.98]);

TW_ax = newaxes(f);
TW_ax.axes_bounds = [0.40 0.18 0.54 0.58];
TW_ax.background = -2;
TW_ax.grid = [2 2];

uicontrol(f, "style", "pushbutton", "position", [30 50 350 40], ...
    "string", "BACK TO DASHBOARD", "fontsize", 12, ...
    "callback", "close(winsid()); exec(""gui/dashboard.sce"",-1)");

function tracewidth_calculate()
    global TW_current TW_temp TW_copper TW_layer TW_result TW_detail TW_ax

    I = strtod(get(TW_current, "string"));
    dT = strtod(get(TW_temp, "string"));
    copperIndex = get(TW_copper, "value");
    layer = get(TW_layer, "value");

    copperValues = [0.5 1 2];
    copper = copperValues(copperIndex);

    if isnan(I) | isnan(dT) | I <= 0 | dT <= 0 then
        set(TW_result, "string", "Width: invalid");
        set(TW_detail, "string", "Use positive numeric values.");
        return
    end

    [width, area, widthMil] = calculate_trace_width(I, dT, copper, layer);

    set(TW_result, "string", msprintf("Width: %.2f mm", width));
    set(TW_detail, "string", msprintf("Area: %.1f mil^2 | Width: %.1f mil", area, widthMil));

    plot_trace_width_curve(TW_ax, dT, copper, layer);
endfunction

tracewidth_calculate();
