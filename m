From: Chris Webb <chris@arachsys.com>
Subject: Re: Divide error in kvm_unlock_kick()
Date: Sun, 1 Jun 2014 13:36:03 +0100
Message-ID: <CA9E2B75-9C1E-4940-A438-A35B459D2B45@arachsys.com>
References: <20140528164231.GA8888@arachsys.com>
	<D2F026E2-666F-4194-B95F-B5001843FA44@arachsys.com>
	<53877396.8010503@redhat.com>
	<CF32F1E1-EF8C-4A18-9697-FAD9CDDBDE8F@arachsys.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CF32F1E1-EF8C-4A18-9697-FAD9CDDBDE8F@arachsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I realised my original bug report was for a guest kernel compiled without
frame pointers which might be unhelpful, so I enabled CONFIG_DEBUG_INFO and
CONFIG_FRAME_POINTER, but I don't think this has made the backtrace any more
detailed.

Is there anything more I can do to pinpoint what might be going on here?

Cheers,

Chris.


divide error: 0000 [#1] PREEMPT SMP 
Modules linked in:
CPU: 1 PID: 1013 Comm: mkdir Not tainted 3.14.4-guest #21
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
task: ffff88007c8cf400 ti: ffff88007c7c6000 task.ti: ffff88007c7c6000
RIP: 0010:[<ffffffff8102ea86>]  [<ffffffff8102ea86>] kvm_unlock_kick+0x69/0x73
RSP: 0000:ffff88007fc83ca8  EFLAGS: 00010046
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000002
RDX: 0000000000000002 RSI: ffff88007fd11d40 RDI: ffffffff8198f840
RBP: ffff88007fc83cc0 R08: 0000000000000000 R09: ffffffff8198f840
R10: 000000000000b5e0 R11: 0000000000000005 R12: ffff88007fd11d40
R13: 000000000000cec0 R14: ffff88007d382b80 R15: 0000000000000002
FS:  00007f4c6e265700(0000) GS:ffff88007fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4c6dc9a080 CR3: 000000007c62e000 CR4: 00000000000406e0
Stack:
 0000000000011d40 ffff88007fd11d40 0000000000000002 ffff88007fc83cd0
 ffffffff815852d0 ffff88007fc83d20 ffffffff810dd694 ffff88007fd00000
 0000000000000046 ffff88007d383172 ffff88007d3abe68 0000000000000003
Call Trace:
 <IRQ> 
 [<ffffffff815852d0>] _raw_spin_unlock+0x36/0x5b
 [<ffffffff810dd694>] try_to_wake_up+0x1f4/0x217
 [<ffffffff810dd6f6>] default_wake_function+0xd/0xf
 [<ffffffff810e99f0>] autoremove_wake_function+0xd/0x2f
 [<ffffffff810e944f>] __wake_up_common+0x50/0x7c
 [<ffffffff810e962f>] __wake_up+0x34/0x46
 [<ffffffff810f3b45>] rsp_wakeup+0x1c/0x1e
 [<ffffffff81112e31>] irq_work_run+0x77/0x9b
 [<ffffffff810063e2>] smp_irq_work_interrupt+0x2a/0x31
 [<ffffffff8158739d>] irq_work_interrupt+0x6d/0x80
 [<ffffffff81585336>] ? _raw_spin_unlock_irqrestore+0x41/0x6a
 [<ffffffff810f5402>] rcu_process_callbacks+0x162/0x486
 [<ffffffff810c4140>] ? run_timer_softirq+0x19f/0x1c0
 [<ffffffff810be612>] __do_softirq+0xe1/0x1e9
 [<ffffffff810be8b7>] irq_exit+0x40/0x87
 [<ffffffff810283f1>] smp_apic_timer_interrupt+0x3f/0x4b
 [<ffffffff81586e9d>] apic_timer_interrupt+0x6d/0x80
 <EOI> 
Code: c5 40 50 87 81 49 8d 44 0d 00 48 8b 30 4c 39 e6 75 c9 8a 40 08 38 d8 75 c2 48 c7 c0 22 b0 00 00 31 db 0f b7 0c 08 b8 05 00 00 00 <0f> 01 c1 5b 41 5c 41 5d 5d c3 4c 8d 54 24 08 48 83 e4 f0 b9 0a 
RIP  [<ffffffff8102ea86>] kvm_unlock_kick+0x69/0x73
 RSP <ffff88007fc83ca8>
---[ end trace ed563ea2dedc59b5 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Shutting down cpus with NMI
Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffff9fffffff)
