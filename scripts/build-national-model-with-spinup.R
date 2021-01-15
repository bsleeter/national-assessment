




library(raster)
library(tidyverse)
library(rsyncrosim)





# ssimDir = "F:/national-assessment/data/ssim-libs/"
ssimDir = "F:/national-assessment/models/"
SyncroSimDir <- "C:/Program Files/SyncroSim/"
mySession <- session(SyncroSimDir)

# myLibrary = ssimLibrary(name = paste0(ssimDir,"Initial Stocks Model Conus.ssim"), session = mySession)
# myLibrary = ssimLibrary(name = paste0(ssimDir,"Initial Stocks Model.ssim"), session = mySession)
myLibrary = ssimLibrary(name = paste0(ssimDir,"national-assessment-full-model.ssim"), session = mySession)
myProject = project(myLibrary, project="Definitions")








############################################################################################
# Definitions for STSM
############################################################################################

# ST-Sim Terminology
sheetName <- "stsim_Terminology"
mySheet <- datasheet(myProject, name=sheetName)
mySheet$AmountLabel[1] <- "Area"
mySheet$AmountUnits[1] <- "Hectares"
mySheet$StateLabelX[1] <- "LULC"
mySheet$StateLabelY[1] <- "Subclass"
mySheet$PrimaryStratumLabel[1] <- "Ecological Boundary"
mySheet$SecondaryStratumLabel[1] <- "Administrative Boundary"
mySheet$SecondaryStratumLabel[1] <- "Ownership"
mySheet$TimestepUnits[1] <- "Year"
saveDatasheet(myProject, mySheet, sheetName)

# ST-Sim Primary Strata
sheetName <- "stsim_Stratum"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/ecoregions.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim Secondary Strata
sheetName <- "stsim_SecondaryStratum"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/states.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim Tertiary Strata
sheetName <- "stsim_TertiaryStratum"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/land-managers-strata.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim State Label x
sheetName <- "stsim_StateLabelX"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/state-label-xid.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim State Label y
sheetName <- "stsim_StateLabelY"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/state-label-yid.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim State Class
sheetName <- "stsim_StateClass"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/state-class-types.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim Transition Types
sheetName <- "stsim_TransitionType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/transition-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim Transition Groups
sheetName <- "stsim_TransitionGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/transition-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# ST-Sim Transition Types by Group
sheetName <- "stsim_TransitionTypeGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/transition-types-by-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# ST-Sim Transition Simulation Groups
# Only used for projection models
sheetName <- "stsim_TransitionSimulationGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/transition-simulation-groups.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# ST-Sim Age Type
sheetName <- "stsim_AgeType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet[1,"Frequency"] <- 1
mySheet[1,"MaximumAge"] <- 300
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim Age Group
maxAge = 300
sheetName <- "stsim_AgeGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet[1:(maxAge/20),"MaximumAge"] <- c(seq(from=20, to=(maxAge-1), by=20), maxAge-1)
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim Attribute Groups
sheetName <- "stsim_AttributeGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/state-attribute-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim State Attribute Types
sheetName <- "stsim_StateAttributeType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/state-attribute-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# ST-Sim Distributions
sheetName <- "corestime_DistributionType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/distributions.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# ST-Sim External Variables
sheetName <- "corestime_ExternalVariableType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/external-variables.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

############################################################################################
# Definitions for Carbon Stock Flow Model
############################################################################################

# SF Stock Types
sheetName <- "stsimsf_StockType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/stock-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# SF Stock Groups
sheetName <- "stsimsf_StockGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/stock-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# SF Flow Types
sheetName <- "stsimsf_FlowType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/flow-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

# SF Flow Groups
sheetName <- "stsimsf_FlowGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/flow-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)


############################################################################################
# Definitions for CCBM-CFS3 Model Linking
############################################################################################

# CBM-CFS3 Administrative Boundaries
sheetName <- "stsimcbmcfs3_AdminBoundary"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/cbm-administrative-boundary.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# CBM-CFS3 Ecological Boundaries
sheetName <- "stsimcbmcfs3_EcoBoundary"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/cbm-ecological-boundary.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# CBM-CFS3 Species Type
sheetName <- "stsimcbmcfs3_SpeciesType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/cbm-species-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

# CBM-CFS3 Disturbance Type
sheetName <- "stsimcbmcfs3_DisturbanceType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/cbm-disturbance-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)






############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
# Create scenario to generate Flow Pathways using CBM-CFS3




############################################################################################
# CBM-CFS3 Crosswalk Tables
############################################################################################

