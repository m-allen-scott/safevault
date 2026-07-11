# SafeVault – AWS Disaster Recovery & Backup Automation System

## 📌 Project Overview

SafeVault is an AWS-based backup and disaster recovery solution that automatically creates compressed backups of important files, stores them securely in Amazon S3, and restores them whenever required.

The project demonstrates real-world cloud engineering concepts including EC2, IAM Roles, Amazon S3, Bash scripting, configuration management, logging, and automated backup workflows.

---

## 🚀 Features

- Automated backup using Bash
- Folder compression (.tar.gz)
- Timestamp-based backup naming
- Secure backup storage in Amazon S3
- Restore backups from Amazon S3
- Configuration management using config.conf
- Backup verification
- Logging support
- Backup retention policy
- IAM Role authentication (No Access Keys)

---

## ☁️ AWS Services Used

- Amazon EC2
- Amazon S3
- AWS IAM
- AWS CLI
- Amazon CloudWatch (Log Group)
- AWS Systems Manager (SSM)

---

## 🛠 Technologies Used

- Amazon Linux 2023
- Bash Scripting
- Git
- GitHub
- AWS CLI

---

## 📂 Project Structure

```text
SafeVault/
│
├── architecture/
├── documentation/
├── screenshots/
├── ProjectFiles/
├── backups/
├── logs/
├── restore/
│
├── backup.sh
├── restore.sh
├── config.conf
├── README.md
└── backup.txt
```

---

## 🔄 Workflow

```
Project Files
      │
      ▼
backup.sh
      │
      ▼
Compress (.tar.gz)
      │
      ▼
Amazon S3
      │
      ▼
restore.sh
      │
      ▼
Restore Files
```

---

## ▶️ Running the Backup

```bash
./backup.sh
```

---

## ▶️ Restoring a Backup

```bash
./restore.sh
```

---

## 📈 Future Enhancements

- EventBridge Scheduler
- CloudWatch Log Streaming
- SNS Email Notifications
- S3 Lifecycle Policies
- Backup Encryption
- Multi-Region Disaster Recovery

---

## 👨‍💻 Author

**Allen Scott**

AWS Cloud Engineering Project
