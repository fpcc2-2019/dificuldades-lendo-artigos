library(tidyverse)

aula3 = read_csv(here::here("data/Lazy, not biased.csv")) %>%
    select(dificuldade = `Quão difícil foi a leitura do artigo? (não é avaliada)`) %>%
    mutate(aula = 3, ordem = 1)

aula4 = read_csv(here::here("data/Dificuldade(s) nas leituras da aula 4.csv")) %>% 
    select(starts_with("Quão fácil")) %>% 
    mutate(aula = 4)

aula4_long = aula4 %>% 
    gather(key = "artigo", value = "dificuldade", -aula) %>% 
    mutate(artigo = substr(artigo, 29, 36), 
           ordem = as.numeric(substr(artigo, 7,8))) %>% 
    select(-artigo)

aula5 = read_csv(here::here("data/Leituras da aula 5.csv")) %>% 
    select(starts_with("Quão difícil"), -ends_with("[Feedback]"), -ends_with("[Score]")) %>%
    mutate(aula = 5)

aula5_long = aula5 %>% 
    gather(key = "artigo", value = "dificuldade", -aula) %>% 
    mutate(artigo = substr(artigo, 38, 45), 
           ordem = as.numeric(substr(artigo, 7,8))) %>% 
    select(-artigo)

artigos = tribble(~ aula, ~ordem, ~ titulo,
                  3,       1, "lazy, not biased",
                  4,       1, "hypergraph models",
                  4,       2, "anthropographics", 
                  4,       3, "linux file systems", 
                  5,       1, "terremotos",
                  5,       2, "CAP", 
                  5,       3, "tensorflow")


bind_rows(aula3, aula4_long, aula5_long) %>% 
    left_join(artigos) %>% 
    write_csv(here::here("data/dificuldades-reportadas.csv"))
