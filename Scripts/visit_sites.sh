#!/bin/bash

# Define the list of links 
links=(
    "https://www.facebook.com/"
    "https://www.messenger.com/"
    "https://www.reddit.com/"
    "http://www.youtube.com/"
    "https://chat.openai.com/chat"
    "https://web.whatsapp.com/"
    "https://web.telegram.org/"
    "https://dev.to/"
    "https://medium.com/"
    "https://stackoverflow.com/"
    #Google accounts
    "https://mail.google.com/"
)

brave-browser --new-window ${links[@]}