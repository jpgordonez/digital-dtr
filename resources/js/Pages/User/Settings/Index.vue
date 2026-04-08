<script setup>
import { ref, computed } from 'vue'
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { router, usePage } from '@inertiajs/vue3'

const page = usePage()
const user = page.props.user

const profileImage = computed(() => {
    if (!user.profile_photo) return '/default-avatar.png'
    return `/storage/${user.profile_photo}`
})

const imagePreview = ref(null)
const imageFile = ref(null)

function handleImageChange(e) {
    const file = e.target.files[0]
    if (!file) return

    imageFile.value = file
    imagePreview.value = URL.createObjectURL(file)
}

function uploadImage() {
    if (!imageFile.value) {
        alert('Select image first')
        return
    }

    const formData = new FormData()
    formData.append('image', imageFile.value)

    router.post('/user/settings/upload-profile', formData, {
    forceFormData: true,
    onSuccess: () => {
        openModal('Profile picture updated successfully!')
    },
    onError: () => {
        openModal('Failed to upload image.', 'error')
    }
})
}

// PROFILE
const name = ref(user.name)

// PASSWORD
const current_password = ref('')
const password = ref('')
const password_confirmation = ref('')

// UPDATE NAME
function updateProfile() {
    router.post('/user/settings/update-profile', {
        name: name.value
    }, {
        onSuccess: () => {
            openModal('Profile updated successfully!')
        },
        onError: () => {
            openModal('Failed to update profile.', 'error')
        }
    })
}

// UPDATE PASSWORD
function updatePassword() {
    router.post('/user/settings/update-password', {
        current_password: current_password.value,
        password: password.value,
        password_confirmation: password_confirmation.value
    }, {
        onSuccess: () => {
            openModal('Password changed successfully!')
        },
        onError: (errors) => {

            if (errors.current_password) {
                openModal('Incorrect current password.', 'error')
            } else if (errors.password) {
                openModal('Password confirmation does not match.', 'error')
            } else {
                openModal('Failed to update password.', 'error')
            }

        }
    })
}

const showModal = ref(false)
const modalMessage = ref('')
const modalType = ref('success') // success | error

function openModal(message, type = 'success') {
    modalMessage.value = message
    modalType.value = type
    showModal.value = true
}


</script>

