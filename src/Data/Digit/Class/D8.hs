{-# LANGUAGE NoImplicitPrelude #-}

module Data.Digit.Class.D8(
  D8(..)
, parse8
) where

import Control.Category (id)
import Control.Lens (Prism', (#))

import Data.Functor ((<$))

import Text.Parser.Char(CharParsing, char)
import Text.Parser.Combinators((<?>))

-- $setup
-- >>> import Data.Digit.Class
-- >>> import Text.Parsec(parse, ParseError, eof)
-- >>> import Data.Void(Void)

class D8 d where
  d8 ::
    Prism'
      d
      ()
  x8 ::
    d
  x8 =
    d8 # ()

instance D8 () where
  d8 =
    id
    
-- |
--
-- >>> parse (parse8 <* eof) "test" "8" :: Either ParseError DecDigit
-- Right DecDigit8
--
-- >>> parse parse8 "test" "8xyz" :: Either ParseError DecDigit
-- Right DecDigit8
--
-- >>> isn't _Right (parse parse8 "test" "xyz" :: Either ParseError DecDigit)
-- True
parse8 ::
  (D8 d, CharParsing p) =>
  p d
parse8 =
  x8 <$ char '8' <?> "8"
