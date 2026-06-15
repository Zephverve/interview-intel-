# interview-intel

面经智能收集与面试预测 Agent Skill（开放 SKILL.md 格式）。

**v1.2.0** · 输入岗位 + **可选公司范围** + **可选简历** → 多源搜集真实面经 → P0/P1/P2 预测题 + **完整口语标准答案** + **分轮次个性化预测** + 7 天计划。

兼容 **Cursor · Claude Code · OpenAI Codex**。

## 更新日志

| 版本 | 变更 |
|------|------|
| **1.2.0** | P1/P2 完整口语答案；有简历时必出分轮次个性化预测（一面/二面/三面/HR） |
| 1.1.0 | 多平台安装；公司范围；references/ 结构；管理命令 |
| 1.0.0 | P0 完整标准答案；多源面经搜索 |

## 公司范围（Phase 0 可选）

| 选项 | 说明 |
|------|------|
| **不限**（默认） | 混合大厂/中小/外企/独角兽样本，报告分区展示 |
| **大厂** | 字节/阿里/腾讯/美团/京东/百度/快手等 |
| **中小厂** | 创业公司、融资阶段公司 |
| **外企** | Google/Microsoft/Amazon 等 + 英文面经 |
| **独角兽** | Minimax/智谱/月之暗面/DeepSeek 等 |
| **金融/银行** | 银行科技、金融科技 |
| **指定公司** | 如「只看美团」 |
| **不要大厂** | 侧重中小厂 + 独角兽 |

## 触发示例

```
用 interview-intel，岗位：Agent 开发，公司范围：不限
搜面经，岗位：后端开发，只看中小厂
收集面经 + 简历 @resume.pdf，目标：字节 Agent 实习
```

## 安装

**方式 A · 解压安装**

```bash
unzip interview-intel-v1.2.0.zip
cd interview-intel
./install.sh          # Cursor + Claude Code + Codex
./install.sh cursor   # 仅 Cursor
```

**方式 B · Git clone**

```bash
git clone https://github.com/YOUR_USERNAME/interview-intel.git
cd interview-intel
./install.sh
```

**打包（维护者）**

```bash
./pack.sh          # 默认 v1.2.0 → dist/interview-intel-v1.2.0.zip
./pack.sh 1.2.1    # 指定版本号
```

| 工具 | 个人路径 |
|------|----------|
| Cursor | `~/.cursor/skills/interview-intel/` |
| Claude Code | `~/.claude/skills/interview-intel/` |
| Codex | `~/.agents/skills/interview-intel/` |

## 目录结构

```
interview-intel/
├── SKILL.md
├── references/
│   ├── search-strategy.md    # 多平台搜索与 WebFetch
│   ├── role-keywords.md      # 岗位 + 公司类型扩展
│   ├── analysis-methods.md   # P0/P1/P2 与分类
│   ├── output-template.md    # 报告与单题模板
│   └── resume-parse.md       # ✅⚠️💡 简历交叉
├── examples/
│   └── agent-engineer.md
├── install.sh
└── README.md
```

## 输出

- 面经摘要 + 来源 URL
- **P0/P1/P2** 每题：核心要点 + **完整口语标准答案** + 追问方向
- **分轮次预测**（无简历=通用；**有简历=绑定项目的一/二/三面/HR 预测表**）
- 7 天计划 · 反问建议
- 简历 ✅强匹配 / ⚠️薄弱 / 💡优势（可选）

## License

MIT
