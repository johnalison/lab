(require 'plstore)
(add-to-list 'plstore-encrypt-to "D37214566A581BF2")


(setq plstore-cache-passphrase-for-symmetric-encryption t)

(setq org-gcal-client-id "57759006028-j8fafbn9prevdvjihbrf7hslpf0g09aa.apps.googleusercontent.com"
      org-gcal-client-secret "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"
      org-gcal-fetch-file-alist '(("johnda102@gmail.com" .  "~/RoamNotes/gcal.org")))

(require 'org-gcal)

;(add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync)))
;(add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync)))
