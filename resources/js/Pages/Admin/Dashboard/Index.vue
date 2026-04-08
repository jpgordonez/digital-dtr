<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { usePage } from '@inertiajs/vue3'

const { stats = {} } = usePage().props
</script>

<template>
<AuthenticatedLayout>

<div class="p-4 sm:p-6 space-y-6">

    <!-- HEADER -->
    <div>
        <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">
            Admin Dashboard
        </h1>
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Overview of student progress and system activity
        </p>
    </div>

    <!-- STATS CARDS -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">

        <!-- TOTAL STUDENTS -->
        <div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] 
                    rounded-xl p-5 shadow-sm hover:shadow-md transition">
            <p class="text-sm text-gray-500 dark:text-gray-400">Total Students</p>
            <h2 class="text-2xl font-bold text-gray-800 dark:text-gray-100 mt-1">
                {{ stats.total_students ?? 0 }}
            </h2>
        </div>

        <!-- ACTIVE -->
        <div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] 
                    rounded-xl p-5 shadow-sm hover:shadow-md transition">
            <p class="text-sm text-gray-500 dark:text-gray-400">Active OJT</p>
            <h2 class="text-2xl font-bold text-green-600 mt-1">
                {{ stats.active ?? 0 }}
            </h2>
        </div>

        <!-- COMPLETED -->
        <div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] 
                    rounded-xl p-5 shadow-sm hover:shadow-md transition">
            <p class="text-sm text-gray-500 dark:text-gray-400">Completed</p>
            <h2 class="text-2xl font-bold text-blue-600 mt-1">
                {{ stats.completed ?? 0 }}
            </h2>
        </div>

        <!-- No. Of COMPANIES -->
        <div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] 
                    rounded-xl p-5 shadow-sm hover:shadow-md transition">
                <p class="text-sm text-gray-500 dark:text-gray-400">Companies</p>
                <h2 class="text-2xl font-bold text-orange-500 mt-1">
                    {{ stats.companies ?? 0 }}
                </h2>
        </div>

    </div>

    

</div>

</AuthenticatedLayout>
</template>