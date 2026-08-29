// PCB MENTOR - FOOTPRINT EXPLORER
global FP_select FP_pitch FP_bodyW FP_bodyL FP_padW FP_padL FP_ax
f = figure( ...
    "figure_name", "PCB Mentor - Footprint Explorer", ...
    "figure_position", [80 40], ...
    "axes_size", [1100 700], ...
    "backgroundcolor", [0.94 0.95 0.97], ...
    "menubar", "none", "toolbar", "none", "resize", "off");

uicontrol(f, "style", "text", "position", [40 640 1020 40], ...
    "string", "FOOTPRINT EXPLORER", "fontsize", 22, "fontweight", "bold", ...
    "horizontalalignment", "center");

uicontrol(f, "style", "text", "position", [60 560 220 30], ...
    "string", "Select Package", "fontsize", 14, "fontweight", "bold");

package_list = ["0402";"0603";"0805";"1206";"SOT-23";"SOIC-8";"DIP-8";"QFN-32";"TQFP-32"];

FP_select = uicontrol(f, "style", "popupmenu", ...
    "position", [60 510 240 40], "string", package_list, "value", 2, ...
    "callback", "update_footprint()");

uicontrol(f, "style", "frame", "position", [40 210 350 250], ...
    "backgroundcolor", [1 1 1]);

uicontrol(f, "style", "text", "position", [60 420 300 30], ...
    "string", "PACKAGE DIMENSIONS", "fontsize", 14, "fontweight", "bold");

FP_pitch = uicontrol(f, "style", "text", "position", [60 375 300 30], ...
    "string", "Pitch: -- mm", "fontsize", 12, "horizontalalignment", "left");

FP_bodyW = uicontrol(f, "style", "text", "position", [60 340 300 30], ...
    "string", "Body Width: -- mm", "fontsize", 12, "horizontalalignment", "left");

FP_bodyL = uicontrol(f, "style", "text", "position", [60 305 300 30], ...
    "string", "Body Length: -- mm", "fontsize", 12, "horizontalalignment", "left");

FP_padW = uicontrol(f, "style", "text", "position", [60 270 300 30], ...
    "string", "Pad Width: -- mm", "fontsize", 12, "horizontalalignment", "left");

FP_padL = uicontrol(f, "style", "text", "position", [60 235 300 30], ...
    "string", "Pad Length: -- mm", "fontsize", 12, "horizontalalignment", "left");

uicontrol(f, "style", "text", "position", [500 560 400 30], ...
    "string", "FOOTPRINT PREVIEW", "fontsize", 14, "fontweight", "bold");

FP_ax = newaxes(f);
FP_ax.axes_bounds = [0.45 0.23 0.48 0.50];
FP_ax.isoview = "on";
FP_ax.grid = [2 2];

uicontrol(f, "style", "pushbutton", "position", [60 140 240 45], ...
    "string", "UPDATE FOOTPRINT", "fontsize", 12, ...
    "callback", "update_footprint()");

uicontrol(f, "style", "pushbutton", "position", [60 70 240 45], ...
    "string", "BACK TO DASHBOARD", "fontsize", 12, ...
    "callback", "close(winsid()); exec(""gui/dashboard.sce"",-1)");

function update_footprint()
    global FP_select FP_pitch FP_bodyW FP_bodyL FP_padW FP_padL FP_ax

    index = get(FP_select, "value");

    names = ["0402";"0603";"0805";"1206";"SOT-23";"SOIC-8";"DIP-8";"QFN-32";"TQFP-32"];

    // Representative nominal package dimensions in mm.
    pitches = [0;0;0;0;0.95;1.27;2.54;0.50;0.80];
    bodyW = [0.50;0.80;1.25;1.60;1.30;3.90;7.62;5.00;7.00];
    bodyL = [1.00;1.60;2.00;3.20;2.90;4.90;10.16;5.00;7.00];
    padW = [0.30;0.50;0.60;0.90;0.60;0.60;1.60;0.25;0.30];
    padL = [0.45;0.95;1.00;1.20;1.00;1.55;2.00;0.75;1.50];

    name = names(index);

    set(FP_pitch, "string", msprintf("Pitch: %.2f mm", pitches(index)));
    set(FP_bodyW, "string", msprintf("Body Width: %.2f mm", bodyW(index)));
    set(FP_bodyL, "string", msprintf("Body Length: %.2f mm", bodyL(index)));
    set(FP_padW, "string", msprintf("Pad Width: %.2f mm", padW(index)));
    set(FP_padL, "string", msprintf("Pad Length: %.2f mm", padL(index)));

    sca(FP_ax);
    if size(FP_ax.children, "*") > 0 then
        delete(FP_ax.children);
    end

    // Simple visual footprint: body + two rows of pads.
    plot([-bodyL(index)/2 bodyL(index)/2 bodyL(index)/2 -bodyL(index)/2 -bodyL(index)/2], ...
         [-bodyW(index)/2 -bodyW(index)/2 bodyW(index)/2 bodyW(index)/2 -bodyW(index)/2]);

    title(name + " Reference Footprint");
    xlabel("Length (mm)");
    ylabel("Width (mm)");

    // For IC packages, draw multiple pad markers; for passives draw 2.
    if index <= 4 then
        plot([-bodyL(index)/3 bodyL(index)/3], [0 0], "o");
    else
        n = 8;
        for k = 1:n
            y = -bodyW(index)/2 - 0.8 + (k-1)*(1.6/(n-1));
            plot([-bodyL(index)/2-0.5 bodyL(index)/2+0.5], [y y], "o");
        end
    end
endfunction

update_footprint();
