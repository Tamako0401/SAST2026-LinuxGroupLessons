export const coverGreetSteps = [
  {
    id: 'cover-greet',
    title: '今天吃什么',
    command: `string="嘉然今天吃什么"
printf '%s\\n' "$string" | grep "今天吃什么"`,
    highlight: '今天吃什么',
  },
]
