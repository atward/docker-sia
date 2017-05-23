# Sia

This repository hold a Docker container for Sia.

## Usage

```
docker run --name=sia -d -v /mnt/user/appdata/sia:/mnt/sia quay.io/arkan/sia:1.2.2
```

### Using CLI
The CLI is only available within the Docker container for security reasons
```
docker exec -it sia ./siac
```

## Licence
[MIT](./LICENSE)
