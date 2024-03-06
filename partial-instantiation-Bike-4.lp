% Partial configuration

ooasp_instantiation("v1", "isnt").
ooasp_isa("inst", "Frame", 1).
ooasp_isa("inst", "Wheel_front", 2).
ooasp_isa("inst", "Wheel_front", 3).

ooasp_associated("inst", "Frame_wheel_front", 1, 2).
ooasp_associated("inst", "Frame_wheel_front", 1, 3).