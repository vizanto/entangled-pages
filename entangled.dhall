let entangled = https://raw.githubusercontent.com/entangled/entangled/master/data/config-schema.dhall
                sha256:a924fcffa514e3909459e48c45924886062ff4a77be582af0517f9c4bae7ae73

let languages = entangled.languages #
        [ { name = "Bash", identifiers = ["bash", "sh"], comment = entangled.comments.hash }
        ]

in { entangled = entangled.Config :: { database = Some ".entangled/db.sqlite"
                                     , watchList = [ "lit/*.md" ]
                                     , languages = languages
                                     }
   , jupyter = [ { language = "Python", kernel = "python3" }
               , { language = "Bash",   kernel = "bash" } ]
   }

