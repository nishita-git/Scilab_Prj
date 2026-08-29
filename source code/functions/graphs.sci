// PCB MENTOR - GRAPH GENERATION

function plot_trace_width_curve(ax, deltaT, copper_oz, layer)
    currents = 0.5:0.5:10;
    widths = zeros(1, length(currents));

    for i = 1:length(currents)
        [w, area, wm] = calculate_trace_width(currents(i), deltaT, copper_oz, layer);
        widths(i) = w;
    end

    sca(ax);
    if size(ax.children, "*") > 0 then
        delete(ax.children);
    end

    plot(currents, widths);
    ax.grid = [2 2];
    ax.box = "on";
    title("Required Trace Width vs Current");
    xlabel("Current (A)");
    ylabel("Trace Width (mm)");
endfunction

function plot_voltage_curve(ax, R, maxCurrent)
    [currents, voltage_drop] = voltage_drop_curve(R, maxCurrent);

    sca(ax);
    if size(ax.children, "*") > 0 then
        delete(ax.children);
    end

    plot(currents, voltage_drop);
    ax.grid = [2 2];
    ax.box = "on";
    title("Voltage Drop vs Current");
    xlabel("Current (A)");
    ylabel("Voltage Drop (V)");
endfunction
