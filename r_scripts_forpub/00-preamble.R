# Data handling & wrangling
library(dplyr)
library(tidyr)
library(readr)
library(readxl)
library(data.table)
library(stringr)
library(forcats)
library(lubridate)

# Spatial data
library(sf)
library(osmdata)
library(osmextract)
library(rnaturalearth)
library(rnaturalearthdata)
library(stars)
library(terra)

# Visualization
library(ggplot2)
library(ggforce)
library(viridis)
library(plotly)
library(scales)
library(patchwork)

# Plant taxonomy / biodiversity data
library(flora)
library(rWCVP)
library(rWCVPdata)

# I/O and web interaction
library(httr)
library(jsonlite)
library(writexl)
library(htmlwidgets)

# Font management
library(showtext)
font_add_google("Roboto Condensed", "roboto_condensed")
showtext_auto()

# Conflict management
library(conflicted)

conflict_prefer("select",   "dplyr")
conflict_prefer("filter",   "dplyr")
conflict_prefer("lag",      "dplyr")
conflict_prefer("count",    "dplyr")
conflict_prefer("mutate",   "dplyr")
conflict_prefer("summarize","dplyr")
conflict_prefer("arrange",  "dplyr")
conflict_prefer("layout",   "plotly")
conflict_prefer("year", "lubridate")
