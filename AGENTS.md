# AGENTS.md

## 交流语言

所有交流一律使用中文:回复、计划、代码注释、提交信息、issue 评论均如此。

## Agent skills

### Issue 追踪器

Issue 存放在 GitHub Issues:`zzxyyds6/Zhabit`(通过 `gh` CLI 操作)。参见 `docs/agents/issue-tracker.md`。

### 分类标签

使用默认的五角色分类标签词汇。参见 `docs/agents/triage-labels.md`。

### 领域文档

单上下文布局:仓库根目录的 `GLOSSARY.md` + `docs/adr/`。参见 `docs/agents/domain.md`。

### Git 网络

git 直连 github.com 易失败,推送/拉取前先设置系统代理环境变量。参见 `docs/agents/git.md`。