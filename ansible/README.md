
## Ansible

k8s Cluster のインストールには Ansible を使用しています。

```
ansible-galaxy collection install -r collections.yaml

ansible-playbook -i inventory.yaml playbook.yaml
```
