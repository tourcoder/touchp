# touchp

`touchp` is a command-line utility written in Go that recursively creates directories and target files in a single command. It combines the functionality of `mkdir -p` and `touch`, making it easy to create files along with their parent directories. It supports multiple file creation, custom permissions, and initial content.

### Features

- Recursively create directories and files with one command.
- Support for multiple file creation in a single invocation.
- Customizable file permissions (e.g., `0644`, `0600`).
- Option to specify initial content for the files.
- Cross-platform compatibility (macOS, Linux, Windows).

### Installation

You can install `touchp` using the provided installation script, which automatically detects your operating system and architecture, then downloads and installs the appropriate precompiled binary.

### Prerequisites

- A supported operating system: macOS, Linux, or Windows.
- `curl` installed (for downloading the script and binary).
- For macOS/Linux: Bash shell (usually preinstalled).
- For Windows: A Bash-compatible environment (e.g., Git Bash, WSL) is recommended for the script, though manual installation is also supported.

### Install via Script

Run the following command in your terminal to download and execute the 

```
curl -fsSL https://raw.githubusercontent.com/huabin/touchp/refs/heads/master/install.sh | sh
```

#### What the Script Does

1. Detects Your System: Identifies your OS (macOS, Linux, Windows) and architecture (amd64, arm64).

2. Downloads the Binary: Fetches the correct precompiled binary from `https://dlc.binhua.org/touchp/` (e.g., touchp-macos-arm64-v1.0.0).

3. Installs the Binary:
 - On macOS/Linux: Places `touchp` in `/usr/local/bin`.
 - On Windows: Downloads the `.exe` file to a temporary directory and prompts you to move it manually to a directory in your PATH.

4. Cleans Up: Removes temporary files after installation.

#### Example Output

- On macOS (Apple Silicon):

	```
	Starting touchp installation...
	Detected system: macos-arm64
	Downloading touchp-macos-arm64-v1.0.0 from https://dlc.binhua.org/touchp/touchp-macos-arm64-v1.0.0...
	Successfully installed touchp to /usr/local/bin/touchp
	You can now run 'touchp --help' to get started.
	```
	
- On Linux (x86_64):

	```
	Starting touchp installation...
	Detected system: linux-amd64
	Downloading touchp-linux-amd64-v1.0.0 from https://dlc.binhua.org/touchp/touchp-linux-amd64-v1.0.0...
	Successfully installed touchp to /usr/local/bin/touchp
	You can now run 'touchp --help' to get started.
	```

- On Windows (via Git Bash):

	```
	Starting touchp installation...
	Detected system: windows-amd64
	Downloading touchp-windows-amd64-v1.0.0.exe from https://dlc.binhua.org/touchp/touchp-windows-amd64-v1.0.0.exe...
	Windows detected. Please manually move touchp-windows-amd64-v1.0.0.exe to a directory in your PATH.
	File downloaded to: /tmp/touchp-install/touchp-windows-amd64-v1.0.0.exe
	```

### Usage

Once installed, you can use `touchp` with the following syntax:

```
touchp [options] <path/to/filename> [<path/to/filename> ...]
```

#### Options

- `-f, --force`: Force overwrite if the file already exists.
- `-c, --content <string>`: Specify initial content for the file(s).
- `-m, --mode <octal>`: Set file permission mode (e.g., 0644, 0600). Default is 0644.
- `--help`: Display help message.

####  Examples

- Create a file with its directories:

	```
	touchp dir/subdir/file.txt
	```
	
	Output: `Successfully created: dir/subdir/file.txt`

- Create a file with content:

	```
	touchp -c "Hello, world!" dir/sub/file.txt
	```

- Create multiple files with custom permissions:

	```
	touchp -m 0600 dir1/file1.txt dir2/file2.txt
	```
	
	Output:
	
	```
	Successfully created: dir1/file1.txt
	Successfully created: dir2/file2.txt
	```

- Force recreate an existing file:

	```
	touchp -f dir/existing/file.txt
	```
	
### Troubleshooting

- Permission Denied: If `/usr/local/bin` is not writable, the script installs to `~/bin`. Add it to your PATH with:

	```
	export PATH=$PATH:~/bin
	```
	
- Command Not Found: Ensure the install directory is in your PATH.

- Windows Issues: Use Git Bash or WSL for the script, or install manually.

### Contributing

Feel free to fork this project, submit issues.

### License

Copyright (c) 2025 Bin Hua.
