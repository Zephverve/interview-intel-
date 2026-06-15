# 标杆示例 · 大模型应用工程师（Agent 方向）

本文件展示 `interview-intel` 对 Agent 岗的**目标输出深度**。实际运行时面经内容来自实时搜索；本示例考点基于近 18 个月业界共识 + 典型面经结构，供 Agent 对照格式与粒度。

---

# 大模型应用工程师（Agent 方向）· 面试情报报告

> 生成时间：2026-06-14 | 有效面经：示例（非实时） | 简历：无 | 目标：大厂实习 · base 不限

---

## 1. 面经情报摘要

### 常见面试流程

| 轮次 | 时长/形式 | 常见内容 |
|------|-----------|----------|
| 一面 | 45–60min · 视频 | 自我介绍 → 1–2 个项目深挖 → Agent/RAG 八股 → 手撕/场景题 |
| 二面 | 45–60min | 项目架构 + 系统设计（Agent 服务/RAG 链路）→ 难点与 trade-off |
| 三面/HR | 30min | 稳定性、职业规划、反问 |

### 各公司差异（典型样本）

| 公司 | 特点 |
|------|------|
| 字节 | 项目挖得深，常问 Agent 评估、成本；手撕中等 |
| 阿里 | RAG+Agent 交叉多，爱问 LangGraph/工作流对比 |
| 腾讯 | 业务场景题多，微信生态相关 Agent 有加分 |
| 美团 | 工程落地、延迟和稳定性权重大 |

### 近 18 个月趋势

- **Multi-Agent / MCP** 追问明显增多
- **Memory 设计**（短期/长期/工具记忆）成为二面高频
- 纯 Transformer 八股占比下降，**「你的 Agent 怎么评估、怎么防幻觉、怎么控成本」** 占比上升

---

## 2. 高频考点

| 考点 | 频次 | 代表公司 | 典型问法 |
|------|------|----------|----------|
| 项目深挖（Agent/RAG） | 8/8 | 全部 | 「详细介绍你做的 Agent，架构怎么设计的？」 |
| ReAct / Tool Use | 7/8 | 字节、阿里 | 「ReAct 和 Plan-and-Execute 区别？怎么选？」 |
| Function Calling | 6/8 | 字节、腾讯 | 「Native FC 和文本协议兜底各有什么坑？」 |
| RAG 全链路 | 6/8 | 阿里、美团 | 「检索不准怎么排查？混合检索怎么做？」 |
| Memory / 上下文 | 5/8 | 字节 | 「Agent 长期记忆怎么设计？和向量库有什么区别？」 |
| 安全与沙箱 | 4/8 | 阿里 | 「code_run 类工具怎么防注入？」 |
| 评估与监控 | 4/8 | 字节、美团 | 「怎么衡量 Agent 任务成功率？」 |
| Transformer 基础 | 4/8 | 全部 | 「Self-attention、KV cache 讲一遍」 |

---

## 3. 预测题库

### P0 · 必考

#### Q1. 自我介绍 + 项目经历 `[通用共识]`

**回答要点**：
- 1.5 分钟结构：背景 → 技术主线（Agent/RAG）→ 2 个代表项目（各 2–3 句 + 1 个数字）→ 求职动机
- 主动锚定最想被问的项目，避免面官随机挑弱项
- 结尾可接：「您想先听 Agent 框架还是 RAG 系统？」

#### Q2. 详细介绍你的 Agent 项目，架构怎么设计的？ `[面经原文]`

**回答要点**：
- 四层讲：接入层 / 执行引擎（ReAct 循环）/ 工具层 / LLM 接入层
- 强调 1 个设计决策及理由（如 display_queue 解耦、Native vs 文本协议）
- 准备架构图（ mentally 或白板）：用户 → 前端 → Agent Loop → Tools → LLM
- 数字：工具数量、max_turns、典型任务轮数

#### Q3. ReAct 是什么？和你的实现有什么区别？ `[面经原文]`

**回答要点**：
- ReAct = Reasoning + Acting 交替：Thought → Action → Observation 循环
- 与 Chain-of-Thought 区别：CoT 只推理不执行；ReAct 可调用外部工具
- 实现细节：消息格式、tool result 如何回填、终止条件（无 tool call / max_turns）
- 局限：轮次多延迟高、错误工具调用累积

#### Q4. Function Calling / Tool Use 怎么实现的？Native 和文本协议差异？ `[面经原文]`

**回答要点**：
- Native：模型 API 原生 tools 参数，结构化好、解析稳
- 文本协议：XML/JSON 文本描述工具，兼容非 FC 模型
- 兜底策略：MixinSession 故障转移
- 坑：参数 JSON 解析失败、模型幻觉 tool name、parallel tool calls

#### Q5. Agent 的记忆系统怎么设计？和 RAG 有什么区别？ `[推断]`

**回答要点**：
- 短期：对话 history + working memory（key_info）
- 长期：分层文本索引（L0 规则 / L1 索引 / L2 事实 / L3 SOP）vs 向量 RAG
- Agent 记忆偏「精确检索 +  procedural」；RAG 偏「语义相似 + 文档」
- Token 预算：什么进 context、什么写文件、什么结晶为 SOP

#### Q6. RAG 链路讲一遍，你做过哪些优化？ `[面经原文]`

**回答要点**：
- Pipeline：解析 → chunk → embed → retrieve → rerank → generate
- 至少 2 项优化：混合检索 BM25+向量、Cross-Encoder 重排、query 改写、分层 chunk
- 指标：Recall@K、MRR、引用准确率、P95 延迟
- 失败 case：长尾术语、多跳推理、表格/公式

