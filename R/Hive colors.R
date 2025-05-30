# hivecolors.R

# Hive Color Palette Utilities
# Author: Israel David Duarte Herrera
# Date: 2025
#
# This script defines a custom color palette called "Hive",
# designed for both discrete and continuous applications,
# including seamless integration with ggplot2.
#
# Inspired by palettes like viridis


# Define the base color map (hex codes)
hive_color_map <- c(
  "#003366",
  "#006699",
  "#3399CC",
  "#66CC99",
  "#99CC33",
  "#FFCC00",
  "#FF6600",
  "#CC3300"
)


#' Generate Hive Colors
#'
#' @description Generate a vector of n colors interpolated along the Hive color map.
#'
#' @param n Number of colors to generate (≥1).
#' @param alpha Transparency level, between 0 (transparent) and 1 (opaque).
#' @param begin Fractional start point along the palette (0 = start, 1 = end).
#' @param end Fractional end point along the palette.
#' @param direction Direction of the gradient: 1 (default) = forward, -1 = reversed.
#'
#' @return Character vector of hex color codes.
#' @export
hive_colors <- function(n, alpha = 1, begin = 0, end = 1, direction = 1) {
  if (n <= 0) {
    return(character(0))
  }
  if (begin < 0 || begin > 1 || end < 0 || end > 1) {
    stop("begin and end must be within [0, 1]")
  }
  if (!direction %in% c(1, -1)) {
    stop("direction must be either 1 (forward) or -1 (reversed)")
  }

  # Reverse range if needed
  if (direction == -1) {
    temp <- begin
    begin <- end
    end <- temp
  }

  # Create color interpolation function in Lab color space (smooth transitions)
  ramp <- grDevices::colorRamp(hive_color_map, space = "Lab", interpolate = "spline")

  # Generate n points between begin and end
  values <- seq(begin, end, length.out = n)

  # Get RGB values scaled between 0–1
  rgb_matrix <- ramp(values) / 255

  # Convert to hex colors with alpha applied
  grDevices::rgb(rgb_matrix[, 1], rgb_matrix[, 2], rgb_matrix[, 3], alpha = alpha)
}


#' Hive Palette Generator (for ggplot2 discrete scales)
#'
#' @description Returns a palette function usable inside ggplot2's discrete_scale().
#'
#' @param alpha Transparency level.
#' @param begin Start point.
#' @param end End point.
#' @param direction Gradient direction.
#'
#' @return Function(n) that generates n hex colors.
#' @export
hive_palette <- function(alpha = 1, begin = 0, end = 1, direction = 1) {
  function(n) {
    hive_colors(n, alpha = alpha, begin = begin, end = end, direction = direction)
  }
}


#' ggplot2 Fill Scale using Hive Colors
#'
#' @description Apply the Hive palette to the ggplot2 fill aesthetic.
#'
#' @param ... Additional parameters for scale functions.
#' @param alpha Transparency.
#' @param begin Start point.
#' @param end End point.
#' @param direction Gradient direction.
#' @param discrete If TRUE, uses discrete scale; if FALSE, uses continuous gradient.
#'
#' @return A ggplot2 scale object.
#' @export
scale_fill_hive <- function(..., alpha = 1, begin = 0, end = 1, direction = 1, discrete = FALSE) {
  if (discrete) {
    ggplot2::discrete_scale("fill", "hive", hive_palette(alpha, begin, end, direction), ...)
  } else {
    ggplot2::scale_fill_gradientn(colors = hive_colors(256, alpha, begin, end, direction), ...)
  }
}


#' ggplot2 Color Scale using Hive Colors
#'
#' @description Apply the Hive palette to the ggplot2 color (line/point) aesthetic.
#'
#' @param ... Additional parameters for scale functions.
#' @param alpha Transparency.
#' @param begin Start point.
#' @param end End point.
#' @param direction Gradient direction.
#' @param discrete If TRUE, uses discrete scale; if FALSE, uses continuous gradient.
#'
#' @return A ggplot2 scale object.
#' @export
scale_color_hive <- function(..., alpha = 1, begin = 0, end = 1, direction = 1, discrete = FALSE) {
  if (discrete) {
    ggplot2::discrete_scale("colour", "hive", hive_palette(alpha, begin, end, direction), ...)
  } else {
    ggplot2::scale_color_gradientn(colors = hive_colors(256, alpha, begin, end, direction), ...)
  }
}

# Alias for UK spelling
#' @rdname scale_color_hive
#' @export
scale_colour_hive <- scale_color_hive



