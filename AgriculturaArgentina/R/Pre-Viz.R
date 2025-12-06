# USING GGPLOT FOR DATA PRE-VIZ
library(tidyverse)
library(ggplot2)

# Load data
df <- read_csv("AgriculturaArgentina/datasets/granos_argentina_1941_2023.csv", locale = locale(encoding = "Latin1")) # nolint

# Mutate a new column: rinde in qqxha instead of kgxha
df_convert <- df |> mutate(rinde_qq_ha = rendimiento_kgxha / 100) |> select(cultivo_nombre, anio, rinde_qq_ha) # nolint

# DF of historic "rinde" -------------------------------------------------------
rinde_anual_prom_x_grano <- df_convert |>
  group_by(cultivo_nombre, anio) |>
  summarise(
    # mean() calculates the average yield for the specific crop and year.
    Rinde_Promedio_qq_ha = mean(rinde_qq_ha, na.rm = TRUE),
    # Use `n()` to count the number of observations (rows) per group.
    N_Observaciones = n()
  ) |>
  ungroup()

# Create a  Plot to visualize the annual yield trend.
plot_evolucion_rendimiento <- rinde_anual_prom_x_grano |>
  ggplot(aes(x = anio, y = Rinde_Promedio_qq_ha, color = cultivo_nombre)) +
  geom_point() +
  geom_smooth() +
  labs(
    title = "Evolución Histórica del Rendimiento Promedio Anual (qq/ha)",
    x = "Year",
    y = "Average Yield (Quintales / Hectárea)",
    color = "Crop" # Legend title.
  ) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1")

# DF of year_of_interest rinde ------------------------------------------------

year_of_interest <- 2019
# Filter data with year_of_interest
df_anual <- df_convert |>
  filter(anio == year_of_interest) |>
  ungroup()

# We make two plot:

# BOXPLOT
plot_rinde_anual_granos <- df_anual |>
  ggplot(aes(x = cultivo_nombre, y = rinde_qq_ha, fill = cultivo_nombre)) +
  geom_boxplot()

# DISTRIBUTION
plot_distribucion_rinde <- df_anual |>
  ggplot(aes(x = rinde_qq_ha, fill = cultivo_nombre)) +
  geom_histogram(
    binwidth = 3,
    color = "black",
    alpha = 0.7 # Transparency helps if bars overlap.
  ) +
  # Use `facet_wrap()` to create separate histogram panels for each crop.
  # The `scales = "free_y"` allows the Y-axis (count) to adapt to each crop.
  facet_wrap(~ cultivo_nombre, scales = "free_y") +
  labs(
    title = paste("Yield distribution (qq/ha) - year", year_of_interest), # nolint
    subtitle = "Frequency",
    x = "Yield (Quintales / Hectárea)",
    y = "Frequency (Número de Observaciones/Registros)",
    fill = "Crop"
  ) +
  scale_fill_brewer(palette = "Set2")


# ================= PLOTS =================
# Yield evolution over the years for all crops:
# plot_evolucion_rendimiento + annotate("text", x = 200, y = 300, label = "--") # nolint
# print(plot_evolucion_rendimiento) # nolint
# ggsave("Yield evolution over the years.png") # nolint

# "Year_of_interest" yield:
# print(plot_rinde_anual_granos) # nolint
# ggsave("2019 Anual yields.png") # nolint


# Yield distribution:
# print(plot_distribucion_rinde) # nolint
# ggsave("Yield distribution.png") # nolint