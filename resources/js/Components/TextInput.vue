<script setup>
import { onMounted, ref } from 'vue';

const model = defineModel({
    type: String,
    required: true,
});

const input = ref(null);

onMounted(() => {
    if (input.value.hasAttribute('autofocus')) {
        input.value.focus();
    }
});

defineExpose({ focus: () => input.value.focus() });
</script>

<template>
    <input
        v-model="model"
        ref="input"
        class="w-full rounded-lg px-3 py-2 transition

               border border-gray-300 dark:border-[#1f1f1f]

               bg-white dark:bg-[#0f0f0f]

               text-gray-900 dark:text-white

               placeholder-gray-400 dark:placeholder-gray-500

               focus:border-black dark:focus:border-white
               focus:ring-1 focus:ring-black dark:focus:ring-white

               outline-none"
    />
</template>