# zkLogin Prover Wrapper for Render

This is a wrapper around `mysten/zklogin:prover-stable` that adds the ability to download the `.zkey` file from Google Drive on startup.

## Usage

### Environment Variables

- `GDRIVE_FILE_ID`: The Google Drive file ID to download (required)
- `ZKEY`: Path to save the zkey file (default: `/app/binaries/zkLogin-main.zkey`)
- `WITNESS_BINARIES`: Directory for witness binaries (default: `/app/binaries`)

### Deploying to Render

1. Push this repo to GitHub
2. Create a new Web Service on Render
3. Select this repository
4. Set the following environment variables:
   - `GDRIVE_FILE_ID`: Your Google Drive file ID
   - (Optional) Override other variables as needed
5. Add a Persistent Disk mounted at `/app/binaries`

### Local Development

Build the image:

```bash
docker build -t zklogin-prover-wrapper .
```

Run the container:

```bash
docker run -p 8080:8080 \
  -e GDRIVE_FILE_ID=your_file_id_here \
  -v $(pwd)/data:/app/binaries \
  zklogin-prover-wrapper
```

## How It Works

1. On startup, the container checks if the zkey file exists at the specified path
2. If not found, it downloads the file from Google Drive using `gdown`
3. The prover is then started with the downloaded file
4. The zkey file is stored in a persistent volume for subsequent restarts
