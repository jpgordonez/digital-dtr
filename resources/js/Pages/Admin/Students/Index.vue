<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { usePage, router } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

const { students, companies } = usePage().props

// SEARCH
const search = ref('')

const filteredStudents = computed(() => {
    return students.filter(s =>
        s.name.toLowerCase().includes(search.value.toLowerCase()) ||
        s.company?.name?.toLowerCase().includes(search.value.toLowerCase())
    )
})

// MODAL
const showModal = ref(false)
const selected = ref(null)

const form = ref({
    name: '',
    company_id: '',
    required_hours: 0
})

const openModal = (student) => {
    selected.value = student
    form.value = {
        name: student.name,
        company_id: student.company_id || '',
        required_hours: student.required_hours || 0
    }
    showModal.value = true
}

const updateStudent = () => {
    router.post(route('admin.students.update', selected.value.id), {
        _method: 'put',
        ...form.value
    }, {
        onSuccess: () => {
            showModal.value = false

            router.visit(route('admin.students'), {
                replace: true,
                preserveState: false,
                preserveScroll: true,
            })
        }
    })
}

const getRendered = (student) => {
    return student.rendered_hours || 0
}

const getRemaining = (student) => {
    return (student.required_hours || 0) - getRendered(student)
}

const remove = (id) => {
    if (!confirm('Are you sure you want to delete this student?')) return

    router.delete(route('admin.students.destroy', id), {
        onSuccess: () => {
            router.visit(route('admin.students'), {
                replace: true,
                preserveScroll: true
            })
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
            Students
        </h1>

        <input 
            v-model="search"
            type="text"
            placeholder="Search students..."
            class="px-4 py-2 rounded-lg border 
                   border-gray-200 dark:border-[#1f1f1f]
                   bg-white dark:bg-[#111]
                   text-gray-800 dark:text-gray-100
                   placeholder-gray-400 dark:placeholder-gray-500
                   text-sm w-full sm:w-64"
        />
    </div>

<!-- TABLE / LIST -->
<!-- TABLE / LIST -->
<div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] rounded-xl overflow-hidden">

    <!-- DESKTOP TABLE -->
    <table class="w-full text-sm hidden md:table">
        <thead class="bg-gray-50 dark:bg-[#161616] text-gray-500 dark:text-gray-400">
            <tr>
                <th class="px-6 py-3 text-left">Name</th>
                <th class="px-6 py-3 text-left">Company</th>
                <th class="px-6 py-3 text-left">Required</th>
                <th class="px-6 py-3 text-left">Rendered</th>
                <th class="px-6 py-3 text-left">Remaining</th>
                <th class="px-6 py-3 text-right">Actions</th>
            </tr>
        </thead>

        <tbody class="divide-y divide-gray-200 dark:divide-[#1f1f1f]">
            <tr v-for="student in filteredStudents" :key="student.id"
                class="hover:bg-gray-50 dark:hover:bg-[#161616] transition">

                <td class="px-6 py-5 font-medium text-black dark:text-white">
                    {{ student.name }}
                </td>

                <td class="px-6 py-5 text-gray-600 dark:text-gray-400">
                    {{ student.company?.name || '-' }}
                </td>

                <td class="px-6 py-5 text-blue-600 dark:text-blue-400 font-medium">
                    {{ student.required_hours || 0 }} hrs
                </td>

                <td class="px-6 py-5 text-gray-800 dark:text-gray-200">
                    {{ getRendered(student) }} hrs
                </td>

                <td class="px-6 py-5 font-semibold"
                    :class="getRemaining(student) <= 0 
                        ? 'text-green-500' 
                        : 'text-orange-500'">
                    {{ getRemaining(student) }} hrs
                </td>

                <!-- ✅ CLEAN ACTIONS -->
                <td class="px-6 py-5 text-right">
                    <div class="flex justify-end gap-2">

                        <button
                            @click="openModal(student)"
                            class="px-3 py-1.5 text-sm rounded-lg
                                   bg-gray-100 text-gray-700 hover:bg-gray-200
                                   dark:bg-[#1f1f1f] dark:text-white">
                            Edit
                        </button>

                        <button
                            @click="remove(student.id)"
                            class="px-3 py-1.5 text-sm rounded-lg
                                   bg-red-500 text-white hover:bg-red-600">
                            Delete
                        </button>

                    </div>
                </td>

            </tr>
        </tbody>
    </table>

    <!-- MOBILE CARDS -->
    <div class="md:hidden divide-y divide-gray-200 dark:divide-[#1f1f1f]">

        <div v-for="student in filteredStudents" :key="student.id"
             class="p-4 space-y-3">

            <div>
                <h2 class="font-semibold text-black dark:text-white">
                    {{ student.name }}
                </h2>
                <p class="text-sm text-gray-600 dark:text-gray-400">
                    {{ student.company?.name || 'No company' }}
                </p>
            </div>

            <div class="grid grid-cols-3 gap-2 text-xs">

                <div class="bg-gray-50 dark:bg-[#161616] p-2 rounded-lg text-center">
                    <p class="text-gray-500 dark:text-gray-400">Required</p>
                    <p class="font-medium text-blue-600 dark:text-blue-400">
                        {{ student.required_hours || 0 }}
                    </p>
                </div>

                <div class="bg-gray-50 dark:bg-[#161616] p-2 rounded-lg text-center">
                    <p class="text-gray-500 dark:text-gray-400">Rendered</p>
                    <p class="font-medium text-gray-800 dark:text-gray-200">
                        {{ getRendered(student) }}
                    </p>
                </div>

                <div class="bg-gray-50 dark:bg-[#161616] p-2 rounded-lg text-center">
                    <p class="text-gray-500 dark:text-gray-400">Remaining</p>
                    <p class="font-semibold"
                       :class="getRemaining(student) <= 0 
                            ? 'text-green-500' 
                            : 'text-orange-500'">
                        {{ getRemaining(student) }}
                    </p>
                </div>

            </div>

            <!-- ✅ MOBILE ACTIONS -->
            <div class="flex gap-2 pt-2">

                <button
                    @click="openModal(student)"
                    class="flex-1 px-3 py-2 text-sm rounded-lg
                           bg-gray-100 text-gray-700 hover:bg-gray-200
                           dark:bg-[#1f1f1f] dark:text-white text-center">
                    Edit
                </button>

                <button
                    @click="remove(student.id)"
                    class="flex-1 px-3 py-2 text-sm rounded-lg
                           bg-red-500 text-white hover:bg-red-600 text-center">
                    Delete
                </button>

            </div>

        </div>

    </div>

</div>
</div>

<!-- MODAL (unchanged) -->
<div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50">

    <div class="bg-white dark:bg-[#111] p-6 rounded-xl w-96 border border-gray-200 dark:border-[#1f1f1f]">

        <h2 class="text-lg font-semibold mb-4 text-gray-800 dark:text-gray-100">
            Edit Student
        </h2>

        <div class="mb-3">
            <label class="text-sm text-gray-500 dark:text-gray-400">Name</label>
            <input v-model="form.name" type="text"
                class="w-full px-4 py-2 rounded-lg border 
                       border-gray-200 dark:border-[#1f1f1f]
                       bg-white dark:bg-[#161616]
                       text-gray-800 dark:text-gray-100" />
        </div>

        <div class="mb-3">
            <label class="text-sm text-gray-500 dark:text-gray-400">Company</label>
            <select v-model="form.company_id"
                class="w-full px-4 py-2 rounded-lg border 
                       border-gray-200 dark:border-[#1f1f1f]
                       bg-white dark:bg-[#161616]
                       text-gray-800 dark:text-gray-100">
                <option value="">Select Company</option>
                <option v-for="company in companies" :key="company.id" :value="company.id">
                    {{ company.name }}
                </option>
            </select>
        </div>

        <div class="mb-3">
            <label class="text-sm text-gray-500 dark:text-gray-400">Required Hours</label>
            <input v-model="form.required_hours" type="number"
                class="w-full px-4 py-2 rounded-lg border 
                       border-gray-200 dark:border-[#1f1f1f]
                       bg-white dark:bg-[#161616]
                       text-gray-800 dark:text-gray-100" />
        </div>

        <div class="flex justify-end gap-2 mt-4">
            <button @click="showModal=false" class="px-4 py-2 text-sm text-gray-600 dark:text-gray-400">
                Cancel
            </button>

            <button @click="updateStudent"
                class="px-4 py-2 bg-black text-white rounded-lg 
                       dark:bg-white dark:text-black">
                Save
            </button>
        </div>

    </div>

</div>

</AuthenticatedLayout>
</template>