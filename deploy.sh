#!/bin/bash

# modified from https://github.com/NatTuck/nu_mart/blob/master/deploy.sh

export PORT=8000
export MIX_ENV=prod
DIR=$1

if [ ! -d "$DIR" ]; then
	  printf "Usage: ./deploy.sh <path>\n"
		  exit
		fi

		echo "Deploy to [$DIR]"

		mix deps.get
		(cd assets && npm install)
		(cd assets && ./node_modules/brunch/bin/brunch b -p)
		mix phx.digest
		mix release --env=prod

		$DIR/bin/microblog stop || true

		mix ecto.migrate

		SRC=`pwd`
		(cd $DIR && tar xf $SRC/_build/prod/rel/microblog/releases/0.0.1/microblog.tar.gz)

		$DIR/bin/microblog start
