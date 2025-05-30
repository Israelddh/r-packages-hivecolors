# hivecolors

A custom color palette package for R, designed to provide beautiful, smooth color gradients inspired by the natural tones of a hive. Easily use discrete or continuous Hive palettes in your visualizations, with seamless integration for **ggplot2**.

![Hive Palette Bar](/figures/hive_palette_bar.png)

---

## Installation

You can install **hivecolors** directly from this GitHub repository using the following commands in your R console:

```r
if (!require("devtools")) 
  install.packages("devtools")

devtools::install_github("Israelddh/hivecolors")
library(hivecolors)
```

## Usage Examples

Scatter plot with continuous color scale using Hive palette

```r
library(ggplot2)
library(hivecolors)

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Petal.Length)) +
  geom_point(size = 3) +
  scale_color_hive()
```
![Scatter plot](/figures/Scatter.png)

Bar plot with Hive discrete palette and labels

```r
counts <- as.data.frame(table(mpg$class))
ggplot(counts, aes(x = Var1, y = Freq, fill = Var1)) +
  geom_col() +
  scale_fill_hive(discrete = TRUE) +
  geom_text(aes(label = Freq), vjust = -0.3) +
  theme_minimal() +
  labs(title = "Count of Vehicles by Class", x = "Class", y = "Count")
```
![Bar plot](/figures/Barplot.png)

Heatmap example using continuous fill scale

```r
volcano_df <- data.frame(
  x = rep(seq_len(ncol(volcano)), each = nrow(volcano)),
  y = rep(seq_len(nrow(volcano)), ncol(volcano)),
  height = as.vector(volcano)
)

ggplot(volcano_df, aes(x = x, y = y, fill = height)) +
  geom_raster() +
  scale_fill_hive()
```
![Heatmap plot](/figures/Heatmap.png)

Ridgeline density plot example

```r
ggplot(diamonds, aes(x = price, y = cut, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_gradientn(colors = hive_colors(256)) +
  theme_minimal() +
  labs(title = "Ridgeline Density Plot of Diamond Prices by Cut")

```
![Ridgeline plot](/figures/Ridgeline.png)

Discrete color scale example with boxplot and jitter

```r
ggplot(mpg, aes(x = class, y = hwy, color = class)) +
  geom_boxplot(outlier.colour = NA, alpha = 0.4, position = position_dodge(width = 0.8)) +
  geom_jitter(width = 0.2) +
  scale_color_hive(discrete = TRUE)
```
![Boxplot](/figures/Boxplot.png)

## Features
Generates smooth, perceptually uniform color palettes using a custom Hive color map.

Supports both discrete and continuous color scales.

Works natively with ggplot2 through convenient scale_color_hive(), scale_fill_hive(), and aliases.

Customizable parameters for transparency (alpha), gradient direction, and color range (begin, end).

## References
The color interpolation is inspired by well-known palettes such as viridis. The design emphasizes smooth transitions and visual accessibility for data visualization.

## Author

Israel David Duarte Herrera
israelddh@hotmail.com
2025


