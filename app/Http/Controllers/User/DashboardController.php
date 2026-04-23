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

        // DAILY HOURS
        $dailyHours = 10;

        // REMAINING DUTY DAYS
        $remainingDutyDays = $dailyHours > 0
            ? ceil($remaining / $dailyHours)
            : 0;

        // ESTIMATED END DATE
        $estimatedEnd = null;

        if ($remainingDutyDays > 0) {
            $date = Carbon::now();
            $daysLeft = $remainingDutyDays;

            while ($daysLeft > 0) {
                $date->addDay();

                if (
                    !$date->isFriday() &&
                    !$date->isSaturday() &&
                    !$date->isSunday()
                ) {
                    $daysLeft--;
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
                'remaining_duty_days' => $remainingDutyDays,
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