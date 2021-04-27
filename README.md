<div align="center">
<h1>Datafuse</h1>
<strong>
Modern Real-Time Data Processing & Analytics DBMS with Cloud-Native Architecture 
</strong>

<br>
<br>

<div>
<a href="https://join.slack.com/t/datafusecloud/shared_invite/zt-nojrc9up-50IRla1Y1h56rqwCTkkDJA">
<img src="https://badgen.net/badge/Slack/Join%20Datafuse/0abd59?icon=slack" alt="slack" />
</a>

<a href="https://github.com/datafuselabs/datafuse/actions">
<img src="https://github.com/datafuselabs/datafuse/actions/workflows/unit-tests.yml/badge.svg" alt="CI Status" />
</a>

<a href="https://codecov.io/gh/datafuselabs/datafuse">
<img src="https://codecov.io/gh/datafuselabs/datafuse/branch/master/graph/badge.svg" alt="codecov" />
</a>

<img src="https://img.shields.io/badge/Platform-Linux,%20ARM,%20OS%20X,%20Windows-green.svg?style=flat" alt="patform" />

<a href="https://opensource.org/licenses/Apache-2.0">
<img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="license" />
</a>

</div>
</div>

Datafuse is a Real-Time Data Processing & Analytics DBMS with Cloud-Native Architecture written
in Rust, inspired by [ClickHouse](https://github.com/ClickHouse/ClickHouse) and powered by [arrow-rs](https://github.com/apache/arrow-rs), built to make it easy to power the Data Cloud.

## Principles

* **Fearless**
  - No data races, No unsafe, Minimize unhandled errors

* **High Performance** 
  - Everything is Parallelism
  
* **High Scalability**
  - Everything is Distributed
  
* **High Reliability**
  - True Separation of Storage and Compute

## Architecture

![Datafuse Architecture](https://datafuse-1253727613.cos.ap-hongkong.myqcloud.com/datafuse-v1.svg)

## Performance

* **Memory SIMD-Vector processing performance only**
* Dataset: 100,000,000,000 (100 Billion)
* Hardware: AMD Ryzen 7 PRO 4750U, 8 CPU Cores, 16 Threads
* Rust: rustc 1.49.0 (e1884a8e3 2020-12-29)
* Build with Link-time Optimization and Using CPU Specific Instructions
* ClickHouse server version 21.2.1 revision 54447

|Query |FuseQuery (v0.1)| ClickHouse (v21.2.1)|
|-------------------------------|---------------| ----|
|SELECT avg(number) FROM numbers_mt(100000000000) | (3.11 s.)| **×3.14 slow, (9.77 s.)** <br /> 10.24 billion rows/s., 81.92 GB/s.|
|SELECT sum(number) FROM numbers_mt(100000000000) | (2.96 s.)| **×2.02 slow, (5.97 s.)** <br /> 16.75 billion rows/s., 133.97 GB/s.|
|SELECT min(number) FROM numbers_mt(100000000000) | (3.57 s.)| **×3.90 slow, (13.93 s.)** <br /> 7.18 billion rows/s., 57.44 GB/s.|
|SELECT max(number) FROM numbers_mt(100000000000) | (3.59 s.)| **×4.09 slow, (14.70 s.)** <br /> 6.80 billion rows/s., 54.44 GB/s.|
|SELECT count(number) FROM numbers_mt(100000000000) | (1.76 s.)| **×2.22 slow, (3.91 s.)** <br /> 25.58 billion rows/s., 204.65 GB/s.|
|SELECT sum(number+number+number) FROM numbers_mt(100000000000) | (23.14 s.)|**×5.47 slow, (126.67 s.)** <br /> 789.47 million rows/s., 6.32 GB/s.|
|SELECT sum(number) / count(number) FROM numbers_mt(100000000000) | (3.09 s.) | **×1.96 slow, (6.07 s.)** <br /> 16.48 billion rows/s., 131.88 GB/s.|
|SELECT sum(number) / count(number), max(number), min(number) FROM numbers_mt(100000000000) |(6.73 s.)| **×4.01 slow, (27.59 s.)** <br /> 3.62 billion rows/s., 28.99 GB/s.|
|SELECT number FROM numbers_mt(10000000000) ORDER BY number DESC LIMIT 1000|(6.91 s.)| **×1.42 slow, (9.83 s.)** <br /> 1.02 billion rows/s., 8.14 GB/s.|
|SELECT max(number),sum(number) FROM numbers_mt(1000000000) GROUP BY number % 3, number % 4, number % 5 |(10.87 s.)| **×1.95 fast, (5.58 s.)** <br /> 179.23 million rows/s., 1.43 GB/s.|


Note:
* ClickHouse system.numbers_mt is <b>16-way</b> parallelism processing
* FuseQuery system.numbers_mt is <b>16-way</b> parallelism processing

## Status

#### General

- [x] SQL Parser
- [x] Query Planner
- [x] Query Optimizer
- [x] Predicate Push Down
- [x] Limit Push Down
- [x] Projection Push Down
- [x] Type coercion
- [x] Parallel Query Execution
- [x] Distributed Query Execution
- [x] Hash GroupBy
- [x] Merge-Sort OrderBy
- [ ] Joins (WIP)

#### SQL Support

- [x] Projection
- [x] Filter (WHERE)
- [x] Limit
- [x] Aggregate Functions
- [x] Scalar Functions
- [x] UDF Functions
- [x] SubQueries
- [x] Sorting
- [ ] Joins (WIP)
- [ ] Window (TODO)


## Getting Started

### Learn Datafuse

* [Architecture](website/datafuse/docs/overview/architecture.md)
* [Performance](website/datafuse/docs/overview/performance.md)
* [SQL](website/datafuse/docs/sqlstatement/)
* [Functions](website/datafuse/docs/functions/)

### Try Datafuse

* [How to Run](website/datafuse/docs/overview/building-and-running.md)
* [How to Run 3-node cluster](scripts/ci/fusequery-cluster-3-nodes.sh)

## Contributing

* [Contribution Guide](website/datafuse/docs/development/contributing.md)
* [Coding Guidelines](website/datafuse/docs/development/coding-guidelines.md)
* [How to Profile](website/datafuse/docs/development/how-to-profile.md)

## Roadmap

- [x] 0.1 Support aggregation select (2021.02)
- [x] 0.2 Support distributed query (2021.03)
- [x] 0.3 Support group by (2021.04)
- [x] 0.4 Support order by (2021.04)
- [ ] 0.5 Support join
- [ ] 1.0 Support TPC-H benchmark

## License

Datafuse is licensed under [Apache 2.0](LICENSE).
