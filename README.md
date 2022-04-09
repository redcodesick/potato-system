"# potato-system" 
1. mount external hdd as /storage
2. setfacl -m u:username:rw file
3. UUID=xxxx  /storage                ext4   rw,user,defaults,nofail,user_xattr,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0,acl 0 2


