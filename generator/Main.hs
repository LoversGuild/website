{-# LANGUAGE OverloadedLists #-}

-- |
-- Module      : Main
-- Description : Lovers' Guild's website generator
-- Copyright   : Copyright (C) 2022-2024 The Lovers' Guild
-- License     : GNU Affero General Public License version 3
-- Maintainer  : dev@loversguild.org
-- Stability   : experimental
-- Portability : GHC
module Main (main) where

import Data.HashSet qualified as HS
import Control.Monad (ap)
import Data.Time
import System.Directory.OsPath
import System.OsPath

import LoveGen

-------------------
-- Configuration --
-------------------

finnishSite :: SiteConfig
finnishSite =
    defaultSiteConfig
        { siteUrl = "https://rakastajienkilta.fi/",
          pagesDir = [osp|pages/fi|],
          outputDir = [osp|output/fi|],
          optionalMetadata = HS.union
                defaultSiteConfig.optionalMetadata $ HS.fromList [ "other-languages" ],
          locales =
            [   ( "fi",
                  LocaleConfig
                    { dateFormat = "%Ana %d. %Bta %Y",
                      timeLocale = finnishTimeLocale
                    }
                )
            ]
        }

-- | Finnish time locale
finnishTimeLocale :: TimeLocale
finnishTimeLocale =
    TimeLocale
        { wDays =
            ap (,) (take 2)
                <$> [ "sunnuntai",
                      "maanantai",
                      "tiistai",
                      "keskiviikko",
                      "torstai",
                      "perjantai",
                      "lauantai"
                    ],
          months =
            ((,) =<< (<> "kuu"))
                <$> [ "tammi",
                      "helmi",
                      "maalis",
                      "huhti",
                      "touko",
                      "kesä",
                      "heinä",
                      "elo",
                      "syys",
                      "loka",
                      "marras",
                      "joulu"
                    ],
          amPm = ("ennen puoltapäivää", "puolen päivän jälkeen"),
          dateTimeFmt = "%d.%m.%Y %H:%M:%S",
          dateFmt = "%d.%m.%Y",
          timeFmt = "%H:%M:%S",
          time12Fmt = "%H:%M:%S",
          knownTimeZones = []
        }

englishSite :: SiteConfig
englishSite =
    defaultSiteConfig
        { siteUrl = "https://loversguild.org/",
          pagesDir = [osp|pages/en|],
          outputDir = [osp|output/en|],
          optionalMetadata = HS.union
                defaultSiteConfig.optionalMetadata $ HS.fromList [ "other-languages" ],
          locales =
            [   ( "en",
                  LocaleConfig
                    { dateFormat = "on %a, %d %b %Y",
                      timeLocale = defaultTimeLocale
                    }
                )
            ]
        }

--------------------------
-- End of Configuration --
--------------------------

-- | Main function of the generator
main :: IO ()
main = do
    cliOpts <- parseCmdLine
    rootDir <- encodeFS cliOpts.directory
    setCurrentDirectory rootDir
    buildSite finnishSite
    buildSite englishSite
