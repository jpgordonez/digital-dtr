<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { router } from '@inertiajs/vue3'
import { ref, computed } from 'vue'


const props = defineProps({
    companies: Array,
    userCompany: Number,
    requiredHours: Number,
    user: Object,
    signatoryName: String,
    signatoryPosition: String    
})

const profileImage = computed(() => {
    if (!props.user.profile_photo) return null
    return `/storage/${props.user.profile_photo}`
})

// REQUIRED HOURS
const requiredInput = ref(props.requiredHours ?? '')

// COMPANY
const selectedCompany = ref(props.userCompany ?? '')

// MODALS
const showConfirmModal = ref(false)
const showCompanyModal = ref(false)

// REQUIRED HOURS MODAL
const openConfirm = () => {

    if (!requiredInput.value) {
        alert('Please enter required hours')
        return
    }

    if (requiredInput.value <= 0) {
        alert('Required hours must be greater than 0')
        return
    }

    showConfirmModal.value = true
}

const confirmSave = () => {
    router.post('/user/profile/required-hours', {
        required_hours: requiredInput.value
    }, {
        preserveScroll: true,
        preserveState: false,
        onSuccess: () => showConfirmModal.value = false
    })
}

// COMPANY MODAL
const openCompanyConfirm = () => {

    if (!selectedCompany.value) {
        alert('Please select a company')
        return
    }

    showCompanyModal.value = true
}

const confirmCompany = () => {
    router.post('/user/profile/company', {
        company_id: selectedCompany.value
    }, {
        preserveScroll: true,
        preserveState: false,
        onSuccess: () => showCompanyModal.value = false
    })
}

const openSignatoryConfirm = () => {
    if (!signatoryInput.value || !signatoryPositionInput.value) {
        alert('Please fill all fields')
        return
    }
    showSignatoryModal.value = true
}

const confirmSignatory = () => {
    router.post('/user/profile/signatory', {
        signatory_name: signatoryInput.value,
        signatory_position: signatoryPositionInput.value
    }, {
        preserveScroll: true,
        preserveState: false,
        onSuccess: () => showSignatoryModal.value = false
    })
}

const isEditingSignatory = ref(false)

const hasSignatory = computed(() => {
    return (
        props.signatoryName !== null &&
        props.signatoryName !== '' &&
        props.signatoryPosition !== null &&
        props.signatoryPosition !== ''
    )
})

// start edit
const startEditSignatory = () => {
    signatoryInput.value = props.signatoryName || ''
    signatoryPositionInput.value = props.signatoryPosition || ''
    isEditingSignatory.value = true
}



const signatoryInput = ref(props.signatoryName ?? '')
const signatoryPositionInput = ref(props.signatoryPosition ?? '')
const showSignatoryModal = ref(false)


</script>

<template>
<AuthenticatedLayout>

<div class="p-6 space-y-6">

    <!-- HEADER -->
    <div>
        <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">
            Profile
        </h1>
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Manage your OJT setup
        </p>
    </div>

    <!-- QUICK STATS -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <!-- USER INFO -->
<div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] rounded-xl p-4 shadow-sm flex items-center gap-4">

    <!-- Avatar -->
