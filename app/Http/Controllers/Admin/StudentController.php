<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Company;
use Inertia\Inertia;

class StudentController extends Controller
{
    public function index()
    {
        return Inertia::render('Admin/Students/Index', [
            'students' => User::where('role', 'user')
                ->with('company')
                ->get(),

            'companies' => Company::all(), // 🔥 IMPORTANT (dropdown)
        ]);
    }

    public function update(Request $request, $id)
    {
        // ✅ validation (safe)
        $request->validate([
            'name' => 'required|string|max:255',
            'company_id' => 'nullable|exists:companies,id',
            'required_hours' => 'nullable|integer|min:0',
        ]);

        $student = User::findOrFail($id);

        $student->update([
            'name' => $request->name,
            'company_id' => $request->company_id,
            'required_hours' => $request->required_hours,
        ]);

        // 🔥 GLOBAL AUTO REFRESH FIX
        return redirect()->route('admin.students');
    }

    public function destroy($id)
    {
        $student = User::findOrFail($id);

        $student->delete();

        return redirect()->route('admin.students');
    }
}