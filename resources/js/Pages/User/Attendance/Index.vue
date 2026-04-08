<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { reactive, onMounted, watch, ref } from 'vue'
import { router } from '@inertiajs/vue3'
import { Calendar } from 'lucide-vue-next'

const props = defineProps({
    needsSetup: Boolean,
    attendance: Object,
    lastLog: Object
})

const form = reactive({
    date: new Date().toISOString().slice(0,10),
    time_in_am: '',
    time_out_am: '',
    time_in_pm: '',
    time_out_pm: '',
    status: 'present',
    remarks: ''
})

onMounted(() => {
    if (props.attendance) {
        form.time_in_am = props.attendance.time_in_am ?? ''
        form.time_out_am = props.attendance.time_out_am ?? ''
        form.time_in_pm = props.attendance.time_in_pm ?? ''
        form.time_out_pm = props.attendance.time_out_pm ?? ''
        form.status = props.attendance.status ?? 'present'
        form.remarks = props.attendance.remarks ?? ''
    }
})

watch(() => form.status, (val) => {
    if (!['present','overtime'].includes(val)) {
        form.time_in_am = ''
        form.time_out_am = ''
        form.time_in_pm = ''
        form.time_out_pm = ''
    }
})

const showSuccess = ref(false)

const submit = () => {
    router.post('/user/attendance', {
        date: form.date,
        time_in_am: form.time_in_am,
        time_out_am: form.time_out_am,
        time_in_pm: form.time_in_pm,
        time_out_pm: form.time_out_pm,
        status: form.status,
        remarks: form.remarks,
    }, {
        preserveScroll: true,
        onSuccess: () => {
            showSuccess.value = true

            // auto close after 2.5s
            setTimeout(() => {
                showSuccess.value = false
            }, 2500)
        }
    })
}

const formatDate = (date) => {
    if (!date) return '-'

    const [year, month, day] = date.split('-')
    const d = new Date(year, month - 1, day)

    const formatted = d.toLocaleDateString('en-US', {
        month: 'short',
        day: 'numeric',
        year: 'numeric'
    })

    const weekday = d.toLocaleDateString('en-US', {
        weekday: 'long'
    })

    return `${formatted} (${weekday})`
}
</script>

<template>
<AuthenticatedLayout>

<div class="p-4 sm:p-6 space-y-6 max-w-3xl mx-auto">

    <!-- HEADER -->
<div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">

    <div>
        <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">
            Attendance
        </h1>
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Fill out your attendance.
        </p>
    </div>