<div class="w-12 h-12 rounded-full overflow-hidden border 
            bg-gray-200 dark:bg-[#1f1f1f] flex items-center justify-center">

    <!-- IF MAY IMAGE -->
    <img v-if="profileImage"
        :src="profileImage"
        class="w-full h-full object-cover">

    <!-- IF WALA -->
    <span v-else
        class="font-bold text-gray-700 dark:text-gray-200">
        {{ props.user.name.charAt(0) }}
    </span>

</div>

    <!-- Info -->
    <div>
        <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
            {{ props.user.name }}
        </h2>
        <p class="text-sm text-gray-500 dark:text-gray-400">
            {{ props.user.email }}
        </p>
    </div>

</div>

        <!-- REQUIRED HOURS -->
        <div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] rounded-xl p-4 shadow-sm space-y-3">

            <p class="text-sm text-gray-500 dark:text-gray-400">Required Hours</p>

            <!-- IF NOT SET -->
            <div v-if="!props.requiredHours || props.requiredHours <= 0">

                <input 
                    type="number"
                    v-model="requiredInput"
                    placeholder="Enter required hours"
                    class="w-full border rounded-lg px-3 py-2 
                           dark:bg-[#111] dark:border-[#1f1f1f]
                           text-gray-800 dark:text-gray-100"
                >

                <button 
                    @click="openConfirm"
                    class="w-full py-2 rounded-lg bg-black text-white 
                           dark:bg-white dark:text-black text-sm">
                    Save & Confirm
                </button>

            </div>

            <!-- IF ALREADY SET -->
            <div v-else>
                <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-100">
                    {{ props.requiredHours }} hrs
                </h2>
            </div>

        </div>
        <!-- COMPANY SELECTION -->
<div class="bg-white dark:bg-[#111] border border-gray-200 dark:border-[#1f1f1f] rounded-xl p-4 shadow-sm space-y-3">

    <p class="text-sm text-gray-500 dark:text-gray-400">Company/Office</p>

    <!-- IF NOT SET -->
    <div v-if="!props.userCompany">

        <select 
            v-model="selectedCompany"
            class="w-full border rounded-lg px-3 py-2 
                   dark:bg-[#111] dark:border-[#1f1f1f]
                   text-gray-800 dark:text-gray-100">

            <option value="">Select company</option>

            <option 
                v-for="company in props.companies" 
                :key="company.id" 
                :value="company.id">
                {{ company.name }}
            </option>

        </select>

        <button 
            @click="openCompanyConfirm"
            class="w-full py-2 rounded-lg bg-black text-white 
                   dark:bg-white dark:text-black text-sm">
            Save & Confirm
        </button>

    </div>

    <!-- IF SET -->
    <div v-else>
        <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
            {{
                props.companies.find(c => c.id == props.userCompany)?.name
            }}
        </h2>
    </div>

</div>

<!-- SIGNATORY -->
<div class="bg-white dark:bg-[#111] 
            border border-gray-200 dark:border-[#1f1f1f] 
            rounded-xl p-5 shadow-sm space-y-4">

    <!-- HEADER -->
    <div class="flex items-center justify-between">
        <div>
            <p class="text-sm text-gray-500 dark:text-gray-400">
                Authorized Signatory
            </p>
            <p class="text-xs text-gray-400 dark:text-gray-500">
                This person will sign your DTR
            </p>
        </div>
    </div>

    <!-- 🔥 EDIT MODE -->
    <div v-if="isEditingSignatory || !hasSignatory" class="space-y-3">

        <input 
            type="text"
            v-model="signatoryInput"
            placeholder="Enter signatory name"
            class="w-full border border-gray-300 dark:border-[#1f1f1f]
                   rounded-lg px-3 py-2 
                   bg-white dark:bg-[#111]
                   text-gray-800 dark:text-gray-100
                   placeholder-gray-400
                   focus:ring-2 focus:ring-black dark:focus:ring-white
                   outline-none transition"
        >

        <input 
            type="text"
            v-model="signatoryPositionInput"
            placeholder="Enter position (e.g. Supervisor)"
            class="w-full border border-gray-300 dark:border-[#1f1f1f]
                   rounded-lg px-3 py-2 
                   bg-white dark:bg-[#111]
                   text-gray-800 dark:text-gray-100
                   placeholder-gray-400
                   focus:ring-2 focus:ring-black dark:focus:ring-white
                   outline-none transition"
        >

        <!-- ACTIONS -->
        <div class="flex gap-2 pt-1">

            <button 
                v-if="hasSignatory"
                @click="isEditingSignatory = false"
                class="w-full py-2 rounded-lg 
                       border border-gray-300 dark:border-[#1f1f1f]
                       text-gray-700 dark:text-gray-300
                       hover:bg-gray-100 dark:hover:bg-[#1a1a1a]
                       transition">
                Cancel
            </button>

            <button 
                @click="openSignatoryConfirm"
                class="w-full py-2 rounded-lg 
                       bg-black text-white 
                       dark:bg-white dark:text-black
                       hover:opacity-90 transition">
                {{ hasSignatory ? 'Update & Confirm' : 'Save & Confirm' }}
            </button>

        </div>

    </div>

    <!-- 🔥 VIEW MODE -->
    <div v-else class="space-y-2">

        <div>
            <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                {{ props.signatoryName }}
            </h2>

            <p class="text-sm text-gray-500 dark:text-gray-400">
                {{ props.signatoryPosition }}
            </p>
        </div>

        <div class="pt-2">
            <button 
                @click="startEditSignatory"
                class="inline-flex items-center px-3 py-1.5 text-sm rounded-lg 
                       bg-black text-white 
                       dark:bg-white dark:text-black
                       hover:opacity-90 transition">
                Edit
            </button>
        </div>

    </div>

</div>

    </div>
</div>

<!-- 🔥 CONFIRM MODAL -->
<div v-if="showConfirmModal" 
     class="fixed inset-0 z-50 flex items-center justify-center">

    <!-- BACKDROP -->
    <div 
        class="absolute inset-0 bg-black/50 backdrop-blur-sm"
        @click="showConfirmModal = false">
    </div>

    <!-- MODAL -->
    <div class="relative bg-white dark:bg-[#111] 
                border border-gray-200 dark:border-[#1f1f1f]
                rounded-xl p-6 w-full max-w-md shadow-lg space-y-4">

        <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
            Confirm Required Hours
        </h2>

        <div class="text-center text-xl font-bold text-gray-800 dark:text-gray-100">
            {{ requiredInput }} hrs
        </div>

        <div class="flex gap-3">

<button 
    @click="showConfirmModal = false"
    class="w-full py-2 rounded-lg border 
           border-gray-300 dark:border-[#1f1f1f]
           text-gray-800 dark:text-gray-100
           hover:bg-gray-100 dark:hover:bg-[#1a1a1a]
           transition">
    Cancel
</button>

<button 
    @click="confirmSave"
    class="w-full py-2 rounded-lg 
           bg-black text-white 
           dark:bg-white dark:text-black
           hover:opacity-90 transition">
    Confirm
</button>

        </div>

    </div>
</div>
<!-- COMPANY MODAL -->
<div v-if="showCompanyModal" 
     class="fixed inset-0 z-50 flex items-center justify-center">

    <div class="absolute inset-0 bg-black/50 backdrop-blur-sm"
         @click="showCompanyModal = false"></div>

    <div class="relative bg-white dark:bg-[#111] 
                border border-gray-200 dark:border-[#1f1f1f]
                rounded-xl p-6 w-full max-w-md shadow-lg space-y-4">

        <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
            Confirm Company
        </h2>

        <div class="text-center text-lg font-bold text-gray-800 dark:text-gray-100">
            {{
                props.companies.find(c => c.id == selectedCompany)?.name
            }}
        </div>

<div class="flex gap-3">

<button 
    @click="showCompanyModal = false"
    class="w-full py-2 rounded-lg border 
           border-gray-300 dark:border-[#1f1f1f]
           text-gray-800 dark:text-gray-100
           hover:bg-gray-100 dark:hover:bg-[#1a1a1a]
           transition">
    Cancel
</button>

<button 
    @click="confirmCompany"
    class="w-full py-2 rounded-lg 
           bg-black text-white 
           dark:bg-white dark:text-black
           hover:opacity-90 transition">
    Confirm
</button>

</div>

    </div>
</div>
<!-- SIGNATORY MODAL -->
<div v-if="showSignatoryModal" class="fixed inset-0 z-50 flex items-center justify-center">

    <div class="absolute inset-0 bg-black/50 backdrop-blur-sm"
         @click="showSignatoryModal = false"></div>

    <div class="relative bg-white dark:bg-[#111] 
                border border-gray-200 dark:border-[#1f1f1f]
                rounded-xl p-6 w-full max-w-md shadow-lg space-y-4">

        <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
            Confirm Signatory
        </h2>

        <div class="text-center text-lg font-bold text-gray-800 dark:text-gray-100">
            {{ signatoryInput }}
        </div>
        <div class="text-center text-sm text-gray-500">
            {{ signatoryPositionInput }}
        </div>

<div class="flex gap-3">

<button 
    @click="showSignatoryModal = false"
    class="w-full py-2 rounded-lg border 
           border-gray-300 dark:border-[#1f1f1f]
           text-gray-800 dark:text-gray-100
           hover:bg-gray-100 dark:hover:bg-[#1a1a1a]
           transition">
    Cancel
</button>

<button 
    @click="confirmSignatory"
    class="w-full py-2 rounded-lg 
           bg-black text-white 
           dark:bg-white dark:text-black
           hover:opacity-90 transition">
    Confirm
</button>

</div>

    </div>
</div>

</AuthenticatedLayout>
</template>