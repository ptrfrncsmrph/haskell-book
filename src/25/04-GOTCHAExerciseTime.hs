{-# LANGUAGE InstanceSigs #-}

module CommonFunctionsAsTypes where

import           Control.Applicative

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

instance (Applicative f, Applicative g) => Applicative (Compose f g) where
  pure :: a -> Compose f g a
  pure a = Compose $ (pure . pure) a
  (<*>) :: Compose f g (a -> b) -> Compose f g a -> Compose f g b
  (Compose f) <*> (Compose a) = Compose $ ((<*>) $ fmap (<*>) f) a