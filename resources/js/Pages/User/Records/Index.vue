<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { router } from '@inertiajs/vue3'
import { Calendar } from 'lucide-vue-next'
import { ref } from 'vue'

const fromInput = ref(null)
const toInput = ref(null)

const props = defineProps({
    records: Object,
    needsSetup: Boolean,
    filters: Object
})

// 📅 INITIAL VALUES
const fromDate = ref(props.filters?.from ?? '')
const toDate = ref(props.filters?.to ?? '')

const applyFilter = () => {
    router.get('/user/records', {
        from: fromDate.value,
        to: toDate.value
    }, {
        preserveState: true,
        replace: true
    })
}

// 📅 Format Date → Feb 15, 2026
const formatDate = (date) => {
    if (!date) return '-'

    const [year, month, day] = date.split('-')
    const d = new Date(year, month - 1, day)

    const formattedDate = d.toLocaleDateString('en-US', {
        month: 'short',
        day: 'numeric',
        year: 'numeric'
    })

    const weekday = d.toLocaleDateString('en-US', {
        weekday: 'long'
    })

    return `${formattedDate} (${weekday})`
}

// ⏰ Format Time → 8:00 AM
const formatTime = (time) => {
    if (!time) return '-'

    const [hour, minute] = time.split(':')
    const date = new Date()
    date.setHours(hour)
    date.setMinutes(minute)

    return date.toLocaleTimeString('en-US', {
        hour: 'numeric',
        minute: '2-digit',
        hour12: true
    })
}

const goTo = (url) => {
    if (!url) return

    router.visit(url, {
        preserveScroll: true,
        preserveState: true
    })
}

const clearFilter = () => {
    fromDate.value = ''
    toDate.value = ''

    router.get('/user/records', {}, {
        preserveState: true,
        replace: true
    })
}

const downloadPDF = () => {
    const params = new URLSearchParams()

    if (fromDate.value) params.append('from', fromDate.value)
    if (toDate.value) params.append('to', toDate.value)

    window.open(`/user/records/pdf?${params.toString()}`)
}

</script>

<template>
<AuthenticatedLayout>

<div class="p-6 space-y-6">

    <!-- HEADER -->
<div class="flex flex-col gap-4 lg:flex-row lg:justify-between lg:items-start">

    <!-- LEFT SIDE -->
    <div class="space-y-3">

        <div>
            <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">
                My Records
            </h1>
            <p class="text-sm text-gray-500 dark:text-gray-400">
                View your attendance logs
            </p>
        </div>

        <!-- FILTER (NOW LEFT SIDE) -->