#### Q7. 怎么防止 Agent 幻觉和危险工具调用？ `[推断]`

**回答要点**：
- 工具层：沙箱、权限白名单、code_run 隔离
- 协议层：patch 唯一匹配、max_turns、敏感操作 ask_user
- 输出层：引用约束、结构化校验
- 监控：异常 tool 调用告警

#### Q8. Transformer self-attention 和 KV cache `[通用共识]`

**回答要点**：
- Q/K/V、scaled dot-product、多头意义
- KV cache：自回归推理缓存历史 K/V，O(n²)→O(n) 每步
- 延伸：GQA 省显存（若简历有 LLM 微调可挂钩）

#### Q9. LangGraph / LangChain 和你的方案怎么选？ `[面经原文]`

**回答要点**：
- LangGraph：显式图/状态机，适合复杂工作流、可观测
- 自研 ReAct loop：轻量、灵活、适合开放性任务
- 不说「LangChain 不好」——说场景：预定义 flow vs 自主 tool 选择
- 可提：原子工具 + code_run 的图灵完备扩展 vs 预注册工具列表

#### Q10. 手撕/场景：设计一个支持 1000 QPS 的 Agent 服务 `[推断]`

**回答要点**：
- 接入：网关 + 限流 + 异步队列
- 推理：vLLM/批处理、模型副本、KV cache
- Agent：有状态 session 存 Redis、无状态 worker 水平扩展
- 工具：独立微服务、超时熔断
- 观测：trace_id 贯穿 LLM/tool 调用链

---

### P1 · 高频（节选）

#### Q11. Multi-Agent 怎么协作？有没有用过 MCP？ `[推断]`

**回答要点**：Orchestrator 模式 vs 对等通信；MCP 标准化 tool/resource；何时 overkill

#### Q12. Agent 怎么评估？ `[面经原文]`

**回答要点**：任务成功率、步骤效率、工具调用准确率；LLM-as-judge；人工 golden set

#### Q13. BM25 和向量检索为什么要结合？ `[面经原文]`

**回答要点**：稀疏捕获 exact match；稠密捕获语义；RRF 或 weighted fusion

#### Q14. LoRA/QLoRA 微调经验 `[通用共识]`

**回答要点**：rank、target modules、数据量；和 RAG 分工——RAG 找知识，微调改风格/格式

#### Q15. 项目中最大的失败和复盘 `[通用共识]`

**回答要点**：真实 case + 根因 + 改动 + 复测结果（STAR）

---

### P2 · 差异化

| # | 题目 | 标签 | 备注 |
|---|------|------|------|
| 1 | MCP vs 自定义 tool schema | [推断] | 新业务线爱问 |
| 2 | Agent 自我进化/SOP 结晶 | [推断] | 有 GenericAgent 类经验是加分项 |
| 3 | 微信/IM Bot 接入架构 | [面经原文] | 腾讯系 |
| 4 | RLHF/DPO 是否必要 | [通用共识] | 算法岗交叉 |

---

## 4. 简历交叉分析

> 本节为**无简历**时的通用模板。

### 通用项目深挖模板

**Agent 项目必答链**：
1. 为什么做 Agent 而不是固定 workflow？
2. 工具怎么设计？为什么 9 个原子工具够用？
3. ReAct 循环终止条件？最长跑过多少轮？
4. 记忆 L0–L4 各存什么？和 vector DB 比优劣？
5. 评估：怎么知道 Agent 完成得好不好？

**RAG 项目必答链**：
1. baseline 指标？每项优化的 delta？
2. chunk 策略？parent-child 怎么做？
3. 引用错了怎么排查？
4. 延迟瓶颈在哪？怎么压到 P95 X 秒？

### 风险点

- 只说「用了 LangGraph」说不清 state 怎么设计 → 准备 1 张图
- 指标只有 after 没有 before → 补 baseline

---

## 5. 7 天准备计划

| 天 | 主题 | 任务 | 题目 |
|----|------|------|------|
| Day 1 | LLM 基础 | Attention、KV cache、GQA；各写 5 分钟口述稿 | Q8 |
| Day 2 | Agent 原理 | ReAct、FC、Memory；画 Agent 架构图 | Q3–Q5 |
| Day 3 | 项目 A | Agent 项目 STAR + 追问链 mock 3 轮 | Q2, Q9 |
| Day 4 | 项目 B | RAG 项目全链路 + 指标 | Q6, Q13 |
| Day 5 | 系统设计 | Agent 服务 QPS、安全、评估 | Q7, Q10, Q12 |
| Day 6 | 模拟面试 | P0 逐题 45min；录音复盘 | Q1–Q10 |
| Day 7 | 查漏补缺 | P1 浏览 + 反问 3 题 + 行为面 | Q11–Q15 |

---

## 6. 反问建议

1. 团队 Agent 落地的主场景是客服、代码还是 internal tooling？目前最大的 production 瓶颈是什么？
2. 评估体系是人工 golden set 还是自动化 pipeline？Agent trace 怎么沉淀？
3. 实习生在项目里通常 ownership 到哪一层——tool、workflow 还是端到端场景？

---

## 7. 来源索引

> 本文件为**格式标杆**，非实时爬取。实际运行时必须替换为真实 URL 列表。

| # | 说明 |
|---|------|
| — | 运行时由 WebSearch/WebFetch 填充，见 sources.md |

---

> 说「展开 Q2」可获取该题 2 分钟口语化完整答案。