# CBM-CFS3 Crosswalk Species
myScenario = scenario(myProject, "CBM-CFS3 Crosswalk [Species and Spatial Unit]")
sheetName <- "stsimcbmcfs3_CrosswalkSpecies"
mySheet <- datasheet(myScenario, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-crosswalk-species-complete.csv")
saveDatasheet(myScenario, mySheet, name=sheetName, append=T)

# CBM-CFS3 Crosswalk Stocks
myScenario = scenario(myProject, "CBM-CFS3 Crosswalk [Carbon Stocks]")
sheetName <- "stsimcbmcfs3_CrosswalkStock"
mySheet <- datasheet(myScenario, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-crosswalk-carbon-stock.csv")
saveDatasheet(myScenario, mySheet, name=sheetName, append=T)

# CBM-CFS3 Crosswalk Transitions
myScenario = scenario(myProject, "CBM-CFS3 Crosswalk [Transitions]")
sheetName <- "stsimcbmcfs3_CrosswalkDisturbance"
mySheet <- datasheet(myScenario, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-crosswalk-disturbance.csv")
saveDatasheet(myScenario, mySheet, name=sheetName, append=T)

# CBM-CFS3 Crosswalk Transitions
myScenario = scenario(myProject, "CBM-CFS3 Crosswalk Spin-up Table")
sheetName <- "stsimcbmcfs3_Spinup"
mySheet <- datasheet(myScenario, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-spin-up.csv")
saveDatasheet(myScenario, mySheet, name=sheetName, append=T)

datasheet(myScenario)


############################################################################################
# SF Model Parameters
############################################################################################

# Base Flows only - all set to 1.0
myScenario <- scenario(myProject, scenario = "Flow Pathways")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsimsf_FlowPathwayDiagram"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-flow-pathways-diagram-stock.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsimsf_FlowPathway"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-flow-pathways-diagram.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Initial Stocks (Non-spatial)
myScenario <- scenario(myProject, scenario = "Initial Stocks")
sheetName <- "stsimsf_InitialStockNonSpatial"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-initial-stocks.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Flow Group Membership
myScenario <- scenario(myProject, scenario = "SF Flow Group Membership")
sheetName <- "stsimsf_FlowTypeGroupMembership"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-flow-group-membership.csv")
saveDatasheet(myScenario, mySheet, sheetName)


############################################################################################
# State Attribute Values - carbon stocks over age derived from CBM model runs with fire as last disturbance
############################################################################################

# State Attribute Values
myScenario <- scenario(myProject, scenario = "State Attribute Values")
sheetName <- "stsim_StateAttributeValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-state-attribute-values-fire.csv")
saveDatasheet(myScenario, mySheet, sheetName)


############################################################################################
# Create scenario to generate full set of flow pathways
############################################################################################

myScenario = scenario(myProject, scenario = "Generate Flow Pathways")
dependency(myScenario, c("CBM-CFS3 Crosswalk [Species and Spatial Unit]",
                         "CBM-CFS3 Crosswalk [Carbon Stocks]",
                         "CBM-CFS3 Crosswalk [Transitions]",
                         "Flow Pathways",
                         "Initial Stocks",
                         "SF Flow Group Membership",
                         "State Attribute Values"))




############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################


############################################################################################
# Generate single cell simulation scenario for validation against CBM-CFS3 stock output
############################################################################################

# Run Control; Non-spatial; 300 years; 1 MC
myScenario <- scenario(myProject, scenario = "Run Control [Non-spatial; 300 years; 1 MC]")
sheetName <- "stsim_RunControl"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
maxTimestep <- 300
maxIteration <- 1
minTimestep <- 1
minIteration <- 1
mySheet[1,"MinimumIteration"] <- minIteration
mySheet[1,"MaximumIteration"] <- maxIteration
mySheet[1,"MinimumTimestep"] <- minTimestep
mySheet[1,"MaximumTimestep"] <- maxTimestep
mySheet[1,"IsSpatial"] <- F
saveDatasheet(myScenario, mySheet, sheetName)

# Pathway Diagram - Calibration
myScenario <- scenario(myProject, scenario = "Pathway Diagram [Calibration]")
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic-calibration.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Initial Conditions - Non-spatial; Single cell; 1ha; Age 0
myScenario <- scenario(myProject, scenario = "Initial Conditions [Non-spatial; Single cell; 1ha; Age 0]")
sheetName <- "stsim_InitialConditionsNonSpatial"
mySheet = read.csv("F:/national-assessment/data/initial-conditions/initial-conditions-non-spatial-single-cell.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Output Options
myScenario <- scenario(myProject, scenario = "Output Options [Non-spatial]")
sheetName <- "stsim_OutputOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1, "SummaryOutputSC"] <- T
mySheet[1, "SummaryOutputSCTimesteps"] <- 1
mySheet[1, "SummaryOutputSCZeroValues"] <- F
mySheet[1, "SummaryOutputTR"] <- T
mySheet[1, "SummaryOutputTRTimesteps"] <- 1
mySheet[1, "SummaryOutputTRIntervalMean"] <- F
saveDatasheet(myScenario, mySheet, sheetName)

# Flow Order
myScenario <- scenario(myProject, scenario = "SF Flow Order")
sheetName <- "stsimsf_FlowOrder"
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-order.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsimsf_FlowOrderOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"ApplyEquallyRankedSimultaneously"] = T
saveDatasheet(myScenario, mySheet, sheetName)

# SF Output Options
myScenario <- scenario(myProject, scenario = "SF Output Options [Non-spatial]")
sheetName <- "stsimsf_OutputOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"SummaryOutputST"] = T
mySheet[1,"SummaryOutputFL"] = T
mySheet[1,"SummaryOutputSTTimesteps"] = 1
mySheet[1,"SummaryOutputFLTimesteps"] = 1
mySheet[1,"SpatialOutputST"] = F
mySheet[1,"SpatialOutputFL"] = F
mySheet[1,"SpatialOutputSTTimesteps"] = 1
mySheet[1,"SpatialOutputFLTimesteps"] = 1
saveDatasheet(myScenario, mySheet, sheetName)

# Stock Group Membership
myScenario <- scenario(myProject, scenario = "SF Stock Group Membership")
sheetName <- "stsimsf_StockTypeGroupMembership"
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/stock-type-group-membership.csv")
saveDatasheet(myScenario, mySheet, sheetName)


############################################################################################
# Create single cell scenario with dependencies
# Need to use Results Scenario from "Generate Flow Pathways Scenario"
############################################################################################

myScenario <- scenario(myProject, scenario = "LUCAS - Single Cell")
dependency(myScenario, c("Run Control [Non-spatial; 300 years; 1 MC]",
                         "Pathway Diagram [Calibration]",
                         "Initial Conditions [Non-spatial; Single cell; 1ha; Age 0]",
                         "Output Options [Non-spatial]",
                         "SF Flow Order",
                         "SF Output Options [Non-spatial]",
                         "SF Stock Group Membership",
                         50))





############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################


############################################################################################
# Generate Spin-up Scenario
############################################################################################

myScenario <- scenario(myProject, scenario = "Spin-up")
dependency(myScenario, c("CBM-CFS3 Spin-up Table",
                         "SF Stock Group Membership",
                         "SF Output Options [Non-spatial]",
                         "SF Flow Order",
                         "Pathway Diagram [Calibration]",
                         50))

# Note: Must remove all State Attributes for Carbon Initial Conditions EXCEPT for Net Growth in order to initialize stocks at 0
# Remove these State Attributes from the newly created "Spin-up" scenario.

# Run Spin-up module in SyncroSim.









############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################


############################################################################################
# Create Spatial Model
############################################################################################

# Run Control; Spatial; 2001-2020; 1 MC
myScenario <- scenario(myProject, scenario = "Run Control [Non-spatial; 2001-2020; 1 MC]")
sheetName <- "stsim_RunControl"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
maxTimestep <- 2020
maxIteration <- 1
minTimestep <- 2001
minIteration <- 1
mySheet[1,"MinimumIteration"] <- minIteration
mySheet[1,"MaximumIteration"] <- maxIteration
mySheet[1,"MinimumTimestep"] <- minTimestep
mySheet[1,"MaximumTimestep"] <- maxTimestep
mySheet[1,"IsSpatial"] <- T
saveDatasheet(myScenario, mySheet, sheetName)


############################################################################################
# Pathway Diagrams - Spatial Model
############################################################################################

# Urbanization
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Urbanization]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-urbanization.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Ag Change
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Ag Change]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-agchange.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Ag Expansion
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Ag Expansion]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-agexpansion.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Ag Contraction
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Ag Contraction]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-agcontraction.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Urban Intensification
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Intensification]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-intensification.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Fire
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Fire]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-fire.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Drought
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Insect]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-insect.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Harvest
myScenario <- scenario(myProject, scenario <- "Pathway Diagram [Harvest]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsim_DeterministicTransition"
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsim_Transition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-probabilistic-harvest.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Merge Pathway Dependencies
myScenario <- scenario(myProject, scenario = "Pathway Diagram")
mergeDependencies(myScenario) = TRUE
dependency(myScenario, c("Pathway Diagram [Urbanization]", "Pathway Diagram [Ag Change]", "Pathway Diagram [Ag Expansion]", "Pathway Diagram [Ag Contraction]", "Pathway Diagram [Intensification]",
                         "Pathway Diagram [Fire]", "Pathway Diagram [Insect]", "Pathway Diagram [Harvest]"))



############################################################################################
# Distributions and External Variables
############################################################################################

# Distributions - Urbanization
myScenario <- scenario(myProject, scenario = "Distirbutions [Urbanization]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-urbanization.csv")  %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Distributions - Urban Intensification
myScenario <- scenario(myProject, scenario = "Distirbutions [Intensification]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-intensification.csv") %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Distributions - Ag Change
myScenario <- scenario(myProject, scenario = "Distirbutions [Ag Change]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-agchange.csv") %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Distributions - Ag Expansion
myScenario <- scenario(myProject, scenario = "Distirbutions [Ag Expansion]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-agexpansion.csv") %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Distributions - Ag Expansion
myScenario <- scenario(myProject, scenario = "Distirbutions [Ag Contraction]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-agcontraction.csv") %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Distributions - Fire
myScenario <- scenario(myProject, scenario = "Distirbutions [Fire]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-fire.csv") %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Distributions - Insect/Drought
myScenario <- scenario(myProject, scenario = "Distirbutions [Insect]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-insect.csv") %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Distributions - Forest Harvest
myScenario <- scenario(myProject, scenario = "Distirbutions [Harvest]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_DistributionValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/distributions/distribution-harvest.csv") %>% rename("Value" = "Amount")
saveDatasheet(myScenario, mySheet, sheetName)

# Merge Distribution Scenarios
myScenario <- scenario(myProject, scenario = "Distributions")
mergeDependencies(myScenario) = T
dependency(myScenario, c("Distirbutions [Urbanization]", "Distirbutions [Intensification]", "Distirbutions [Ag Change]",
                         "Distirbutions [Ag Expansion]", "Distirbutions [Ag Contraction]", "Distirbutions [Fire]", "Distirbutions [Insect]", "Distirbutions [Harvest]"))


# External Variables
myScenario <- scenario(myProject, scenario = "External Variables")
sheetName <- "corestime_ExternalVariableValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/external-variables/external-variables-bau.csv")
saveDatasheet(myScenario, mySheet, sheetName)