<div class="flex flex-wrap items-end gap-2">

    <!-- FROM -->
    <div class="flex flex-col">
        <label class="text-xs text-gray-500 dark:text-gray-400 mb-1">
            From
        </label>

        <div class="relative">
            <input
                ref="fromInput"
                type="date"
                v-model="fromDate"
                class="w-full border rounded-lg px-3 py-2 pr-10 text-sm
                       bg-white dark:bg-[#111]
                       border-gray-200 dark:border-[#1f1f1f]
                       text-gray-800 dark:text-gray-200
                       focus:outline-none focus:ring-2 focus:ring-black dark:focus:ring-white
                       appearance-none"
            />

            <Calendar
                @click="fromInput?.showPicker()"
                class="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4
                       text-gray-400 dark:text-gray-500 cursor-pointer"
            />
        </div>
    </div>

    <!-- TO -->
    <div class="flex flex-col">
        <label class="text-xs text-gray-500 dark:text-gray-400 mb-1">
            To
        </label>

        <div class="relative">
            <input
                ref="toInput"
                type="date"
                v-model="toDate"
                class="w-full border rounded-lg px-3 py-2 pr-10 text-sm
                       bg-white dark:bg-[#111]
                       border-gray-200 dark:border-[#1f1f1f]
                       text-gray-800 dark:text-gray-200
                       focus:outline-none focus:ring-2 focus:ring-black dark:focus:ring-white
                       appearance-none"
            />

            <Calendar
                @click="toInput?.showPicker()"
                class="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4
                       text-gray-400 dark:text-gray-500 cursor-pointer"
            />
        </div>
    </div>

    <!-- APPLY -->
    <button
        @click="applyFilter"
        class="px-4 py-2 rounded-lg text-sm font-medium
               bg-black text-white hover:opacity-90
               dark:bg-white dark:text-black">
        Apply
    </button>

    <!-- CLEAR -->
    <button
        @click="clearFilter"
        class="px-4 py-2 rounded-lg text-sm font-medium
               border border-gray-300 dark:border-[#1f1f1f]
               text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-[#1f1f1f]">
        Clear
    </button>

    <button
    @click="downloadPDF"
    class="px-4 py-2 rounded-lg text-sm font-medium
           bg-blue-600 text-white hover:opacity-90">
    Preview PDF
</button>
</div>

    </div>

    <!-- RIGHT SIDE -->
    <div class="flex justify-start lg:justify-end">
<button
    @click="router.visit('/user/attendance')"
    class="w-full lg:w-auto
           px-5 py-2.5 lg:px-4 lg:py-2
           text-sm
           rounded-lg
           font-medium
           bg-black text-white 
           dark:bg-white dark:text-black
           shadow-sm hover:shadow-md
           hover:opacity-90 transition">
    Go to Records
</button>
    </div>

</div>

    <!-- 🚨 SETUP ALERT -->
    <div v-if="props.needsSetup"
        class="bg-yellow-50 dark:bg-yellow-900/20 
               border border-yellow-200 dark:border-yellow-800
               text-yellow-800 dark:text-yellow-300
               rounded-xl p-5 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">

        <div>
            <p class="font-semibold">Setup Required</p>
            <p class="text-sm">
                Please complete your profile (company & required hours) to access your records.
            </p>
            <p class="text-xs mt-1 opacity-80">
                ⚠️ Records are locked until setup is completed
            </p>
        </div>

<button
    @click="router.visit('/user/profile')"
    class="w-full lg:w-auto
           px-5 py-2.5 lg:px-4 lg:py-2
           text-sm
           rounded-lg
           font-medium
           bg-black text-white 
           dark:bg-white dark:text-black
           shadow-sm hover:shadow-md
           hover:opacity-90 transition">
    Go to Records
</button>
    </div>

    <!-- 🔒 LOCKED CONTENT -->
    <div v-if="!props.needsSetup">
        
        <div class="flex flex-wrap justify-between items-center mb-4 text-sm text-gray-600 dark:text-gray-300">

    <p>
        Showing {{ records.from }} - {{ records.to }} of {{ records.total }} records
    </p>

    <p>
        Total Hours (page): 
        <span class="font-semibold">
            {{
                records.data.reduce((sum, r) => sum + parseFloat(r.hours_rendered || 0), 0).toFixed(2)
            }} hrs
        </span>
    </p>

</div>
        <!-- YOUR RECORDS TABLE HERE -->
        <div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] rounded-xl p-5 shadow-sm">

    <div class="hidden md:block overflow-x-auto">
        <table class="w-full text-sm text-left">

            <!-- HEADER -->
        <thead class="bg-gray-50 dark:bg-[#161616] text-gray-600 dark:text-gray-300">
            <tr>
                <th class="px-4 py-3">Date</th>
                <th class="px-4 py-3 text-center">AM</th>
                <th class="px-4 py-3 text-center">PM</th>
                <th class="px-4 py-3">Hours</th>
                <th class="px-4 py-3">Status</th>
            </tr>
        </thead>

            <!-- BODY -->
<tbody  class="divide-y divide-gray-100 dark:divide-[#1f1f1f]">

<tr v-for="record in records?.data || []" :key="record.id"
    class="transition text-sm"
    :class="{
        'bg-green-50 dark:bg-green-900/10': record.status === 'present',
        'bg-blue-50 dark:bg-blue-900/10': record.status === 'overtime',
        'bg-yellow-50 dark:bg-yellow-900/10': record.status === 'holiday',
        'bg-gray-50 dark:bg-[#161616]': record.status === 'weekend',
        'bg-red-50 dark:bg-red-900/10': record.status === 'absent',
    }"
>

    <!-- DATE -->
    <td class="px-4 py-3 font-medium text-gray-800 dark:text-gray-100">
        {{ formatDate(record.date) }}
    </td>

    <!-- AM -->
<td class="px-4 py-3">
<div class="text-center font-medium">
    <span class="text-gray-800 dark:text-gray-200">
        {{ formatTime(record.time_in_am) }}
    </span>
    <span class="mx-1 text-gray-400 text-xs">–</span>
    <span class="text-gray-800 dark:text-gray-200">
        {{ formatTime(record.time_out_am) }}
    </span>
</div>
</td>

<!-- PM -->
<td class="px-4 py-3">
<div class="text-center font-medium">
    <span class="text-gray-800 dark:text-gray-200">
        {{ formatTime(record.time_in_pm) }}
    </span>
    <span class="mx-1 text-gray-400 text-xs">–</span>
    <span class="text-gray-800 dark:text-gray-200">
        {{ formatTime(record.time_out_pm) }}
    </span>
</div>
</td>

    <!-- HOURS -->
    <td class="px-4 py-3 font-semibold text-gray-800 dark:text-gray-200">
        {{ record.hours_rendered ?? '0.00' }} hrs
    </td>

    <!-- STATUS -->
    <td class="px-4 py-3">
 <span class="px-2 py-1 rounded-full text-xs font-semibold capitalize"
    :class="{
        'bg-green-100 text-green-700': record.status === 'present',
        'bg-blue-100 text-blue-700': record.status === 'overtime',
        'bg-yellow-100 text-yellow-700': record.status === 'holiday',
        'bg-gray-200 text-gray-700': record.status === 'weekend',
        'bg-red-100 text-red-700': record.status === 'absent',
        'bg-purple-100 text-purple-700': record.status === 'Dayoff',
    }"
>
    {{ record.status }}
</span>
    </td>

</tr>

    <!-- EMPTY STATE -->
    <tr v-if="!records?.data || records.data.length === 0">
        <td colspan="7"
            class="text-center py-6 text-gray-500 dark:text-gray-400">
            No records found
        </td>
    </tr>

</tbody>
        </table>
       
    </div>
    
    <div class="md:hidden space-y-4 mt-4">

    <div v-for="record in records?.data || []" :key="record.id"
        class="border border-gray-200 dark:border-[#1f1f1f]
               rounded-xl p-4 bg-white dark:bg-[#111] shadow-sm">

        <p class="font-semibold text-gray-800 dark:text-gray-100">
            {{ formatDate(record.date) }}
        </p>

        <div class="mt-2 text-sm text-gray-600 dark:text-gray-300">
            <span class="text-xs text-gray-400">AM:</span><br>
            {{ formatTime(record.time_in_am) }} – {{ formatTime(record.time_out_am) }}
        </div>

        <div class="mt-2 text-sm text-gray-600 dark:text-gray-300">
            <span class="text-xs text-gray-400">PM:</span><br>
            {{ formatTime(record.time_in_pm) }} – {{ formatTime(record.time_out_pm) }}
        </div>

        <div class="flex justify-between items-center mt-3">
            <p class="text-sm font-semibold">
                {{ record.hours_rendered ?? '0.00' }} hrs
            </p>

            <span class="px-2 py-1 rounded-full text-xs font-semibold capitalize"
                :class="{
                    'bg-green-100 text-green-700': record.status === 'present',
                    'bg-blue-100 text-blue-700': record.status === 'overtime',
                    'bg-yellow-100 text-yellow-700': record.status === 'holiday',
                    'bg-gray-200 text-gray-700': record.status === 'weekend',
                    'bg-red-100 text-red-700': record.status === 'absent',
                    'bg-purple-100 text-purple-700': record.status === 'Dayoff',
                }">
                {{ record.status }}
            </span>
        </div>

    </div>

</div>

</div>

<div class="flex items-center justify-between mt-4">

    <!-- PREVIOUS -->
    <button
        @click="goTo(records.prev_page_url)"
        :disabled="!records.prev_page_url"
        class="px-4 py-2 text-sm rounded-lg border
            border-gray-200 dark:border-[#1f1f1f]
            bg-white dark:bg-[#111]
            text-gray-700 dark:text-gray-300
            hover:bg-gray-100 dark:hover:bg-[#1f1f1f]
            disabled:opacity-40">
        ← Previous
    </button>

    <!-- PAGE INFO -->
    <p class="text-sm text-gray-500 dark:text-gray-400">
        Page {{ records.current_page }} of {{ records.last_page }}
    </p>

    <!-- NEXT -->
    <button
        @click="goTo(records.next_page_url)"
        :disabled="!records.next_page_url"
        class="px-4 py-2 text-sm rounded-lg border
       border-gray-200 dark:border-[#1f1f1f]
       bg-white dark:bg-[#111]
       text-gray-700 dark:text-gray-300
       hover:bg-gray-100 dark:hover:bg-[#1f1f1f]
       disabled:opacity-40">
        Next →
    </button>

</div>

    </div>

</div>



</AuthenticatedLayout>
</template>