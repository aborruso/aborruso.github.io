# Istruzioni per agenti AI su questo repository Quarto

## Architettura generale
- Il sito è generato con [Quarto](https://quarto.org/), usando file `.qmd` e `.md` come sorgente.
- La configurazione principale è in `_quarto.yml`.
- I contenuti sono organizzati in directory come `posts/`, `til/`, `garage/`, e file principali come `index.qmd`, `blog.qmd`, `til.qmd`.
- Le estensioni Quarto sono in `_extensions/`.
- La cartella `docs/` contiene l'output statico del sito (HTML, CSS, XML, ecc.).

## Workflow di sviluppo
- Per generare il sito statico, usa il comando Quarto:
  ```zsh
  quarto render
  ```
- Per visualizzare il sito localmente:
  ```zsh
  quarto preview
  ```
- I file in `docs/` vengono aggiornati automaticamente dal build Quarto.

## Convenzioni e pattern
- Ogni post o pagina è un file `.qmd` o `.md` in una sottocartella dedicata.
- I metadati globali dei post sono in `posts/_metadata.yml` e `til/_metadata.yml`.
- Gli stili personalizzati sono in `styles.css`.
- Le immagini e risorse statiche sono in `images/` e `risorse/`.
- Per includere snippet o template, usa la cartella `include/`.
- Le estensioni Quarto sono gestite in `_extensions/` e possono essere aggiornate tramite Quarto CLI.

## Dipendenze e integrazioni
- Non sono presenti dipendenze Python, Node.js o altri package manager: tutto è gestito da Quarto.
- Alcuni post possono includere codice R, Python o Bash, ma non sono richieste dipendenze globali.

## Esempi di pattern
- Un nuovo post si aggiunge creando una sottocartella in `posts/` con un file `.qmd`.
- Per aggiungere una tabella Python, vedi `include/_table-python.qmd`.
- Per estensioni custom, vedi `_extensions/quarto-ext/`.

## Note
- Non modificare direttamente i file in `docs/`: sono generati automaticamente.
- Mantieni la struttura delle directory per una navigazione ordinata.
- Aggiorna `_quarto.yml` per modifiche globali di configurazione.

---
Queste istruzioni sono pensate per agenti AI che automatizzano task di sviluppo, build e manutenzione su questo sito Quarto.
