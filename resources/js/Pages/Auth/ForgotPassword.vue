<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue'
import InputError from '@/Components/InputError.vue'
import InputLabel from '@/Components/InputLabel.vue'
import PrimaryButton from '@/Components/PrimaryButton.vue'
import TextInput from '@/Components/TextInput.vue'
import { Head, useForm, Link } from '@inertiajs/vue3'

defineProps({
    status: String,
})

const form = useForm({
    email: '',
})

const submit = () => {
    form.post(route('password.email'))
}
</script>

<template>
    <GuestLayout>
        <Head title="Forgot Password" />

        <div class="w-full max-w-md">

            <!-- CARD -->
            <div class="bg-white/70 dark:bg-[#111]/80 backdrop-blur-xl 
                        border border-gray-200 dark:border-[#1f1f1f]
                        shadow-xl rounded-2xl p-8 space-y-6">

                <!-- HEADER -->
                <div class="flex items-center gap-4 justify-center text-left">

                    <!-- ICON -->
                    <img 
                        src="/images/icons/email.png"
                        alt="icon"
                        class="w-12 h-12 object-contain"
                    />

                    <!-- TEXT -->
                    <div>
                        <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">
                            Forgot password
                        </h2>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Reset your account access
                        </p>
                    </div>

                </div>

                <!-- DESCRIPTION -->
                <p class="text-sm text-gray-500 dark:text-gray-400 leading-relaxed text-center">
                    Enter your email and we’ll send you a reset link to regain access to your account.
                </p>

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
                            class="mt-2 block w-full"
                            v-model="form.email"
                            required
                            autofocus
                        />
                        <InputError class="mt-2" :message="form.errors.email" />
                    </div>

                    <!-- BUTTON -->
                    <PrimaryButton
                        class="w-full justify-center text-center py-2.5 rounded-lg 
                               bg-black dark:bg-white text-white dark:text-black 
                               hover:opacity-90 transition"
                        :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                    >
                        Send Reset Link
                    </PrimaryButton>

                </form>

                <!-- FOOTER -->
                <p class="text-center text-sm text-gray-500 dark:text-gray-400">
                    Remember your password?
                    <Link
                        :href="route('login')"
                        class="text-blue-500 hover:underline"
                    >
                        Back to login
                    </Link>
                </p>

            </div>

        </div>

    </GuestLayout>
</template>