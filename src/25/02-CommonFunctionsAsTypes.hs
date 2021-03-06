module CommonFunctionsAsTypes where

newtype Identity a = Identity
  { runIdentity :: a
  } deriving (Eq, Show)

newtype Compose f g a = Compose
  { runCompose :: f (g a)
  } deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance (Functor f, Functor g) => Functor (Compose f g) where
  fmap f (Compose fga) = Compose $ (fmap . fmap) f fga
