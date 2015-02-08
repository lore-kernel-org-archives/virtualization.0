From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 08 Feb 2015 23:27:56 +0530
Message-ID: <54D7A3A4.1030609__29810.8933646747$1423418772$gmane$org@linux.vnet.ibm.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D50E84.2060703@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54D50E84.2060703@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, oleg@redhat.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/07/2015 12:27 AM, Sasha Levin wrote:
> On 02/06/2015 09:49 AM, Raghavendra K T wrote:
>> Paravirt spinlock clears slowpath flag after doing unlock.
>> As explained by Linus currently it does:
>>                  prev = *lock;
>>                  add_smp(&lock->tickets.head, TICKET_LOCK_INC);
>>
>>                  /* add_smp() is a full mb() */
>>
>>                  if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
>>                          __ticket_unlock_slowpath(lock, prev);
>>
>>
>> which is *exactly* the kind of things you cannot do with spinlocks,
>> because after you've done the "add_smp()" and released the spinlock
>> for the fast-path, you can't access the spinlock any more.  Exactly
>> because a fast-path lock might come in, and release the whole data
>> structure.
>>
>> Linus suggested that we should not do any writes to lock after unlock(),
>> and we can move slowpath clearing to fastpath lock.
>>
>> However it brings additional case to be handled, viz., slowpath still
>> could be set when somebody does arch_trylock. Handle that too by ignoring
>> slowpath flag during lock availability check.
>>
>> Reported-by: Sasha Levin <sasha.levin@oracle.com>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>
> With this patch, my VMs lock up quickly after boot with:

Tried to reproduce the hang myself, and there seems to be still a
barrier (or logic I miss).

Looking closely below, unlock_kick got missed though we see
that SLOWPATH_FLAG is still set:

/me goes back to look closely

(gdb) bt
#0  native_halt () at ./arch/x86/include/asm/irqflags.h:55
#1  0xffffffff81037c27 in halt () at ./arch/x86/include/asm/paravirt.h:116
#2  kvm_lock_spinning (lock=0xffff88023ffe8240, want=52504) at 
arch/x86/kernel/kvm.c:786
#3  0xffffffff81037251 in __raw_callee_save_kvm_lock_spinning ()
#4  0xffff88023fc0edb0 in ?? ()
#5  0x0000000000000000 in ?? ()

(gdb) p *(arch_spinlock_t *)0xffff88023ffe8240
$1 = {{head_tail = 3441806612, tickets = {head = 52500, tail = 52517}}}
(gdb) t 2
[Switching to thread 2 (Thread 2)]
#0  native_halt () at ./arch/x86/include/asm/irqflags.h:55
55	}
(gdb) bt
#0  native_halt () at ./arch/x86/include/asm/irqflags.h:55
#1  0xffffffff81037c27 in halt () at ./arch/x86/include/asm/paravirt.h:116
#2  kvm_lock_spinning (lock=0xffff88023ffe8240, want=52502) at 
arch/x86/kernel/kvm.c:786
#3  0xffffffff81037251 in __raw_callee_save_kvm_lock_spinning ()
#4  0x0000000000000246 in irq_stack_union ()
#5  0x0000000000080750 in ?? ()
#6  0x0000000000020000 in ?? ()
#7  0x0000000000000004 in irq_stack_union ()
#8  0x000000000000cd16 in nmi_print_seq ()
Cannot access memory at address 0xbfc0
(gdb) t 3
[Switching to thread 3 (Thread 3)]
#0  native_halt () at ./arch/x86/include/asm/irqflags.h:55
55	}
(gdb) bt
#0  native_halt () at ./arch/x86/include/asm/irqflags.h:55
#1  0xffffffff81037c27 in halt () at ./arch/x86/include/asm/paravirt.h:116
#2  kvm_lock_spinning (lock=0xffff88023ffe8240, want=52512) at 
arch/x86/kernel/kvm.c:786
#3  0xffffffff81037251 in __raw_callee_save_kvm_lock_spinning ()
#4  0xffff88023fc8edb0 in ?? ()
#5  0x0000000000000000 in ?? ()

[...] //other threads with similar output

(gdb) t 8
[Switching to thread 8 (Thread 8)]
#0  native_halt () at ./arch/x86/include/asm/irqflags.h:55
55	}
(gdb) bt
#0  native_halt () at ./arch/x86/include/asm/irqflags.h:55
#1  0xffffffff81037c27 in halt () at ./arch/x86/include/asm/paravirt.h:116
#2  kvm_lock_spinning (lock=0xffff88023ffe8240, want=52500) at 
arch/x86/kernel/kvm.c:786
#3  0xffffffff81037251 in __raw_callee_save_kvm_lock_spinning ()
#4  0xffff88023fdcedb0 in ?? ()
#5  0x0000000000000000 in ?? ()
