<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\Attendance;
use Illuminate\Http\Request;

class RecordController extends Controller
{
    public function index(Request $request)
    {
        $user = Auth::user();

        $needsSetup = !$user->company_id || !$user->required_hours;

        $from = $request->input('from');
        $to = $request->input('to');

        $query = Attendance::where('user_id', $user->id)
            ->orderBy('date', 'desc');

        // ✅ FIXED RANGE FILTER
        if ($from && $to) {
            $query->whereDate('date', '>=', $from)
                  ->whereDate('date', '<=', $to);
        }

        $records = $query->paginate(8)->withQueryString();

        return Inertia::render('User/Records/Index', [
            'needsSetup' => $needsSetup,
            'records' => $records,
            'filters' => [
                'from' => $from,
                'to' => $to
            ]
        ]);
    }
}