#=============================================================================
# Put together the package
#=============================================================================

# WORKFLOW: UPDATE EXISTING PACKAGE
# 1) Modify package content and documentation.
# 2) Increase package number in "use_description" below.
# 3) Go through this script and carefully answer "no" if a "use_*" function
#    asks to overwrite the existing files. Don't skip that function call.
# devtools::load_all()

library(usethis)

# Sketch of description file
use_description(
  fields = list(
    Title = "Kernel SHAP",
    Version = "0.3.3",
    Description = "Multidimensional refinement of the Kernel SHAP algorithm described in
    Ian Covert and Su-In Lee (2021) <http://proceedings.mlr.press/v130/covert21a>.
    The package allows to calculate Kernel SHAP values in an exact way, by iterative 
    sampling (as in the reference above), or by a hybrid of the two. 
    As soon as sampling is involved, the algorithm iterates until convergence, 
    and standard errors are provided.
    The package works with any model that provides numeric predictions of dimension one or higher.
    Examples include linear regression, logistic regression (on logit or probability scale),
    other generalized linear models, generalized additive models, and neural networks. 
    The package plays well together with meta-learning packages like 'tidymodels', 'caret' or 'mlr3'. 
    Visualizations can be done using the R package 'shapviz'.",
    `Authors@R` = "c(person('Michael', family = 'Mayer', role = c('aut', 'cre'), email = 'mayermichael79@gmail.com'),
       person('David', family = 'Watson', role = 'ctb', email = 'david.s.watson11@gmail.com'))",
    Depends = "R (>= 3.2.0)",
    LazyData = NULL
  ),
  roxygen = TRUE
)

use_package("stats", "Imports")
use_package("utils", "Imports")
use_package("foreach", "Imports")

use_package("doFuture", "Suggests")

use_gpl_license(2)

# Your files that do not belong to the package itself (others are added by "use_* function")
use_build_ignore(c("^packaging.R$", "[.]Rproj$", "^compare_with_python.R$",
                   "^cran-comments.md$", "^logo.png$", "^Z_exact.R$"), escape = FALSE)

# If your code uses the pipe operator %>%
# use_pipe()

# If your package contains data. Google how to document
# use_data()

# Add short docu in Markdown (without running R code)
use_readme_md()

# Longer docu in RMarkdown (with running R code). Often quite similar to readme.
# use_vignette("kernelshap")

# If you want to add unit tests
use_testthat()
# use_test("kernelshap.R")
# use_test("methods.R")

# On top of NEWS.md, describe changes made to the package
use_news_md()

# Add logo
use_logo("logo.png")

# If package goes to CRAN: infos (check results etc.) for CRAN
use_cran_comments()

use_github_links() # use this if this project is on github

#=============================================================================
# Finish package building (can use fresh session)
#=============================================================================

library(devtools)

document()
test()
check(manual = TRUE, cran = TRUE)
build()
# build(binary = TRUE)
install(upgrade = FALSE)

# Run only if package is public(!) and should go to CRAN
if (FALSE) {
  check_win_devel()
  check_rhub()

  # Wait until above checks are passed without relevant notes/warnings
  # then submit to CRAN
  release()
}
