<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Inertia\Inertia;
use App\Models\Company;

class DashboardController extends Controller
{
    public function index()
        {
            $students = User::where('role', 'user');

            return Inertia::render('Admin/Dashboard/Index', [
                'stats' => [
                    'total_students' => $students->count(),

                    'companies' => Company::count(),

                    'active' => User::where('role', 'user')
                        ->whereNotNull('company_id')
                        ->where('required_hours', '>', 0)
                        ->where('rendered_hours', '>', 0) // 🔥 optional
                        ->whereColumn('rendered_hours', '<', 'required_hours')
                        ->count(),

                    // ✅ FIXED (use this if may rendered_hours ka na)
                    'completed' => User::where('role', 'user')
                        ->whereNotNull('company_id')
                        ->where('required_hours', '>', 0) // ✅ important
                        ->whereColumn('rendered_hours', '>=', 'required_hours')
                        ->count(),

                    'no_company' => User::where('role', 'user')
                        ->whereNull('company_id')
                        ->count(),
                ]
            ]);
        }
}
