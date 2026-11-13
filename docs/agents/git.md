# Git 网络与推送

## 推送代理(Windows 本机)

- 系统代理为 `127.0.0.1:7897`。`gh` CLI 会自动使用系统代理,但 **git 不会**,直连 github.com 经常连接重置。
- 推送/拉取前设置代理环境变量,再执行 git 命令:

```powershell
$env:HTTP_PROXY = 'http://127.0.0.1:7897'
$env:HTTPS_PROXY = 'http://127.0.0.1:7897'
git push origin main
```

- 若代理也失败,才使用 Git Data API 兜底(建 blob → 建 tree → 建 commit → PATCH refs/heads/main)。
- 注意:PowerShell 管道会按控制台编码重新编码字节,**不能**用 `git cat-file blob <sha>:<path> | ...` 或 `>` 重定向中转二进制/中文内容;应使用 `cmd /c "... > 文件"` 捕获原始字节,再按 UTF-8 显式解码。
- PowerShell 的 `ConvertFrom-Json` 会把 ISO8601 日期解析成 DateTime;需要原样字符串时用 `gh api ... --jq '.xxx.date'`。
