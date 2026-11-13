const prepareLog = "printf '%s\\n' 200 404 200 500 404 > status.log"

export const blackBoxSteps = [
  {
    id: 'black-box-grep',
    title: 'grep',
    command: `${prepareLog}\ngrep '404' status.log`,
    highlight: '',
  },
  {
    id: 'black-box-wc',
    title: 'wc',
    command: `${prepareLog}\ngrep -x '404' status.log | wc -l`,
    highlight: '',
  },
]
