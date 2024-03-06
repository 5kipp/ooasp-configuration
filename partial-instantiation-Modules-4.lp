% Partial configuration

ooasp_instantiation("v1","inst").
ooasp_isa("inst", "Frame", 1).
ooasp_isa("inst", "Frame", 2).
ooasp_isa("inst", "ModuleA", 3).

ooasp_associated("inst", "Frame_modules", 1, 3).
ooasp_associated("inst", "Frame_modules", 2, 3).