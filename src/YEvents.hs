module YEvents ( YEvent(..)
               , toEvent
               ) where

import Data.Time
import System.IO.Unsafe (unsafePerformIO)
import qualified Data.Text as T
import Events

data YEvent = YEvent { name      :: T.Text
                     , detail    :: T.Text
                     , startDay  :: Day
                     , startTime :: TimeOfDay
                     , endDay    :: Day
                     , endTime   :: TimeOfDay
                     }

toEvent :: YEvent -> Event
toEvent (YEvent n d sd st ed et) = Event (T.unpack n) (T.unpack d) start end
  where toLocalTime              = LocalTime
        tz                       = unsafePerformIO getCurrentTimeZone
        start                    = localTimeToUTC tz (toLocalTime sd st)
        end                      = localTimeToUTC tz (toLocalTime ed et)
