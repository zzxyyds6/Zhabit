# Issue 追踪器:GitHub

本仓库的 issue 与规格说明都以 GitHub issue 形式存放,所有操作使用 `gh` CLI。

## 约定

- **创建 issue**:`gh issue create --title "..." --body "..."`。多行正文使用 heredoc。
- **读取 issue**:`gh issue view <number> --json number,title,body,labels,comments`。
- **列出 issue**:`gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`,按需加 `--label` 和 `--state` 过滤。
- **将 issue 设为父 issue 的子项**:创建时用 `gh issue create --parent <parent> ...`,或事后用 `gh issue edit <parent> --add-sub-issue <child>`(`gh` 2.94+)。旧版 `gh`:`gh api --method POST repos/<owner>/<repo>/issues/<parent>/sub_issues -F sub_issue_id=<child-db-id>`(数据库 id,见下方"阻塞")。没有子 issue 功能时,在子项正文顶部写 `Part of #<parent>`。
- **阻塞**:使用 GitHub 原生 issue 依赖,这是规范且在 UI 可见的表示方式。添加依赖:`gh issue create --blocked-by <n>,<n> ...` 或 `gh issue edit <child> --add-blocked-by <blocker>`(`gh` 2.94+)。旧版 `gh`:`gh api --method POST repos/<owner>/<repo>/issues/<child>/dependencies/blocked_by -F issue_id=<blocker-db-id>`,其中 `<blocker-db-id>` 是阻塞者的数字**数据库 id**(`gh api repos/<owner>/<repo>/issues/<n> --jq .id`,不是 `#number` 或 `node_id`)。依赖不可用时,退化为在子项正文顶部写 `Blocked by: #<n>, #<n>`。当所有阻塞者关闭后,工单即视为可开始。
- **统计未关闭的阻塞者**:`gh api repos/<owner>/<repo>/issues/<n> --jq .issue_dependencies_summary.blocked_by`(只统计 open 的;0 表示可开始)。`gh issue view <n> --json blockedBy` 也会列出已关闭的阻塞者,需过滤:`--jq '[.blockedBy.nodes[] | select(.state == "OPEN")] | length'`。
- **评论 issue**:`gh issue comment <number> --body "..."`。
- **添加 / 移除标签**:`gh issue edit <number> --add-label "..."` / `--remove-label "..."`。
- **关闭**:先用 `gh issue comment <number> --body "..."` 写明原因,再 `gh issue close <number>`。对已关闭的 issue 执行 `gh issue close --comment` 会丢弃评论但仍返回退出码 0。

在仓库克隆内运行时,`gh` 会根据 `git remote -v` 自动推断仓库。

只能向用户自己的仓库提 issue。除非用户拥有 `mattpocock/skills`,否则绝不向其提 issue。在 fork 中,`gh` 可能默认指向上游仓库,因此会话内第一次 `gh issue create` 之前,先用 `gh repo view --json nameWithOwner` 检查目标仓库;若不是用户的仓库,先与其确认。

## Pull request 作为分类入口

**PR 作为请求入口:否。**(若本仓库把外部 PR 当作功能请求处理,把此值改为 `yes`;`/triage` 会读取此开关。)

设为 `yes` 时,PR 走与 issue 相同的标签和状态,使用对应的 `gh pr` 命令:

- **读取 PR**:`gh pr view <number>`,再用 `gh pr view <number> --comments`(非 TTY 时 `--comments` 只输出评论,不含正文);diff 用 `gh pr diff <number>`。
- **列出待分类的外部 PR**:`gh api --paginate 'repos/{owner}/{repo}/pulls?state=open' --jq '.[] | select(.author_association | IN("OWNER","MEMBER","COLLABORATOR") | not) | {number, title, author: .user.login, author_association, labels: [.labels[].name]}'`。
- **评论 / 标签 / 关闭**:`gh pr comment`、`gh pr edit --add-label`/`--remove-label`、`gh pr close`。

GitHub 上 issue 和 PR 共用同一个编号空间,裸 `#42` 可能是两者之一:先用 `gh pr view 42` 解析,失败再回退到 `gh issue view 42`。

## 当技能说"发布到 issue 追踪器"

创建一个 GitHub issue。

## 当技能说"获取相关工单"

按上面**读取 issue** 的方式读取。

## Wayfinder 操作

供 `/wayfinder` 使用。**地图**是一个单独的 issue,其子 issue 即为工单。

- **地图**:一个带 `wayfinder:map` 标签的 issue,正文包含笔记 / 已决事项 / 迷雾区。创建:`gh issue create --label wayfinder:map`。
- **子工单**:以 GitHub 子 issue 形式挂到地图(见"将 issue 设为父 issue 的子项")。子 issue 不可用时,把子项加入地图正文的任务列表,并在子项正文顶部写 `Part of #<map>`。标签:`wayfinder:<type>`(`research`/`prototype`/`grilling`/`task`)。工单被认领后指派给推进的开发者。
- **阻塞**:见"约定"下的**阻塞**。
- **前沿查询**:列出地图的未关闭子项(`gh issue list --state open`,限定地图的子 issue / 任务列表),剔除有未关闭阻塞者(见"统计未关闭的阻塞者",或 `Blocked by` 行中存在 open issue)或已被认领的项;按地图顺序取第一个。
- **认领**:`gh issue edit <n> --add-assignee @me`,这应是会话中的第一次写操作。
- **解决**:`gh issue comment <n> --body "<答复>"`,然后 `gh issue close <n>`,再把上下文指针(gist + 链接)追加到地图的"已决事项"。