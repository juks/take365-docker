if [ ! -d "app" ] 
then
	echo "+ clonning take365 code..."
	git clone git@github.com:juks/take365.git app
else
	echo "- app dir exists, skipping clonning take365 code..."
fi

if [ ! -f "sql/take365.sql" ] 
then
	echo "+ untar take365 sql"
	cd sql && tar -xzvf take365.sql.tar.gz && cd ..
else
	echo "- sql file already decompressed, skipping..."
fi

if [ ! -f "app/config/config_local.php" ] 
then

	echo ""
	echo "Enter take365 host (for example: localhost:8087):"
	read host_name

	echo "+ copying docker config to local config"

	REPLACE_COMMAND='{sub("{host_placeholder}","'
	REPLACE_COMMAND+=$host_name
	REPLACE_COMMAND+='")}1'

	echo $REPLACE_COMMAND

	awk $REPLACE_COMMAND app/config/config_docker.php > app/config/config_local.php
else
	echo "- config local file already exists, skipping..."
fi

if [ ! -f "app/web/index.php" ] 
then
	echo "+ copying index.php from dist"
	cp app/web/index.php.dist app/web/index.php
else
	echo "- index.php file already exists, skipping..."
fi

chmod 777 app/web/
chmod 777 app/web/assets
cp additional-files/react.js app/web/js/
cp additional-files/react.css app/web/css/

docker-compose up -d
docker-compose exec php composer install
docker-compose exec --workdir="/var/sql/" db bash install.sh

echo "Done."