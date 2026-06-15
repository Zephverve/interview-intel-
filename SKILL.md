---
name: interview-intel
description: >-
  Collects interview experience (面经) from Nowcoder, Zhihu, CSDN, Xiaohongshu, GitHub and
  more for any job role and company type (big tech, startups, foreign firms, unicorns).
  Outputs P0/P1/P2 predicted questions with full standard oral answers, 7-day plan, and
  resume cross-analysis. Use when user says 收集面经, 搜面经, 面经分析, 面试预测, 帮我看面经,
  这个岗位面试会问什么, XX岗位面经, 大厂面试经验, 搜索面试题, interview experience, 面经收集,
  or asks to prepare for Agent/RAG/LLM/backend interviews.
---

# 面经智能收集与面试预测 · interview-intel

> **语言**：自动检测用户语言，全程使用同一语言回复。
>
> **公司覆盖**（Phase 0 可选，默认「不限」混合各类型）：
> 大厂 · 中小厂 · 外企 · 独角兽 · 金融/银行 · 指定公司名
> —— 见 [references/role-keywords.md](references/role-keywords.md)

Agent Skill（SKILL.md 开放格式）。兼容 Cursor、Claude Code、OpenAI Codex。

## 触发示例

- 「帮我收集 Agent 开发面经」
- 「搜一下字节 Agent 岗最近面经」
- 「中小厂后端面试一般问什么」
- 「根据面经预测 + 简历 @resume.pdf」
- 「用 interview-intel，岗位：大模型应用 Agent，公司：不限」

## 输出深度（必遵）

1. 面经情报摘要（流程、公司差异、近 3 个月趋势）
2. 高频考点表 + **P0/P1/P2 预测题**
3. **P0/P1/P2 每题均含标准口语答案正文**（禁止「摘要」「只写 2 句」）
   - P0：1.5–3 分钟 · P1：1–1.5 分钟 · P2：0.5–1 分钟（完整段落，非 bullet）
4. **分轮次预测**（一面/二面/三面/HR）：无简历=通用高频；**有简历=每轮列出个性化预测题+为何会问**
5. 简历交叉 ✅⚠️💡（有简历时，见 resume-parse.md 分轮次模板）
6. 7 天准备计划 + 反问建议 + **来源 URL 清单**

单题格式见 [references/output-template.md](references/output-template.md)。

## 进度检查清单

```
- [ ] Phase 0: 解析输入（岗位/公司范围/级别/简历/时间）
- [ ] Phase 1: 多源 WebSearch（见 search-strategy.md）
- [ ] Phase 2: WebFetch 深度提取（8–10 篇）
- [ ] Phase 3: 去重 + 频次 + P0/P1/P2（见 analysis-methods.md）
- [ ] Phase 4: 简历交叉（如有）
- [ ] Phase 5: 按 output-template 输出完整报告
```

---

## Phase 0 · 输入解析

**必填**：岗位名（如「Agent 开发」「大模型应用工程师」）

**选填**：

| 字段 | 默认 | 说明 |
|------|------|------|
| **公司范围** | 不限 | 见下表；用户可说「不要大厂」「只看中小厂」 |
| 目标公司 | — | 具体公司名（可与范围叠加） |
| 级别 | 实习/校招 | 社招则调整搜索词 |
| 时间范围 | 近 12 个月 | AI 岗优先近 6 个月；可缩至 3 个月 |
| 简历 | 无 | `@file` 或粘贴路径 |
| base | 不限 | |

### 公司范围选项

| 用户输入 | 搜索策略 |
|----------|----------|
| **不限**（默认） | 混合大厂+中小+独角兽样本，报告中分区展示 |
| **大厂** | 字节/阿里/腾讯/美团/京东/百度/快手/拼多多等 |
| **中小厂** | 创业公司、B 轮、融资、非大厂面经 |
| **外企** | Google/Microsoft/Amazon/Meta + 英文 `interview experience` |
| **独角兽** | Minimax/智谱/月之暗面/DeepSeek/商汤等 |
| **金融/银行** | 银行科技、券商 IT、金融科技面经 |
| **指定公司** | 搜索词直接加公司名 |

岗位扩展词、公司别名： [references/role-keywords.md](references/role-keywords.md)

---

## Phase 1 · 多源搜索

详见 [references/search-strategy.md](references/search-strategy.md)。

并行 WebSearch，覆盖：**牛客 · 知乎 · CSDN · 小红书 · 微信(搜狗) · GitHub · 通用 web**。

