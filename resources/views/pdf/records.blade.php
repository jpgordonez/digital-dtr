<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>DTR Report</title>

    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            margin: 30px;
        }

        .header {
            text-align: center;
            margin-bottom: 10px;
        }

        .header h2 {
            margin: 0;
            font-size: 18px;
        }


        .info {
            margin-bottom: 10px;
        }

        .info p {
            margin: 2px 0;
        }

        .divider {
            border-bottom: 2px solid #000;
            margin: 10px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #000;
            padding: 6px;
            text-align: center;
        }

        th {
            background: #000;
            color: #fff;
        }

        .total {
            margin-top: 10px;
            text-align: right;
            font-weight: bold;
        }

        .footer {
            margin-top: 40px;
            width: 100%;
        }

        .signature {
            width: 45%;
            display: inline-block;
            text-align: center;
        }

        .line {
            margin-top: 40px;
            border-top: 1px solid #000;
        }

        .label {
            font-size: 11px;
            margin-top: 3px;
        }
    </style>
</head>
<body>

<!-- HEADER -->
<div class="header">
    <h2>DAILY TIME RECORD</h2>
</div>

<div class="divider"></div>

<!-- USER INFO -->
<div class="info">
    <p><strong>Name:</strong> {{ $user->name }}</p>
<p>
    <strong>Date Range:</strong>
    @if($from && $to)
        {{ \Carbon\Carbon::parse($from)->format('M j, Y') }} -
        {{ \Carbon\Carbon::parse($to)->format('M j, Y') }}
    @else
        All
    @endif
</p>
    <p><strong>Date Generated:</strong> {{ now()->format('F d, Y') }}</p>
</div>

<!-- TABLE -->
<table>
    <thead>
        <tr>
            <th>Date</th>
            <th>AM (In-Out)</th>
            <th>PM (In-Out)</th>
            <th>Hours</th>
        </tr>
    </thead>
    <tbody>
    @php $total = 0; @endphp

    @forelse($records as $r)

        @php 
            $total += $r->hours_rendered; 
            $status = strtolower($r->status);
        @endphp

        @if(in_array($status, ['weekend','holiday','dayoff']))

            <!-- ✅ FULL ROW COVER -->
            <tr>
                <td colspan="4" style="font-weight:bold; text-align:center; background:#f2f2f2;">
                    {{ \Carbon\Carbon::parse($r->date)->format('M d, Y') }} - {{ strtoupper($r->status) }}
                </td>
            </tr>

        @else

            <!-- ✅ NORMAL ROW -->
            <tr>
                <td>{{ \Carbon\Carbon::parse($r->date)->format('M d, Y') }}</td>
                <td>{{ $r->time_in_am }} - {{ $r->time_out_am }}</td>
                <td>{{ $r->time_in_pm }} - {{ $r->time_out_pm }}</td>
                <td>{{ number_format($r->hours_rendered, 2) }}</td>
            </tr>

        @endif

    @empty
        <tr>
            <td colspan="4">No records found</td>
        </tr>
    @endforelse
</tbody>
</table>

<!-- TOTAL -->
<div class="total">
    Total Hours Rendered: {{ number_format($total, 2) }} hrs
</div>

<div style="
    margin-top:25px;
    font-size:11px;
    text-align:justify;
    font-style:italic;
    line-height:1.6;
    text-indent:30px;
">
    I certify on my honor that the above is a true and correct report of the hours of work performed, 
    record of which was made daily at the time of arrival and departure from office.
</div>

<!-- SIGNATURE -->
<div class="footer">

    <!-- EMPLOYEE -->
    <div class="signature">
        <div class="line"></div>
        <div class="label">
            <strong>{{ $user->name }}</strong><br>
            <span style="font-size:10px;">Student</span>
        </div>
    </div>

    <!-- SUPERVISOR -->
    <div class="signature" style="float:right;">
        <div class="line"></div>
        <div class="label">

            @if($user->signatory_name && $user->signatory_position)
                <strong>{{ $user->signatory_name }}</strong><br>

                <span style="font-size:10px;">
                    {{ $user->signatory_position }}
                </span><br>

                {{-- OFFICE --}}
                @if($user->company)
                    <span style="font-size:10px;">
                        {{ $user->company->name }}
                    </span>
                @endif

            @else
                <span style="font-size:10px;">
                    Supervisor / Authorized Signatory
                </span>
            @endif

        </div>
    </div>

</div>

</body>
</html>