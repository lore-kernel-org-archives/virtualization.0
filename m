From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/6] x86: reduce paravirtualized spinlock overhead
Date: Mon, 18 May 2015 10:11:46 +0200
Message-ID: <55599EC2.8090203@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
	<55425ADA.4060105@goop.org> <554709BB.7090400@suse.com>
	<5548FC1A.7000806@goop.org> <554A0132.3070802@suse.com>
	<20150517053036.GB16607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150517053036.GB16607@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, x86@kernel.org, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, gleb@kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, pbonzini@redhat.com, tglx@linutronix.de, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On 05/17/2015 07:30 AM, Ingo Molnar wrote:
>
> * Juergen Gross <jgross@suse.com> wrote:
>
>> On 05/05/2015 07:21 PM, Jeremy Fitzhardinge wrote:
>>> On 05/03/2015 10:55 PM, Juergen Gross wrote:
>>>> I did a small measurement of the pure locking functions on bare metal
>>>> without and with my patches.
>>>>
>>>> spin_lock() for the first time (lock and code not in cache) dropped from
>>>> about 600 to 500 cycles.
>>>>
>>>> spin_unlock() for first time dropped from 145 to 87 cycles.
>>>>
>>>> spin_lock() in a loop dropped from 48 to 45 cycles.
>>>>
>>>> spin_unlock() in the same loop dropped from 24 to 22 cycles.
>>>
>>> Did you isolate icache hot/cold from dcache hot/cold? It seems to me the
>>> main difference will be whether the branch predictor is warmed up rather
>>> than if the lock itself is in dcache, but its much more likely that the
>>> lock code is icache if the code is lock intensive, making the cold case
>>> moot. But that's pure speculation.
>>>
>>> Could you see any differences in workloads beyond microbenchmarks?
>>>
>>> Not that its my call at all, but I think we'd need to see some concrete
>>> improvements in real workloads before adding the complexity of more pvops.
>>
>> I did another test on a larger machine:
>>
>> 25 kernel builds (time make -j 32) on a 32 core machine. Before each
>> build "make clean" was called, the first result after boot was omitted
>> to avoid disk cache warmup effects.
>>
>> System time without my patches: 861.5664 +/- 3.3665 s
>>                 with my patches: 852.2269 +/- 3.6629 s
>
> So how does the profile look like in the guest, before/after the PV
> spinlock patches? I'm a bit surprised to see so much spinlock
> overhead.

I did another test in Xen dom0:

System time without my patches: 2903 +/- 2 s
                with my patches: 2904 +/- 2 s

BTW, this was what I expected: There should be no significant change in
system time, as the only real difference between both variants in a
guest is an additional 2-byte nop in the inlined unlock function call,
another one in the lock call and one jmp instruction less in the lock
call.

What I didn't expect was the huge performance difference between native
and guest. The used configuration (32 cores with hyperthreads enabled)
surely is one reason for the difference, but still this seems to be too
much. I double checked the results on bare metal, they are still more
or less the same (did only one kernel build resulting in 862 seconds
system time). There seems to be a lot of room for improvement, but
this is another story.

Regarding spinlock overhead: I think the reason I saw about 1% less
system time with my patches was mainly due to less cache misses.
Inlining of the unlock function avoided an additional instruction cache
miss for the unlock function. KT Raghavendra did some benchmarks with
only small user programs and high kernel load which showed nearly no
effect at all.

Additionally I've compared the two kernels using bloat-o-meter:

add/remove: 11/13 grow/shrink: 654/603 up/down: 6046/-31754 (-25708)

with some hot path functions going down in size quite nice, e.g.:

__raw_spin_unlock_irq                        336      90    -246


Juergen
