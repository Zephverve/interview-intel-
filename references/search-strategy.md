# 搜索与抓取策略

## Query 构造

变量：`{role}` 岗位 · `{keywords}` 扩展词（见 role-keywords.md）· `{company}` 公司名 · `{scope}` 公司范围词 · `{year}` 当前年及前一年

### 必跑搜索（并行，≥8 条）

```
1. site:nowcoder.com "{role}" 面经 {year}
2. site:nowcoder.com "{role}" 面试 {company}
3. site:zhihu.com "{role}" 面试 面经 {scope}
4. site:weixin.sogou.com "{role}" 面试 面经
5. site:csdn.net "{role}" 面经 OR 面试经历
6. site:github.com "{role}" interview questions OR 面经
7. "{role}" "{keywords}" 面经 一面 二面 {year}
8. 小红书 "{role}" 面经 OR site:xiaohongshu.com "{role}" 面试
```

### 按公司范围追加

| 范围 | 追加 query |
|------|------------|
| 大厂 | `{role} 字节 阿里 腾讯 美团 面经` |
| 中小厂 | `{role} 创业公司 中小厂 面经 面试` |
| 外企 | `{role} interview experience Google Amazon Microsoft` + `site:leetcode.com/discuss` |
| 独角兽 | `{role} Minimax 智谱 月之暗面 DeepSeek 面经` |
| 金融 | `{role} 银行 金融科技 面经 面试` |
| 指定公司 | `site:nowcoder.com {company} {role} 面经` |

### 补漏（高质量面经 <8 篇时）

```
9. site:leetcode.cn 面经 "{role}"
10. "{role}" 实习 面试 经验
11. site:juejin.cn "{role}" 面试
12. "{role}" 秋招 春招 面经 {year}
```

## 平台特性

| 平台 | 优先级 | 注意 |
|------|--------|------|
| 牛客 | P0 | 结构化好，优先 WebFetch |
| 知乎 | P0 | 长文多 |
| CSDN/掘金 | P1 | 过滤培训班广告 |
| GitHub | P1 | 整理帖 credibility=medium |
| 搜狗微信 | P1 | 链接可能失效 |
| 小红书 | P2 | 二手来源，标注可信度 |
| LeetCode Discuss | P2 | 外企/算法岗 |

## 筛选标准

**保留**：
- 含 ≥3 道具体面试题
- 12 个月内（AI 岗优先 6 个月）
- 有公司或岗位信息

**丢弃**：
- 纯广告/引流 · 无具体题 · 与岗位无关 · 正文过短

目标：去重后 **8–15 篇** 进入 Phase 2。

## 可信度

| 级别 | 条件 |
|------|------|
| high | 公司+轮次+具体题+技术细节，≤18 个月 |
| medium | 部分细节或 GitHub 整理 |
| low | 泛泛而谈/过时 — **不参与 P0** |

## WebFetch

- 上限 **10 URL/次**，优先牛客/知乎
- 单篇 >5000 字可分段提取
- 失败跳过，最多重试 2 次

## WebFetch 提取 prompt

```
从页面提取所有面试相关问题：
1. 原题或规范概括
2. 类型：算法/八股/系统设计/项目/行为/HR
3. 轮次（如有）
4. 公司（如有）
5. 作者回答要点或面试官反馈（如有）
```
