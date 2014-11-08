APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")
LINKS = APP_CONFIG["links"]