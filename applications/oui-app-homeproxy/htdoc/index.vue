<template>
  <div class="space-y-6">
    <h1 class="text-2xl font-bold">HomeProxy</h1>

    <!-- GENERAL CONFIG -->
    <div class="rounded-xl border p-4 shadow-sm space-y-4">
      <h2 class="text-lg font-semibold">General</h2>

      <label class="block">
        <span class="block mb-1 font-medium">Routing mode</span>
        <select v-model="form.routing_mode" class="border rounded p-2 w-full">
          <option value="bypass_mainland_china">Bypass Mainland China</option>
          <option value="gfwlist">GFW List</option>
          <option value="proxy_mainland_china">Proxy Mainland China</option>
          <option value="global">Global</option>
          <option value="custom">Custom</option>
        </select>
      </label>

      <label class="inline-flex items-center gap-2">
        <input type="checkbox" v-model="form.auto_update" class="border rounded" />
        <span>Auto‑update subscriptions daily</span>
      </label>
    </div>

    <!-- NODE TABLE -->
    <div class="rounded-xl border p-4 shadow-sm space-y-4">
      <h2 class="text-lg font-semibold flex items-center justify-between">
        Nodes
        <button class="px-3 py-1 rounded bg-slate-700 text-white"
                @click="addNode">Add Node</button>
      </h2>

      <table class="table-auto w-full text-sm">
        <thead class="text-left">
        <tr>
          <th>Name</th><th>Server</th><th>Port</th><th>Type</th><th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(n, i) in nodes" :key="n['.name'] || i">
          <td><input v-model="n.alias"  class="border p-1 w-full" /></td>
          <td><input v-model="n.server" class="border p-1 w-full" /></td>
          <td><input v-model="n.port"   class="border p-1 w-full" /></td>
          <td>
            <select v-model="n.type" class="border p-1 w-full">
              <option value="vless">VLESS</option>
              <option value="vmess">VMess</option>
              <option value="trojan">Trojan</option>
            </select>
          </td>
          <td>
            <button class="text-red-600 hover:underline"
                    @click="nodes.splice(i,1)">Delete</button>
          </td>
        </tr>
        </tbody>
      </table>
    </div>

    <!-- ACTIONS -->
    <div class="flex gap-4">
      <button @click="save(false)" :disabled="busy"
              class="px-4 py-2 rounded bg-amber-500 text-white">Save</button>
      <button @click="save(true)"  :disabled="busy"
              class="px-4 py-2 rounded bg-green-600 text-white">Save & Apply</button>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'

const busy = ref(false)
const form = reactive({ routing_mode: 'bypass_mainland_china', auto_update: false })
const nodes = ref([])

const load = async() => {
  const { cfg } = await this.$oui.call('homeproxy', 'get')
  Object.assign(form, cfg.config[0] || {})
  nodes.value = cfg.nodes || []
}

const save = async(apply) => {
  busy.value = true
  await this.$oui.call('homeproxy', 'set', {
    config: form,
    nodes: nodes.value,
    apply
  })
  busy.value = false
  this.$oui.toast.success(apply ? 'Saved & applied!' : 'Saved!')
}

const addNode = () => {
  nodes.value.push({ alias: '', server: '', port: 443, type: 'vless' })
}

onMounted(load)
</script>

<style scoped>

.border { border: 1px solid rgb(203 213 225); }
</style>
