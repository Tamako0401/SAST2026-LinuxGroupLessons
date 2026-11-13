import { execFile } from 'node:child_process'
import { mkdtemp, rm } from 'node:fs/promises'
import { tmpdir } from 'node:os'
import { isAbsolute, join } from 'node:path'
import { promisify } from 'node:util'
import { statusLogSteps } from './demos/status-log.js'
import { coverGreetSteps } from './demos/cover-greet.js'
import { blackBoxSteps } from './demos/black-box.js'

const exec = promisify(execFile)
const presets = new Map([...statusLogSteps, ...coverGreetSteps, ...blackBoxSteps].map(({ id, command }) => [id, command]))
const endpoint = '/__lesson02/run/'

function reply(response, status, data) {
  response.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Cache-Control': 'no-store',
  })
  response.end(JSON.stringify(data))
}

async function runPreset(command) {
  const windows = process.platform === 'win32'
  const bash = process.env.LESSON02_BASH || (windows
    ? join(process.env.ProgramFiles || 'C:\\Program Files', 'Git', 'bin', 'bash.exe')
    : '/bin/bash')
  if (!isAbsolute(bash)) throw new Error('LESSON02_BASH 必须是 Bash 可执行文件的绝对路径。')

  const cwd = await mkdtemp(join(tmpdir(), 'sast-lesson02-'))
  const env = { ...process.env }
  delete env.BASH_ENV
  delete env.ENV
  const script = windows ? 'export PATH="/usr/bin:/bin:$PATH"\n' + command : command
  const started = performance.now()
  const execution = (output, exitCode) => ({
    stdout: output.stdout,
    stderr: output.stderr,
    exitCode,
    elapsedMs: Math.round(performance.now() - started),
  })

  try {
    const output = await exec(bash, ['--noprofile', '--norc', '-eo', 'pipefail', '-c', script], {
      cwd, env, encoding: 'utf8', timeout: 4000, maxBuffer: 64 * 1024, windowsHide: true,
    })
    return execution(output, 0)
  } catch (error) {
    if (typeof error.code === 'number') return execution(error, error.code)
    if (error.code === 'ENOENT') throw new Error('找不到 Bash。请检查 Git Bash 或 LESSON02_BASH。')
    if (error.code === 'ERR_CHILD_PROCESS_STDIO_MAXBUFFER') throw new Error('输出超过 64 KiB。')
    if (error.killed) throw new Error('命令运行超时。')
    throw error
  } finally {
    // Only remove the directory created by mkdtemp for this run.
    await rm(cwd, { recursive: true, force: true })
  }
}

export default {
  plugins: [{
    name: 'lesson02-local-bash',
    apply: 'serve',
    configureServer(server) {
      server.middlewares.use(async (request, response, next) => {
        if (!request.url?.startsWith(endpoint)) return next()
        if (request.method !== 'POST') {
          response.setHeader('Allow', 'POST')
          return reply(response, 405, { error: '请用课件中的运行按钮。' })
        }

        const { host, origin } = request.headers
        const localHost = /^(?:localhost|127\.0\.0\.1|\[::1\])(?::\d+)?$/.test(host || '')
        const loopback = ['127.0.0.1', '::1', '::ffff:127.0.0.1'].includes(request.socket.remoteAddress)
        if (!localHost || !loopback || origin !== 'http://' + host)
          return reply(response, 403, { error: '请从本机课件运行演示。' })

        const command = presets.get(request.url.slice(endpoint.length))
        if (!command) return reply(response, 404, { error: '没有这个演示单元。' })

        try {
          reply(response, 200, await runPreset(command))
        } catch (error) {
          reply(response, 500, { error: error.message })
        }
      })
    },
  }],
}
