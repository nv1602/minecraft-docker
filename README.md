# minecraft-server-compose

This project builds on the excellent [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server) and related tools to offer a modular, easily configurable Docker Compose-based setup for running vanilla or modded Minecraft servers.

This is just a personal project I threw together because I was bored and wanted to mess around with Docker and Minecraft.
It works for me™ but it's not meant to be a polished or anything.
Use at your own risk, expect rough edges, and feel free to fork or modify however you want.

## Usage

1. **Clone the repository**  
   ```
   git clone https://github.com/nv1602/minecraft-docker.git
   cd minecraft-docker
   ```

2. **Pick or Compose Your Services**  
   - Select the `docker-compose.yml` files for your desired Minecraft server(s) and services.
     ```bash
     docker compose \
      -f mc.yml \
      -f backups.yml \
      -f playit.yml \
      up -d
     ```

3. **Configure Environment Variables**  
   - Create a `.env` file in the project root with your server configuration. See `.env.example` for details.
   - Leave variables blank to use image defaults or disable features.
   - You can define mods either:
     - + By creating a `modlist.txt` and using the provided script (recommended for lots of mods)..
     - Or by listing mods directly in an environment variable in `.env`.

4. **(Optional) Manage Mods via a text file**
   -  If you have many mods, it’s easiest to list them in modrinth.txt (one slug per line):
    ```
    # Comments and blank lines are ignored
    # See format details: https://docker-minecraft-server.readthedocs.io/en/latest/mods-and-plugins/modrinth/
    lithium
    sodium
    fabric-api
    ```
    - Once you have your mod list, use the included script to generate or process your mod list:
    ```bash
    ./apply_mods_to_env.sh <filename>
    ```
    This will populate (or update) MODRINTH_PROJECTS in your .env.
6. **Start the Stack**  
   ```
   docker compose up -d
   ```

7. **Managing the Server**  
   - To execute commands inside the running Minecraft container:
     ```
     docker compose exec <service> <command>
     ```
     Replace `<service>` with your server's container name (e.g. `mc`).

   - To attach your terminal to the Minecraft container:
     ```
     docker compose attach <service>
     ```
     
   - Stop everything (runs final backup if configured):
     ```
     docker compose down
     ```

## Credits

This project uses the following Docker images:

- [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server): The main Minecraft server image.
- [itzg/mc-backup](https://hub.docker.com/r/itzg/mc-backup): For automated server backups.
- [ghcr.io/playit-cloud/playit-agent](https://github.com/playit-cloud/playit-agent): Expose your local server to the internet without port forwarding

Please refer to each image's documentation for further details.

## Example

A minimal `.env`:
```
EULA=true
TYPE=VANILLA
VERSION=LATEST
DIFFICULTY=2
```
using just `mc.yml`.

## License

MIT License. See [LICENSE](LICENSE).
