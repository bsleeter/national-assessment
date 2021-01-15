



library(raster)
library(tidyverse)
library(rsyncrosim)
library(sf)
library(fasterize)

# Create a simple ST-Sim library which will calculate spatial initial conditions maps from non-spatial input
SyncroSimDir <- "C:/Program Files/SyncroSim/"
mySession <- session(SyncroSimDir)

ssimDir = "F:/national-assessment/models/"

myLibrary = ssimLibrary(name = paste0(ssimDir,"Initial Stocks Model Conus.ssim"), session = mySession)
#myLibrary = ssimLibrary(name = paste0(ssimDir,"Initial Stocks Model.ssim"), session = mySession)
myProject = project(myLibrary, project="Initial Stocks")



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















########################
# Definitions (ST-Sim) #
########################
# ST-Sim Terminology
sheetName <- "stsim_Terminology"
mySheet <- datasheet(myProject, name=sheetName)
mySheet$AmountLabel[1] <- "Area"
mySheet$AmountUnits[1] <- "Hectares"
mySheet$StateLabelX[1] <- "LULC"
mySheet$StateLabelY[1] <- "Subclass"
mySheet$PrimaryStratumLabel[1] <- "Ecological Boundary"
mySheet$SecondaryStratumLabel[1] <- "Administrative Boundary"
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

#ST-Sim Age Type
sheetName <- "stsim_AgeType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet[1,"Frequency"] <- 1
mySheet[1,"MaximumAge"] <- 300
saveDatasheet(myProject, mySheet, name=sheetName)

#ST-Sim Age Group
sheetName <- "stsim_AgeGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet[1:(maxAge/20),"MaximumAge"] <- c(seq(from=20, to=(maxAge-1), by=20), maxAge-1)
saveDatasheet(myProject, mySheet, name=sheetName)

#ST-Sim Attribute Groups
sheetName <- "stsim_AttributeGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/state-attribute-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

#ST-Sim Attribute Types
sheetName <- "stsim_StateAttributeType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/state-attribute-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

#SF Stock Types
sheetName <- "stsimsf_StockType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/stock-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

#SF Stock Groups
sheetName <- "stsimsf_StockGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/stock-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)

#SF Flow Types
sheetName <- "stsimsf_FlowType"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/flow-type.csv")
saveDatasheet(myProject, mySheet, name=sheetName)

#SF Flow Groups
sheetName <- "stsimsf_FlowGroup"
mySheet <- datasheet(myProject, name=sheetName, optional=T)
mySheet = read.csv("F:/national-assessment/data/definitions/flow-group.csv")
saveDatasheet(myProject, mySheet, name=sheetName, append=T)



# NB: No transitions for now

####################################
# Sub-scenario datasheets (ST-Sim) #
####################################

