{-# LANGUAGE NoImplicitPrelude #-}

module Data.Digit.D7 where

import Papa
import Text.Parser.Char(CharParsing, char)
import Text.Parser.Combinators((<?>))

-- $setup
-- >>> import Text.Parsec(parse, ParseError, eof)
-- >>> import Data.Void(Void)
-- >>> import Data.Digit.Digit7

class D7 d where
  d7 ::
    Prism'
      d
      ()
  x7 ::
    d
  x7 =
    d7 # ()

instance D7 () where
  d7 =
    id
    
-- |
--
-- >>> parse (parse7 <* eof) "test" "7" :: Either ParseError (Digit7 ())
-- Right (Digit7 ())
--
-- >>> parse parse7 "test" "7xyz" :: Either ParseError (Digit7 ())
-- Right (Digit7 ())
--
-- >>> isn't _Right (parse parse7 "test" "xyz" :: Either ParseError (Digit7 ()))
-- True
--
-- prop> \c -> c /= '7' ==> isn't _Right (parse parse7 "test" [c] :: Either ParseError (Digit7 ()))
parse7 ::
  (D7 d, CharParsing p) =>
  p d
parse7 =
  x7 <$ char '7' <?> "7"

instance D7 d => D7 (Either d x) where
  d7 =
    _Left . d7
