# -----------------------------
# Options affecting formatting.
# -----------------------------
with section("format"):

  # How wide to allow formatted cmake files
  line_width = 180

  # How many spaces to tab for indent
  tab_size = 4

# ------------------------------------------------
# Options affecting comment reflow and formatting.
# ------------------------------------------------
with section("markup"):

  # If comment markup is enabled, don't reflow the first comment block in each
  # listfile. Use this to preserve formatting of your copyright/license
  # statements.
  first_comment_is_literal = True
