<?php

define( 'DB_NAME', getenv('DB_NAME') );
define( 'DB_USER', getenv('DB_USER') );
define( 'DB_PASSWORD', getenv('DB_PASSWORD') );
define( 'DB_HOST', getenv('DB_HOST') );
define( 'WP_HOME', getenv('WP_URL') );
define( 'WP_SITEURL', getenv('WP_URL') );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

// cles d'authentification
// utilisees pour securiser les cookies et sessions des users dans WP
// Pour generer automaituquement : https://api.WP.org/secret-key/1.1/salt/
define( 'AUTH_KEY',         '' );
define( 'SECURE_AUTH_KEY',  '' );
define( 'LOGGED_IN_KEY',    '' );
define( 'NONCE_KEY',        '' );
define( 'AUTH_SALT',        '' );
define( 'SECURE_AUTH_SALT', '' );
define( 'LOGGED_IN_SALT',   '' );
define( 'NONCE_SALT',       '' );

// Prefixe des tables de la base de donnees
// permet d'avoir plusieurs instal WP dans la meme base de donnees
// avec des prefixes differents pour chq instal
$table_prefix = 'wp_';

// mode de debugage
define( 'WP_DEBUG', true );

// ABSPATH definit le chemin absolu vers le repertoire WP sur le serveur
// __DIR__ fait reference au repertoire actuel ou se trouve le fichier wp-config.php
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

// inclut le fichier wp-settings.php qui charge les paramètres principaux de WP et initialise le site
// ! toujours a la fin du fichier wp-config.php
require_once ABSPATH . 'wp-settings.php';
