#!/usr/local/bin/python3
import re
import sys
import dateutil.parser
from datetime import datetime, timezone
from dateutil import tz
regexp = 'message="(.*?)"'

to_local = tz.tzlocal()

for line in sys.stdin :
    if (line.find('/heartbeat') == -1):
        try:
            (logLevel, space, time, clazz, rest) = line.split(" ", 4)
            for match in re.finditer(regexp, line, re.S):
                match_text = match.group()
                localtime = dateutil.parser.parse(time).astimezone(to_local)
                print(logLevel, localtime, clazz, match_text)
        except:
            print(line, end = '')
