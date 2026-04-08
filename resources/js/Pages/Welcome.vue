<script setup>
import { Link } from '@inertiajs/vue3'
import GuestLayout from '@/Layouts/GuestLayout.vue'
import { onMounted, ref } from 'vue'

const show = ref(false)

onMounted(() => {
    setTimeout(() => {
        show.value = true
    }, 100)
})
</script>

<template>
    <GuestLayout>

        <!-- HEADER RIGHT SLOT -->
        <template #header-right>
            <Link 
                href="/login"
                class="text-sm text-gray-600 dark:text-white/70 hover:text-black dark:hover:text-white transition relative group"
            >
                Login
                <span class="absolute left-0 -bottom-1 w-0 h-[1px] bg-gray-500 dark:bg-white/60 transition-all group-hover:w-full"></span>
            </Link>
        </template>

        <!-- HERO -->
        <div 
            :class="[
                'grid md:grid-cols-2 gap-16 items-center w-full max-w-6xl transition-all duration-700 ease-out',
                show ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-6'
            ]"
        >

            <!-- LEFT -->
            <div 
                class="text-center md:text-left transition-all duration-700 delay-200"
                :class="show ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-6'"
            >

                <!-- ICON + TITLE -->
                <div class="flex items-center gap-3 justify-center md:justify-start mb-4">
                    <span class="text-sm uppercase tracking-widest text-gray-400">
                        OJT System
                    </span>
                </div>

                <!-- TITLE -->
                <h1 class="text-4xl md:text-6xl font-bold leading-tight mb-6 tracking-tight">
                    Track Your <br />
                    <span class="text-blue-500">
                        Duty Hours
                    </span>
                </h1>

                <!-- SUBTEXT -->
                <p class="text-gray-400 text-lg mb-10 leading-relaxed max-w-md mx-auto md:mx-0">
                    A smart and simple system to manage your OJT attendance, 
                    monitor your progress, and stay on track with your required hours.
                </p>

                <!-- BUTTON -->
                <Link
                    href="/login"
                    class="inline-block bg-blue-600 hover:bg-blue-700 px-7 py-3 rounded-lg font-medium tracking-wide transition transform hover:scale-105 active:scale-95 shadow-md hover:shadow-lg"
                >
                    Enter System
                </Link>

            </div>

            <!-- RIGHT -->
            <div 
                class="flex justify-center transition-all duration-700 delay-300"
                :class="show ? 'opacity-100 scale-100' : 'opacity-0 scale-95'"
            >
                <img 
                    src="/images/icons/part-time.png"
                    alt="OJT"
                    class="w-64 md:w-[340px] object-contain animate-float"
                />
            </div>

        </div>

    </GuestLayout>
</template>