From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/4] Virtual Machine Time Accounting
Date: Tue, 04 Aug 2009 15:23:44 -0700
Message-ID: <4A78B4F0.2010201__19353.9177802906$1249424746$gmane$org@goop.org>
References: <46C99371.7070705@bull.net>
	<1249395398.7924.223.camel@twins>	<20090804170747.11801f0a@skybase>
	<1249403202.4762.12.camel@laptop>	<20090804192924.217930fc@skybase>
	<1249407194.4762.28.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1249407194.4762.28.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 08/04/09 10:33, Peter Zijlstra wrote:
> On Tue, 2009-08-04 at 19:29 +0200, Martin Schwidefsky wrote:
>
>   
>>> So its going to split user time into user and guest. Does that really
>>> make sense? For the host kernel it really is just another user process,
>>> no?
>>>       
>> The code (at least in parts) is already upstream. Look at the
>> account_guest_time function:
>>
>> static void account_guest_time(struct task_struct *p, cputime_t cputime,
>>                                cputime_t cputime_scaled)
>> {
>>         cputime64_t tmp;
>>         struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
>>
>>         tmp = cputime_to_cputime64(cputime);
>>
>>         /* Add guest time to process. */
>>         p->utime = cputime_add(p->utime, cputime);
>>         p->utimescaled = cputime_add(p->utimescaled, cputime_scaled);
>>         account_group_user_time(p, cputime);
>>         p->gtime = cputime_add(p->gtime, cputime);
>>
>>         /* Add guest time to cpustat. */
>>         cpustat->user = cputime64_add(cpustat->user, tmp);
>>         cpustat->guest = cputime64_add(cpustat->guest, tmp);
>> }
>>
>> The cpu time for a guest is added to p->utime AND p->gtime. That is
>> done not to break existing tools that know nothing about guest time.
>> A guest time aware tool can subtract the p->gtime from p->utime to
>> get the time spent by the process outside of the guest context.
>>     
>
> But why? How a vcpu anything other than yet another userspace process?
>   

Normally a running process can either be accumulating user or system
time.  From the host's perspective, the time spent running a vcpu is
more or less a form of system time[*], but the CPU happens to be in an
odd state (for kvm it would be in an actual completely different CPU
mode; for lguest it would just be configured unusually).

[* I think?  I assume qemu goes into a syscall for a while to run the
vcpu, then returns to qemu userspace when it needs to handle some
exception ]

I don't see that vcpu time is so particularly distinct from any other
kind of system time that it really needs a whole special form of time
accounting, unless the scheduler is being modified to schedule guests
differently from normal processes.  Otherwise it just seems like
something that could be relegated to one of the existing
tracing/benchmarking/profiling mechanisms.

(Full disclosure: these patches are completely irrelevant to Xen.)

    J
