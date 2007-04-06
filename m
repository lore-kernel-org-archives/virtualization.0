From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 18/20] clean up tsc-based sched_clock
Date: Fri, 06 Apr 2007 16:40:22 -0700
Message-ID: <4616DA66.8040009@goop.org>
References: <20070404191151.009821039@goop.org>	<20070404191206.476822257@goop.org> <20070406162233.b835bd4c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933379AbXDFXlM@vger.kernel.org>
In-Reply-To: <20070406162233.b835bd4c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Wed, 04 Apr 2007 12:12:09 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Three cleanups:
>>  - change "instable" -> "unstable"
>>  - its better to use get_cpu_var for getting this cpu's variables
>>  - change cycles_2_ns to do the full computation rather than just the
>>    tsc->ns scaling.  Its a simpler interface, and it makes the function
>>    more generally useful.
>>
>> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>>
>> ---
>>  arch/i386/kernel/sched-clock.c |   35 +++++++++++++++++++++--------------
>>     
>
> I'm dropping the relevant patch from Andi's tree due to it causing
> mysterious hangs when initscripts start ondemand.  So I'll need to drop
> this patch and "[patch 19/20] Add a sched_clock paravirt_op".
>
>
> I still need to work out why that hang is happening - it is very
> mysterious.  I got as far as working out that it was hanging on
> write_seqlock_irqsave(xtime_lock), then remembered that it's with
> CONFIG_SMP=n so I stomped off to bed in disgust.  Later.
>   

Though I do get:

BUG: at arch/i386/kernel/sched-clock.c:167 init_sched_clock()
 [<c0109012>] show_trace_log_lvl+0x1a/0x30
 [<c01095c7>] show_trace+0x12/0x14
 [<c010965b>] dump_stack+0x16/0x18
 [<c0465f51>] init_sched_clock+0x82/0xa8
 [<c045e547>] init+0x14b/0x241
 [<c0108bf7>] kernel_thread_helper+0x7/0x10
 =======================

which suggests that its being initialized too late.

    J
