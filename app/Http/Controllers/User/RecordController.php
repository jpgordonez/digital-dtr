<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\Attendance;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;


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

        public function exportPdf(Request $request)
            {
                $user = Auth::user();

                $query = Attendance::where('user_id', $user->id);

                if ($request->from && $request->to) {
                    $query->whereBetween('date', [$request->from, $request->to]);
                }

                $records = $query->orderBy('date', 'asc')->get();

                $pdf = Pdf::loadView('pdf.records', [
                    'records' => $records,
                    'from' => $request->from,
                    'to' => $request->to,
                    'user' => $user
                ]);

                // Kunin last word (surname)
                    $lastName = collect(explode(' ', $user->name))->last();

                    // gawing lowercase
                    $lastName = strtolower($lastName);

                    // alisin special characters (ñ → n, etc.)
                    $lastName = iconv('UTF-8', 'ASCII//TRANSLIT', $lastName);
                    $lastName = preg_replace('/[^a-z0-9]/', '', $lastName);

                    // final filename
                    $fileName = $lastName . '-attendance.pdf';

                    return $pdf->stream($fileName);
            }
}