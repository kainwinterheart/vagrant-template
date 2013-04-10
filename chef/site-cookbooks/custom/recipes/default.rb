# create a 2.7 virtualenv owned by vagrant user
#
python_virtualenv "/home/vagrant/env" do
  owner "vagrant"
  group "vagrant"
  action :create
end

# install python packages into our virtualenv
python_packages = [
  "gunicorn",
  "flake8",
  "flask",
  "itsdangerous",
  "wtforms",
  "betterprint",
  "requests",
  "pycrypto",
  "python-memcached",
  "qrcode",
  "pil"
]
python_packages.each do |p|
  python_pip p do
    virtualenv "/home/vagrant/env"
    action :install
  end
end
# install some ubuntu packages
packages = [
  "libapache2-mod-wsgi",
  "sl",
  "colordiff",
  "byobu",
  "git",
  "vim-nox"
]

packages.each do |p|
  package p
end

# make a directory named html
directory "/home/vagrant/html" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

# make a symlink
link "/home/vagrant/your-repo-is-here" do
  action :create
  link_type :symbolic
  to "/vagrant/"
end

# if this file does not exist, create it with the content "prod"
file "/home/vagrant/your-repo-is-here/env.txt" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create_if_missing
  content "prod"
end