############################################################################################
# Initial Conditions and Output Options
############################################################################################

# Initial Conditions with Imputed Age
myScenario <- scenario(myProject, scenario = "Initial Conditions [Spatial; Imputed Age; 1km]")
sheetName <- "stsim_InitialConditionsSpatial"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1, "StratumFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-ecoregion.tif"
mySheet[1, "SecondaryStratumFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-states.tif"
mySheet[1, "TertiaryStratumFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-land-managers.tif"
mySheet[1, "StateClassFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-state-class.tif"
mySheet[1, "AgeFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-imputed-age.tif"
saveDatasheet(myScenario, mySheet, sheetName)

# Set Initial TST Rasters
myScenario <- scenario(myProject, scenario = "Initial Conditions [Spatial; Imputed Age; 1km]")
sheetName <- "stsim_InitialTSTSpatial"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(TransitionGroupID = "Fire: High Severity [Type]", TSTFileName = "F:/national-assessment/data/initial-conditions/final/ic-tst-fire.tif"))
mySheet = addRow(mySheet, data.frame(TransitionGroupID = "Management: Forest Clearcut [Type]", TSTFileName = "F:/national-assessment/data/initial-conditions/final/ic-tst-harvest.tif"))
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim Summary (Tabular) Output options
myScenario <- scenario(myProject, scenario = "Output Options [Spatial]")
sheetName <- "stsim_OutputOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1, "SummaryOutputSC"] <- T
mySheet[1, "SummaryOutputSCTimesteps"] <- 1
mySheet[1, "SummaryOutputSCZeroValues"] <- F
mySheet[1, "SummaryOutputTR"] <- T
mySheet[1, "SummaryOutputTRTimesteps"] <- 1
mySheet[1, "SummaryOutputTRIntervalMean"] <- F
mySheet[1, "SummaryOutputTRSC"] <- F
mySheet[1, "SummaryOutputTRSCTimesteps"] <- 1
mySheet[1, "SummaryOutputSA"] <- F
mySheet[1, "SummaryOutputSATimesteps"] <- 1
mySheet[1, "SummaryOutputTA"] <- F
mySheet[1, "SummaryOutputTATimesteps"] <- 1
mySheet[1, "SummaryOutputOmitSS"] <- F
mySheet[1, "SummaryOutputOmitTS"] <- F
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim Spatial (annual) Output options
sheetName <- "stsim_OutputOptionsSpatial"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1, "RasterOutputSC"] <- T
mySheet[1, "RasterOutputSCTimesteps"] <- 1
mySheet[1, "RasterOutputAge"] <- T
mySheet[1, "RasterOutputAgeTimesteps"] <- 1
mySheet[1, "RasterOutputTR"] <- T
mySheet[1, "RasterOutputTRTimesteps"] <- 1
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim Spatial  (average) Output options
sheetName <- "stsim_OutputOptionsSpatialAverage"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1, "AvgRasterOutputTP"] <- T
mySheet[1, "AvgRasterOutputTPTimesteps"] <- 20
mySheet[1, "AvgRasterOutputTPCumulative"] <- T
saveDatasheet(myScenario, mySheet, sheetName)


############################################################################################
# Adjacency Settings and Multipliers
############################################################################################

myScenario = scenario(myProject, scenario = "Adjacency Settings")
sheetName = "stsim_TransitionAdjacencySetting"
mySheet = read.csv("F:/national-assessment/data/adjacency/transition-adjacency-setting.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName = "stsim_TransitionAdjacencyMultiplier"
mySheet = datasheet(myScenario, sheetName, optional = T, empty = T)
mySheet = read.csv("F:/national-assessment/data/adjacency/transition-adjacency-multipliers.csv")
saveDatasheet(myScenario, mySheet, sheetName)


############################################################################################
# Transition Targets
############################################################################################

myScenario <- scenario(myProject, scenario = "Transition Targets [Reference]")
sheetName <- "stsim_TransitionTarget"
mySheet <- datasheet(myScenario, name = sheetName, empty = F, optional = T)
mySheet <- read.csv("F:/national-assessment/data/transition-targets/transition-targets-reference.csv")
saveDatasheet(myScenario, mySheet, sheetName)

############################################################################################
# Transition Multipliers
############################################################################################

myScenario <- scenario(myProject, scenario = "Transition Multipliers [Fire Severity]")
sheetName <- "stsim_TransitionMultiplierValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = F, optional = T)
mySheet <- read.csv("F:/national-assessment/data/transition-multipliers/transition-multipliers-fire-severity.csv")
saveDatasheet(myScenario, mySheet, sheetName)


############################################################################################
# Transition Spatial Multipliers
############################################################################################

# Urbanization
dir1 = "F:/national-assessment/data/spatial-multipliers/urbanization-high/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Urbanization: High [Type]"

dir2 = "F:/national-assessment/data/spatial-multipliers/urbanization-medium/"
list2 = list.files(dir2, pattern = "*.tif$")
tg2 = "Urbanization: Medium [Type]"

dir3 = "F:/national-assessment/data/spatial-multipliers/urbanization-low/"
list3 = list.files(dir3, pattern = "*.tif$")
tg3 = "Urbanization: Low [Type]"

dir4 = "F:/national-assessment/data/spatial-multipliers/urbanization-open/"
list4 = list.files(dir4, pattern = "*.tif$")
tg4 = "Urbanization: Open [Type]"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Urbanization]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg3, MultiplierFileName = paste0(dir3,list3)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg4, MultiplierFileName = paste0(dir4,list4)))
saveDatasheet(myScenario, mySheet, sheetName)

