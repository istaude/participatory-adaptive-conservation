source("r_scripts_forpub/00-preamble.R")


# where are rl gartendiv observations in germany? ------------------------------

# load gartendiv observation counts
shp <- readRDS("data_forpub/counts_germany.rds")

# get germany boundary
germany_sf <- rnaturalearth::ne_countries(country = "Germany", 
                                          scale = "medium", returnclass = "sf")
germany_utm <- st_transform(germany_sf, 32632)

shp_plot <- shp %>%
  mutate(
    counts_occ = if_else(!is.na(n_rl_occ) & n_rl_occ > 0, as.numeric(n_rl_occ), NA_real_),
    counts_spec  = if_else(!is.na(n_rl_species) & n_rl_species > 0, as.numeric(n_rl_species), NA_real_)
  )


max_rl <- max(shp_plot$counts_spec, na.rm = TRUE)
breaks_rl <- c(1, 2, 5, 10, 20, 50, 100, 200, 500, 1000)
breaks_rl <- breaks_rl[breaks_rl <= max_rl]

(ggplot(shp_plot) +
    geom_sf(
      fill = "grey80",
      color = NA
    ) +
    geom_sf(
      aes(fill = counts_spec),
      color = "white",
      linewidth = 0
    ) +
    scale_fill_viridis_c(
      option = "mako",
      trans = "log10",
      breaks = breaks_rl,
      labels = scales::comma,
      na.value = "grey80",
      name = "N threatened spp.\nin gardens",
      guide = guide_colourbar(
        title.position = "left",
        barheight = unit(0.4, "cm"),
        barwidth  = unit(4.5, "cm"),
        frame.colour = NA,
        ticks.colour = "grey80"
      )
    ) +
    coord_sf(expand = FALSE) +
    theme_void(base_family = font_family, base_size = 14) +
    theme(
      plot.title = element_text(face = "bold"),
      legend.position = "bottom",
      legend.box = "horizontal",
      legend.title = element_text(size = 12, color = "#444444", vjust = .9),
      legend.text = element_text(size = 9),
      legend.key.height = unit(0.4, "cm"),
      legend.key.width  = unit(0.8, "cm"),
      legend.spacing.x = unit(0.3, "cm")
    ) -> fig1_panel_a
)


# plot the number of species in each category -----------------------------

df <- read.csv("data_forpub/rl_freqs.csv")

# color scheme
vir_cols <- viridisLite::viridis(length(rl_levels), option = "mako", begin = 0.1, end = 0.8)


(
  ggplot(df, aes(x = rl_cat2, y = n, color = rl_cat2)) +
    # stick
    geom_segment(aes(xend = rl_cat2, y = 0, yend = n),
                 linewidth = .7, show.legend = FALSE) +
    # head
    geom_point(size = 6, show.legend = FALSE) +
    # labels to the right of the head
    geom_text(
      aes(label = paste0(n, " (", perc, ")"), y = n),
      vjust = -1.5,
      family = "roboto_condensed",
      fontface = "italic",
      size = 4
    ) +
    expand_limits(y = max(df$n) * 1.15) +
    scale_color_manual(values = setNames(vir_cols, rl_levels), guide = "none") +
    labs(x = "", y = "N species") +
    theme_minimal(base_size = 14, base_family = "roboto_condensed") +
    theme(
      panel.grid.minor.x = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.y = element_blank(),
      plot.title = element_text(face = "bold"),
      plot.margin = margin(10, 10, 10, 10),
      axis.title = element_text(color = "#444444")
    ) -> fig1_panel_b
)


# multipanel
(fig1_panel_a + fig1_panel_b) +
  plot_annotation(
    tag_levels = 'a', 
    theme = theme(
      plot.tag = element_text(
        family = "roboto_condensed",
        face = "bold",
        size = 14,
        color = "#333333"
      )
    )
  )



# do gardens give species a head start? -----------------------------------


# this file contains species that occurred in gardens northward of their historic range
polewards <- read.csv("data_forpub/polewards.csv")

