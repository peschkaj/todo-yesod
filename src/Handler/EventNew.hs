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

getEventR :: Handler Html
getEventR = do
  es <- liftIO getCurrentEvents
  defaultLayout $ do
    setTitle "All Events"
    $(widgetFile "events/events")

getEventNewR :: Handler Html
getEventNewR = postEventNewR

postEventNewR :: Handler Html
postEventNewR = do
  ((res, formWidget), enctype) <- runFormPost $ eventForm
  case res of
    FormSuccess entry -> do
      c <- liftIO getCurrentEvents
      es <- liftIO (addEvent (toEvent entry) c)
      case es of (e:_) | (toEvent entry) == e -> setMessage "Successfully added event"
                       | otherwise            -> setMessage "Unable to add event"
                 _                            -> setMessage "Something unexpected and terrible happened"
      redirect $ HomeR
    _ -> defaultLayout $ do
      setTitle "New Event"
      $(widgetFile "events/new")
