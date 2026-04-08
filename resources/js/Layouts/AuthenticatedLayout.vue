<script setup>
import {
    Sun, Moon,
    LayoutDashboard,
    Building2,
    Users,
    User,
    LogOut,
    FileText,
    BarChart3,
    CalendarCheck,
    Settings,
    ClipboardList,
    Bell
} from 'lucide-vue-next'
import { Link, usePage } from '@inertiajs/vue3'
import { ref, onMounted, onBeforeUnmount } from 'vue'

const user = usePage().props.auth.user

const dark = ref(false)

onMounted(() => {
    dark.value = document.documentElement.classList.contains('dark')
})

const toggleDark = () => {
    if (document.documentElement.classList.contains('dark')) {
        document.documentElement.classList.remove('dark')
        localStorage.theme = 'light'
        dark.value = false
    } else {
        document.documentElement.classList.add('dark')
        localStorage.theme = 'dark'
        dark.value = true
    }
}

const menuClass = (name) => [
    'flex items-center px-4 py-2 rounded-xl text-sm transition',
    sidebarOpen.value ? 'gap-3 justify-start' : 'justify-center',
    route().current(name)
        ? 'bg-gray-100 dark:bg-[#1f1f1f] text-gray-900 dark:text-white'
        : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-[#1a1a1a]'
]

const showDropdown = ref(false)

const toggleDropdown = () => {
    showDropdown.value = !showDropdown.value
}

const dropdownRef = ref(null)

const handleClickOutside = (e) => {
    if (dropdownRef.value && !dropdownRef.value.contains(e.target)) {
        showDropdown.value = false
    }
}

onMounted(() => {
    document.addEventListener('click', handleClickOutside)
})

onBeforeUnmount(() => {
    document.removeEventListener('click', handleClickOutside)
})

const sidebarOpen = ref(
    window.innerWidth < 1024
        ? false // 📱 mobile always closed
        : (localStorage.getItem('sidebarOpen') === null
            ? true
            : localStorage.getItem('sidebarOpen') === 'true')
)

const isMobile = ref(window.innerWidth < 1024)

const handleResize = () => {
    isMobile.value = window.innerWidth < 1024

    if (isMobile.value) {
        sidebarOpen.value = false
    } else {
        const saved = localStorage.getItem('sidebarOpen')
        sidebarOpen.value = saved === null ? true : saved === 'true'
    }
}

onMounted(() => {
    window.addEventListener('resize', handleResize)
})

onBeforeUnmount(() => {
    window.removeEventListener('resize', handleResize)
})

const toggleSidebar = () => {
    sidebarOpen.value = !sidebarOpen.value
    localStorage.setItem('sidebarOpen', sidebarOpen.value)
}

</script>

<template>

    <div class="min-h-screen flex bg-gray-100 dark:bg-black ">

        <!-- SIDEBAR -->
        <aside 
            :class="[
                'h-screen transition-all duration-300 ease-in-out',
                isMobile ? 'fixed top-0 left-0 z-[60]'
                    : 'relative',
                isMobile 
                    ? (sidebarOpen ? 'translate-x-0 w-64' : '-translate-x-full w-64')
                    : (sidebarOpen ? 'w-64' : 'w-20')
            ]"
            class="bg-white dark:bg-[#0f0f0f] 
            border-r border-gray-200 dark:border-[#1f1f1f] 
            text-gray-700 dark:text-gray-300 flex-shrink-0">

            <!-- HEADER -->
        <div class="flex items-center gap-3 p-4 border-b border-gray-200 dark:border-[#1f1f1f]">

            <img src="/images/icons/part-time.png" class="w-10 h-10 rounded-full" />

            <div :class="[
                isMobile ? 'block' : (sidebarOpen ? 'block' : 'hidden')
            ]">
                <p class="font-semibold text-gray-800 dark:text-white text-sm">
                    OJT DTR System
                </p>
                <p class="text-xs text-gray-400">
                    Monitoring Panel
                </p>
            </div>

        </div>
                    <!-- MENU -->
        <nav class="mt-4 space-y-4">

<!-- ================= ADMIN ================= -->
<template v-if="user?.role === 'admin'">

    <!-- CORE -->
    <div>
        <p v-if="sidebarOpen" class="px-4 text-xs text-gray-400 uppercase mb-2">
            Core
        </p>

        <Link 
            :href="route('admin.dashboard')" 
            :class="menuClass('admin.dashboard')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <LayoutDashboard class="w-5 h-5" />
            <span v-if="sidebarOpen">Dashboard</span>
        </Link>
    </div>

    <!-- MANAGEMENT -->
    <div>
        <p v-if="sidebarOpen" class="px-4 text-xs text-gray-400 uppercase mb-2">
            Management
        </p>

        <Link 
            :href="route('admin.students')" 
            :class="menuClass('admin.students')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <Users class="w-5 h-5" />
            <span v-if="sidebarOpen">Students</span>
        </Link>

        <Link 
            :href="route('admin.companies')" 
            :class="menuClass('admin.companies')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <Building2 class="w-5 h-5" />
            <span v-if="sidebarOpen">Companies</span>
        </Link>

        <Link 
            :href="route('admin.records')" 
            :class="menuClass('admin.records')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <ClipboardList class="w-5 h-5" />
            <span v-if="sidebarOpen">DTR Records</span>
        </Link>
    </div>

    <!-- ANALYTICS -->
    <div>
        <p v-if="sidebarOpen" class="px-4 text-xs text-gray-400 uppercase mb-2">
            Analytics
        </p>

        <Link 
            :href="route('admin.reports')"
            :class="menuClass('admin.reports')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <BarChart3 class="w-5 h-5" />
            <span v-if="sidebarOpen">Reports</span>
        </Link>

        <Link 
            :href="route('admin.attendance')" 
            :class="menuClass('admin.attendance')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <CalendarCheck class="w-5 h-5" />
            <span v-if="sidebarOpen">Attendance</span>
        </Link>
    </div>

    <!-- SYSTEM -->
    <div>
        <p v-if="sidebarOpen" class="px-4 text-xs text-gray-400 uppercase mb-2">
            System
        </p>

        <Link 
            :href="route('admin.notifications')"
            :class="menuClass('admin.notifications')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <Bell class="w-5 h-5" />
            <span v-if="sidebarOpen">Notifications</span>
        </Link>

        <Link 
            :href="route('admin.settings')" 
            :class="menuClass('admin.settings')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <Settings class="w-5 h-5" />
            <span v-if="sidebarOpen">Settings</span>
        </Link>
    </div>