# this can now be plotted
(
  ggplot(polewards, aes(x = poleward_shift)) +
    geom_histogram(
      bins = 40,
      fill = viridis(1, option = "mako", begin = 0.2, end = 0.8, alpha = 0.85),
      color = viridis(1, option = "mako", begin = 0.2, end = 0.8, alpha = 0.85),
      linewidth = 0.2
    ) +
    
    labs(
      x = "Northward head start of garden records (° latitude)",
      y = "N observations"
    ) +
    
    theme_minimal(base_size = 14, base_family = "roboto_condensed") +
    theme(
      axis.title.x = element_text(color = "#444444"),
      axis.title.y = element_text(color = "#444444"),
      axis.text.x  = element_text(color = "#444444"),
      axis.text.y  = element_text(color = "#444444"),
      panel.grid.minor = element_blank(),
      plot.margin = margin(l = 40, r = 40, b = 10),
      legend.position = "none"
    ) -> fig2_panel_a
)

# Salix myrtilloides
# loads historic range data and scrambled GartenDiv occurrences for the species
spec <- readRDS("data_forpub/salixm_historical_range.rds")
spec_pts <- readRDS("data_forpub/salixm_gartendiv.rds")

(
  ggplot() +
    geom_sf(
      data = spec_pts,
      color = viridis(1, option = "mako", begin = 0.1),
      size = 2,
      alpha = 0.9
    ) +
    geom_sf(data = germany_sf, fill = NA, color = "black", size = 0.3) +
    geom_sf(data = spec,
            aes(fill = OP), 
            color = NA,
            alpha = 0.9) +
    
    scale_fill_viridis_c(option = "mako", begin = 0.4, end = 0.9,
                         na.value = NA,
                         name = expression(p[occ])) +
    
    coord_sf() +
    labs(title = "Salix myrtilloides",
         subtitle = "up to 1.37° north",
         caption = "Red List Category: CR") +
    theme_void(base_size = 14, base_family = "roboto_condensed") +
    theme(
      legend.position   = "bottom",
      legend.box        = "horizontal",
      legend.title      = element_text(size = 12, color = "#444444", vjust = .9),
      legend.text       = element_text(size = 9),
      legend.key.height = unit(0.4, "cm"),
      legend.key.width  = unit(0.8, "cm"),
      legend.spacing.x  = unit(0.3, "cm"),
      legend.margin      = margin(t = 0, r = 0, b = 0, l = 10),
      legend.box.margin  = margin(t = 5, r = 0, b = 0, l = 0), 
      plot.title = element_text(face = "italic", color = "#444444"),
      plot.subtitle = element_text( color = "#444444"),
      plot.caption = element_text( color = "#444444"),
      plot.margin = margin(r = 40)
    ) -> fig2_panel_b
)



# Aster amellus
# loads historic range data and scrambled GartenDiv occurrences for the species
spec <- readRDS("data_forpub/astera_historical_range.rds")
spec_pts <- readRDS("data_forpub/astera_gartendiv.rds")

(
  ggplot() +
    geom_sf(
      data = spec_pts,
      color = viridis(1, option = "mako", begin = 0.1),
      size = 2,
      alpha = 0.9
    ) +
    geom_sf(data = germany_sf, fill = NA, color = "black", size = 0.3) +
    geom_sf(data = spec,
            aes(fill = OP), 
            color = NA,
            alpha = 0.9) +
    
    scale_fill_viridis_c(option = "mako", begin = 0.4, end = 0.9,
                         na.value = NA,
                         name = expression(p[occ])) +
    
    coord_sf() +
    labs(title = "Aster amellus",
         caption = "Red List Category: VU",
         subtitle = "up to 0.34° north",) +
    theme_void(base_size = 14, base_family = "roboto_condensed") +
    theme(
      legend.position   = "bottom",
      legend.box        = "horizontal",
      legend.title      = element_text(size = 12, color = "#444444", vjust = .9),
      legend.text       = element_text(size = 9),
      legend.key.height = unit(0.4, "cm"),
      legend.key.width  = unit(0.8, "cm"),
      legend.spacing.x  = unit(0.3, "cm"),
      legend.margin      = margin(t = 0, r = 0, b = 0, l = 10),
      legend.box.margin  = margin(t = 5, r = 0, b = 0, l = 0) ,
      plot.title = element_text(face = "italic", color = "#444444"),
      plot.subtitle = element_text( color = "#444444"),
      plot.caption = element_text( color = "#444444"),
      plot.margin = margin(l = 40)
    ) -> fig2_panel_c
)



fig2_panel_a /
  (fig2_panel_b  +fig2_panel_c) +
  plot_annotation(
    tag_levels = 'a',  # automatically labels A, B, C, D
    theme = theme(
      plot.tag = element_text(
        family = "roboto_condensed",
        face = "bold",
        size = 14,
        color = "#333333"
      )
    )
  )
