#!/bin/bash

# Define the list of links
    links=(
    "https://extensions.gnome.org/extension/1634/resource-monitor/"
    "https://extensions.gnome.org/extension/5237/rounded-window-corners/"
    "https://extensions.gnome.org/extension/3193/blur-my-shell/"
    "https://extensions.gnome.org/extension/517/caffeine/"
    "https://extensions.gnome.org/extension/19/user-themes/"

    #brave extensions

    "https://chromewebstore.google.com/detail/automa/infppggnoaenmfagbfknfkancpbljcca"
    "https://chromewebstore.google.com/detail/blocktube/bbeaicapbccfllodepmimpkgecanonai"
    "https://chromewebstore.google.com/detail/colorzilla/bhlhnicpbhignbdhedgjhgdocnmhomnp"
    "https://chromewebstore.google.com/detail/keepassxc-browser/oboonakemofpalcgghocfoadofidjkkk"
    "https://chromewebstore.google.com/detail/medium-member-only-post-r/jbejhilkbegomejdgdhaakegbhfabdca"
    "https://chrome.google.com/webstore/detail/print-friendly-pdf/ohlencieiipommannpdfcmfdpjjmeolj?hl=bn"
    "https://chrome.google.com/webstore/detail/tab-for-a-cause/gibkoahgjfhphbmeiphbcnhehbfdlcgo"
    "https://chromewebstore.google.com/detail/multiselect-for-youtube/gpgbiinpmelaihndlegbgfkmnpofgfei"
    "https://chrome.google.com/webstore/detail/video-speed-controller/nffaoalbilbmmfgbnbgppjihopabppdk"
    "https://chrome.google.com/webstore/detail/volume-master/jghecgabfgfdldnmbfkhmffcabddioke"
    "https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh"
    "https://chromewebstore.google.com/detail/smartswitch-transfer-yout/ofjkkedodlibekaaldndffjfhbpkjikp"
    "https://chromewebstore.google.com/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone"
    
)

# Loop through the links and open each one in a new tab
for link in "${links[@]}"
do
  xdg-open "$link"
done