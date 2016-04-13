rm -rf public
hugo
rsync -avz -e ssh public/ thomascoopman.eu:/home/thomas/hugo
