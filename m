From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [RFC PATCH 00/26] Runtime paravirt patching
Date: Fri, 10 Apr 2020 02:18:33 -0700
Message-ID: <99d80ba2-9bc9-143f-0f9a-7178c619a2e2@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408120856.GY20713@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408120856.GY20713@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2020-04-08 5:08 a.m., Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 10:02:57PM -0700, Ankur Arora wrote:
>> A KVM host (or another hypervisor) might advertise paravirtualized
>> features and optimization hints (ex KVM_HINTS_REALTIME) which might
>> become stale over the lifetime of the guest. For instance, the
>> host might go from being undersubscribed to being oversubscribed
>> (or the other way round) and it would make sense for the guest
>> switch pv-ops based on that.
> 
> So what, the paravirt spinlock stuff works just fine when you're not
> oversubscribed.
> 
>> We keep an interesting subset of pv-ops (pv_lock_ops only for now,
>> but PV-TLB ops are also good candidates)
> 
> The PV-TLB ops also work just fine when not oversubscribed. IIRC
> kvm_flush_tlb_others() is pretty much the same in that case.
> 
>> in .parainstructions.runtime,
>> while discarding the .parainstructions as usual at init. This is then
>> used for switching back and forth between native and paravirt mode.
>> ([1] lists some representative numbers of the increased memory
>> footprint.)
>>
>> Mechanism: the patching itself is done using stop_machine(). That is
>> not ideal -- text_poke_stop_machine() was replaced with INT3+emulation
>> via text_poke_bp(), but I'm using this to address two issues:
>>   1) emulation in text_poke() can only easily handle a small set
>>   of instructions and this is problematic for inlined pv-ops (and see
>>   a possible alternatives use-case below.)
>>   2) paravirt patching might have inter-dependendent ops (ex.
>>   lock.queued_lock_slowpath, lock.queued_lock_unlock are paired and
>>   need to be updated atomically.)
> 
> And then you hope that the spinlock state transfers.. That is that both
> implementations agree what an unlocked spinlock looks like.
> 
> Suppose the native one was a ticket spinlock, where unlocked means 'head
> == tail' while the paravirt one is a test-and-set spinlock, where
> unlocked means 'val == 0'.
> 
> That just happens to not be the case now, but it was for a fair while.
> 
>> The alternative use-case is a runtime version of apply_alternatives()
>> (not posted with this patch-set) that can be used for some safe subset
>> of X86_FEATUREs. This could be useful in conjunction with the ongoing
>> late microcode loading work that Mihai Carabas and others have been
>> working on.
> 
> The whole late-microcode loading stuff is crazy already; you're making
> it take double bonghits.
That's fair. I was talking in a fairly limited sense, ex making static_cpu_has()
catch up with boot_cpu_has() after a microcode update but I should have
specified that.

> 
>> Also, there are points of similarity with the ongoing static_call work
>> which does rewriting of indirect calls.
> 
> Only in so far as that code patching is involved. An analogy would be
> comparing having a beer with shooting dope. They're both 'drugs'.
I meant closer to updating indirect pointers, like static_call_update()
semantics. But of course I don't know static_call code well enough.

> 
>> The difference here is that
>> we need to switch a group of calls atomically and given that
>> some of them can be inlined, need to handle a wider variety of opcodes.
>>
>> To patch safely we need to satisfy these constraints:
>>
>>   - No references to insn sequences under replacement on any kernel stack
>>     once replacement is in progress. Without this constraint we might end
>>     up returning to an address that is in the middle of an instruction.
> 
> Both ftrace and optprobes have that issue, neither of them are quite as
> crazy as this.
I did look at ftrace. Will look at optprobes. Thanks.

> 
>>   - handle inter-dependent ops: as above, lock.queued_lock_unlock(),
>>     lock.queued_lock_slowpath() and the rest of the pv_lock_ops are
>>     a good example.
> 
> While I'm sure this is a fun problem, why are we solving it?
> 
>>   - handle a broader set of insns than CALL and JMP: some pv-ops end up
>>     getting inlined. Alternatives can contain arbitrary instructions.
> 
> So can optprobes.> 
>>   - locking operations can be called from interrupt handlers which means
>>     we cannot trivially use IPIs for flushing.
> 
> Heck, some NMI handlers use locks..
This does handle the NMI locking problem. The solution -- doing it
in the NMI handler was of course pretty ugly.

>> Handling these, necessitates that target pv-ops not be preemptible.
> 
> I don't think that is a correct inferrence.The non-preemptibility requirement was to ensure that any pv-op under
replacement not be under execution after it is patched out.
(Not a concern for pv_lock_ops.)

Ensuring that we don't return to an address in the middle of an instruction
could be done by moving the NOPs in the prefix, but I couldn't think of
any other way to ensure that a function not be under execution.

Thanks
Ankur

>> Once that is a given (for safety these need to be explicitly whitelisted
>> in runtime_patch()), use a state-machine with the primary CPU doing the
>> patching and secondary CPUs in a sync_core() loop.
>>
>> In case we hit an INT3/BP (in NMI or thread-context) we makes forward
>> progress by continuing the patching instead of emulating.
>>
>> One remaining issue is inter-dependent pv-ops which are also executed in
>> the NMI handler -- patching can potentially deadlock in case of multiple
>> NMIs. Handle these by pushing some of this work in the NMI handler where
>> we know it will be uninterrupted.
> 
> I'm just seeing a lot of bonghits without sane rationale. Why is any of
> this important?
> 
