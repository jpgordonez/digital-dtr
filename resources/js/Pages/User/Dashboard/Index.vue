<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { computed } from 'vue'

const props = defineProps({
    stats: Object,
    needsSetup: Boolean,
    user: Object
})

const profileImage = computed(() => {
    if (!props.user.profile_photo) return null
    return `/storage/${props.user.profile_photo}`
})

const formatDate = (date) => {
    if (!date) return '—'

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

<div class="p-6 space-y-6">

    <!-- HEADER -->
    <div>
        <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">
            Dashboard
        </h1>
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Overview of your OJT progress
        </p>
    </div>

    <!-- SETUP ALERT -->
    <div v-if="props.needsSetup"
        class="bg-yellow-50 dark:bg-yellow-900/20 
               border border-yellow-200 dark:border-yellow-800
               text-yellow-800 dark:text-yellow-300
               rounded-xl p-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">

        <div>
            <p class="font-semibold">Setup Required</p>
            <p class="text-sm">
                Please complete your profile (company & required hours) to unlock your dashboard.
            </p>
            <p class="text-xs mt-1 opacity-80">
                ⚠️ Dashboard is locked until setup is completed
            </p>
        </div>

        <button 
            @click="$inertia.visit('/user/profile')"
            class="w-full sm:w-auto px-4 py-2 rounded-lg 
                   bg-black text-white 
                   dark:bg-white dark:text-black text-sm">
            Go to Profile
        </button>

    </div>

    <!-- DASHBOARD CONTENT -->
    <div v-if="!props.needsSetup" class="space-y-6">

        <!-- STATS GRID -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            
            <!-- USER INFO -->
            <div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] rounded-xl p-4 shadow-sm flex items-center gap-4">

            <!-- Avatar -->
<div class="w-12 h-12 rounded-full overflow-hidden border 
            bg-gray-200 dark:bg-[#1f1f1f] flex items-center justify-center">

    <!-- IF MAY IMAGE -->
    <img v-if="profileImage"
        :src="profileImage"
        class="w-full h-full object-cover">

    <!-- IF WALA -->
    <span v-else
        class="font-bold text-gray-700 dark:text-gray-200">
        {{ props.user.name.charAt(0) }}
    </span>

</div>

            <!-- Info -->
            <div>
                <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                    {{ props.user.name }}
                </h2>
            </div>

            </div>

            <!-- COMPANY INFO -->
             
<div class="bg-white dark:bg-[#111] 
            border border-gray-200 dark:border-[#1f1f1f] 
            rounded-xl p-4 shadow-sm">

    <div class="flex items-center justify-between">

        <!-- LEFT -->
        <div>
            <p class="text-sm text-gray-500 dark:text-gray-400">
                Company / Office
            </p>

            <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                {{ props.user.company?.name || 'Not set' }}
            </h2>

            <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                Your assigned OJT workplace
            </p>
        </div>

        <!-- RIGHT LOGO -->
<div v-if="props.user.company?.logo">
    <img 
        :src="`/storage/${props.user.company.logo}`"
        alt="Company Logo"
        class="w-14 h-14 object-contain rounded-lg" />
</div>

    </div>

</div>
            <!-- SIGNATORY INFO -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-4 shadow-sm">

                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Authorized Signatory
                </p>

                <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                    {{ props.user.signatory || 'Not set' }}
                </h2>

                <p class="text-xs text-gray-500 dark:text-gray-400 capitalize">
                    {{ props.user.signatory_position }}
                </p>

            </div>

            <!-- REQUIRED -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-4 shadow-sm">
                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Required Hours
                </p>
                <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-100">
                    {{ props.stats.required }} hrs
                </h2>
            </div>

            <!-- RENDERED -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-4 shadow-sm">
                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Rendered Hours
                </p>
                <h2 class="text-xl font-semibold text-green-600">
                    {{ props.stats.rendered }} hrs
                </h2>
            </div>

            <!-- REMAINING -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-4 shadow-sm">
                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Remaining
                </p>
                <h2 class="text-xl font-semibold text-red-500">
                    {{ props.stats.remaining.toFixed(2) }} hrs
                </h2>
            </div>

            <!-- ESTIMATED END -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-4 shadow-sm">

                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Estimated End Date
                </p>

                <h2 class="text-lg font-semibold text-blue-600">
                    {{ formatDate(props.stats.estimated_end) }}
                </h2>

                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                    Based on 10 hrs/day (no weekends)
                </p>

            </div>

            <!-- REMAINING DUTY DAYS -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-4 shadow-sm">
                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Remaining Duty Days
                </p>

                <h2 class="text-xl font-semibold text-indigo-600">
                    {{ props.stats.remaining_duty_days }} day(s)
                </h2>

                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                    Based on 10 hrs/day
                </p>
            </div>

        </div>

    </div>

</div>

</AuthenticatedLayout>
</template>