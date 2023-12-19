
## Multipass Installation

Multipass is a root-level application due to its use of virtualization.

Later versions allow a non-root user to access the service via secondary authentication.

```bash
# Download latest version
curl -L https://multipass.run/download/macos -o /tmp/multipass.pkg

# Install with administrator privileges
su administrator -c 'sudo /usr/sbin/installer -pkg /tmp/multipass.pkg -target /Applications'

# Create a strong, random password
export AUTHSTRING=$(uuidgen | sed "s/[-]//g")

# Create a passphrase for authentication of non-root users
su administrator -c 'multipass set local.passphrase=${AUTHSTRING}'

# Authenticate to multipass
multipass authenticate ${AUTHSTRING}

# Test access
multipass find
```

## Multipass Uninstallation

Run the following command to remove the Multipass installation.

```bash
su administrator -c 'sudo sh "/Library/Application Support/com.canonical.multipass/uninstall.sh"'
```