cat("Start:", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z") , "\n\n")

## Packages
cat("\n\nLoad packages\n\n")
library(dplyr)
library(purrr)
library(AVDGForex)

cat("\n\nStart Exchange Rate ETL script!\n\n")

## Get list of projects
alldbs <- activityinfo::getDatabases()

database_df <- purrr::reduce(listofdbs, dplyr::bind_rows)

db_labels <- database_df$label

## Wrap `getForex()` in `purrr::safely()` for error handling
safe_getForex <- safely(AVDGForex::getForex)

## Iterate over each project
cat("\n\nGet Forex...\n\n")
forex_raw <- map(db_labels,
    ~ safe_getForex(.x))

## Error handling for `getForex()` output...
forex_err <- map(forex_raw, "error")
forex_res <- map(forex_raw, "result")

if (length(forex_err) > 0) {
  ## Error handling code...
  ## Possibly email or other warning...
}

cat("\n\nStart clean Forex data!\n\n")
AVDGForex::cleanForex()

cat("\n\nStart visualize Forex data!\n\n")
AVDGForex::visualizeForex()

cat("\n\nDone!\n\n")

cat("\n\n End:", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z") , "\n\n")
