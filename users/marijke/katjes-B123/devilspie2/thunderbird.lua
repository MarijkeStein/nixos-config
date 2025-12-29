local class_name = get_class_instance_name()
local window_name = get_window_name()


if (class_name == "Thunderbird*" and window_name == "Thunderbird*") then
    set_window_workspace(4);
    set_window_geometry(0, 25, 800, 800)
end

