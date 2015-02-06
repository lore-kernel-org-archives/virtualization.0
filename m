From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Fri, 06 Feb 2015 13:57:08 -0500
Message-ID: <54D50E84.2060703@oracle.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org
Cc: waiman.long@hp.com, jeremy@goop.org, ak@linux.intel.com, a.ryabinin@samsung.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, riel@redhat.com, x86@kernel.org, oleg@redhat.com, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, davej@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On 02/06/2015 09:49 AM, Raghavendra K T wrote:
> Paravirt spinlock clears slowpath flag after doing unlock.
> As explained by Linus currently it does:
>                 prev = *lock;
>                 add_smp(&lock->tickets.head, TICKET_LOCK_INC);
> 
>                 /* add_smp() is a full mb() */
> 
>                 if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
>                         __ticket_unlock_slowpath(lock, prev);
> 
> 
> which is *exactly* the kind of things you cannot do with spinlocks,
> because after you've done the "add_smp()" and released the spinlock
> for the fast-path, you can't access the spinlock any more.  Exactly
> because a fast-path lock might come in, and release the whole data
> structure.
> 
> Linus suggested that we should not do any writes to lock after unlock(),
> and we can move slowpath clearing to fastpath lock.
> 
> However it brings additional case to be handled, viz., slowpath still
> could be set when somebody does arch_trylock. Handle that too by ignoring
> slowpath flag during lock availability check.
> 
> Reported-by: Sasha Levin <sasha.levin@oracle.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

With this patch, my VMs lock up quickly after boot with:

[  161.613469] BUG: spinlock lockup suspected on CPU#31, kworker/31:1/5213
[  161.613469]  lock: purge_lock.28981+0x0/0x40, .magic: dead4ead, .owner: kworker/7:1/6400, .owner_cpu: 7
[  161.613469] CPU: 31 PID: 5213 Comm: kworker/31:1 Not tainted 3.19.0-rc7-next-20150204-sasha-00048-gee3a350 #1869
[  161.613469] Workqueue: events bpf_prog_free_deferred
[  161.613469]  0000000000000000 00000000f03dd27f ffff88056b227a88 ffffffffa1702276
[  161.613469]  0000000000000000 ffff88017cf70000 ffff88056b227aa8 ffffffff9e1d009c
[  161.613469]  ffffffffa3edae60 0000000086c3f830 ffff88056b227ad8 ffffffff9e1d01d7
[  161.613469] Call Trace:
[  161.613469] dump_stack (lib/dump_stack.c:52)
[  161.613469] spin_dump (kernel/locking/spinlock_debug.c:68 (discriminator 8))
[  161.613469] do_raw_spin_lock (include/linux/nmi.h:48 kernel/locking/spinlock_debug.c:119 kernel/locking/spinlock_debug.c:137)
[  161.613469] _raw_spin_lock (kernel/locking/spinlock.c:152)
[  161.613469] ? __purge_vmap_area_lazy (mm/vmalloc.c:615)
[  161.613469] __purge_vmap_area_lazy (mm/vmalloc.c:615)
[  161.613469] ? vm_unmap_aliases (mm/vmalloc.c:1021)
[  161.613469] vm_unmap_aliases (mm/vmalloc.c:1052)
[  161.613469] ? vm_unmap_aliases (mm/vmalloc.c:1021)
[  161.613469] ? __lock_acquire (kernel/locking/lockdep.c:2019 kernel/locking/lockdep.c:3184)
[  161.613469] change_page_attr_set_clr (arch/x86/mm/pageattr.c:1394)
[  161.613469] ? debug_object_deactivate (lib/debugobjects.c:463)
[  161.613469] set_memory_rw (arch/x86/mm/pageattr.c:1662)
[  161.613469] ? __lock_is_held (kernel/locking/lockdep.c:3518)
[  161.613469] bpf_jit_free (include/linux/filter.h:377 arch/x86/net/bpf_jit_comp.c:991)
[  161.613469] bpf_prog_free_deferred (kernel/bpf/core.c:646)
[  161.613469] process_one_work (kernel/workqueue.c:2014 include/linux/jump_label.h:114 include/trace/events/workqueue.h:111 kernel/workqueue.c:2019)
[  161.613469] ? process_one_work (./arch/x86/include/asm/atomic64_64.h:33 include/asm-generic/atomic-long.h:38 kernel/workqueue.c:598 kernel/workqueue.c:625 kernel/workqueue.c:2007)
[  161.613469] worker_thread (include/linux/list.h:189 kernel/workqueue.c:2147)
[  161.613469] ? process_one_work (kernel/workqueue.c:2091)
[  161.613469] kthread (kernel/kthread.c:207)
[  161.613469] ? finish_task_switch (./arch/x86/include/asm/current.h:14 kernel/sched/sched.h:1058 kernel/sched/core.c:2258)
[  161.613469] ? flush_kthread_work (kernel/kthread.c:176)
[  161.613469] ret_from_fork (arch/x86/kernel/entry_64.S:283)
[  161.613469] ? flush_kthread_work (kernel/kthread.c:176)

And a few soft lockup messages inside the scheduler after that.


Thanks,
Sasha