# Intensification
dir1 = "F:/national-assessment/data/spatial-multipliers/intensification-open-low/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Intensification: Open to Low [Type]"

dir2 = "F:/national-assessment/data/spatial-multipliers/intensification-open-medium/"
list2 = list.files(dir2, pattern = "*.tif$")
tg2 = "Intensification: Open to Medium [Type]"

dir3 = "F:/national-assessment/data/spatial-multipliers/intensification-open-high/"
list3 = list.files(dir3, pattern = "*.tif$")
tg3 = "Intensification: Open to High [Type]"

dir4 = "F:/national-assessment/data/spatial-multipliers/intensification-low-medium/"
list4 = list.files(dir4, pattern = "*.tif$")
tg4 = "Intensification: Low to Medium [Type]"

dir5 = "F:/national-assessment/data/spatial-multipliers/intensification-low-high/"
list5 = list.files(dir5, pattern = "*.tif$")
tg5 = "Intensification: Low to High [Type]"

dir6 = "F:/national-assessment/data/spatial-multipliers/intensification-medium-high/"
list6 = list.files(dir6, pattern = "*.tif$")
tg6 = "Intensification: Medium to High [Type]"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Intensification]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg3, MultiplierFileName = paste0(dir3,list3)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg4, MultiplierFileName = paste0(dir4,list4)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg5, MultiplierFileName = paste0(dir5,list5)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg6, MultiplierFileName = paste0(dir6,list6)))
saveDatasheet(myScenario, mySheet, sheetName)

