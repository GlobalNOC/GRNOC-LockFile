Name: perl-GRNOC-LockFile
Version: 1.0.1
Release: 1%{?dist}
Summary: GRNOC Lock File Library
License: Apache License, Version 2.0
Group: Development/Libraries
URL: http://globalnoc.iu.edu
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch: noarch
Requires: perl >= 5.8.8
Requires: perl(LockFile::Simple)
Requires: perl(File::Pid)
Requires: perl(Moo)
Requires: perl(Types::Standard)
BuildRequires: perl(Test::Simple)
BuildRequires: perl(Test::Pod)
BuildRequires: perl(Test::Pod::Coverage)
BuildRequires: perl(Try::Tiny)

%description
This Perl library is used to manage lock files for GRNOC software.

%prep
%setup -q -n perl-GRNOC-LockFile-%{version}

%build
%{__perl} Makefile.PL PREFIX="%{buildroot}%{_prefix}" INSTALLDIRS="vendor"
make

%install
rm -rf $RPM_BUILD_ROOT
make pure_install

# clean up buildroot
find %{buildroot} -name .packlist -exec %{__rm} {} \;

%{_fixperms} $RPM_BUILD_ROOT/*

%check
make test

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644 ,root, root, -)
%{perl_vendorlib}/GRNOC/LockFile.pm
%{perl_vendorlib}/GRNOC/LockFile.pod
%doc %{_mandir}/man3/GRNOC::LockFile.3pm.gz

