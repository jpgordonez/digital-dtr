<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Company;
use Illuminate\Support\Facades\Auth;

class ProfileController extends Controller
{
    // 🔥 LOAD PROFILE PAGE
        public function index()
        {
            /** @var \App\Models\User $user */
            $user = Auth::user();

            return inertia('User/Profile/Index', [
                'companies' => Company::select('id', 'name')->get(),
                'userCompany' => $user->company_id,
                'requiredHours' => $user->required_hours,

                'user' => [
                    'name' => $user->name,
                    'email' => $user->email,
                    'profile_photo' => $user->profile_photo,
                ],

                'signatoryName' => $user->signatory_name, // ✅ FIXED
                'signatoryPosition' => $user->signatory_position, // ✅ FIXED
            ]);
        }

    // 🔥 UPDATE REQUIRED HOURS
    public function updateRequiredHours(Request $request)
    {
        $request->validate([
            'required_hours' => 'required|numeric|min:1'
        ]);

        /** @var \App\Models\User $user */
        $user = Auth::user();

        // OPTIONAL: prevent overwrite (remove if you want editable)
        if ($user->required_hours) {
            return back()->withErrors([
                'required_hours' => 'Already set. Admin only can change this.'
            ]);
        }

        $user->required_hours = $request->required_hours;
        $user->save();

        return back();
    }

    // 🔥 UPDATE COMPANY
    public function updateCompany(Request $request)
    {
        $request->validate([
            'company_id' => 'required|exists:companies,id'
        ]);

        /** @var \App\Models\User $user */
        $user = Auth::user();

        // OPTIONAL: prevent overwrite
        if ($user->company_id) {
            return back()->withErrors([
                'company' => 'Company already selected. Admin only can change this.'
            ]);
        }

        $user->company_id = $request->company_id;
        $user->save();

        return back();
    }
    public function updateSignatory(Request $request)
    {
        $request->validate([
            'signatory_name' => 'required|string|max:255',
            'signatory_position' => 'required|string|max:255',
        ]);

        /** @var \App\Models\User $user */
        $user = Auth::user();

        $user->signatory_name = $request->signatory_name;
        $user->signatory_position = $request->signatory_position;
        $user->save();

        return back();
    }
    
}