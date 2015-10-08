# test-kitchen-example

Testing an Ansible-provisioned Apache box & static HTML web application.

```
ansible-galaxy install --role-file=ansible/requirements.yml --roles-path=ansible/roles --force
bundle install
bundle exec kitchen test
```