# Ag Change
dir1 = "F:/national-assessment/data/spatial-multipliers/ag-change-cropland-pasture/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Ag Change: Cropland to Pasture [Type]"

dir2 = "F:/national-assessment/data/spatial-multipliers/ag-change-pasture-cropland/"
list2 = list.files(dir2, pattern = "*.tif$")
tg2 = "Ag Change: Pasture to Cropland [Type]"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Ag Change]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
saveDatasheet(myScenario, mySheet, sheetName)

# Ag Contraction
dir1 = "F:/national-assessment/data/spatial-multipliers/ag-contraction-cropland/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Ag Contraction: Cropland"

dir2 = "F:/national-assessment/data/spatial-multipliers/ag-contraction-pasture/"
list2 = list.files(dir2, pattern = "*.tif$")
tg2 = "Ag Contraction: Pasture"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Ag Contraction]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
saveDatasheet(myScenario, mySheet, sheetName)

# Ag Expansion
dir1 = "F:/national-assessment/data/spatial-multipliers/ag-expansion-cropland/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Ag Expansion: Cropland [Type]"

dir2 = "F:/national-assessment/data/spatial-multipliers/ag-expansion-pasture/"
list2 = list.files(dir2, pattern = "*.tif$")
tg2 = "Ag Expansion: Pasture [Type]"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Ag Expansion]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2012,5), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
saveDatasheet(myScenario, mySheet, sheetName)

