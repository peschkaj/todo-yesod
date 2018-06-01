{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.DeadlineNew where

import Import
import YDeadline
import Deadline


deadlineForm :: Html -> MForm Handler (FormResult YDeadline, Widget)
deadlineForm = renderDivs $ YDeadline
  <$> areq textField "Title" Nothing
  <*> areq textField "Description" Nothing
  <*> areq dayField  "Due Date" Nothing
  <*> areq timeField "Deadline Time" Nothing

getDeadlineR :: Handler Html
getDeadlineR = do
  ds <- liftIO getCurrentDeadlines
  today <- liftIO getCurrentTime
  defaultLayout $ do
    setTitle "All Deadlines"
    $(widgetFile "deadline/deadlines")

getDeadlineNewR :: Handler Html
getDeadlineNewR = do
  (formWidget, enctype) <- generateFormPost $ deadlineForm
  defaultLayout $ do
    setTitle "New Deadline"
    $(widgetFile "deadline/new")

postDeadlineNewR :: Handler Html
postDeadlineNewR = do
  ((res, formWidget), enctype) <- runFormPost $ deadlineForm
  case res of
    FormSuccess entry -> do
      c <- liftIO getCurrentDeadlines
      _ <- liftIO (addDeadline (toDeadline entry) c)
      setMessage "Successfully added deadline"
      redirect $ HomeR
    _ -> defaultLayout $ do
      setTitle "New Deadline"
      $(widgetFile "deadline/new")
