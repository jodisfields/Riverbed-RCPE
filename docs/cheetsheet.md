# Cheetsheet

## SCP Commands

#### Copy Single Files

```sh
$ scp user@remote_host.com:/some/remote/directory ~/my_local_file.txt
```

#### Copy Multiple Files

```sh
$ scp username@remotehost:/path/directory/\{foo.txt,bar.txt\} .
```

#### Verbose Output

```sh
$ scp -v source_file_path destination_file_path
```

#### Copy Entire Directory (Recursively)

```sh
$ scp -r source_file_path destination_file_path
```

#### Speed Up Transfer with Compression

```sh
$ scp -C source_file_path destination_file_path
```

#### Specify Identity File

```sh
$ scp -i private_key.pem ~/test.txt root@192.168.1.3:/some/path/test.txt
```