- 根据 Phase 0 **公司范围**追加搜索词（外企加英文、中小厂加「创业公司」等）
- 目标：去重后 **≥8 篇** 高质量面经（含具体题目）
- 小红书：WebSearch 间接获取，标注「二手来源」

---

## Phase 2 · 深度提取

对 **8–10 篇** 高价值 URL 用 WebFetch 抓正文。

提取字段：原题 · 类型（算法/八股/系统设计/项目/行为/HR）· 轮次 · 公司 · 日期

**WebFetch prompt 要点**：提取所有面试问题；标注类型与轮次；保留作者回答要点。

失败则跳过（最多重试 2 次）。去重：语义相似题合并，统计出现篇数。

---

## Phase 3 · 聚合与分级

详见 [references/analysis-methods.md](references/analysis-methods.md)。

### P0 / P1 / P2

| 级别 | 标准 |
|------|------|
| **P0** | ≥3 篇面经出现，或 ≥2 家公司，或岗位 must_cover 核心题 |
| **P1** | 2 篇面经，或与简历强 match |
| **P2** | 1 篇或差异化加分项 |

每题标注：`[面经原文]` / `[推断]` / `[通用共识]`

### 分维度 + 分轮次

- **类型**：算法 · 八股 · 系统设计 · 项目深挖 · 行为 · HR
- **轮次**：一面（算法+基础+简历）· 二面（系统设计+项目）· 三面 · HR
- **趋势**：近 3 个月新热点单独列出

### 标准答案（强制）

P0/P1 每题必须含：
- 📊 频次与公司
- 📖 核心要点（3 条）
- 🗣️ **标准口语答案**（口语化、先结论后展开、含【替换点】）
- 🔍 追问方向（2–3 条）

写法：像对面试官说话，不是笔记。见 output-template。

### Agent 岗覆盖检查

ReAct/MCP · LangGraph · RAG · Memory · 系统设计 · 评估 · 行为面 —— 缺项在 P1 补 `[通用共识]`。

---

## Phase 4 · 简历交叉

有简历时读 [references/resume-parse.md](references/resume-parse.md)：

- ✅ **强匹配**：面经高频 ∩ 简历项目 → 必被深挖 + data point
- ⚠️ **薄弱项**：面经高频但简历无 → 补洞或话术
- 💡 **优势项**：简历亮点但面经少 → 主动引导

无简历：输出通用项目深挖模板（STAR + 追问链）。

**有简历时额外必出 · 分轮次个性化预测**（独立章节，不可省略）：

对每一轮输出：**预测题列表（5–8 道/轮）+ 简历关联点 + 建议准备的 data point**。

| 轮次 | 预测逻辑 |
|------|----------|
| 一面 | 简历项目初筛 + Agent/RAG 基础 + 与 GenericAgent/科研问答 直接相关的题 |
| 二面 | 深挖最强项目 + 系统设计 + 面经 P0 中与简历交集的题 |
| 三面 | 架构取舍 + 行业认知 + 简历 claim 的 bold 点验证 |
| HR | 动机 + 稳定性（一般不绑项目，除非实习空档） |

模板见 [references/resume-parse.md](references/resume-parse.md#分轮次个性化预测)。

---

## Phase 5 · 输出报告

严格按 [references/output-template.md](references/output-template.md)。

**禁止**：编造 URL · 把 `[推断]` 标成 `[面经原文]` · 只有要点无口语答案

落盘：`./interview-intel/{岗位-slug}-{日期}.md`（用户要求时）

---

## 管理命令

| 用户说 | 动作 |
|--------|------|
| 换一批面经 | 扩大搜索词/换平台，重新 Phase 1–5 |
| 只看 XX 公司 | 过滤公司范围并重跑 |
| 只看最近 3 个月 | 缩小时间窗 |
| 多搜算法题 / 八股 | 侧重某类型 |
| 详细解答第 N 题 | 单题 deep dive + 追问答法 |
| 基于面经出 10 道模拟题 | 在报告基础上生成模拟卷（可提示用户另开 mock 流程） |

---

## 参考资料

| 文件 | 内容 |
|------|------|
| [references/search-strategy.md](references/search-strategy.md) | 各平台 query、筛选、WebFetch |
| [references/role-keywords.md](references/role-keywords.md) | 岗位扩展、**公司类型**适配 |
| [references/analysis-methods.md](references/analysis-methods.md) | 频次、分类、趋势 |
| [references/output-template.md](references/output-template.md) | 报告与单题模板 |
| [references/resume-parse.md](references/resume-parse.md) | ✅⚠️💡 交叉规则 |
| [examples/agent-engineer.md](examples/agent-engineer.md) | Agent 岗输出范例 |
