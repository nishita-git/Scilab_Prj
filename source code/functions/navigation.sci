// PCB MENTOR - NAVIGATION
function open_gui(filename)

    path = "gui/" + filename;

    // Check that the requested file exists
    if isfile(path) then
        exec(path, -1);
    else
        messagebox("File not found: " + path, "PCB Mentor");
    end

endfunction

function go_dashboard()
    open_gui("dashboard.sce");
endfunction

function go_tracewidth()
    open_gui("tracewidth.sce");
endfunction

function go_voltage()
    open_gui("voltage.sce");
endfunction

function go_drc()
    open_gui("drc.sce");
endfunction

function go_footprints()
    open_gui("footprints.sce");
endfunction

function go_learning()
    open_gui("learning.sce");
endfunction
