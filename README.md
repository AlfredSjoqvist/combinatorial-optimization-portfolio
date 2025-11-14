# Combinatorial Optimization Portfolio

This repository contains a curated collection of optimization models, heuristics, and mathematical programming projects implemented in **Julia**, **GMPL/GLPK**, and supporting solver tools. The focus is on clear model formulation, practical problem‑solving, and performance‑aware algorithmic reasoning.

## Skills Demonstrated

* Linear Programming (LP), Integer Programming (IP), Mixed‑Integer Programming (MIP)
* Network flow modeling and minimum‑cost flow optimization
* Facility location modeling (capacitated and uncapacitated)
* Heuristic optimization and performance benchmarking
* Modeling languages: GMPL/GLPK, Julia (JuMP‑style modeling patterns)
* Solver workflows, feasibility analysis, constraint inspection
* Scenario modeling, parameterized data handling (JSON/DAT)
* Optimization architecture, clean model structure, reproducible experiments
* Analytical reporting: dual values, shadow prices, reduced costs
* Systems‑level thinking in optimization problem design

---

## Project Overview

### gmpl-network-flow-models

A collection of GMPL formulations for classic **network flow** and **minimum‑cost flow** problems. Includes structured input files, solver outputs, and parameterized scenarios. Demonstrates clean model construction, flow conservation constraints, cost minimization, and the use of GLPK tooling for inspecting primal/dual values.

### julia-lp-problems

Julia implementations of foundational linear and integer programming models. This includes the diet problem, covering formulations, Sudoku, chessboard placement problems, and forest planning. Emphasizes modular model design, JSON‑driven data loading, and reproducible LP/MIP workflows using modern Julia tooling.

### min-cost-flow

Standalone minimum‑cost flow instances solved through modeling languages and solver pipelines. The focus is on structured graph definition, cost structures, feasibility verification, and comparing optimal cost behavior across different input instances.

### facility-location-gmpl

GMPL‑based formulations of facility location problems across multiple scales. Includes instance families requiring binary decisions, capacity handling, demand assignment, and LP‑relaxation exploration. Demonstrates classical operations‑research modeling and constraint interpretation.

### facility-location-heuristics

Large‑scale facility location instances approached through custom heuristics. Implemented in Julia and Python, these heuristics aim to deliver near‑optimal solutions efficiently for computationally intensive instances. Highlights greedy construction, local optimization strategies, scenario comparison, and benchmarking against optimal LP/MIP solutions.
