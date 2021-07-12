# Setup ------------------------------------------------------------------------
library(sf)
library(ggplot2)
library(showtext)
library(extrafont)

# Get data
atl <- st_read("GC_Roads/GC_RD_GA/Roads_Atlanta_GA.shp")

# Bellevue point
bellevue <- c(33.786438268256425, -84.35381374455805)
bellevue_deg <- c("33° 47' 11.04'' N", "84° 21' 13.68'' W")


# Plot config ------------------------------------------------------------------
colours <- c("base" = "#a7b4b5", "bellevue" = "#2a698b", "background" = "#FEFDF7")

font_add("Harvey", "./harvey.otf")
showtext_auto()
extrafont::loadfonts()

fonts <- c("title" = "Harvey", "subtitle" = "Fira")


# Make the plot ----------------------------------------------------------------
atl_plot <- ggplot(atl) +
    geom_sf(colour = colours[["base"]]) +
    geom_sf(
        data = dplyr::filter(atl, NAME == "Bellevue"), 
        colour = colours[["bellevue"]], 
        size = 1.5
    ) +
    labs(
        title = "Atlanta", 
        subtitle = "2018-2020"
    ) +
    theme(
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_rect(fill = colours[["background"]]),
        panel.border = element_rect(fill = NA, size = rel(0.5)),
        panel.grid = element_blank(),
        plot.background = element_rect(fill = colours[["background"]]), 
        plot.margin = margin(20, 20, 15, 20), 
        plot.title = element_text(
            hjust = .5, 
            family = fonts[["title"]], 
            size = rel(4), 
            margin = margin(20),
            colour = colours[["bellevue"]]
        ),
        plot.subtitle = element_text(
            hjust = .5, 
            family = fonts[["subtitle"]], 
            size = rel(2), 
            margin = margin(5),
            colour = colours[["bellevue"]]
        ),        
        plot.title.position = "plot"
    )

atl_plot

# Set up printing ---------------------------------------------------------
delivery_address <- ggirl::address(
    name = "Jim Leach", 
    address_line_1 = "644 Park Place",
    address_line_2 = "Apt 1", 
    city = "Brooklyn", 
    state = "NY",
    postal_code = "11216", 
    country = "US"
)
contact_email <- "jimmy22theave@gmail.com"


ggirl::ggartprint(
    atl_plot, 
    background = colours[["background"]], 
    size = "11x14", 
    orientation = "portrait",
    contact_email = contact_email,
    address = delivery_address
    )
