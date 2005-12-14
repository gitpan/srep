%define modname srep
%define modversion 1.09

Name: %modname
Version: %modversion
Release: 1
Source: http://www.cpan.org/authors/id/JV/%{name}-%{version}.tar.gz
BuildArch: noarch
Provides: %modname = %version
URL: http://www.squirrel.nl/people/jvromans/
BuildRoot: %{_tmppath}/rpm-buildroot-%{name}-%{version}-%{release}
Prefix: %{_prefix}

Summary: Make bulk changes to files
License: Artistic
Group: Applications/Productivity

%description
srep performs bulk replacements on the contents of series of files.

It is driven by a data file with replacement instructions.

When processing the files, each file is rewritten when one or more of
the replacement instructions succeed. If no replacement instructions
succeed, the file is left unmodified.

All the power of Perl patters can be used in the replacement
instructions. Additionally, facilities are provided for easy
replacement of words and balanced bracketed strings.

%prep
%setup -q

%build
perl Makefile.PL
make all test

%install
rm -rf $RPM_BUILD_ROOT
make DESTDIR=$RPM_BUILD_ROOT install

rm -f ${RPM_BUILD_ROOT}%{_libdir}/perl*/*/*/perllocal.pod

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc CHANGES README

%{_bindir}/srep
%{_libdir}/perl5/site_perl/*/*/auto/srep
%{_mandir}/man1/*

%changelog
* Wed Dec 12 2005 Johan Vromans <jvromans@squirrel.nl>
- Initial version.
