{-# LANGUAGE NoImplicitPrelude #-}

module Data.Digit.D3 where

import Papa
import Text.Parser.Char(CharParsing, char)
import Text.Parser.Combinators((<?>))

-- $setup
-- >>> import Text.Parsec(parse, ParseError, eof)
-- >>> import Data.Void(Void)
-- >>> import Data.Digit.Digit3

class D3 d where
  d3 ::
    Prism'
      d
      ()
  x3 ::
    d
  x3 =
    d3 # ()

instance D3 () where
  d3 =
    id

-- |
--
-- >>> parse (parse3 <* eof) "test" "3" :: Either ParseError (Digit3 ())
-- Right (Digit3 ())
--
-- >>> parse parse3 "test" "3xyz" :: Either ParseError (Digit3 ())
-- Right (Digit3 ())
--
-- >>> isn't _Right (parse parse3 "test" "xyz" :: Either ParseError (Digit3 ()))
-- True
--
-- prop> \c -> c /= '3' ==> isn't _Right (parse parse3 "test" [c] :: Either ParseError (Digit3 ()))
parse3 ::
  (D3 d, CharParsing p) =>
  p d
parse3 =
  x3 <$ char '3' <?> "3"

instance D3 d => D3 (Either d x) where
  d3 =
    _Left . d3
