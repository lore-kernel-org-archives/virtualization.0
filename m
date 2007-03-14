From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Tue, 13 Mar 2007 23:52:12 -0700
Message-ID: <45F79B9C.20609@goop.org>
References: <45F6D1D0.6080905@goop.org>	 <1173816769.22180.14.camel@localhost>  <45F70A71.9090205@goop.org>	 <1173821224.1416.24.camel@dwalker1>  <45F71EA5.2090203@goop.org> <1173837606.23595.32.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030666AbXCNGwP@vger.kernel.org>
In-Reply-To: <1173837606.23595.32.camel@imap.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Con Kolivas <kernel@kolivas.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Daniel Walker wrote:
> The adjustments that I spoke of above are working regardless of ntp ..
> The stability of the TSC directly effects the clock mult adjustments in
> timekeeping, as does interrupt latency since the clock is essentially
> validated against the timer interrupt.
>   

Yep.  But the tsc is just an example of a clocksource, and doesn't have
any real bearing on what I'm saying.

> like I said there are other factors so that's not going to exactly model
> cpu speed changes. You could come up with another method, but that would
> likely require another known constant clock.
>   

Well, it doesn't need to be a constant clock if its modelling a changing
rate.  And it doesn't need to be an exact model; it just needs to be
better than the current situation.

> sched_clock doesn't measure amounts of cpu work either, it's all about
> timing. 
>   

Specifically, how much cpu time a process has used.  But if the CPU is
running at half speed (or 50% duty cycle), then claiming that the
process got the full amount of time is just an error.

>> Well, lots of cpus have dynamic frequencies.  Any scheduler which
>> maintains history will suffer the same problem, even on UP.  If
>> processes A and B are supposed to have the same priority and they both
>> execute for 1ms of real time, did they make the same amount of
>> progress?  Not if the cpu changed speed in between.
>>     
>
> That's true, but given a constant clock (like what sched_clock should
> have) then the accounting is similarly inaccurate. Any connection
> between the scheduler and the TSC frequency changes aren't part of the
> design AFAIK ..
>   

Well, my whole argument is that sched_clock /should not/ be a constant
clock.  And I'm not quite sure why you keep bringing up the tsc, because
it has no relevance.

    J
