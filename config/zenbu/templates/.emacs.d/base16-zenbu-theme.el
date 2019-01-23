;;; Code:

(require 'base16-theme)

(defvar base16-zenbu-colors
  '(:base00 "{{ base00 }}"
    :base01 "{{ base01 }}"
    :base02 "{{ base02 }}"
    :base03 "{{ base03 }}"
    :base04 "{{ base04 }}"
    :base05 "{{ base05 }}"
    :base06 "{{ base06 }}"
    :base07 "{{ base07 }}"
    :base08 "{{ base08 }}"
    :base09 "{{ base09 }}"
    :base0A "{{ base0A }}"
    :base0B "{{ base0B }}"
    :base0C "{{ base0C }}"
    :base0D "{{ base0D }}"
    :base0E "{{ base0E }}"
    :base0F "{{ base0F }}")
  "All colors for Base16 theme generated with zenbu, hard are defined here.")

;; Define the theme
(deftheme base16-zenbu)

;; Add all the faces to the theme
(base16-theme-define 'base16-zenbu base16-zenbu-colors)

;; Mark the theme as provided
(provide-theme 'base16-zenbu)

(provide 'base16-zenbu-theme)

;;; base16-zenbu-theme.el ends here
