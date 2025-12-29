local class_name = get_class_instance_name()
local window_name = get_window_name()


if (class_name == "Signal*" and window_name == "Signal*") then
    set_window_workspace(4);
    set_window_geometry(400, 25, 400, 400)
end

