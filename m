From: Chris Webb <chris@arachsys.com>
Subject: Divide error in kvm_unlock_kick()
Date: Wed, 28 May 2014 17:42:31 +0100
Message-ID: <20140528164231.GA8888__5826.80408047072$1401464356$gmane$org@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Running a 3.14.4 x86-64 SMP guest kernel on qemu-2.0, with kvm enabled and
-cpu host on a 3.14.4 AMD Opteron host, I'm seeing a reliable kernel panic from
the guest shortly after boot. I think is happening in kvm_unlock_kick() in the
paravirt_ops code:

divide error: 0000 [#1] PREEMPT SMP 
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.14.4-guest #16
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
task: ffff88007d384880 ti: ffff88007d3b2000 task.ti: ffff88007d3b2000
RIP: 0010:[<ffffffff8102f0cc>]  [<ffffffff8102f0cc>] kvm_unlock_kick+0x63/0x6b
RSP: 0018:ffff88007fc83db0  EFLAGS: 00010046
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000003 RSI: ffff88007fd91d40 RDI: 0000000000000008
RBP: ffff88007fd91d40 R08: 0000000000000000 R09: ffffffff8198e840
R10: ffff88007cbc7400 R11: ffff88007cbc9d00 R12: 000000000000cec0
R13: 0000000000000001 R14: ffff88007fd91d40 R15: 0000000000000001
FS:  00007ff42a4d3700(0000) GS:ffff88007fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007ff42a290006 CR3: 000000007c76d000 CR4: 00000000000406e0
Stack:
 ffff88007fd11d40 ffff88007d361cc0 ffff88007fc8d240 ffffffff81563990
 ffffffff810e42a6 000000038102fa73 0000000000000282 0000000000000000
 ffff88007fd12668 ffff88007fc83ecc 00ffffff00000000 000000000000006b
Call Trace:
 <IRQ> 
 [<ffffffff81563990>] ? _raw_spin_unlock+0x57/0x61
 [<ffffffff810e42a6>] ? load_balance+0x4ff/0x783
 [<ffffffff810e4681>] ? rebalance_domains+0x157/0x20c
 [<ffffffff810e4841>] ? run_rebalance_domains+0x10b/0x148
 [<ffffffff810be7c1>] ? __do_softirq+0xec/0x1fe
 [<ffffffff810beacc>] ? irq_exit+0x48/0x8d
 [<ffffffff815658dd>] ? reschedule_interrupt+0x6d/0x80
 <EOI> 
 [<ffffffff8100a842>] ? hard_enable_TSC+0x2e/0x2e
 [<ffffffff8102fbe1>] ? native_safe_halt+0x2/0x3
 [<ffffffff8100a853>] ? default_idle+0x11/0x14
 [<ffffffff810ed4e7>] ? cpu_startup_entry+0x153/0x1d2
 [<ffffffff810277ad>] ? start_secondary+0x220/0x23c
Code: 0c c5 40 50 87 81 49 8d 04 0c 48 8b 30 48 39 ee 75 ca 8a 40 08 38 d8 75 c3 48 c7 c0 22 b0 00 00 31 db 0f b7 0c 08 b8 05 00 00 00 <0f> 01 c1 5b 5d 41 5c c3 4c 8d 54 24 08 48 83 e4 f0 b9 0a 00 00 
RIP  [<ffffffff8102f0cc>] kvm_unlock_kick+0x63/0x6b
 RSP <ffff88007fc83db0>
---[ end trace 2278d9742b4dff74 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Shutting down cpus with NMI
Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffff9fffffff)

My host kernel config is http://cdw.me.uk/tmp/host-config.txt and the guest
config is http://cdw.me.uk/tmp/guest-config.txt with qemu command line:

  qemu-system-x86 -enable-kvm -cpu qemu64 -machine q35 -m 2048 -name $1 \
    -smp sockets=1,cores=4 -pidfile /run/$1.pid -runas nobody \
    -serial stdio -vga none -vnc none -kernel /boot/vmlinuz-guest \
    -append "console=ttyS0 root=/dev/vda" \
    -drive file=/dev/guest/$1,cache=none,format=raw,if=virtio \
    -device virtio-net-pci,netdev=nic,mac=$(< /sys/class/net/$1/address) \
    -netdev tap,id=nic,fd=3 3<>/dev/tap$(< /sys/class/net/$1/ifindex)

I can stop this crash by disabling CONFIG_PARAVIRT_SPINLOCKS in my guest
kernel, running with -cpu qemu64 instead of -cpu host, or running with -smp 1
instead of -smp 4. (Removing/changing the -machine q35 makes no difference.)

My CPU flags inside the crashing guest look like this:

fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush
mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb lm rep_good nopl
extd_apicid pni pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic popcnt aes xsave
avx f16c hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse
3dnowprefetch osvw xop fma4 tbm arat npt nrip_save tsc_adjust bmi1

whereas in a (working) -cpu qemu64 guest, they look like this:

fpu de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx
fxsr sse sse2 ht syscall nx lm nopl pni cx16 x2apic popcnt hypervisor lahf_lm
cmp_legacy svm abm sse4a

I tried enabling CONFIG_PARAVIRT_DEBUG, but no extra information was reported.

Very happy to do any testing at my end which might help track down what's going
on here.

Best wishes,

Chris.
