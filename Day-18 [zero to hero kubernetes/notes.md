## What is Mounting in Linux?

Mounting is the process of making a filesystem (like a USB drive, a network share, or even a Windows drive) accessible in a specific directory in Linux. It allows the operating system to recognize and interact with external storage or virtual filesystems.

Think of it like plugging in a USB drive: before you can use it, your system needs to "mount" it so that you can access its files.

## How Mounting Works in Linux

- **Physical or Virtual Storage Devices** (USB, HDD, SSD, network shares, etc.) must be mounted before they can be accessed.
- Once mounted, they appear as part of the Linux filesystem under a specific directory (called a **mount point**).
- The Linux filesystem does not use drive letters (`C:`, `D:`, etc.) like Windows. Instead, everything is part of a single hierarchical structure.

## Example: Mounting a Windows Drive in WSL (Windows Subsystem for Linux)

Since you're using Ubuntu in WSL, **Windows drives (C:, D:, etc.) are automatically mounted** under `/mnt/`.

- `C:\` in Windows becomes `/mnt/c/` in WSL.
- `D:\` in Windows becomes `/mnt/d/` in WSL.

So, when you access `/mnt/c/`, you're actually browsing your Windows `C:` drive **from within Linux**.

## Manually Mounting a Drive in Linux

If you need to manually mount a storage device, you can use:

```bash
sudo mount /dev/sdb1 /mnt/mydrive
```

- `/dev/sdb1` → The device (e.g., a USB drive or partition).
- `/mnt/mydrive` → The mount point where files will be accessible.

To unmount it:

```bash
sudo umount /mnt/mydrive
```

## Mounting a Directory (Bind Mount)

You can also mount a directory to another location using:

```bash
sudo mount --bind /mnt/c/kubernetes /home/user/k8s
```

Now, `/home/user/k8s` will show the same files as `/mnt/c/kubernetes`.

## Why is Mounting Important in Kubernetes?

- **Persistent Storage**: In Kubernetes, volumes are mounted into pods so they can store and share data.
- **HostPath Volumes**: Your script mounts `/mnt/c/kubernetes` into Kubernetes containers so they can read/write data from that folder.
- **WSL Integration**: Since WSL mounts Windows drives under `/mnt/`, it allows Linux processes to interact with Windows files.

