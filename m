From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Thu, 14 Jun 2012 17:51:02 +0530
Message-ID: <4FD9D72E.1010606__27272.6778210656$1339676592$gmane$org@linux.vnet.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
	<20120507082928.GI16608@gmail.com> <4FA7888F.80505@redhat.com>
	<4FA7AAD8.6050003@linux.vnet.ibm.com> <4FA7BABA.4040700@redhat.com>
	<4FA7CC05.50808@linux.vnet.ibm.com> <4FA7CCA2.4030408@redhat.com>
	<4FA7D06B.60005@linux.vnet.ibm.com>
	<20120507134611.GB5533@linux.vnet.ibm.com>
	<4FA7D2E5.1020607@redhat.com> <4FA7D3F7.9080005@linux.vnet.ibm.com>
	<4FA7D50D.1020209@redhat.com> <4FA7E06E.20304@linux.vnet.ibm.com>
	<4FA7E1C8.7010509@redhat.com> <4FB0014A.90604@linux.vnet.ibm.com>
	<4FB31CA4.5070908@linux.vnet.ibm.com>
	<4FC603D4.20107@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FC603D4.20107@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Nikunj A. Dadhania" <nikunj@linux.vnet.ibm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.co>
List-Id: virtualization@lists.linuxfoundation.org

