issues <- tools::CRAN_check_issues() |>
  dplyr::arrange(Package)

n <- nrow(issues)
table_rows <- vector("list", n)

as_tr <- function(.row) {
  htmltools::tags$tr(
    htmltools::tags$td(
      htmltools::tags$a(
        .row$Package,
        href = sprintf("https://cran.r-project.org/package=%s", .row$Package),
        class = "font-mono hover:font-bold decoration-dotted decoration-indigo-500 hover:decoration-solid"
      )
    ),
    htmltools::tags$td(
      .row$Version
    ),
    htmltools::tags$td(
      htmltools::tags$a(
        .row$kind,
        href = .row$href,
        class = "decoration decoration-dotted text-zinc-200 hover:text-white font-mono decoration-rose-500 hover:decoration-solid"
      )
    )
  )
}


for (i in seq_len(n)) {
  .row <- issues[i, ]
  table_rows[[i]] <- as_tr(.row)
}

index_html <-
  htmltools::tags$html(
    htmltools::tags$head(
      htmltools::tags$meta(
        name = "viewport",
        content = "width=device-width, initial-scale=1.0"
      ),
      htmltools::tags$script(
        src = "https://cdn.tailwindcss.com/?plugins=forms,typography"
      )
    ),
    htmltools::tags$body(
      htmltools::tags$div(
        htmltools::h1(
          "Failing CRAN Checks",
          class = "text-2xl md:text-3xl font-mono"
        ),
        htmltools::div(
          htmltools::p(
            "The below packages are currently failing CRAN checks and are at risk of being archived.",
            "Use the ",
            htmltools::a(
              "GitHub Action ",
              href = "https://github.com/ricochet-rs/cran-checks?tab=readme-ov-file#usage",
              class = "font-semibold decoration-green-500 decoration-2"
            ),
            "to stay notified!"
          ),
          htmltools::p("Access check result as json via: "),
          htmltools::pre(
            "curl https://ricochet-rs.github.io/cran-checks/b64.json",
            class = "bg-zinc-800"
          ),
          htmltools::tags$details(
            htmltools::tags$summary("JSON output"),
            htmltools::pre(
              readLines("https://ricochet-rs.github.io/cran-checks/b64.json") |>
                jsonify::pretty_json(),
              class = "bg-zinc-800"
            )
          ),
          class = "text-sm border-b pb-4 border-zinc-500/50"
        ),
        htmltools::tags$table(
          htmltools::tags$thead(
            htmltools::tags$tr(
              htmltools::tags$th("Package"),
              htmltools::tags$th("Version"),
              htmltools::tags$th("Issue")
            )
          ),
          htmltools::tags$tbody(table_rows)
        ),
        htmltools::p(
          "Made with 🤍 by ",
          htmltools::a(
            "ricochet",
            href = "https://ricochet.rs",
            class = "font-mono font-bold decoration-dotted"
          ),
          " 🐇",
          class = "text-zinc-500 text-sm"
        )
      ),
      class = "bg-zinc-900 mx-auto prose-invert prose md:prose-lg my-10 px-4 lg:px-0"
    )
  )

# htmltools::html_print(index_html)

htmltools::save_html(index_html, "docs/index.html")