# ST-Sim Run Control
maxTimestep <- 1
maxIteration <- 1
minTimestep <- 0
minIteration <- 1
myScenario <- scenario(myProject, scenario <- paste0("Run Control [Spatial; ", maxTimestep, " years; ", maxIteration, " MC]"))
sheetName <- "stsim_RunControl"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"MinimumIteration"] <- minIteration
mySheet[1,"MaximumIteration"] <- maxIteration
mySheet[1,"MinimumTimestep"] <- minTimestep
mySheet[1,"MaximumTimestep"] <- maxTimestep
mySheet[1,"IsSpatial"] <- T
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim Transition Pathways
myScenario <- scenario(myProject, scenario <- "Pathway Diagram")
sheetName <- "stsim_DeterministicTransition"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/definitions/pathway-diagram-deterministic.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# CONUS Model
myScenario <- scenario(myProject, scenario = "Initial Conditions [Spatial; Imputed Age]")
sheetName <- "stsim_InitialConditionsSpatial"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1, "StratumFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-ecoregion.tif"
mySheet[1, "SecondaryStratumFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-states.tif"
mySheet[1, "TertiaryStratumFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-land-managers.tif"
mySheet[1, "StateClassFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-state-class.tif"
mySheet[1, "AgeFileName"] <- "F:/national-assessment/data/initial-conditions/final/ic-imputed-age.tif"
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim Output options
myScenario <- scenario(myProject, scenario = "Output Options [Spatial]")
sheetName <- "stsim_OutputOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1, "SummaryOutputSC"] <- T
mySheet[1, "SummaryOutputSCTimesteps"] <- 1
mySheet[1, "SummaryOutputSCZeroValues"] <- F
mySheet[1, "SummaryOutputTR"] <- F
mySheet[1, "SummaryOutputTRTimesteps"] <- 1
mySheet[1, "SummaryOutputTRIntervalMean"] <- F
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim State Attribute Values
myScenario <- scenario(myProject, scenario = "State Attributes Spin-up [Net Growth]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_StateAttributeValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/state-attributes/state-attributes-spin-up-net-growth.csv") 
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim State Attribute Values
myScenario <- scenario(myProject, scenario = "State Attributes Spin-up [Fire]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_StateAttributeValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/state-attributes/state-attributes-spin-up-fire.csv") 
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim State Attribute Values
myScenario <- scenario(myProject, scenario = "State Attributes Spin-up [Harvest]")
mergeDependencies(myScenario) = T
sheetName <- "stsim_StateAttributeValue"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/state-attributes/state-attributes-spin-up-harvest.csv") 
saveDatasheet(myScenario, mySheet, sheetName)

# ST-Sim State Attribute Values
myScenario <- scenario(myProject, scenario = "State Attributes Spin-up Fire")
mergeDependencies(myScenario) = T
dependency(myScenario, c("State Attributes Spin-up [Net Growth]", "State Attributes Spin-up [Fire]"))

# ST-Sim State Attribute Values
myScenario <- scenario(myProject, scenario = "State Attributes Spin-up Harvest")
mergeDependencies(myScenario) = T
dependency(myScenario, c("State Attributes Spin-up [Net Growth]", "State Attributes Spin-up [Harvest]"))







# SF Initial Stocks
myScenario <- scenario(myProject, scenario = "SF Initial Stocks [Non Spatial]")
sheetName <- "stsimsf_InitialStockNonSpatial"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/initial-stocks-non-spatial.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# SF Flow Pathways Diagram
myScenario <- scenario(myProject, scenario = "Flow Pathways")
sheetName <- "stsimsf_FlowPathwayDiagram"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-pathway-diagram.csv")
saveDatasheet(myScenario, mySheet, sheetName)


myScenario <- scenario(myProject, scenario = "Flow Pathways")
sheetName <- "stsimsf_FlowPathway"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-base-flows.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# SF Flow Multipliers
myScenario <- scenario(myProject, scenario = "Flow Multipliers")
sheetName <- "stsimsf_FlowMultiplier"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-pathways-spinup-base-multipliers.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# SF Stock Group Membership
myScenario <- scenario(myProject, scenario = "SF Stock Group Membership")
sheetName <- "stsimsf_StockTypeGroupMembership"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/stock-type-group-membership.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# SF Flow Group Membership
myScenario <- scenario(myProject, scenario = "SF Flow Group Membership")
sheetName <- "stsimsf_FlowTypeGroupMembership"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-type-group-membership.csv")
saveDatasheet(myScenario, mySheet, sheetName)

# SF Flow Flow Order
myScenario <- scenario(myProject, scenario = "SF Flow Order")
sheetName <- "stsimsf_FlowOrder"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet = read.csv("F:/national-assessment/data/stock-flow-model/flow-order.csv")
saveDatasheet(myScenario, mySheet, sheetName)

myScenario <- scenario(myProject, scenario = "SF Flow Order")
sheetName <- "stsimsf_FlowOrderOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"ApplyEquallyRankedSimultaneously"] = T
saveDatasheet(myScenario, mySheet, sheetName)

# SF Output Options
myScenario <- scenario(myProject, scenario = "SF Output Options")
sheetName <- "stsimsf_OutputOptions"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"SummaryOutputST"] = T
mySheet[1,"SummaryOutputFL"] = T
mySheet[1,"SummaryOutputSTTimesteps"] = 1
mySheet[1,"SummaryOutputFLTimesteps"] = 1
mySheet[1,"SpatialOutputST"] = T
mySheet[1,"SpatialOutputFL"] = T
mySheet[1,"SpatialOutputSTTimesteps"] = 1
mySheet[1,"SpatialOutputFLTimesteps"] = 1
saveDatasheet(myScenario, mySheet, sheetName)

# Spatial Multiprocessing
myScenario = scenario(myProject, scenario = "Spatial Multiprocessing")
sheetName = "corestime_Multiprocessing"
mySheet <- datasheet(myScenario, name = sheetName, empty = T, optional = T)
mySheet[1,"MaskFileName"] = "F:/national-assessment/data/spatial-multiprocessing/multi-processing-regions-16.tif"
saveDatasheet(myScenario, mySheet, sheetName)

datasheet(myScenario)




#############################
# Full scenarios (STSim SF) #
#############################
myScenarioName <- "Initial Spatial Stock Simulation Fire [Imputed Age]"
myScenario = scenario(myProject, scenario = myScenarioName)
dependency(myScenario, 
           c("Run Control [Spatial; 1 years; 1 MC]",
             "Pathway Diagram",
             "Initial Conditions [Spatial; Imputed Age]",
             "Output Options [Spatial]",
             "State Attributes Spin-up [Net Growth]",
             "State Attributes Spin-up Fire",
             "Flow Pathways",
             "Flow Multipliers",
             "SF Initial Stocks [Non Spatial]",
             "SF Output Options",
             "SF Flow Order",
             "SF Stock Group Membership",
             "SF Flow Group Membership",
             "Spatial Multiprocessing"))

myScenarioName <- "Initial Spatial Stock Simulation Harvest [Imputed Age]"
myScenario = scenario(myProject, scenario = myScenarioName)
dependency(myScenario, 
           c("Run Control [Spatial; 1 years; 1 MC]",
             "Pathway Diagram",
             "Initial Conditions [Spatial; Imputed Age]",
             "Output Options [Spatial]",
             "State Attributes Spin-up [Net Growth]",
             "State Attributes Spin-up Harvest",
             "Flow Pathways",
             "Flow Multipliers",
             "SF Initial Stocks [Non Spatial]",
             "SF Output Options",
             "SF Flow Order",
             "SF Stock Group Membership",
             "SF Flow Group Membership",
             "Spatial Multiprocessing"))

datasheet(myScenario)





##############################
# Get Carbon Stock Maps from Initial Stocks Simulation and write to disk
##############################

#fxn to execute a conditional statement
Con=function(condition, trueValue, falseValue){
  return(condition * trueValue + (!condition)*falseValue)
}

# Read in datasheet with stock type names
rdf = datasheet(myProject, "stsimsf_OutputSpatialStockGroup", scenario = 25) %>% filter(Timestep == 0)
filesnames = rdf$StockGroupID %>% str_remove(":")

# Read in Stock maps for Fire Scenario
rFire = datasheetRaster(myProject, scenario = 25, datasheet = "stsimsf_OutputSpatialStockGroup", timestep = 0)
names(rFire) = rdf$Filename
writeRaster(rFire, filename = paste0("F:/national-assessment/data/initial-stocks/imputed/fire/", filesnames, ".tif"), format="GTiff", overwrite=TRUE, bylayer=TRUE, NAflag=0)

# Read in Stock maps for Harvest scenario
rHarvest = datasheetRaster(myProject, scenario = 26, datasheet = "stsimsf_OutputSpatialStockGroup", timestep = 0)
names(rHarvest) = rdf$Filename
writeRaster(rHarvest, filename = paste0("F:/national-assessment/data/initial-stocks/imputed/harvest/", filesnames, ".tif"), format="GTiff", overwrite=TRUE, bylayer=TRUE, NAflag=0)

# Create Fire history map
# nifc = st_read("I:/GIS-Vector/Fire/NIFC/Interagency_Fire_Perimeter_History_All_Years_Read_Only-shp/InteragencyFirePerimeterHistory.shp")
# nifc = st_transform(nifc, crs=crs(eco))
# nifc$FIRE_YEAR = as.numeric(as.character(nifc$FIRE_YEAR))
# str(nifc)
# nifcHistorical = nifc %>% filter(FIRE_YEAR < 2001)
# 
# nifcRaster = fasterize(nifcHistorical, eco, background = 0)
# nifcRaster = mask(nifcRaster, eco)
# plot(nifcRaster)
nifcRaster = raster("F:/national-assessment/data/initial-stocks/nifc_mask.tif")
# writeRaster(nifcRaster, "F:/national-assessment/data/initial-stocks/nifc_mask.tif", overwrite=T)


# Apply conditional statement to create merged carbon stock maps based on fire history
newraster = Con(nifcRaster == 1, rFire, rHarvest)
names(newraster) = rdf$Filename
plot(newraster$stkg_385.it1.ts0.tif)
writeRaster(newraster, filename = paste0("F:/national-assessment/data/initial-stocks/imputed/merged/", filesnames, ".tif"), format="GTiff", overwrite=TRUE, bylayer=TRUE, NAflag=0)