<button
    @click="router.visit('/user/records')"
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

    <div v-if="props.lastLog"
    class="text-sm text-gray-500 dark:text-gray-400
           bg-gray-50 dark:bg-[#161616]
           border border-gray-200 dark:border-[#1f1f1f]
           rounded-lg px-4 py-2">

    Last Log: 
    <span class="font-medium text-gray-700 dark:text-gray-200">
        {{ formatDate(props.lastLog.date) }}
    </span>
</div>

    <!-- 🚨 SETUP ALERT -->
    <div v-if="props.needsSetup"
        class="rounded-xl border p-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4
        bg-yellow-50 border-yellow-200 text-yellow-800
        dark:bg-yellow-900/20 dark:border-yellow-800 dark:text-yellow-300">

        <div>
            <p class="font-semibold">Setup Required</p>
            <p class="text-sm">
                Complete your profile before using attendance.
            </p>
        </div>

        <button 
            @click="$inertia.visit('/user/profile')"
            class="w-full sm:w-auto px-4 py-2 rounded-lg text-sm font-medium
                   bg-black text-white hover:opacity-90
                   dark:bg-white dark:text-black">
            Go to Profile
        </button>
    </div>

    <!-- FORM -->
    <form v-if="!props.needsSetup"
        @submit.prevent="submit"
        class="bg-white dark:bg-[#111]
               border border-gray-200 dark:border-[#1f1f1f]
               rounded-xl p-5 sm:p-6 shadow-sm space-y-6">

        <!-- DATE -->
<div class="relative">
    <label class="block text-sm text-gray-500 dark:text-gray-400 mb-1">
        Date
    </label>

    <!-- INPUT -->
    <input 
        type="date" 
        v-model="form.date"

        class="w-full rounded-lg pl-3 pr-10 py-2 text-sm
               bg-white dark:bg-[#111]
               border border-gray-200 dark:border-[#1f1f1f]
               text-gray-900 dark:text-white
               focus:ring-2 focus:ring-black dark:focus:ring-white
               outline-none"

        @click="$event.target.showPicker && $event.target.showPicker()"
    />

    <!-- ICON RIGHT -->
    <Calendar 
        class="absolute right-3 top-[38px] w-4 h-4 
               text-gray-400 dark:text-gray-500 pointer-events-none"
    />
</div>

        <div>
    <label class="text-sm text-gray-500 dark:text-gray-400">Status</label>
    <select v-model="form.status" class="w-full rounded-lg px-3 py-2 text-sm
bg-white dark:bg-[#111]
border border-gray-200 dark:border-[#1f1f1f]
text-gray-900 dark:text-white
focus:ring-2 focus:ring-black dark:focus:ring-white
outline-none">
        <option value="present">Present</option>
        <option value="Dayoff">Day Off</option>
        <option value="weekend">Weekend</option>
        <option value="holiday">Holiday</option>
        <option value="absent">Absent</option>
        <option value="overtime">Overtime</option>
    </select>
</div>

<div>
    <label class="text-sm text-gray-500 dark:text-gray-400">Remarks</label>
    <textarea v-model="form.remarks"
        class="w-full rounded-lg px-3 py-2 text-sm
bg-white dark:bg-[#111]
border border-gray-200 dark:border-[#1f1f1f]
text-gray-900 dark:text-white
focus:ring-2 focus:ring-black dark:focus:ring-white
outline-none"
        placeholder="Optional notes..."></textarea>
</div>

        <!-- AM -->
        <div class="space-y-3">
            <p class="text-xs font-semibold text-gray-500 dark:text-gray-400">
                Morning Session
            </p>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="text-xs text-gray-500 dark:text-gray-400">Time In</label>
                    <input type="time" v-model="form.time_in_am"
                        class="w-full rounded-lg px-3 py-2 text-sm
                           bg-white dark:bg-[#111]
                           border border-gray-200 dark:border-[#1f1f1f]
                           text-gray-900 dark:text-white
                           focus:ring-2 focus:ring-black dark:focus:ring-white
                           outline-none"
                        :disabled="!['present','overtime'].includes(form.status)"/>
                </div>

                <div>
                    <label class="text-xs text-gray-500 dark:text-gray-400">Lunch Break</label>
                    <input type="time" v-model="form.time_out_am"
                        class="w-full rounded-lg px-3 py-2 text-sm
                           bg-white dark:bg-[#111]
                           border border-gray-200 dark:border-[#1f1f1f]
                           text-gray-900 dark:text-white
                           focus:ring-2 focus:ring-black dark:focus:ring-white
                           outline-none"
                        :disabled="!['present','overtime'].includes(form.status)"/>
                </div>
            </div>
        </div>

        <!-- PM -->
        <div class="space-y-3">
            <p class="text-xs font-semibold text-gray-500 dark:text-gray-400">
                Afternoon Session
            </p>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="text-xs text-gray-500 dark:text-gray-400">Time In</label>
                    <input type="time" v-model="form.time_in_pm"
                        class="w-full rounded-lg px-3 py-2 text-sm
                           bg-white dark:bg-[#111]
                           border border-gray-200 dark:border-[#1f1f1f]
                           text-gray-900 dark:text-white
                           focus:ring-2 focus:ring-black dark:focus:ring-white
                           outline-none"
                        :disabled="!['present','overtime'].includes(form.status)"/>
                </div>

                <div>
                    <label class="text-xs text-gray-500 dark:text-gray-400">Time Out</label>
                    <input type="time" v-model="form.time_out_pm"
                        class="w-full rounded-lg px-3 py-2 text-sm
                           bg-white dark:bg-[#111]
                           border border-gray-200 dark:border-[#1f1f1f]
                           text-gray-900 dark:text-white
                           focus:ring-2 focus:ring-black dark:focus:ring-white
                           outline-none"
                        :disabled="!['present','overtime'].includes(form.status)"/>
                </div>
            </div>
        </div>

        <!-- SUBMIT -->
        <button
            class="w-full py-2.5 rounded-lg text-sm font-medium transition
                   bg-black text-white hover:opacity-90
                   dark:bg-white dark:text-black">
            Save Attendance
        </button>

    </form>

</div>

<transition
    enter-active-class="transition-all duration-200"
    enter-from-class="opacity-0 scale-95"
    enter-to-class="opacity-100 scale-100"
    leave-active-class="transition-all duration-150"
    leave-from-class="opacity-100 scale-100"
    leave-to-class="opacity-0 scale-95"
>
    <div v-if="showSuccess"
        class="fixed inset-0 z-50 flex items-center justify-center">

        <!-- BACKDROP -->
        <div class="absolute inset-0 bg-black/40 backdrop-blur-sm"></div>

        <!-- MODAL -->
        <div class="relative bg-white dark:bg-[#111]
            border border-gray-200 dark:border-[#1f1f1f]
            rounded-xl px-6 py-5 shadow-lg
            w-[90%] max-w-sm text-center
            transform transition-all duration-200 scale-100">

            <!-- ICON -->
            <div class="mb-3 text-green-500 text-3xl">
                ✔
            </div>

            <!-- TITLE -->
            <p class="font-semibold text-gray-800 dark:text-white">
                Attendance Saved
            </p>

            <!-- SUBTEXT -->
            <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
                Your record has been successfully saved.
            </p>

        </div>
    </div>
</transition>

</AuthenticatedLayout>
</template>