% Partial configuration

ooasp_instantiation("v1","inst").
ooasp_isa("inst", "Frame", 1).
ooasp_isa("inst", "ModuleA", 2).
ooasp_isa("inst", "ModuleB", 3).
ooasp_isa("inst","ElementA",4).

ooasp_associated("inst", "Frame_modules", 1, 2).
