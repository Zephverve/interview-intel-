# 岗位与公司关键词

## 公司范围 · 搜索适配

用户指定范围时，在 query 中追加对应词组（可与具体公司名叠加）。

| 范围 | 搜索扩展 | 报告中的「公司差异」区块 |
|------|----------|-------------------------|
| **不限** | 不强制过滤；样本含多类型 | 按大厂/中小/外企/独角兽分区摘要 |
| **大厂** | 字节 阿里 腾讯 美团 京东 百度 快手 拼多多 华为 | 重点写各厂风格差异 |
| **中小厂** | 创业公司 融资 B轮 C轮 中小厂 非大厂 | 强调工程落地、全栈、业务题 |
| **外企** | Google Microsoft Amazon Meta Apple + English queries | 英文题、系统设计、BQ |
| **独角兽** | Minimax 智谱 月之暗面 DeepSeek 商汤 百川 | Agent/RAG 深度、业务场景 |
| **金融/银行** | 银行 券商 金融科技 风控 信贷 | 稳定性、合规、传统+AI |
| **指定公司** | 直接用公司名 + 别名 | 仅该公司/业务线 |

用户说「**不要大厂**」→ 排除字节/阿里/腾讯等词，侧重中小厂+独角兽 query。

## 公司别名

| 输入 | 搜索扩展 |
|------|----------|
| 字节 | 字节跳动 ByteDance 抖音 TikTok |
| 阿里 | 阿里巴巴 蚂蚁 淘天 阿里云 |
| 腾讯 | 微信 天美 光子 |
| 美团 | 美团 大众点评 |
| 百度 | 百度 文心 |
| 京东 | 京东 零售 物流 |
| 快手 | 快手 直播 |
| 拼多多 | 拼多多 TEMU |

---

## 岗位映射

### 大模型应用工程师 - Agent 方向

| 字段 | 值 |
|------|-----|
| primary | 大模型应用工程师 Agent |
| expand | Agent, AI Agent开发, 智能体, Tool Use, ReAct, Function Calling, LangGraph, Multi-Agent, MCP |
| topic_clusters | Agent架构, Tool/FC, Memory, Planning, Multi-Agent, 安全, RAG交叉, 工程落地 |
| must_cover | ReAct, 工具设计, Memory, Native vs 文本协议, 评估 |

### 大模型应用工程师 - RAG 方向

| 字段 | 值 |
|------|-----|
| primary | 大模型应用工程师 RAG |
| expand | RAG, 检索增强, Embedding, 重排, Chunk, 向量数据库, Hybrid Search, GraphRAG |
| must_cover | 混合检索, Recall/MRR, Cross-Encoder, 幻觉, 延迟 |

### 后端 / AI 平台

| 字段 | 值 |
|------|-----|
| primary | AI 平台 后端工程师 |
| expand | 模型服务, vLLM, 高并发, MLOps, K8s, Agent 服务 |
| must_cover | 推理服务, 限流降级, 可观测性 |

### NLP/LLM 算法

| 字段 | 值 |
|------|-----|
| primary | NLP 算法工程师 大模型 |
| expand | Transformer, LoRA, RLHF, SFT, 推理优化 |
| must_cover | Attention, 微调对比, KV cache |

### Fallback

1. 保留用户原词为 `primary`
2. `expand` = 拆词 + 同义词（Agent开发 → Agent, 智能体, LLM应用）
3. 从 Phase 1 结果提取共现词作 topic_clusters
4. 搜索 `"{岗位} 面试 考点"` 辅助 must_cover

### 岗位名模糊扩展示例

| 用户输入 | 同步搜索 |
|----------|----------|
| Agent开发 | AI Agent开发, 大模型应用开发, 智能体开发 |
| 后端 | 后端开发, Java后端, Go后端（按简历技术栈选） |
