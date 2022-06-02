#!/bin/sh

function middlemousefix {
  while true
  do
    xsel -fin </dev/null
  done
}

while true
do
  middlemousefix &
  yad --notification --text="Pasting is currently DISABLED" --image="action-unavailable-symbolic"
  kill $!
  wait
  yad --notification --text "Pasting is currently ENABLED" --image="face-plain" --image="accessories-text-editor-symbolic"
done