# Fire
dir1 = "F:/national-assessment/data/spatial-multipliers/fire/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Fire"

# dir1 = "F:/national-assessment/data/spatial-multipliers/fire-high-severity/"
# list1 = list.files(dir1, pattern = "*.tif$")
# tg1 = "Fire: High Severity [Type]"
# 
# dir2 = "F:/national-assessment/data/spatial-multipliers/fire-medium-severity/"
# list2 = list.files(dir2, pattern = "*.tif$")
# tg2 = "Fire: Medium Severity [Type]"
# 
# dir3 = "F:/national-assessment/data/spatial-multipliers/fire-low-severity/"
# list3 = list.files(dir3, pattern = "*.tif$")
# tg3 = "Fire: Low Severity [Type]"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Fire]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2020,1), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
# mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2014,1), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
# mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2014,1), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
# mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2014,1), TransitionGroupID = tg3, MultiplierFileName = paste0(dir3,list3)))
saveDatasheet(myScenario, mySheet, sheetName)

# Insect
dir1 = "F:/national-assessment/data/spatial-multipliers/insect-high-severity/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Insect: High Severity [Type]"

dir2 = "F:/national-assessment/data/spatial-multipliers/insect-medium-severity/"
list2 = list.files(dir2, pattern = "*.tif$")
tg2 = "Insect: Medium Severity [Type]"

dir3 = "F:/national-assessment/data/spatial-multipliers/insect-low-severity/"
list3 = list.files(dir3, pattern = "*.tif$")
tg3 = "Insect: Low Severity [Type]"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Insect]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2015,1), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2015,1), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2015,1), TransitionGroupID = tg3, MultiplierFileName = paste0(dir3,list3)))
saveDatasheet(myScenario, mySheet, sheetName)

# Harvest
dir1 = "F:/national-assessment/data/spatial-multipliers/clearcut/"
list1 = list.files(dir1, pattern = "*.tif$")
tg1 = "Management: Forest Clearcut [Type]"

dir2 = "F:/national-assessment/data/spatial-multipliers/selection/"
list2 = list.files(dir2, pattern = "*.tif$")
tg2 = "Management: Forest Selection [Type]"

