<script setup>
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

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
})

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    })
}
</script>

<template>
    <GuestLayout>
        <Head title="Register" />

        <div class="w-full max-w-md">

            <!-- CARD -->
            <Transition name="popup">
    <div
        v-if="show"
        class="bg-white/70 dark:bg-[#111]/80 backdrop-blur-xl 
               border border-gray-200 dark:border-[#1f1f1f]
               shadow-xl rounded-2xl p-8 space-y-6"
    >

                <!-- HEADER (MATCH LOGIN 🔥) -->
                <div class="flex items-center gap-4 justify-center text-left">

                    <!-- ICON -->
                    <img 
                        src="/images/icons/access-control.png"
                        alt="icon"
                        class="w-12 h-12 object-contain"
                    />

                    <!-- TEXT -->
                    <div>
                        <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">
                            Create account
                        </h2>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Register to start your OJT tracking
                        </p>
                    </div>

                </div>

                <!-- FORM -->
                <form @submit.prevent="submit" class="space-y-5">

                    <!-- NAME -->
                    <div>
                        <InputLabel for="name" value="Name" />
                        <TextInput
                            id="name"
                            type="text"
                            class="mt-2 block w-full rounded-lg"
                            v-model="form.name"
                            required
                        />
                        <InputError class="mt-2" :message="form.errors.name" />
                    </div>

                    <!-- EMAIL -->
                    <div>
                        <InputLabel for="email" value="Email" />
                        <TextInput
                            id="email"
                            type="email"
                            class="mt-2 block w-full rounded-lg"
                            v-model="form.email"
                            required
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

                    <!-- CONFIRM PASSWORD -->
                    <div>
                        <InputLabel for="password_confirmation" value="Confirm Password" />
                        <TextInput
                            id="password_confirmation"
                            type="password"
                            class="mt-2 block w-full rounded-lg"
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
                        Register
                    </PrimaryButton>

                </form>

                <!-- FOOTER -->
                <p class="text-center text-sm text-gray-500 dark:text-gray-400">
                    Already have an account?
                    <Link
                        :href="route('login')"
                        class="text-blue-500 hover:underline"
                    >
                        Login here
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