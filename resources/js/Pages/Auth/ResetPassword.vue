<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue'
import InputError from '@/Components/InputError.vue'
import InputLabel from '@/Components/InputLabel.vue'
import PrimaryButton from '@/Components/PrimaryButton.vue'
import TextInput from '@/Components/TextInput.vue'
import { Head, useForm, Link } from '@inertiajs/vue3'

const props = defineProps({
    email: String,
    token: String,
})

const form = useForm({
    token: props.token,
    email: props.email,
    password: '',
    password_confirmation: '',
})

const submit = () => {
    form.post(route('password.store'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    })
}
</script>

<template>
    <GuestLayout>
        <Head title="Reset Password" />

        <div class="w-full max-w-md">

            <!-- CARD -->
            <div class="bg-white/70 dark:bg-[#111]/80 backdrop-blur-xl 
                        border border-gray-200 dark:border-[#1f1f1f]
                        shadow-xl rounded-2xl p-8 space-y-6">

                <!-- HEADER -->
                <div class="flex items-center gap-4 justify-center text-left">

                    <!-- ICON -->
                    <img 
                        src="/images/icons/padlock.png"
                        alt="icon"
                        class="w-12 h-12 object-contain"
                    />

                    <!-- TEXT -->
                    <div>
                        <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">
                            Reset password
                        </h2>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Create a new secure password
                        </p>
                    </div>

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

                    <!-- PASSWORD -->
                    <div>
                        <InputLabel for="password" value="Password" />
                        <TextInput
                            id="password"
                            type="password"
                            class="mt-2 block w-full"
                            v-model="form.password"
                            required
                        />
                        <InputError class="mt-2" :message="form.errors.password" />
                    </div>

                    <!-- CONFIRM -->
                    <div>
                        <InputLabel for="password_confirmation" value="Confirm Password" />
                        <TextInput
                            id="password_confirmation"
                            type="password"
                            class="mt-2 block w-full"
                            v-model="form.password_confirmation"
                            required
                        />
                        <InputError class="mt-2" :message="form.errors.password_confirmation" />
                    </div>

                    <!-- BUTTON -->
                    <PrimaryButton
                        class="w-full justify-center text-center py-2.5 rounded-lg 
                               bg-black dark:bg-white text-white dark:text-black 
                               hover:opacity-90 transition"
                        :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                    >
                        Reset Password
                    </PrimaryButton>

                </form>

                <!-- FOOTER -->
                <p class="text-center text-sm text-gray-500 dark:text-gray-400">
                    Back to
                    <Link
                        :href="route('login')"
                        class="text-blue-500 hover:underline"
                    >
                        Login
                    </Link>
                </p>

            </div>

        </div>

    </GuestLayout>
</template>