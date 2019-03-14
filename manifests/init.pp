class postgresql10 {
	file { '/root/postgres10.tar.gz' :
		ensure => present,
		source => "puppet:///modules/postgresql10/postgres10.tar.gz",
		}
	
	exec { 'Untar & install postgresql' :
		cwd => "/root",
		command => "/usr/bin/tar -xzvf postgres10.tar.gz && /usr/bin/cd postgres10/ && /usr/bin/yum localinstall --disablerepo=* *.rpm -y",
		}
		
	exec { 'Configure postgresql10' :
		cwd => "/root",
		command => "/usr/pgsql-10/bin/postgresql-10-setup initdb && sed -i \"59c\listen_addresses = \'*\' \" /var/lib/pgsql/10/data/postgresql.conf && sed -i \"60c\port = 5432\" /var/lib/pgsql/10/data/postgresql.conf && /usr/bin/sed -i \"81c\host    all             all             0.0.0.0/0               md5 \" /var/lib/pgsql/10/data/pg_hba.conf",
                creates => "/var/lib/pgsql/10/data/pg_hba.conf",
		}
	
	service { 'postgresql-10':
                ensure => running,
                enable => true,
            }
}