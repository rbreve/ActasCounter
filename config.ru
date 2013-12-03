# This file is used by Rack-based servers to start the application.

# Max memory size (RSS) per worker
use Unicorn::WorkerKiller::Oom, (145*(1024**2)), (165*(1024**2))

require ::File.expand_path('../config/environment',  __FILE__)
run ConteoActas::Application
