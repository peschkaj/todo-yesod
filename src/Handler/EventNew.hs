{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.EventNew where

import Import
import Events
import YEvents

eventForm :: Html -> MForm Handler (FormResult YEvent, Widget)
eventForm = renderDivs $ YEvent
  <$> areq textField "Name" Nothing
  <*> areq textField "Details" Nothing
  <*> areq dayField  "Start Day" Nothing
  <*> areq timeField "Start Time" Nothing
  <*> areq dayField  "End Day" Nothing
  <*> areq timeField "End Time" Nothing


getEventNewR :: Handler Html
getEventNewR = do
  (formWidget, enctype) <- generateFormPost $ eventForm
  defaultLayout $ do
    setTitle "New Event"
    $(widgetFile "events/new")

postEventNewR :: Handler Html
postEventNewR = do
  ((res, formWidget), enctype) <- runFormPost $ eventForm
  case res of
    FormSuccess entry -> do
      c <- liftIO getCurrentEvents
      _ <- liftIO (addEvent (toEvent entry) c)
      setMessage "Successfully added event"
      redirect $ HomeR
    _ -> defaultLayout $ do
      setTitle "New Event"
      $(widgetFile "events/new")
