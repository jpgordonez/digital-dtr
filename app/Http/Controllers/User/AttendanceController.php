<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Attendance;
use Carbon\Carbon;
use App\Models\User;

class AttendanceController extends Controller
{
    public function index()
    {
        /** @var \App\Models\User $user */
        $user = Auth::user();

        $needsSetup = !$user->company_id || !$user->required_hours;

        $today = now()->toDateString();

        $attendance = Attendance::where('user_id', $user->id)
            ->where('date', $today)
            ->first();

        $lastLog = Attendance::where('user_id', $user->id)
            ->latest('date')
            ->first();

        return Inertia::render('User/Attendance/Index', [
            'needsSetup' => $needsSetup,
            'attendance' => $attendance,
            'lastLog' => $lastLog,
        ]);
    }

    public function store(Request $request)
    {
        /** @var \App\Models\User $user */
        $user = Auth::user();

        // ✅ VALIDATION
        $request->validate([
            'date' => 'required|date',
            'time_in_am' => 'nullable',
            'time_out_am' => 'nullable',
            'time_in_pm' => 'nullable',
            'time_out_pm' => 'nullable',
            'status' => 'required|string',
            'remarks' => 'nullable|string',
        ]);

        // ✅ SAVE OR UPDATE
        $attendance = Attendance::updateOrCreate(
            [
                'user_id' => $user->id,
                'date' => $request->date,
            ],
            [
                'time_in_am' => $request->time_in_am,
                'time_out_am' => $request->time_out_am,
                'time_in_pm' => $request->time_in_pm,
                'time_out_pm' => $request->time_out_pm,
                'status' => $request->status ?? 'present',
                'remarks' => $request->remarks,
            ]
        );

        // ✅ IF NOT WORKING DAY (weekend, holiday, absent)
        if (!in_array($attendance->status, ['present', 'overtime'])) {
            $attendance->hours_rendered = 0;
            $attendance->save();

            return back()->with('success', 'Attendance saved successfully');
        }

        // 🔥 FLEXIBLE COMPUTATION
        $totalMinutes = 0;

        // COMPLETE AM + PM
        if (
            $attendance->time_in_am &&
            $attendance->time_out_am &&
            $attendance->time_in_pm &&
            $attendance->time_out_pm
        ) {
            $totalMinutes += Carbon::parse($attendance->time_in_am)
                ->diffInMinutes($attendance->time_out_am);

            $totalMinutes += Carbon::parse($attendance->time_in_pm)
                ->diffInMinutes($attendance->time_out_pm);
        }

        // STRAIGHT DUTY (no lunch)
        elseif (
            $attendance->time_in_am &&
            $attendance->time_out_pm &&
            !$attendance->time_out_am &&
            !$attendance->time_in_pm
        ) {
            $totalMinutes = Carbon::parse($attendance->time_in_am)
                ->diffInMinutes($attendance->time_out_pm);
        }

        // AM only
        elseif ($attendance->time_in_am && $attendance->time_out_am) {
            $totalMinutes = Carbon::parse($attendance->time_in_am)
                ->diffInMinutes($attendance->time_out_am);
        }

        // PM only
        elseif ($attendance->time_in_pm && $attendance->time_out_pm) {
            $totalMinutes = Carbon::parse($attendance->time_in_pm)
                ->diffInMinutes($attendance->time_out_pm);
        }

        // ✅ SAVE HOURS
        $attendance->hours_rendered = round($totalMinutes / 60, 2);
        $attendance->save();

        // ✅ UPDATE USER TOTAL (only valid work days)
        $totalRendered = Attendance::where('user_id', $user->id)
            ->whereIn('status', ['present', 'overtime'])
            ->sum('hours_rendered');

        $user->rendered_hours = $totalRendered;
        $user->save();

        return back()->with('success', 'Attendance saved successfully');
    }
}