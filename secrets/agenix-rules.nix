let
  sclera = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAV8ur94oXT6nTPxKitInqFfgiusAqmlepO/FS2I303D root@sclera";
in
{
  "attic-env.age".publicKeys = [ sclera ];
  "dovecot-passwd.age".publicKeys = [ sclera ];
  "grafana-secret-key.age".publicKeys = [ sclera ];
  "nextcloud-admin-pass.age".publicKeys = [ sclera ];
  "nextcloud-secrets.json.age".publicKeys = [ sclera ];
  "onlyoffice-jwt.age".publicKeys = [ sclera ];
  "onlyoffice-nonce.age".publicKeys = [ sclera ];
}
