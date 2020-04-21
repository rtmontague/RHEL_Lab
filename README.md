# RHEL Lab

## Install Dependencies
```
$ sudo dnf install pkg-config libvirt-dev
$ pip3 install libvirt-python
```

## Usage
### Create Internal network and base VMs

```bash
$ ./setup 
```
#### VM Credentials:
```
radmin / password
root   / password1q2w!Q@W
```

### Destroy Internal network and VMs
```bash
$ ./reset 
```