## Shiny Demo

### Background

This project utilizes refactored, simplified code from a client deliverable to highlight typical frontend and backend of a Shiny app.

Client worked in the Ministry of Health of Canada. They had a series of limnological data, alongside weather metrics, that would predict E. Coli levels. They relied on private and public data collection. 

This demo uses public APIs to fetch data, alongside set intervals of environmental data, to feed into a bayesian net model. This uses the package `bnlearn`.

From there, a probability is returned which informs the end user on E. Coli levels above safe thresholds. 

> This app is for demo purposes. Most of the code is repurposed and restructure. For instance, helper functions are not contained and instead altogether with one main server logic. In production, this app was heavily modularized and had a very clean mental model. Table and charting design followed a brand standard that was removed for the sake of public demoing.

### Highlights

- html static components, such as masthead, homebody, svg cards
- utilizes `shiny.router` to improve on SPA user interaction and flow
- utilizes `shinyjs` to intuit usability by showing and hiding UI
- leans on scss styling to nudge user interaction
- modularizes each region's server logic with `session$id`
- utilizes namespacing to reduce redundant code
- utilizes `rhino` for file structuring
- Reproducible examples are key in my development workflow. These are included under /reprex. These might need to be pulled out of the `rhino` file system to run correctly.

### To Run App:

- Ensure dependencies/lockfile snapshot are loaded
- if styling isn't showing up, rebuild with `rhino::build_sass`
- run with `shiny::runApp()`