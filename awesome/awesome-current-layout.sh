#!/bin/bash
awesome-client 'return mouse.screen.selected_tag.layout.name' | awk -F'"' '{print $2}'
