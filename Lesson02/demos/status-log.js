const prepareLog = "printf '%s\\n' 200 404 200 500 404 > status.log"

export const statusLogSteps = [
  {
    id: 'prepare-log',
    title: '准备日志',
    command: prepareLog,
  },
  {
    id: 'filter-log',
    title: '筛选整行',
    command: prepareLog + "\ngrep -x '404' status.log",
  },
  {
    id: 'count-log',
    title: '统计行数',
    command: prepareLog + "\ngrep -x '404' status.log | wc -l",
  },
]
