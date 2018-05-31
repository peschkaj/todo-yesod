module YDeadline ( YDeadline(..)
                 , toDeadline
                 ) where

import Data.Time
import System.IO.Unsafe (unsafePerformIO)
import qualified Data.Text as T
import Deadline

data YDeadline = YDeadline { title        :: T.Text
                           , description  :: T.Text
                           , dueDate      :: Day
                           , deadlineTime :: TimeOfDay
                           }

toDeadline :: YDeadline -> Deadline
toDeadline (YDeadline t d dd dt) = Deadline t d (toUTCTime dd dt)
  where tz                       = unsafePerformIO getCurrentTimeZone
        toUTCTime dd' dt'        = localTimeToUTC tz (LocalTime dd' dt')
