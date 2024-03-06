% modules example kb "v1"
% classes
ooasp_class("v1","Bike").
ooasp_class("v1","Frame").
ooasp_class("v1","Wheel").
ooasp_class("v1","Saddle"). 
ooasp_class("v1","Wheel_front").
ooasp_class("v1","Wheel_back"). 


% class inheritance
ooasp_subclass("v1","Frame","Bike").
ooasp_subclass("v1","Wheel","Bike").
ooasp_subclass("v1","Saddle","Bike").
ooasp_subclass("v1","Wheel_front","Wheel").
ooasp_subclass("v1","Wheel_back","Wheel").


% attributes and associations
% class Frame
ooasp_assoc("v1","Frame_wheel_front","Frame",1,1,"Wheel_front",1,1).
ooasp_assoc("v1","Frame_wheel_back","Frame",1,1,"Wheel_back",1,1).
ooasp_assoc("v1","Frame_saddle","Frame",1,1,"Saddle",1,1).
ooasp_attribute("v1", "Frame", "basket", "boolean").
ooasp_attribute("v1", "Frame", "gears", "string").
ooasp_attribute_enum("v1", "Frame", "gears", "Hub").
ooasp_attribute_enum("v1", "Frame", "gears", "Derailleur").
