-   Download the repository (source code).
-   Use all the sql files in your local mysql server in the mentioned sequence.
	`SOURCE <address-of-zuber-repository>/zuber-schema.sql`
    -   zuber-schema.sql
    -   zuber-data.sql
    -   zuber-queries.sql
    -   zuber-triggers.sql
    -   zuber-olap.sql
-   Replace host, user & password  in `database.py` file at line number `10, 11 & 12` with your mysql credentials.
-   Then open up the terminal at the repository path and do `make install`.
-   Then run either `zuber_client.py` or `zuber_admin.py` files present in the CLI directory.

    > Remember to use all the sql files in your local mysql server before launching CLI.