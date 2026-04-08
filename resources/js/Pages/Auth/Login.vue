<script setup>
import Checkbox from '@/Components/Checkbox.vue'
import GuestLayout from '@/Layouts/GuestLayout.vue'
import InputError from '@/Components/InputError.vue'
import InputLabel from '@/Components/InputLabel.vue'
import PrimaryButton from '@/Components/PrimaryButton.vue'
import TextInput from '@/Components/TextInput.vue'
import { Head, Link, useForm } from '@inertiajs/vue3'
import { ref, onMounted } from 'vue'

const show = ref(false)

onMounted(() => {
    setTimeout(() => {
        show.value = true
    }, 50)
})

defineProps({
    canResetPassword: Boolean,
    status: String,
})

const form = useForm({
    email: '',
    password: '',
    remember: false,
})

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    })
}
</script>

<template>
    <GuestLayout>
        <Head title="Login" />

        <div class="w-full max-w-md">

            <!-- CARD -->
<Transition name="popup">
    <div
        v-if="show"
        class="bg-white/70 dark:bg-[#111]/80 backdrop-blur-xl 
               border border-gray-200 dark:border-[#1f1f1f]
               shadow-xl rounded-2xl p-8 space-y-6"
    >

                <!-- TITLE -->
<div class="flex items-center gap-4 justify-center text-left">

    <!-- ICON -->
    <img 
        src="/images/icons/key.png"
        alt="icon"
        class="w-12 h-12 object-contain"
    />

    <!-- TEXT -->
    <div>
        <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">
            Welcome back
        </h2>
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Sign in to your account
        </p>
    </div>

</div>

                <!-- STATUS -->
                <div v-if="status" class="text-sm text-green-600 text-center">
                    {{ status }}
                </div>

                <!-- FORM -->
                <form @submit.prevent="submit" class="space-y-5">

                    <!-- EMAIL -->
                    <div>
                        <InputLabel for="email" value="Email" />
                        <TextInput
                            id="email"
                            type="email"
                            class="mt-2 block w-full rounded-lg"
                            v-model="form.email"
                            required
                            autofocus
                        />
                        <InputError class="mt-2" :message="form.errors.email" />
                    </div>

                    <!-- PASSWORD -->
                    <div>
                        <InputLabel for="password" value="Password" />
                        <TextInput
                            id="password"
                            type="password"
                            class="mt-2 block w-full rounded-lg"
                            v-model="form.password"
                            required
                        />
                        <InputError class="mt-2" :message="form.errors.password" />
                    </div>

                    <!-- REMEMBER -->
                    <div class="flex items-center justify-between text-sm">
                        <label class="flex items-center gap-2 text-gray-600 dark:text-gray-400">
                            <Checkbox v-model:checked="form.remember" />
                            Remember me
                        </label>

                        <Link
                            v-if="canResetPassword"
                            :href="route('password.request')"
                            class="hover:underline text-gray-600 dark:text-gray-400"
                        >
                            Forgot?
                        </Link>
                    </div>

                    <!-- LOGIN BUTTON -->
                    <PrimaryButton
                        class="w-full justify-center text-center py-2.5 rounded-lg 
                               bg-black dark:bg-white text-white dark:text-black 
                               hover:opacity-90 transition"
                        :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                    >
                        Log in
                    </PrimaryButton>

                </form>

                <!-- FOOTER -->
                <p class="text-center text-sm text-gray-500 dark:text-gray-400">
                    Don’t have an account?
                    <Link
                        :href="route('register')"
                        class="text-blue-500 hover:underline"
                    >
                        Create one
                    </Link>
                </p>

            </div>

            </Transition>
        </div>
    

    </GuestLayout>
    
</template>

<style>
.popup-enter-from {
    opacity: 0;
    transform: scale(0.95) translateY(10px);
}

.popup-enter-to {
    opacity: 1;
    transform: scale(1) translateY(0);
}

.popup-enter-active {
    transition: all 0.35s ease;
}
</style>