<template>
<AuthenticatedLayout>
<div class="p-6 max-w-5xl mx-auto space-y-6">

    

    <!-- HEADER -->
    <div>
        <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">
            User Settings
        </h1>
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Manage your account information and security
        </p>
    </div>

    <!-- GRID -->
    <div class="grid md:grid-cols-3 gap-6">

        <!-- LEFT SIDE -->
        <div class="md:col-span-1">

            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-6 shadow-sm">

                <h2 class="font-semibold text-gray-800 dark:text-gray-100 mb-4">
                    Profile Picture
                </h2>

                <div class="flex flex-col items-center gap-4">

                    <img 
                        :src="imagePreview || profileImage"
                        class="w-24 h-24 rounded-full object-cover border shadow-sm"
                    >

                    <input type="file" @change="handleImageChange"
                        class="text-xs text-gray-500">

                    <button @click="uploadImage"
                        class="w-full px-4 py-2 text-sm rounded-lg 
                               bg-black text-white 
                               dark:bg-white dark:text-black 
                               hover:opacity-90 transition">
                        Upload Photo
                    </button>

                </div>

            </div>

        </div>

        <!-- RIGHT SIDE -->
        <div class="md:col-span-2 space-y-6">

            <!-- PROFILE INFO -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-6 shadow-sm">

                <h2 class="font-semibold text-gray-800 dark:text-gray-100 mb-4">
                    Profile Information
                </h2>

                <div class="grid md:grid-cols-2 gap-4">

                    <!-- NAME -->
                    <div>
                        <label class="text-xs text-gray-500 dark:text-gray-400 mb-1 block">
                            Name
                        </label>
                        <input type="text" v-model="name"
                            class="w-full border border-gray-300 dark:border-[#1f1f1f]
                                   bg-white dark:bg-[#161616]
                                   text-gray-800 dark:text-gray-100
                                   rounded-lg px-3 py-2 text-sm
                                   focus:ring-2 focus:ring-black dark:focus:ring-white">
                    </div>

                    <!-- EMAIL -->
                    <div>
                        <label class="text-xs text-gray-500 dark:text-gray-400 mb-1 block">
                            Email
                        </label>
                        <input type="text" :value="user.email"
                            disabled
                            class="w-full border border-gray-300 dark:border-[#1f1f1f]
                                   bg-white dark:bg-[#161616]
                                   text-gray-800 dark:text-gray-100
                                   rounded-lg px-3 py-2 text-sm
                                   opacity-60 cursor-not-allowed">
                    </div>

                </div>

                <div class="flex justify-end mt-4">
                    <button @click="updateProfile"
                        class="px-4 py-2 text-sm rounded-lg 
                               bg-black text-white 
                               dark:bg-white dark:text-black 
                               hover:opacity-90 transition">
                        Save Changes
                    </button>
                </div>

            </div>

            <!-- PASSWORD -->
            <div class="bg-white dark:bg-[#111] 
                        border border-gray-200 dark:border-[#1f1f1f] 
                        rounded-xl p-6 shadow-sm">

                <h2 class="font-semibold text-gray-800 dark:text-gray-100 mb-4">
                    Change Password
                </h2>

                <div class="grid md:grid-cols-2 gap-4">

                    <input v-model="current_password" type="password" placeholder="Current Password"
                        class="w-full border border-gray-300 dark:border-[#1f1f1f]
                               bg-white dark:bg-[#161616]
                               text-gray-800 dark:text-gray-100
                               rounded-lg px-3 py-2 text-sm
                               focus:ring-2 focus:ring-black dark:focus:ring-white">

                    <input v-model="password" type="password" placeholder="New Password"
                        class="w-full border border-gray-300 dark:border-[#1f1f1f]
                               bg-white dark:bg-[#161616]
                               text-gray-800 dark:text-gray-100
                               rounded-lg px-3 py-2 text-sm
                               focus:ring-2 focus:ring-black dark:focus:ring-white">

                    <input v-model="password_confirmation" type="password" placeholder="Confirm Password"
                        class="w-full border border-gray-300 dark:border-[#1f1f1f]
                               bg-white dark:bg-[#161616]
                               text-gray-800 dark:text-gray-100
                               rounded-lg px-3 py-2 text-sm
                               focus:ring-2 focus:ring-black dark:focus:ring-white">

                </div>

                <div class="flex justify-end mt-4">
                    <button @click="updatePassword"
                        class="px-4 py-2 text-sm rounded-lg 
                               bg-black text-white 
                               dark:bg-white dark:text-black 
                               hover:opacity-90 transition">
                        Update Password
                    </button>
                </div>

            </div>

        </div>

    </div>

</div>
<div v-if="showModal"
     class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">

    <div class="bg-white dark:bg-[#111] 
                border border-gray-200 dark:border-[#1f1f1f]
                rounded-xl p-6 w-full max-w-sm shadow-lg text-center space-y-4">

        <!-- ICON -->
        <div class="text-3xl">
            <span v-if="modalType === 'success'">✅</span>
            <span v-else>❌</span>
        </div>

        <!-- MESSAGE -->
        <p class="text-sm text-gray-700 dark:text-gray-300">
            {{ modalMessage }}
        </p>

        <!-- BUTTON -->
        <button @click="showModal = false"
            class="w-full px-4 py-2 text-sm rounded-lg 
                   bg-black text-white 
                   dark:bg-white dark:text-black">
            OK
        </button>

    </div>

</div>
</AuthenticatedLayout>
</template>