myScenario <- scenario(myProject, scenario = "Spatial Multipliers [Forest Harvest]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_TransitionSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2014,1), TransitionGroupID = tg1, MultiplierFileName = paste0(dir1,list1)))
mySheet = addRow(mySheet, data.frame(Timestep = seq(2002,2014,1), TransitionGroupID = tg2, MultiplierFileName = paste0(dir2,list2)))
saveDatasheet(myScenario, mySheet, sheetName)

# Merge Spatial Multipliers

myScenario <- scenario(myProject, scenario = "Spatial Multipliers")
mergeDependencies(myScenario) = T
dependency(myScenario, c("Spatial Multipliers [Urbanization]", "Spatial Multipliers [Intensification]", "Spatial Multipliers [Ag Change]",
                         "Spatial Multipliers [Ag Contraction]", "Spatial Multipliers [Ag Expansion]", "Spatial Multipliers [Fire]",
                         "Spatial Multipliers [Insect]", "Spatial Multipliers [Forest Harvest]"))




############################################################################################
# Get output tables from Spin-up simulation
############################################################################################

# myLibrary = ssimLibrary(name = paste0(ssimDir,"Initial Stocks Model Conus.ssim"), session = mySession)
myLibrary = ssimLibrary(name = paste0(ssimDir,"Spin-up Model Conus.ssim"), session = mySession)
# myLibrary = ssimLibrary(name = paste0(ssimDir,"national-assessment-full-model.ssim"), session = mySession)
myProject = project(myLibrary, project="Definitions")


# Define the output scenario from the Spin-up
spinupOutputScenario = 137

# State Attribute (Carbon Initial Conditions and Net Growth)
# Note: Need to remove primary and secondary stratum
data = datasheet(myProject, "stsim_StateAttributeValue", scenario = spinupOutputScenario)
head(data)
data1 = data %>% mutate(StratumID = NA, SecondaryStratumID = NA) %>%
  mutate(AgeMin=TSTMin, AgeMax=TSTMax) %>%
  mutate(TSTMin=NA, TSTMax=NA) %>%
  group_by(StateClassID, StateAttributeTypeID) %>%
  mutate(AgeMax = ifelse(AgeMin==max(AgeMin), NA, AgeMax))
write_csv(data1, "F:/national-assessment/data/state-attributes/state-attribute-values-carbon-spinup-output.csv")

data2 = data1 %>% filter(TSTGroupID == "Fire: High Severity [Type]") %>% mutate(TSTGroupID=NA) %>% filter(StateAttributeTypeID!="Net Growth")
write_csv(data2, "F:/national-assessment/data/state-attributes/state-attributes-spin-up-fire.csv")

data3 = data1 %>% filter(TSTGroupID == "Management: Forest Clearcut [Type]") %>% mutate(TSTGroupID=NA) %>% filter(StateAttributeTypeID!="Net Growth")
write_csv(data3, "F:/national-assessment/data/state-attributes/state-attributes-spin-up-harvest.csv")

unique(data$StateAttributeTypeID)

# Flow Pathways (Base flows and fire/harvest flows)
data = datasheet(myProject, "stsimsf_FlowPathway", scenario = spinupOutputScenario)
data = data %>% mutate(FromStratumID = NA, FromSecondaryStratumID = NA)
dataBaseFlows = data %>% filter(is.na(TransitionGroupID))
dataEventFlows = data %>% filter(!is.na(TransitionGroupID))
write_csv(dataBaseFlows, "F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-base-flows.csv")
write_csv(dataEventFlows, "F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-event-flows.csv")

# Flow Multipliers (Base flow multipliers)
data = datasheet(myProject, "stsimsf_FlowMultiplier", scenario = spinupOutputScenario)
data = data %>% mutate(StratumID = NA, SecondaryStratumID = NA)
write_csv(data, "F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-base-multipliers.csv")


############################################################################################
# State Attributes
############################################################################################

# Adjacency Attributes
myScenario <- scenario(myProject, scenario = "State Attributes [Adjacency]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_StateAttributeValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/state-attributes/state-attribute-values-adjacency.csv") 
saveDatasheet(myScenario, mySheet, sheetName)

# Carbon Initial Conditions and Net Growth Attributes
myScenario <- scenario(myProject, scenario = "State Attributes [Carbon TST]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_StateAttributeValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/state-attributes/state-attribute-values-carbon-spinup-output.csv") 
saveDatasheet(myScenario, mySheet, sheetName)

# Carbon Initial Conditions and Net Growth Attributes using age insted of TST
myScenario <- scenario(myProject, scenario = "State Attributes [Carbon Age]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_StateAttributeValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet <- read.csv("F:/national-assessment/data/state-attributes/state-attribute-values-carbon-spinup-output.csv") 
d1 = mySheet %>%
  filter(TSTGroupID == "Fire: High Severity [Type]") %>%
  group_by(StateClassID, StateAttributeTypeID) %>%
  mutate(AgeMin = TSTMin, AgeMax = TSTMax) %>%
  mutate(TSTGroupID = NA, TSTMin = NA, TSTMax = NA)
d2 = mySheet %>%
  filter(StateAttributeTypeID == "Net Growth")
mySheet1 = bind_rows(d1, d2)
saveDatasheet(myScenario, mySheet1, sheetName)

unique(mySheet$StateAttributeTypeID)
data = mySheet %>% filter(StateAttributeTypeID == "Net Growth: Atmosphere to Coarse Root")

# Merge Pathway Dependencies
myScenario <- scenario(myProject, scenario = "State Attributes [Spatial]")
mergeDependencies(myScenario) = TRUE
dependency(myScenario, c("State Attributes [Adjacency]", "State Attributes [Carbon Age]"))


############################################################################################
# Flow Pathways
############################################################################################

# Base Flows from Spin-up
myScenario <- scenario(myProject, scenario = "Flow Pathways [Spin-up; Base Flows]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsimsf_FlowPathwayDiagram"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-flow-pathways-diagram-stock.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsimsf_FlowPathway"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-base-flows.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Fire and Harvest Event Flows from Spin-up
myScenario <- scenario(myProject, scenario = "Flow Pathways [Spin-up; Event Flows]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsimsf_FlowPathwayDiagram"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-flow-pathways-diagram-stock.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsimsf_FlowPathway"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-event-flows.csv")
saveDatasheet(myScenario, mySheet, sheetName, append = T)

# Other Event Flows
myScenario <- scenario(myProject, scenario = "Flow Pathways [Other; Event Flows]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsimsf_FlowPathwayDiagram"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/cbm-cfs3/cbm-flow-pathways-diagram-stock.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsimsf_FlowPathway"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-pathways-lulc-other-non-spinup.csv")
saveDatasheet(myScenario, mySheet, sheetName, append = T)


myScenario <- scenario(myProject, scenario = "Flow Pathways [Spatial]")
mergeDependencies(myScenario) = TRUE
dependency(myScenario, c("Flow Pathways [Spin-up; Base Flows]",
                         "Flow Pathways [Spin-up; Event Flows]",
                         "Flow Pathways [Other; Event Flows]"))


############################################################################################
# Flow Order
############################################################################################

# Flow Order
myScenario <- scenario(myProject, scenario = "SF Flow Order")
sheetName <- "stsimsf_FlowOrder"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-order.csv")
saveDatasheet(myScenario, mySheet, sheetName)
sheetName <- "stsimsf_FlowOrderOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"ApplyEquallyRankedSimultaneously"] = T
saveDatasheet(myScenario, mySheet, sheetName)



############################################################################################
# Flow Multipliers
############################################################################################

# SF Flow Multipliers
myScenario <- scenario(myProject, scenario = "SF Flow Multipliers [Scalar]")
mergeDependencies(myScenario) = T
sheetName <- "stsimsf_FlowMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = addRow(mySheet, data.frame(Timestep = 2002, FlowGroupID = "Net Growth: Total", Value = 0.01))
mySheet = addRow(mySheet, data.frame(Timestep = 2002, FlowGroupID = "Q10 Fast Flows", Value = 0.01))
mySheet = addRow(mySheet, data.frame(Timestep = 2002, FlowGroupID = "Q10 Slow Flows", Value = 0.01))
saveDatasheet(myScenario, mySheet, sheetName)

# SF Flow Multipliers from Spin-up
myScenario <- scenario(myProject, scenario = "SF Flow Multipliers [Spin-up; Base]")
mergeDependencies(myScenario) = T
sheetName <- "stsimsf_FlowMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-base-multipliers.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# Merge Flow Multipliers files
myScenario <- scenario(myProject, scenario = "SF Flow Multipliers [Spatial]")
mergeDependencies(myScenario) = T
dependency(myScenario, c("SF Flow Multipliers [Scalar]",
                         "SF Flow Multipliers [Spin-up; Base]"))

############################################################################################
# Flow Spatial Multipliers
############################################################################################

# Growth spatial multiplier
indir = "F:/national-assessment/data/flow-spatial-multipliers/growth/"
gcm = "historical"
rcp = ""

myScenario <- scenario(myProject, scenario = "SF Flow Spatial Multipliers [Growth]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsimsf_FlowSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
list = list.files(path = "F:/national-assessment/data/flow-spatial-multipliers/growth/historical/", pattern = "*.tif")
mySheet = data.frame(Timestep = seq(1979,2020), FlowGroupID = "Net Growth: Total", MultiplierFileName = paste(indir,gcm,"/",rcp,list, sep=""))
saveDatasheet(myScenario, mySheet, sheetName)

# Q10 Fast Multiplier
indir = "F:/national-assessment/data/flow-spatial-multipliers/q10Fast/"
gcm = "historical"
rcp = ""

myScenario <- scenario(myProject, scenario = "SF Flow Spatial Multipliers [Q10 Fast]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsimsf_FlowSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
list = list.files(path = "F:/national-assessment/data/flow-spatial-multipliers/q10Fast/historical/", pattern = "*.tif")
mySheet = data.frame(Timestep = seq(1979,2020), FlowGroupID = "Q10 Fast Flows", MultiplierFileName = paste(indir,gcm,"/",rcp,list, sep=""))
saveDatasheet(myScenario, mySheet, sheetName)

# Q10 Slow Multiplier
indir = "F:/national-assessment/data/flow-spatial-multipliers/q10Slow/"
gcm = "historical"
rcp = ""

myScenario <- scenario(myProject, scenario = "SF Flow Spatial Multipliers [Q10 Slow]")
mergeDependencies(myScenario) = TRUE
sheetName <- "stsimsf_FlowSpatialMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
list = list.files(path = "F:/national-assessment/data/flow-spatial-multipliers/q10Slow/historical/", pattern = "*.tif")
mySheet = data.frame(Timestep = seq(1979,2020), FlowGroupID = "Q10 Slow Flows", MultiplierFileName = paste(indir,gcm,"/",rcp,list, sep=""))
saveDatasheet(myScenario, mySheet, sheetName)

# Merge Flow Spatial Multipliers
myScenario = scenario(myProject, scenario = "SF Flow Spatial Multipliers")
mergeDependencies(myScenario) = TRUE
dependency(myScenario, c("SF Flow Spatial Multipliers [Growth]", "SF Flow Spatial Multipliers [Q10 Fast]", "SF Flow Spatial Multipliers [Q10 Slow]"))


############################################################################################
# Flow Output Options (Spatial)
############################################################################################

myScenario <- scenario(myProject, scenario = "SF Output Options [Spatial]")
sheetName <- "stsimsf_OutputOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"SummaryOutputST"] = T
mySheet[1,"SummaryOutputFL"] = T
mySheet[1,"SummaryOutputSTTimesteps"] = 1
mySheet[1,"SummaryOutputFLTimesteps"] = 1
mySheet[1,"SpatialOutputST"] = T
mySheet[1,"SpatialOutputFL"] = F
mySheet[1,"SpatialOutputSTTimesteps"] = 1
mySheet[1,"SpatialOutputFLTimesteps"] = 1
saveDatasheet(myScenario, mySheet, sheetName)



############################################################################################
# Spatial Multiprocessing
############################################################################################

myScenario = scenario(myProject, scenario = "Spatial Multiprocessing")
sheetName = "corestime_Multiprocessing"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"MaskFileName"] = "F:/national-assessment/data/spatial-multiprocessing/multi-processing-regions-16.tif"
saveDatasheet(myScenario, mySheet, sheetName)

datasheet(myScenario)
