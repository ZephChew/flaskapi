--DROP DATABASE IF EXISTS pypi_39;

CREATE DATABASE pypi_39;

\c pypi_39;

CREATE TABLE IF NOT EXISTS nexus_packages (
	pkgName 			VARCHAR(255) PRIMARY KEY,
	pkgVersion 			VARCHAR(20) NOT NULL,
	pyVersion			VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS package_request (
    pkgName 			VARCHAR(255) PRIMARY KEY,
	pkgVersion 			VARCHAR(20) NOT NULL
);