<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index()
    {
        /** @var \App\Models\User $user */
        $user = Auth::user();
        $user->load('company');

        $needsSetup = !$user->company_id || !$user->required_hours;

        $required = $user->required_hours ?? 0;
        $rendered = $user->rendered_hours ?? 0;
        $remaining = round(max($required - $rendered, 0), 2);

        // 🔥 ESTIMATED END DATE (MOVED HERE)
        $dailyHours = 10;

        $remainingDays = $dailyHours > 0 
            ? ceil($remaining / $dailyHours) 
            : 0;

        $estimatedEnd = null;

        if ($remainingDays > 0) {
            $date = Carbon::now();

            while ($remainingDays > 0) {
                $date->addDay();

                if (
    !$date->isFriday() &&
    !$date->isSaturday() &&
    !$date->isSunday()
) {
                    $remainingDays--;
                }
            }

            $estimatedEnd = $date->toDateString();
        }

        return inertia('User/Dashboard/Index', [
            'needsSetup' => $needsSetup,

            'stats' => [
                'required' => $required,
                'rendered' => $rendered,
                'remaining' => $remaining,
                'estimated_end' => $estimatedEnd,
            ],

            'user' => [
                'name' => $user->name,
                'signatory' => $user->signatory_name,
                'signatory_position' => $user->signatory_position,
                'company' => $user->company,
                'profile_photo' => $user->profile_photo,
            ]
        ]);
    }
}