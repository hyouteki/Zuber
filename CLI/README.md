> Done till now in Zuber CLI
## Zuber Client
- [x] sign up
  - [x] customer
  - [x] driver
- [ ] sign in
    - [ ] customer
        - [x] check details
        - [x] change password
        - [ ] book a trip
        - [ ] check history
        - [x] sign out
    - [ ] driver
## Zuber admin
- [x] Select/print options
    - [x] print customers
    - [x] print drivers
    - [x] print cars
## How to use
- Download assest/source code.
- Use all the sql files in your local mysql server in the mentioned sequence.
  - zuber-schema.sql
  - zuber-data.sql
  - zuber-queries.sql
  - zuber-triggers.sql
  - zuber-olap.sql
- Then do `make install` in your terminal.
- Then run either `zuber_client.py` or `zuber_admin.py` files.
  > Remember to use all the sql files in your local mysql server before launching CLI.
