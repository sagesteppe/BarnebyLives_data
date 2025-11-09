library(usethis)
library(googlesheets4)

# prepare material for authorship table.
setwd('~/Documents/assoRted/BarnebyLives_data/data-raw')
abbrevs <- read.csv('ipni_author_abbreviations.csv')

trailed <- vector(mode = 'character', length = nrow(abbrevs))
trailed[grep('\\.$', abbrevs$author_abbrevation)] <- '.'
# identify which abbreviations have a trailing period

abbrevs_spaced <- sub('\\.$', '', abbrevs$author_abbrevation) # remove the trailing periods
abbrevs_notrail <- sub('\\.(?!.*\\.)', ". ",
                       abbrevs_spaced, perl = T) # identify the last period in the name, and add a space after it

abbrevs <- paste0(abbrevs_notrail, trailed)
ipni_authors <- data.frame(x = abbrevs)

write_csv(
  ipni_authors, 
  file.path('..', 'data', 'ipni_authors.csv')
)


