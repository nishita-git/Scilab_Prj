// PCB MENTOR - DRC ASSISTANT

global DRC_clearance DRC_requiredClearance DRC_trace DRC_requiredTrace DRC_status DRC_explanation

f = figure( ...
    "figure_name", "PCB Mentor - DRC Assistant", ...
    "figure_position", [120 70], ...
    "axes_size", [1050 650], ...
    "backgroundcolor", [0.94 0.96 0.98], ...
    "menubar", "none", "toolbar", "none", "resize", "off");

uicontrol(f, "style", "text", "position", [30 585 850 45], ...
    "string", "DRC Assistant", "fontsize", 26, "fontweight", "bold");

panel = uicontrol(f, "style", "frame", "position", [30 250 430 270], ...
    "backgroundcolor", [1 1 1]);

uicontrol(panel, "style", "text", "position", [20 220 380 30], ...
    "string", "Design Rule Inputs", "fontsize", 17, "fontweight", "bold");

uicontrol(panel, "style", "text", "position", [20 170 220 25], ...
    "string", "Actual Clearance (mm)", "fontsize", 12);

DRC_clearance = uicontrol(panel, "style", "edit", "position", [260 165 130 35], "string", "0.20");

uicontrol(panel, "style", "text", "position", [20 120 220 25], ...
    "string", "Required Clearance (mm)", "fontsize", 12);

DRC_requiredClearance = uicontrol(panel, "style", "edit", "position", [260 115 130 35], "string", "0.15");

uicontrol(panel, "style", "text", "position", [20 70 220 25], ...
    "string", "Actual Trace Width (mm)", "fontsize", 12);

DRC_trace = uicontrol(panel, "style", "edit", "position", [260 65 130 35], "string", "0.25");

uicontrol(panel, "style", "text", "position", [20 20 220 25], ...
    "string", "Minimum Trace Width (mm)", "fontsize", 12);

DRC_requiredTrace = uicontrol(panel, "style", "edit", "position", [260 15 130 35], "string", "0.20");

uicontrol(f, "style", "pushbutton", "position", [30 195 430 40], ...
    "string", "RUN DESIGN RULE CHECK", "fontsize", 14, ...
    "callback", "run_drc()");

resultFrame = uicontrol(f, "style", "frame", "position", [500 250 500 270], ...
    "backgroundcolor", [1 1 1]);

DRC_status = uicontrol(resultFrame, "style", "text", ...
    "position", [25 205 450 40], "string", "READY", ...
    "fontsize", 22, "fontweight", "bold", "backgroundcolor", [1 1 1]);

DRC_explanation = uicontrol(resultFrame, "style", "text", ...
    "position", [25 70 450 110], ...
    "string", "Enter design values and run the check.", ...
    "fontsize", 12, "backgroundcolor", [1 1 1], "horizontalalignment", "left");

uicontrol(f, "style", "pushbutton", "position", [30 70 430 40], ...
    "string", "BACK TO DASHBOARD", "fontsize", 12, ...
    "callback", "close(winsid()); exec(""gui/dashboard.sce"",-1)");

function run_drc()
    global DRC_clearance DRC_requiredClearance DRC_trace DRC_requiredTrace DRC_status DRC_explanation
    a = strtod(get(DRC_clearance, "string"));
    r = strtod(get(DRC_requiredClearance, "string"));
    t = strtod(get(DRC_trace, "string"));
    rt = strtod(get(DRC_requiredTrace, "string"));
    if isnan(a) | isnan(r) | isnan(t) | isnan(rt) then
        set(DRC_status, "string", "INVALID INPUT");
        set(DRC_explanation, "string", "Please enter numeric values.");
        return
    end
    clearanceOK = a >= r;
    traceOK = t >= rt;
    NL = ascii(10);
    if clearanceOK & traceOK then
        set(DRC_status, "string", "DESIGN CHECK PASSED");
        set(DRC_status, "foregroundcolor", [0.1 0.55 0.25]);
        set(DRC_explanation, "string", ...
            "Clearance: PASS" + NL + "Trace width: PASS" + NL + NL + "All entered limits are satisfied.");
    else
        set(DRC_status, "string", "REVIEW REQUIRED");
        set(DRC_status, "foregroundcolor", [0.85 0.35 0.05]);
        if ~clearanceOK & ~traceOK then
            msg = "Clearance: FAIL" + NL + "Trace width: FAIL" + NL + NL + "Both limits need attention.";
        elseif ~clearanceOK then
            msg = "Clearance: FAIL" + NL + "Trace width: PASS" + NL + NL + "Increase spacing.";
        else
            msg = "Clearance: PASS" + NL + "Trace width: FAIL" + NL + NL + "Increase trace width.";
        end
        set(DRC_explanation, "string", msg);
    end
endfunction

run_drc();
