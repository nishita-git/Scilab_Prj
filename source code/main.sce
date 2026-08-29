// PCB MENTOR - MAIN
clc;
clear;
projectPath = get_absolute_file_path("main.sce");
chdir(projectPath);
exec("functions/navigation.sci", -1);
exec("functions/trace_width.sci", -1);
exec("functions/voltage_drop.sci", -1);
exec("functions/ipc_tables.sci", -1);
exec("functions/graphs.sci", -1);
exec("gui/dashboard.sce", -1);
