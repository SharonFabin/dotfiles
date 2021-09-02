#!/bin/bash

sudo pacman -Syu stack
git clone https://github.com/fosskers/aura.git
cd aura
stack install -- aura
cd ..
