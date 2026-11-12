<script setup>
import { computed, reactive, ref } from 'vue'

const props = defineProps({
  steps: { type: Array, required: true },
})

const index = ref(0)
const runs = reactive({})
const localRunner = import.meta.env.DEV
const step = computed(() => props.steps[index.value])
const run = computed(() => runs[step.value?.id])
const outputLines = computed(() => {
  const stdout = run.value?.result?.stdout
  return stdout ? stdout.replace(/\r?\n$/, '').split(/\r?\n/) : []
})

async function execute() {
  const id = step.value.id
  if (!localRunner || runs[id]?.pending) return
  runs[id] = { pending: true }
  try {
    const response = await fetch('/__lesson02/run/' + encodeURIComponent(id), {
      method: 'POST',
    })
    const data = await response.json()
    runs[id] = response.ok ? { result: data } : { error: data.error }
  } catch {
    runs[id] = { error: '无法连接本机 Bash。请用 npm run dev 启动课件。' }
  }
}
</script>

<template>
  <section v-if="step" class="notebook" aria-label="Bash Notebook" @click.stop>
    <div class="notebook-tabs" role="group" aria-label="选择演示单元">
      <button
        v-for="(item, itemIndex) in steps"
        :key="item.id"
        type="button"
        :aria-pressed="itemIndex === index"
        @click="index = itemIndex"
      >{{ item.title }}</button>
    </div>

    <div class="notebook-cell">
      <div class="cell-toolbar">
        <button
          type="button"
          class="cell-run"
          :disabled="!localRunner || run?.pending"
          @click="execute"
        ><span aria-hidden="true"></span>{{ run?.pending ? '运行中' : '运行' }}</button>
        <span class="cell-language">Bash</span>
      </div>
      <div class="cell-code" aria-label="预填命令">
        <div v-for="(line, lineIndex) in step.command.split('\n')" :key="lineIndex" class="cell-line">
          <span aria-hidden="true">{{ lineIndex + 1 }}</span>
          <code>{{ line }}</code>
        </div>
      </div>

      <div class="cell-result" aria-live="polite">
        <div v-if="run?.result" class="cell-summary">
          <span>{{ outputLines.length ? outputLines.length + ' 行输出' : '无标准输出' }}</span>
          <span>{{ run.result.elapsedMs }} ms</span>
          <span :class="{ 'cell-error': run.result.exitCode !== 0 }">退出码 {{ run.result.exitCode }}</span>
        </div>
        <p v-else-if="run?.error" class="cell-summary cell-error">{{ run.error }}</p>
        <p v-else class="cell-summary">{{ !localRunner ? '本机放映时可运行此单元' : run?.pending ? '等待 Bash 返回' : '尚未运行' }}</p>

        <table v-if="outputLines.length" class="cell-output" aria-label="标准输出">
          <thead><tr><th scope="col">行</th><th scope="col">stdout</th></tr></thead>
          <tbody>
            <tr v-for="(line, lineIndex) in outputLines" :key="lineIndex">
              <th scope="row">{{ lineIndex + 1 }}</th><td><code>{{ line }}</code></td>
            </tr>
          </tbody>
        </table>
        <div v-if="run?.result?.stderr" class="cell-stderr">
          <strong>stderr</strong><pre>{{ run.result.stderr }}</pre>
        </div>
      </div>
    </div>
  </section>
</template>
