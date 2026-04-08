<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { usePage, router } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

const page = usePage()
const companies = computed(() => page.props.companies)

const filteredCompanies = computed(() => {
    return companies.value.filter(c =>
        c.name.toLowerCase().includes(search.value.toLowerCase()) ||
        (c.address || '').toLowerCase().includes(search.value.toLowerCase())
    )
})

const showModal = ref(false)
const isEdit = ref(false)
const selectedId = ref(null)

const name = ref('')
const address = ref('')
const logo = ref(null)

const search = ref('')

const handleFile = (e) => {
    logo.value = e.target.files[0]
}

// OPEN MODAL
const openModal = (company = null) => {
    if (company) {
        isEdit.value = true
        selectedId.value = company.id
        name.value = company.name
        address.value = company.address || ''
    } else {
        isEdit.value = false
        selectedId.value = null
        name.value = ''
        address.value = ''
    }
    logo.value = null
    showModal.value = true
}

// SUBMIT
const submit = () => {
    const form = new FormData()

    form.append('name', name.value)
    form.append('address', address.value) // 🔥 FIX

    if (logo.value) {
        form.append('logo', logo.value)
    }

    if (isEdit.value) {
        form.append('_method', 'put')

        router.post(route('admin.companies.update', selectedId.value), form, {
            forceFormData: true,
            onSuccess: () => {
                showModal.value = false
            }
        })
    } else {
        router.post(route('admin.companies.store'), form, {
            forceFormData: true,
            onSuccess: () => {
                showModal.value = false
            }
        })
    }
}

const remove = (id) => {
    if (!confirm('Are you sure you want to delete this company?')) return

    router.delete(route('admin.companies.delete', id), {
        onSuccess: () => {
            // optional: success feedback
        }
    })
}
</script>

<template>
<AuthenticatedLayout>

<div class="space-y-6">

