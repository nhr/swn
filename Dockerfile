FROM fedora:41
MAINTAINER swn@emichron.com
RUN dnf install -y gcc httpd perl perl-CGI perl-CPAN perl-Data-Dumper perl-DBI perl-Env perl-GD perl-GDTextUtil perl-JSON perl-Module-Install perl-PDF-API2 perl-Term-Prompt perl-Test-Simple sqlite
COPY .cpan/CPAN/MyConfig.pm /root/.cpan/CPAN/MyConfig.pm
RUN cpan install Data::RandomPerson FindBin MIME::Base64 PDF::API2::Simple Text::Reflow
COPY CGI /var/www/html/CGI/
COPY css /var/www/html/css/
COPY Fonts /var/www/html/Fonts/
COPY Includes /var/www/html/Includes/
COPY js /var/www/html/js/
COPY PerlLibs /var/www/html/PerlLibs/
COPY index.html swn.sqlite /var/www/html/
COPY Container/httpd.conf /etc/httpd/conf/httpd.conf
COPY Container/.htaccess.docker /var/www/html/.htaccess
RUN chown apache:apache /var/www/html/swn.sqlite
EXPOSE 8080
CMD /usr/sbin/httpd -d /var/www -f /etc/httpd/conf/httpd.conf -DFOREGROUND
