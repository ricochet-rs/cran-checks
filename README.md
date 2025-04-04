# CRAN Checks

Provides daily updates on the CRAN check status of every package on CRAN for every flavor. CRAN package checks are available as a json file at `https://ricochet-rs.github.io/cran-checks/{pkg}.json`.

This repository contains a GitHub Action that can be used to get daily updates of the check status of your package. If your package is ever failing a check, you will get an email notification from GitHub of this failure.

## Usage


### Using {usethis}
Create a new GitHub Action with 

```r
usethis::use_github_action(
  url = "https://github.com/ricochet-rs/cran-checks/blob/main/check-pkg/cran-checks.yaml",
  open = TRUE
)
```

Be sure to change the **`pkg`**  input to the name of your package.


### Manually

Or, create the file manually. Create a file `.github/workflows/cran-checks.yaml`.

Paste the below in the file. 

```yaml
name: Check CRAN status

on:
  schedule:
    # Runs daily at 4:00 PM UTC (9:00 AM PST)
    - cron: '0 16 * * *'  
  # allows for manually running of the check
  workflow_dispatch:

jobs:
  check_cran_status:
    runs-on: ubuntu-latest

    steps:
      - name: Get CRAN checks
        uses: ricochet-rs/cran-checks/check-pkg@main
        with:
          pkg: YOUR-PKG-NAME
```


## Details

Each morning at 15:00 UTC (08:00 PST), [CRAN checks by package](https://cran.r-project.org/web/checks/check_summary_by_package.html) page is downloaded and processed into json. 

The json is served on GitHub pages so that it can be accessed as a pseudo-API.

The workflow `ricochet-rs/cran-checks/check-pkg` fetches the json and identifies if there are any `WARN` or `ERROR` statuses. If so, the action fails. Alternatively, if the package is not on CRAN it will also fail. 

## License 

MIT / Apache 2.0