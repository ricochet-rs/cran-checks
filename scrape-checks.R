library(dplyr)


cli::cli_alert_info("Fetching check results from CRAN")
results <- tools::CRAN_check_results() |>
  dplyr::as_tibble()


cli::cli_alert_info("Reshaping or json")
check_long <- results |>
  dplyr::rename_with(heck::to_snek_case) |>
  dplyr::rename(check_status = status) |>
  tidyr::nest(results = -c("package", "maintainer", "priority"))

# split by row
splits <- split(check_long, check_long$package)
# convert each row to json
cli::cli_alert_info("Converting checks to json")

pkg_check_status <- lapply(
  splits,
  \(.x) jsonify::to_json(unclass(.x), unbox = TRUE)
)

cli::cli_alert_info("Writing json files")

# write the results to json
for (pkg in names(pkg_check_status)) {
  fp <- file.path("docs", paste0(pkg, ".json"))
  writeLines(pkg_check_status[[pkg]], fp)
}
