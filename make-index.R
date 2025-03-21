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
  htmltools::tags$body(
    htmltools::tags$head(
      htmltools::tags$meta(
        name = "viewport",
        content = "width=device-width, initial-scale=1.0"
      ),
      htmltools::tags$script(
        src = "https://cdn.tailwindcss.com/?plugins=forms,typography"
      )
    ),
    htmltools::tags$div(
      htmltools::tags$div(
        htmltools::h1(
          "Failing CRAN Checks",
          class = "text-2xl md:text-3xl font-mono !mb-0"
        ),
        htmltools::a(
          htmltools::tags$svg(
            xmlns = "http://www.w3.org/2000/svg",
            width = "16",
            height = "16",
            fill = "currentColor",
            class = "ms-2 text-zinc-300 hover:text-white size-6",
            viewBox = "0 0 16 16",
            htmltools::tags$path(
              d = "M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8"
            )
          ),
          href = "https://github.com/ricochet-rs/cran-checks",
          class = "hover:cursor-pointer"
        ),
        class = "flex justify-between items-center mb-6"
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


# htmltools::html_print(index_html)

htmltools::save_html(index_html, "docs/index.html", background = NULL)