</template>


<!-- ================= USER ================= -->
<template v-else>

    <!-- CORE -->
    <div>
        <p v-if="sidebarOpen" class="px-4 text-xs text-gray-400 uppercase mb-2">
            Core
        </p>

        <Link 
            :href="route('user.dashboard')" 
            :class="menuClass('user.dashboard')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <LayoutDashboard class="w-5 h-5" />
            <span v-if="sidebarOpen">Dashboard</span>
        </Link>
    </div>

    <!-- OJT -->
    <div>
        <p v-if="sidebarOpen" class="px-4 text-xs text-gray-400 uppercase mb-2">
            OJT
        </p>

        <Link 
            :href="route('user.records')" 
            :class="menuClass('user.records')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <FileText class="w-5 h-5" />
            <span v-if="sidebarOpen">My Records</span>
        </Link>

        <Link 
            :href="route('user.attendance')"
            :class="menuClass('user.attendance')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <CalendarCheck class="w-5 h-5" />
            <span v-if="sidebarOpen">Attendance</span>
        </Link>
    </div>

    <!-- ACCOUNT -->
    <div>
        <p v-if="sidebarOpen" class="px-4 text-xs text-gray-400 uppercase mb-2">
            Account
        </p>

        <Link 
            :href="route('user.profile')"
            :class="menuClass('user.profile')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <User class="w-5 h-5" />
            <span v-if="sidebarOpen">Profile</span>
        </Link>

        <Link 
            :href="route('user.settings')"
            :class="menuClass('user.settings')"
            @click="isMobile && (sidebarOpen = false)"
        >
            <Settings class="w-5 h-5" />
            <span v-if="sidebarOpen">Settings</span>
        </Link>

    </div>

</template>

        </nav>

        </aside>

        <!-- OVERLAY -->
        <div 
            v-if="sidebarOpen && isMobile"
            @click="sidebarOpen = false"
            class="fixed inset-0 bg-black/40 backdrop-blur-sm z-[55] lg:hidden "
        ></div>

        <!-- MAIN CONTENT -->
        <div class="flex-1 flex flex-col">

                    <!-- TOP BAR -->
        <div class="sticky top-0 z-50
            bg-white/70 dark:bg-[#0f0f0f]/70 backdrop-blur-xl
            border-b border-gray-200 dark:border-[#1f1f1f]
            px-6 py-3 flex items-center justify-between">
        <button
            @click="toggleSidebar"
            class="mr-3 p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-[#1f1f1f] transition"
        >
            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-600 dark:text-gray-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                    d="M4 6h16M4 12h16M4 18h16" />
            </svg>
        </button>

            <!-- RIGHT -->
            <div class="flex items-center gap-3 relative">

                <!-- THEME -->
                <button 
                    @click="toggleDark"
                    class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-[#1f1f1f] transition"
                >
                    <Moon v-if="dark" class="w-5 h-5 text-white/80" />
                    <Sun v-else class="w-5 h-5 text-yellow-500" />
                </button>

                <!-- AVATAR + DROPDOWN -->
                <div class="relative" ref="dropdownRef">

                    <!-- AVATAR BUTTON -->
                    <button 
                        @click="toggleDropdown"
                        class="flex items-center gap-2 pl-3 border-l border-gray-200 dark:border-[#1f1f1f]"
                    >
                        <!-- PROFILE PIC (if meron ka later) -->
                        <div class="w-9 h-9 rounded-full bg-blue-500 flex items-center justify-center text-white font-semibold">
                            {{ user?.name.charAt(0) }}
                        </div>
                    </button>

                    <!-- DROPDOWN -->
        <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95 translate-y-1"
            enter-to-class="opacity-100 scale-100 translate-y-0"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100 translate-y-0"
            leave-to-class="opacity-0 scale-95 translate-y-1"
        >
            <div v-if="showDropdown"
                class="absolute right-0 mt-2 w-44 
                bg-white dark:bg-[#111] 
                border border-gray-200 dark:border-[#1f1f1f] 
                rounded-xl shadow-lg overflow-hidden origin-top-right ">

        <Link
        method="post"
        as="button"
        :href="route('logout')"
        class="w-full text-left
                flex items-center gap-3 px-4 py-3
                text-sm text-red-600
                hover:bg-gray-100
                dark:text-red-400
                dark:hover:bg-[#1b1b1b]"
        >
        <LogOut class="w-4 h-4 text-red-500 dark:text-red-400" />
        <span>Log out</span>
        </Link>

            </div>
        </Transition>
                </div>

            </div>
        </div>

                    <!-- PAGE CONTENT -->
        <main class="flex-1 p-6 bg-gray-50 dark:bg-black">
            <div class="bg-white dark:bg-[#111] rounded-xl shadow-sm border border-gray-200 dark:border-[#1f1f1f] p-6">
                <slot />
            </div>
        </main>
        </div>
    </div>
</template>