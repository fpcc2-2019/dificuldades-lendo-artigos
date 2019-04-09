read_projectdata <- function() {
    readr::read_csv(
        here::here("data/dificuldades-reportadas.csv"),
        col_types = cols(
            dificuldade = col_double(),
            aula = col_double(),
            ordem = col_double(),
            titulo = col_character()
        )
    ) %>% 
        filter(!is.na(dificuldade))
}
