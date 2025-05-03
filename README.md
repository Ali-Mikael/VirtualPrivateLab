# Virtual Private Lab
## Create a private virtual lab with Vagrant and Salt 

## How to use:

```
$ vagrant up
```

## Prerequisites
You should have `Vagrant` and `VirtualBox` installed for this setup to work. <br>  
- Vagrant is more important! <br>
- VirtualBox you can live without if you use another virtualization software & tweak the configurations.

### Vagrant up ... = VM's are up... = What next?
On the salt-master:

```
$ sudo salt '*' state.apply
``` 

This will apply all necessary basic settings for the minions to set up your environment. After this 
you're free to do as you please! <br> 
Enjoy!