On 05/30/2012 04:56 PM, Raghavendra K T wrote:
> On 05/16/2012 08:49 AM, Raghavendra K T wrote:
>> On 05/14/2012 12:15 AM, Raghavendra K T wrote:
>>> On 05/07/2012 08:22 PM, Avi Kivity wrote:
>>>
>>> I could not come with pv-flush results (also Nikunj had clarified that
>>> the result was on NOn PLE
>>>
>>>> I'd like to see those numbers, then.
>>>>
>>>> Ingo, please hold on the kvm-specific patches, meanwhile.
> [...]
>> To summarise,
>> with 32 vcpu guest with nr thread=32 we get around 27% improvement. In
>> very low/undercommitted systems we may see very small improvement or
>> small acceptable degradation ( which it deserves).
>>
>
> For large guests, current value SPIN_THRESHOLD, along with ple_window
> needed some of research/experiment.
>
> [Thanks to Jeremy/Nikunj for inputs and help in result analysis ]
>
> I started with debugfs spinlock/histograms, and ran experiments with 32,
> 64 vcpu guests for spin threshold of 2k, 4k, 8k, 16k, and 32k with
> 1vm/2vm/4vm for kernbench, sysbench, ebizzy, hackbench.
> [ spinlock/histogram gives logarithmic view of lockwait times ]
>
> machine: PLE machine with 32 cores.
>
> Here is the result summary.
> The summary includes 2 part,
> (1) %improvement w.r.t 2K spin threshold,
> (2) improvement w.r.t sum of histogram numbers in debugfs (that gives
> rough indication of contention/cpu time wasted)
>
> For e.g 98% for 4k threshold kbench 1 vm would imply, there is a 98%
> reduction in sigma(histogram values) compared to 2k case
>
> Result for 32 vcpu guest
> ==========================
> +----------------+-----------+-----------+-----------+-----------+
> | Base-2k | 4k | 8k | 16k | 32k |
> +----------------+-----------+-----------+-----------+-----------+
> | kbench-1vm | 44 | 50 | 46 | 41 |
> | SPINHisto-1vm | 98 | 99 | 99 | 99 |
> | kbench-2vm | 25 | 45 | 49 | 45 |
> | SPINHisto-2vm | 31 | 91 | 99 | 99 |
> | kbench-4vm | -13 | -27 | -2 | -4 |
> | SPINHisto-4vm | 29 | 66 | 95 | 99 |
> +----------------+-----------+-----------+-----------+-----------+
> | ebizzy-1vm | 954 | 942 | 913 | 915 |
> | SPINHisto-1vm | 96 | 99 | 99 | 99 |
> | ebizzy-2vm | 158 | 135 | 123 | 106 |
> | SPINHisto-2vm | 90 | 98 | 99 | 99 |
> | ebizzy-4vm | -13 | -28 | -33 | -37 |
> | SPINHisto-4vm | 83 | 98 | 99 | 99 |
> +----------------+-----------+-----------+-----------+-----------+
> | hbench-1vm | 48 | 56 | 52 | 64 |
> | SPINHisto-1vm | 92 | 95 | 99 | 99 |
> | hbench-2vm | 32 | 40 | 39 | 21 |
> | SPINHisto-2vm | 74 | 96 | 99 | 99 |
> | hbench-4vm | 27 | 15 | 3 | -57 |
> | SPINHisto-4vm | 68 | 88 | 94 | 97 |
> +----------------+-----------+-----------+-----------+-----------+
> | sysbnch-1vm | 0 | 0 | 1 | 0 |
> | SPINHisto-1vm | 76 | 98 | 99 | 99 |
> | sysbnch-2vm | -1 | 3 | -1 | -4 |
> | SPINHisto-2vm | 82 | 94 | 96 | 99 |
> | sysbnch-4vm | 0 | -2 | -8 | -14 |
> | SPINHisto-4vm | 57 | 79 | 88 | 95 |
> +----------------+-----------+-----------+-----------+-----------+
>
> result for 64 vcpu guest
> =========================
> +----------------+-----------+-----------+-----------+-----------+
> | Base-2k | 4k | 8k | 16k | 32k |
> +----------------+-----------+-----------+-----------+-----------+
> | kbench-1vm | 1 | -11 | -25 | 31 |
> | SPINHisto-1vm | 3 | 10 | 47 | 99 |
> | kbench-2vm | 15 | -9 | -66 | -15 |
> | SPINHisto-2vm | 2 | 11 | 19 | 90 |
> +----------------+-----------+-----------+-----------+-----------+
> | ebizzy-1vm | 784 | 1097 | 978 | 930 |
> | SPINHisto-1vm | 74 | 97 | 98 | 99 |
> | ebizzy-2vm | 43 | 48 | 56 | 32 |
> | SPINHisto-2vm | 58 | 93 | 97 | 98 |
> +----------------+-----------+-----------+-----------+-----------+
> | hbench-1vm | 8 | 55 | 56 | 62 |
> | SPINHisto-1vm | 18 | 69 | 96 | 99 |
> | hbench-2vm | 13 | -14 | -75 | -29 |
> | SPINHisto-2vm | 57 | 74 | 80 | 97 |
> +----------------+-----------+-----------+-----------+-----------+
> | sysbnch-1vm | 9 | 11 | 15 | 10 |
> | SPINHisto-1vm | 80 | 93 | 98 | 99 |
> | sysbnch-2vm | 3 | 3 | 4 | 2 |
> | SPINHisto-2vm | 72 | 89 | 94 | 97 |
> +----------------+-----------+-----------+-----------+-----------+
>
>  From this, value around 4k-8k threshold seem to be optimal one. [ This
> is amost inline with ple_window default ]
> (lower the spin threshold, we would cover lesser % of spinlocks, that
> would result in more halt_exit/wakeups.
>
> [ www.xen.org/files/xensummitboston08/LHP.pdf also has good graphical
> detail on covering spinlock waits ]
>
> After 8k threshold, we see no more contention but that would mean we
> have wasted lot of cpu time in busy waits.
>
> Will get a PLE machine again, and 'll continue experimenting with
> further tuning of SPIN_THRESHOLD.

Sorry for delayed response. Was doing too much of analysis and
experiments.

Continued my experiment, with spin threshold. unfortunately could
not settle between which one of 4k/8k threshold is better, since it
depends on load and type of workload.

Here is the result for 32 vcpu guest for sysbench and kernebench for 4 
8GB RAM vms on same PLE machine with:

1x: benchmark running on 1 guest
2x: same benchmark running on 2 guest and so on

1x run is taken over 8*3 run averages
2x run was taken with 4*3 runs
3x run was with 6*3
4x run was with 4*3


kernbench
=========
total job=2* number of vcpus
kernbench -f -H -M -o $total_job


+------------+------------+-----------+---------------+---------+
| base       |  pv_4k     | %impr     |   pv_8k       | %impr   |
+------------+------------+-----------+---------------+---------+
| 49.98      |  49.147475 | 1.69393   |   50.575567   | -1.17758|
| 106.0051   |  96.668325 | 9.65857   |   91.62165    | 15.6987 |
| 189.82067  |  181.839   | 4.38942   |   188.8595    | 0.508934|
+------------+------------+-----------+---------------+---------+

sysbench
===========
Ran with  num_thread=2* number of vcpus

sysbench --num-threads=$num_thread --max-requests=100000 --test=oltp 
--oltp-table-size=500000 --db-driver=pgsql --oltp-read-only run

32 vcpu
-------

+------------+------------+-----------+---------------+---------+
| base       |  pv_4k     | %impr     |   pv_8k       | %impr   |
+------------+------------+-----------+---------------+---------+
| 16.4109    |  12.109988 | 35.5154   |   12.658113   | 29.6473 |
| 14.232712  |  13.640387 | 4.34244   |   14.16485    | 0.479087|
| 23.49685   |  23.196375 | 1.29535   |   19.024871   | 23.506  |
+------------+------------+-----------+---------------+---------+

and observations are:

1) 8k threshold does better for medium overcommit. But PLE has more
control rather than pv spinlock.

2) 4k does well for no overcommit and high overcommit cases. and also,
for non PLE machine this helps rather than 8k. in medium overcommit
cases, we see less performance benefits due to increase in halt exits

I 'll continue my analysis.
Also I have come-up with directed yield patch where we do directed
yield in vcpu block path, instead of blind schedule. will do some more
experiment with that and post as an RFC.

Let me know if you have any comments/suggestions.
