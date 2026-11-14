export const standardStreamSteps = [
  {
    id: 'stdin-from-file',
    title: '0 · stdin',
    command: "printf '%s\\n' 'hello' > input.txt\ncat 0< input.txt",
  },
  {
    id: 'redirect-stdout',
    title: '1 · stdout',
    command: [
      "{ echo 'hello'; echo 'warning' >&2; } 1> out.txt",
      "cat out.txt",
    ].join('\n'),
  },
  {
    id: 'redirect-stderr',
    title: '2 · stderr',
    command: [
      "{ echo 'hello'; echo 'warning' >&2; } 2> err.txt",
      "cat err.txt",
    ].join('\n'),
  },
]
