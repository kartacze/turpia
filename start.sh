#!/bin/bash

echo "starting elixir project"

iex --sname turpia --cookie secret -S mix phx.server
