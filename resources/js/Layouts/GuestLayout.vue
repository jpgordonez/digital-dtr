<script setup>
import { Link } from '@inertiajs/vue3'
import { ref, onMounted } from 'vue'
import { Sun, Moon } from 'lucide-vue-next'

const dark = ref(true)

onMounted(() => {
    const saved = localStorage.getItem('theme')
    dark.value = saved ? saved === 'dark' : true
    document.documentElement.classList.toggle('dark', dark.value)
})

const toggleTheme = () => {
    dark.value = !dark.value
    localStorage.setItem('theme', dark.value ? 'dark' : 'light')
    document.documentElement.classList.toggle('dark', dark.value)
}
</script>

<template>
    <div class="min-h-screen bg-[#F8FAFC] dark:bg-[#0B0B0F] text-black dark:text-white flex flex-col">

        <!-- HEADER -->
        <div class="flex justify-between items-center px-8 md:px-16 py-6">

            <!-- LOGO -->
            <Link href="/" class="flex items-center gap-2 group transition hover:scale-[1.02]">
                <img 
                    src="/images/icons/calendar.png" 
                    class="w-5 h-5 opacity-90 group-hover:opacity-100 transition" 
                />

                <span class="font-semibold text-lg tracking-wide text-black dark:text-white/90 group-hover:text-black dark:group-hover:text-white transition">
                    Digital DTR
                </span>
            </Link>

            <!-- RIGHT SIDE -->
            <div class="flex items-center gap-4">

                <!-- THEME TOGGLE -->
            <button 
                @click="toggleTheme"
                class="p-2 rounded-lg hover:bg-black/5 dark:hover:bg-white/10 transition"
            >
                <Moon v-if="dark" class="w-5 h-5 text-white/80" />
                <Sun v-else class="w-5 h-5 text-yellow-500" />
            </button>

                <!-- LOGIN SLOT -->
                <slot name="header-right" />

            </div>
        </div>

        <!-- CONTENT -->
        <main class="flex-1 flex items-center justify-center px-8 md:px-16">
            <slot />
        </main>

        <!-- FOOTER -->
        <div class="text-center text-gray-500 dark:text-white/40 text-sm pb-6 tracking-wide">
            BSIT Batch 2026 • Digital DTR
        </div>

    </div>
</template>