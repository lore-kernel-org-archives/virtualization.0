From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [RFC PATCH 00/26] Runtime paravirt patching
Date: Fri, 10 Apr 2020 02:55:44 -0700
Message-ID: <c13ce409-790d-18dd-d941-673e9bb797c3@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <87k12qawwl.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <87k12qawwl.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2020-04-08 7:12 a.m., Thomas Gleixner wrote:
> Ankur Arora <ankur.a.arora@oracle.com> writes:
>> A KVM host (or another hypervisor) might advertise paravirtualized
>> features and optimization hints (ex KVM_HINTS_REALTIME) which might
>> become stale over the lifetime of the guest. For instance, the
>> host might go from being undersubscribed to being oversubscribed
>> (or the other way round) and it would make sense for the guest
>> switch pv-ops based on that.
> 
> If your host changes his advertised behaviour then you want to fix the
> host setup or find a competent admin.
> 
>> This lockorture splat that I saw on the guest while testing this is
>> indicative of the problem:
>>
>>    [ 1136.461522] watchdog: BUG: soft lockup - CPU#8 stuck for 22s! [lock_torture_wr:12865]
>>    [ 1136.461542] CPU: 8 PID: 12865 Comm: lock_torture_wr Tainted: G W L 5.4.0-rc7+ #77
>>    [ 1136.461546] RIP: 0010:native_queued_spin_lock_slowpath+0x15/0x220
>>
>> (Caused by an oversubscribed host but using mismatched native pv_lock_ops
>> on the gues.)
> 
> And this illustrates what? The fact that you used a misconfigured setup.
> 
>> This series addresses the problem by doing paravirt switching at
>> runtime.
> 
> You're not addressing the problem. Your fixing the symptom, which is
> wrong to begin with.
> 
>> The alternative use-case is a runtime version of apply_alternatives()
>> (not posted with this patch-set) that can be used for some safe subset
>> of X86_FEATUREs. This could be useful in conjunction with the ongoing
>> late microcode loading work that Mihai Carabas and others have been
>> working on.
> 
> This has been discussed to death before and there is no safe subset as
> long as this hasn't been resolved:
> 
>    https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/
Thanks. I was thinking of fairly limited subset: ex re-evaluate
X86_FEATURE_ALWAYS to make sure static_cpu_has() reflects reality
but I guess that has second order effects here.

Ankur

> 
> Thanks,
> 
>          tglx
> 
