{
  filesystems."/mnt/share" = {
    device = "u416901@u416901:/backup";
    fsType = "sshfs";
    options = [
      "nodev"
      "noatime"
      "allow_other"
      "IdentityFile=/root/.ssh/id_rsa"
    ];
  };
}
