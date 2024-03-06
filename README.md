# ooasp-configuration

My final encoding can be found in the ooasp.lp file. 
Because it has fairly poor performance, I have limited the number of available objects to 30. For the eventuality that a test case requires more objects than that I have included an exact copy of my encoding but with 50 object IDs called ooasp-50.lp

The test cases I provide are structered into two config models (config-model-Bike.lp and config-model-Modules.lp) with 4 partial instantiations each.
The fourth instantiation should return UNSAT as it is impossible to complete it to a valid configuration.

The command to run the test cases is as you'd expect:

    clingo config-model-[...].lp partial-instantiation-[...].lp ooasp.lp

Just be mindful that the partial instantiation are matched up with the correct config model (Bike for Bike and Modules for Modules).

Here are the solving times for my encoding on my system for each test case:

30 object IDs:
```
Modules 1 - 6.856s
Modules 2 - 6.845s
Modules 3 - 6.649s
Modules 4 - 6.411s (UNSAT)

Bike 1 - 3.170s
Bike 2 - 2.920s
Bike 3 - 0.526s
Bike 4 - 0.938s (UNSAT)
```
50 object IDs:
```
Modules 1 - 44.667s
Modules 2 - 45.039s
Modules 3 - 44.040s
Modules 4 - 49.895s (UNSAT)

Bike 1 - 62.548s
Bike 2 - 54.729s
Bike 3 - 2.022s
Bike 4 - 4.199s (UNSAT)
```
