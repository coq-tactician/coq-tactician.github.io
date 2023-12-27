(TeX-add-style-hook
 "web-example"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "tikz"
    "minted"
    "amsfonts"))
 :latex)

