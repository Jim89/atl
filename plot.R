# Setup ------------------------------------------------------------------------
library(sf)
library(ggplot2)
library(showtext)

# Get data
atl <- st_read("GC_Roads/GC_RD_GA/Roads_Atlanta_GA.shp")

# Plot config ------------------------------------------------------------------
font_add("Harvey", "./harvey.otf")
font_add("Free", "/usr/share/fonts/truetype/freefont/FreeMono.ttf")
showtext_auto()

fonts <- c("title" = "Harvey", "subtitle" = "Free")

colours <- c(
    base = "#a7b4b5", 
    bellevue = "#2a698b", 
    background = "#FEFDF7",
    title = "#206487",
    subtitle = "black"
    )

# Make the plot ----------------------------------------------------------------
# Example
# eg_plot <- ggirl::ggartprint_example_map("Seattle", "Washington")

atl_plot <- ggplot(atl) +
    geom_sf(colour = colours[["base"]], alpha = .75) +
    geom_sf(
        data = dplyr::filter(atl, NAME == "Bellevue"), 
        colour = colours[["bellevue"]], 
        size = 1.5
    ) +
    labs(
        title = "Atlanta", 
        subtitle = "2018 - 2020"
    ) +
    theme_grey(60) +
    theme(
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_rect(fill = colours[["background"]]),
        panel.border = element_rect(fill = NA, size = rel(0.5), colour = "black"),
        panel.grid = element_blank(),
        plot.background = element_rect(fill = colours[["background"]]), 
        #plot.margin = margin(10, 10, 10, 10), 
        plot.title = element_text(
            hjust = .5, 
            family = fonts[["title"]], 
            size = rel(3.5), 
            margin = margin(20),
            colour = colours[["title"]]
        ),
        plot.subtitle = element_text(
            hjust = .5, 
            family = fonts[["subtitle"]], 
            size = rel(1.5), 
            margin = margin(b = 5),
            colour = colours[["bellevue"]]
        ),        
        plot.title.position = "plot"
    )

ggirl::ggartprint_preview(atl_plot, "11x14", "portrait")

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

ggsave("atl.png", atl_plot)

