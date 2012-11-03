# Disable ssh by default for security reasons.
# Enable it manually using salt remote execution interface
ssh:
  service.dead:
    - enable: False
