From: Chris Webb <chris@arachsys.com>
Subject: Re: Divide error in kvm_unlock_kick()
Date: Tue, 17 Jun 2014 11:27:59 +0100
Message-ID: <20140617102759.GA28493@arachsys.com>
References: <20140528164231.GA8888@arachsys.com>
	<D2F026E2-666F-4194-B95F-B5001843FA44@arachsys.com>
	<53877396.8010503@redhat.com>
	<CF32F1E1-EF8C-4A18-9697-FAD9CDDBDE8F@arachsys.com>
	<CA9E2B75-9C1E-4940-A438-A35B459D2B45@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA9E2B75-9C1E-4940-A438-A35B459D2B45@arachsys.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I see kernel 3.15 is now out, so I retested with 3.15 guest and host. I'm
still getting exactly the same guest kernel panic: a divide error in
kvm_unlock_kick with -cpu host, but not with -cpu qemu64:

divide error: 0000 [#1] PREEMPT SMP 
Modules linked in:
CPU: 1 PID: 781 Comm: mkdir Not tainted 3.15.0-guest #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
task: ffff88007cbf6180 ti: ffff880000088000 task.ti: ffff880000088000
RIP: 0010:[<ffffffff8102d1e0>]  [<ffffffff8102d1e0>] kvm_unlock_kick+0x63/0x6b
RSP: 0000:ffff88007fc83d38  EFLAGS: 00010046
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000002
RDX: 0000000000000002 RSI: ffff88007fd11d80 RDI: ffffffff81994840
RBP: ffff88007fd11d80 R08: 0000000000000000 R09: ffffffff81994840
R10: ffff88007c480c88 R11: 0000000000000005 R12: 000000000000cec0
R13: ffff88007d38332a R14: 0000000000000002 R15: ffff88007d382d00
FS:  00007fdabf7fd700(0000) GS:ffff88007fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0643f6509 CR3: 000000007c028000 CR4: 00000000000406e0
Stack:
 0000000000011d80 0000000000000002 ffff88007fd11d80 ffffffff8156f83f
 ffffffff810dba53 0000000000000046 ffff88007fd00000 ffff88007d3bbe70
 ffffffff81845da8 0000000000000003 0000000000000000 0000000000000000
Call Trace:
 <IRQ> 
 [<ffffffff8156f83f>] ? _raw_spin_unlock+0x32/0x55
 [<ffffffff810dba53>] ? try_to_wake_up+0x1ed/0x20f
 [<ffffffff810e78b8>] ? autoremove_wake_function+0x9/0x2a
 [<ffffffff810e739a>] ? __wake_up_common+0x47/0x73
 [<ffffffff810e7547>] ? __wake_up+0x33/0x44
 [<ffffffff8110f10b>] ? irq_work_run+0x72/0x8f
 [<ffffffff81006079>] ? smp_irq_work_interrupt+0x26/0x2b
 [<ffffffff8157185d>] ? irq_work_interrupt+0x6d/0x80
 [<ffffffff810dba64>] ? try_to_wake_up+0x1fe/0x20f
 [<ffffffff8102ad01>] ? native_apic_msr_read+0x6/0x4e
 [<ffffffff8156f89f>] ? _raw_spin_unlock_irqrestore+0x3d/0x65
 [<ffffffff810f2de3>] ? rcu_process_callbacks+0x15e/0x47d
 [<ffffffff810cccf3>] ? execute_in_process_context+0x55/0x55
 [<ffffffff810bdb98>] ? __do_softirq+0xe0/0x1e6
 [<ffffffff810bde23>] ? irq_exit+0x3c/0x81
 [<ffffffff810270e4>] ? smp_apic_timer_interrupt+0x3b/0x46
 [<ffffffff8157135d>] ? apic_timer_interrupt+0x6d/0x80
 <EOI> 
Code: 0c c5 c0 b8 87 81 49 8d 04 0c 48 8b 30 48 39 ee 75 ca 8a 40 08 38 d8 75 c3 48 c7 c0 22 b0 00 00 31 db 0f b7 0c 08 b8 05 00 00 00 <0f> 01 c1 5b 5d 41 5c c3 4c 8d 54 24 08 48 83 e4 f0 b9 0a 00 00 
RIP  [<ffffffff8102d1e0>] kvm_unlock_kick+0x63/0x6b
 RSP <ffff88007fc83d38>
---[ end trace 949b1bf47cc57d09 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Shutting down cpus with NMI
Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffff9fffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt

I'm at a complete loss as to what to do next to debug this. Any help would be
extremely gratefully received!

I've put 3.15 host and guest configs here:

  http://cdw.me.uk/tmp/3.15-guest-config.txt
  http://cdw.me.uk/tmp/3.15-host-config.txt

dmesg just after boot here:

  http://cdw.me.uk/tmp/3.15-guest-dmesg.txt
  http://cdw.me.uk/tmp/3.15-host-dmesg.txt

and /proc/cpuinfo from both host and guest here:

  http://cdw.me.uk/tmp/3.15-guest-cpuinfo.txt
  http://cdw.me.uk/tmp/3.15-host-cpuinfo.txt

The qemu command line was

  qemu-system-x86 -enable-kvm -cpu host -machine q35 -m 2048 -name omega \
    -smp sockets=1,cores=4 -pidfile /run/omega.pid -runas nobody \
    -serial stdio -vga none -vnc none -kernel /boot/vmlinuz-guest \
    -append "console=ttyS0 root=/dev/vda" \
    -drive file=/dev/guest/omega,cache=none,format=raw,if=virtio \
    -device virtio-rng-pci \
    -device virtio-net-pci,netdev=nic,mac=02:14:72:3c:69:54 \
    -netdev tap,id=nic,fd=3,vhost=on 3<>/dev/tapNNN

but removing the -machine q35 and -device virtio-rng-pci doesn't affect the
crash.

Dropping to -smp 1, running with -cpu qemu64, or compiling the guest kernel
without paravirtualised spinlock support does remove the panic, albeit at the
cost of performance.

Best wishes,

Chris.