<!-- HEADER -->
<div class="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-3">

    <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">
        Companies
    </h1>

    <div class="flex flex-col sm:flex-row items-stretch sm:items-center gap-2 w-full sm:w-auto">

        <input 
            v-model="search"
            type="text"
            placeholder="Search companies..."
            class="px-4 py-2 rounded-lg border 
                   border-gray-200 dark:border-[#1f1f1f]
                   bg-white dark:bg-[#111]
                   text-gray-800 dark:text-gray-100
                   placeholder-gray-400 dark:placeholder-gray-500
                   text-sm w-full sm:w-64"
        />

        <button 
            @click="openModal()"
            class="px-4 py-2 rounded-lg bg-black text-white 
                   dark:bg-white dark:text-black whitespace-nowrap">
            + Add
        </button>

    </div>

</div>

<!-- TABLE / LIST -->
<div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] rounded-xl overflow-hidden">

    <!-- DESKTOP TABLE -->
    <table class="w-full text-sm hidden md:table">

        <thead class="text-gray-500 dark:text-gray-400
                      border-b border-gray-200 dark:border-[#1f1f1f]
                      bg-gray-50 dark:bg-[#161616]">
            <tr>
                <th class="px-6 py-4">Logo</th>
                <th class="px-6 py-4">Name</th>
                <th class="px-6 py-4">Address</th>
                <th class="px-6 py-4 text-right">Actions</th>
            </tr>
        </thead>

        <tbody class="divide-y divide-gray-200 dark:divide-[#1f1f1f]">

            <tr v-for="company in filteredCompanies"
                :key="company.id"
                class="hover:bg-gray-50 dark:hover:bg-[#161616] transition">

                <td class="px-6 py-5">
                    <img v-if="company.logo"
                         :src="`/storage/${company.logo}`"
                         class="w-10 h-10 object-contain rounded" />
                </td>

                <td class="px-6 py-5 font-medium text-black dark:text-white">
                    {{ company.name }}
                </td>

                <td class="px-6 py-5 text-gray-600 dark:text-gray-400">
                    {{ company.address || 'No address' }}
                </td>

                <!-- ACTIONS -->
                <td class="px-6 py-5 text-right">
                    <div class="flex justify-end gap-2">

                        <button
                            @click="openModal(company)"
                            class="px-3 py-1.5 text-sm rounded-lg
                                   bg-gray-100 text-gray-700 hover:bg-gray-200
                                   dark:bg-[#1f1f1f] dark:text-white">
                            Edit
                        </button>

                        <button
                            @click="remove(company.id)"
                            class="px-3 py-1.5 text-sm rounded-lg
                                   bg-red-500 text-white hover:bg-red-600">
                            Delete
                        </button>

                    </div>
                </td>

            </tr>

            <tr v-if="filteredCompanies.length === 0">
                <td colspan="4"
                    class="px-6 py-8 text-center text-gray-500 dark:text-gray-400">
                    No companies added yet.
                </td>
            </tr>

        </tbody>
    </table>

    <!-- MOBILE CARDS -->
    <div class="md:hidden divide-y divide-gray-200 dark:divide-[#1f1f1f]">

        <div v-for="company in filteredCompanies"
             :key="company.id"
             class="p-4 space-y-3">

            <!-- TOP -->
            <div class="flex items-center gap-3">
                <img v-if="company.logo"
                     :src="`/storage/${company.logo}`"
                     class="w-10 h-10 object-contain rounded" />

                <div class="flex-1">
                    <p class="font-semibold text-black dark:text-white">
                        {{ company.name }}
                    </p>
                </div>
            </div>

            <!-- ADDRESS -->
            <div class="text-sm text-gray-600 dark:text-gray-400">
                📍 {{ company.address || 'No address' }}
            </div>

            <!-- ACTIONS (FIXED UX HERE 🔥) -->
            <div class="flex gap-2 pt-2">

                <button
                    @click="openModal(company)"
                    class="flex-1 px-3 py-2 text-sm rounded-lg
                           bg-gray-100 text-gray-700 hover:bg-gray-200
                           dark:bg-[#1f1f1f] dark:text-white text-center">
                    Edit
                </button>

                <button
                    @click="remove(company.id)"
                    class="flex-1 px-3 py-2 text-sm rounded-lg
                           bg-red-500 text-white hover:bg-red-600 text-center">
                    Delete
                </button>

            </div>

        </div>

        <div v-if="filteredCompanies.length === 0"
             class="p-6 text-center text-gray-500 dark:text-gray-400">
            No companies added yet.
        </div>

    </div>

</div>

</div>

<!-- MODAL (unchanged logic) -->
<div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50">

    <div class="bg-white dark:bg-[#111] p-6 rounded-xl w-96 border border-gray-200 dark:border-[#1f1f1f]">

        <h2 class="text-lg font-semibold mb-4 text-gray-800 dark:text-gray-100">
            {{ isEdit ? 'Edit Company' : 'Add Company' }}
        </h2>

        <input 
            v-model="name"
            type="text"
            placeholder="Company name"
            class="w-full mb-3 px-4 py-2 rounded-lg border 
                   border-gray-200 dark:border-[#1f1f1f]
                   bg-white dark:bg-[#161616]
                   text-gray-800 dark:text-gray-100"
        />

        <input 
            v-model="address"
            type="text"
            placeholder="Company address"
            class="w-full mb-3 px-4 py-2 rounded-lg border 
                   border-gray-200 dark:border-[#1f1f1f]
                   bg-white dark:bg-[#161616]
                   text-gray-800 dark:text-gray-100"
        />

        <input type="file" @change="handleFile" class="mb-4 text-gray-700 dark:text-gray-300" />

        <div class="flex justify-end gap-2">
            <button @click="showModal=false" class="text-gray-600 dark:text-gray-400">
                Cancel
            </button>

            <button 
                @click="submit"
                class="px-4 py-2 bg-black text-white rounded-lg 
                       dark:bg-white dark:text-black">
                Save
            </button>
        </div>

    </div>

</div>

</AuthenticatedLayout>
</template>