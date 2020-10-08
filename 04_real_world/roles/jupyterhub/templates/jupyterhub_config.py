import logging
import os

FORMATTER = '%(asctime)s|%(name)s|%(levelname)s|%(message)s'
DATE_FORMAT = '%Y-%m-%d %H:%M:%S'
LOGS_PATH = '{{ logs_dir }}'

c.Application.log_format = FORMATTER

class SafeToCopyTimedRotatingFileHandler(logging.handlers.TimedRotatingFileHandler):
    def __init__(self, filename, when='D', interval=1, backupCount=0, encoding=None, delay=False, utc=False, atTime=None):
        self.__filename = filename
        self.__when = when
        self.__interval = interval
        self.__backupCount = backupCount
        self.__encoding = encoding
        self.__delay = delay
        self.__utc = utc
        self.__atTime = atTime
        super().__init__(filename, when, interval, backupCount, encoding, delay, utc, atTime)

    def __deepcopy__(self, memodict={}):
        result = type(self)(filename=self.__filename)
        result.setLevel(self.level)
        result.setFormatter(self.formatter)
        return result

safe_handler = SafeToCopyTimedRotatingFileHandler(os.path.join(LOGS_PATH, '{{ ansible_host }}_{{ jupyter.port1 }}.{{ jupyter.name }}_server.log'), backupCount=5)
safe_handler.setLevel(logging.DEBUG)
safe_handler.setFormatter(logging.Formatter(FORMATTER))

c.JupyterHub.extra_log_handlers = [safe_handler]

ch = logging.StreamHandler()
ch.setLevel(logging.INFO)
ch.setFormatter(formatter)
logger.addHandler(ch)

c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.ip = '0.0.0.0'

c.Spawner.disable_user_config = False
c.Spawner.notebook_dir = '~'

c.JupyterHub.pid_file = '{{ conda_envs }}/{{ jupyter.name }}/var/log/{{ jupyter.name }}.pid'
c.ConfigurableHTTPProxy.api_url = 'http://localhost:{{ jupyter.port2 }}'
c.ConfigurableHTTPProxy.should_start = False
import binascii
c.ConfigurableHTTPProxy.auth_token = binascii.b2a_hex(os.urandom(16))
c.JupyterHub.cleanup_servers = False
c.JupyterHub.bind_url = 'http://:{{ jupyter.port1 }}'
c.JupyterHub.hub_port = {{ jupyter.port3 }}
c.JupyterHub.port = {{ jupyter.port1 }}
c.JupyterHub.data_files_path = '{{ conda_envs }}/{{ jupyter.name }}/share/jupyterhub'

