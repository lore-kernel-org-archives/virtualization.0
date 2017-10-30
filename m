From: Juergen Gross <jgross@suse.com>
Subject: Re: [locking/paravirt] static_key_disable_cpuslocked(): static key
	'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
Date: Mon, 30 Oct 2017 08:47:08 +0100
Message-ID: <f542f9af-70e1-b3e9-fdda-4a83af71fc99@suse.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
	<20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
	<20171030073509.23xtazsqrjuduqq5@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171030073509.23xtazsqrjuduqq5@wfg-t540p.sh.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: boris.ostrovsky@oracle.com, jeremy@goop.org, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, rusty@rustcorp.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, hpa@zytor.com, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On 30/10/17 08:35, Fengguang Wu wrote:
> On Sun, Oct 29, 2017 at 11:51:55PM +0100, Fengguang Wu wrote:
>> Hi Linus,
>>
>> Up to now we see the below boot error/warnings when testing v4.14-rc6.
>>
>> They hit the RC release mainly due to various imperfections in 0day's
>> auto bisection. So I manually list them here and CC the likely easy to
>> debug ones to the corresponding maintainers in the followup emails.
>>
>> boot_successes: 4700
>> boot_failures: 247
> =

> [...]
> =

>> WARNING:at_kernel/jump_label.c:#static_key_disable_cpuslocked: 7

This patch is in the tip tree only, it will be merged in 4.15. So I
don't understand why you are reporting this for 4.14-rc6.

There is a patch by Dou Liyang pending since 28th October addressing
that issue:

[PATCH tip v2] x86/paravirt: Make the virt_spin_lock_key setup after
jump_label_init()


Juergen

> =

> The call trace is
> =

> [=A0=A0=A0 0.000000] Booting paravirtualized kernel on bare hardware
> [=A0=A0=A0 0.000000] clocksource: refined-jiffies: mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [=A0=A0=A0 0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:72
> nr_cpu_ids:72 nr_node_ids:2
> [=A0=A0=A0 0.000000] percpu: Embedded 39 pages/cpu @ffff88103f400000 s120=
088
> r8192 d31464 u262144
> [=A0=A0=A0 0.000000] pcpu-alloc: s120088 r8192 d31464 u262144 alloc=3D1*2=
097152
> [=A0=A0=A0 0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10=
 11
> 12 13 14 15 [=A0=A0=A0 0.000000] pcpu-alloc: [0] 16 17 36 37 38 39 40 41 =
[0]
> 42 43 44 45 46 47 48 49 [=A0=A0=A0 0.000000] pcpu-alloc: [0] 50 51 52 53 =
-- --
> -- -- [1] 18 19 20 21 22 23 24 25 [=A0=A0=A0 0.000000] pcpu-alloc: [1] 26=
 27
> 28 29 30 31 32 33 [1] 34 35 54 55 56 57 58 59 [=A0=A0=A0 0.000000] pcpu-a=
lloc:
> [1] 60 61 62 63 64 65 66 67 [1] 68 69 70 71 -- -- -- -- [=A0=A0=A0 0.0000=
00]
> static_key_disable_cpuslocked(): static key
> 'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
> [=A0=A0=A0 0.000000] ------------[ cut here ]------------
> [=A0=A0=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:161
> static_key_disable_cpuslocked+0x6c/0x80
> [=A0=A0=A0 0.000000] Modules linked in:
> [=A0=A0=A0 0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.14.0-rc6-00162-g3d6dabc2 #1
> [=A0=A0=A0 0.000000] Hardware name: Intel Corporation S2600WTT/S2600WTT, =
BIOS
> SE5C610.86B.01.01.0008.021120151325 02/11/2015
> [=A0=A0=A0 0.000000] task: ffffffff81e10480 task.stack: ffffffff81e00000
> [=A0=A0=A0 0.000000] RIP: 0010:static_key_disable_cpuslocked+0x6c/0x80
> [=A0=A0=A0 0.000000] RSP: 0000:ffffffff81e03e98 EFLAGS: 00010092 ORIG_RAX:
> 0000000000000000
> [=A0=A0=A0 0.000000] RAX: 000000000000006f RBX: ffffffff81e36fc0 RCX:
> ffffffff81e60cf8
> [=A0=A0=A0 0.000000] RDX: 0000000000000001 RSI: 0000000000000092 RDI:
> 0000000000000047
> [=A0=A0=A0 0.000000] RBP: ffffffff81e03ea8 R08: 6b5f636974617473 R09:
> 000000000000018c
> [=A0=A0=A0 0.000000] R10: 0000000000000000 R11: 000000000000006f R12:
> ffff88207ffcf4c0
> [=A0=A0=A0 0.000000] R13: ffffffff82170920 R14: ffffffff8218b780 R15:
> 0000000000000000
> [=A0=A0=A0 0.000000] FS:=A0 0000000000000000(0000) GS:ffff88103f400000(00=
00)
> knlGS:0000000000000000
> [=A0=A0=A0 0.000000] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [=A0=A0=A0 0.000000] CR2: ffff88207f4e0000 CR3: 000000207ee09000 CR4:
> 00000000000606b0
> [=A0=A0=A0 0.000000] Call Trace:
> [=A0=A0=A0 0.000000]=A0 static_key_disable+0x1a/0x30
> [=A0=A0=A0 0.000000]=A0 native_pv_lock_init+0x1b/0x1e
> [=A0=A0=A0 0.000000]=A0 native_smp_prepare_boot_cpu+0x32/0x35
> [=A0=A0=A0 0.000000]=A0 start_kernel+0x14f/0x421
> [=A0=A0=A0 0.000000]=A0 x86_64_start_reservations+0x2a/0x2c
> [=A0=A0=A0 0.000000]=A0 x86_64_start_kernel+0x72/0x75
> [=A0=A0=A0 0.000000]=A0 secondary_startup_64+0xa5/0xb0
> [=A0=A0=A0 0.000000] Code: 85 c0 75 2f 48 c7 c7 20 5e f0 81 e8 df 2a 7b 0=
0 5b
> 41 5c 5d c3 48 89 fa 48 c7 c6 40 93 a3 81 48 c7 c7 00 8b cb 81 e8 95 b5
> f3 ff <0f> ff eb a8 0f ff eb b3 48 89 df e8 14 fc ff ff eb c7 66 90 e8
> [=A0=A0=A0 0.000000] ---[ end trace c12d07f00399ce78 ]---
> [=A0=A0=A0 0.000000] Built 2 zonelists, mobility grouping on.=A0 Total pa=
ges:
> 33006159
> [=A0=A0=A0 0.000000] Policy zone: Normal
> =

> which is bisected to
> =

> commit 9043442b43b1fddf202591b84702863286700c1a
> Author:=A0=A0=A0=A0 Juergen Gross <jgross@suse.com>
> AuthorDate: Wed Sep 6 19:36:24 2017 +0200
> Commit:=A0=A0=A0=A0 Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue Oct 10 11:50:12 2017 +0200
> =

> =A0=A0 locking/paravirt: Use new static key for controlling call of
> virt_spin_lock()
> =

> =A0=A0 There are cases where a guest tries to switch spinlocks to bare me=
tal
> =A0=A0 behavior (e.g. by setting "xen_nopvspin" boot parameter). Today th=
is
> =A0=A0 has the downside of falling back to unfair test and set scheme for
> =A0=A0 qspinlocks due to virt_spin_lock() detecting the virtualized
> =A0=A0 environment.
> =

> =A0=A0 Add a static key controlling whether virt_spin_lock() should be
> =A0=A0 called or not. When running on bare metal set the new key to false.
> =

> =A0=A0 Signed-off-by: Juergen Gross <jgross@suse.com>
> =A0=A0 Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> =A0=A0 Acked-by: Waiman Long <longman@redhat.com>
> =A0=A0 Cc: Linus Torvalds <torvalds@linux-foundation.org>
> =A0=A0 Cc: Peter Zijlstra <peterz@infradead.org>
> =A0=A0 Cc: Thomas Gleixner <tglx@linutronix.de>
> =A0=A0 Cc: akataria@vmware.com
> =A0=A0 Cc: boris.ostrovsky@oracle.com
> =A0=A0 Cc: chrisw@sous-sol.org
> =A0=A0 Cc: hpa@zytor.com
> =A0=A0 Cc: jeremy@goop.org
> =A0=A0 Cc: rusty@rustcorp.com.au
> =A0=A0 Cc: virtualization@lists.linux-foundation.org
> =A0=A0 Cc: xen-devel@lists.xenproject.org
> =A0=A0 Link: http://lkml.kernel.org/r/20170906173625.18158-2-jgross@suse.=
com
> =A0=A0 Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
> arch/x86/include/asm/qspinlock.h | 11 ++++++++++-
> arch/x86/kernel/paravirt.c=A0=A0=A0=A0=A0=A0 | 14 ++++++++++++--
> arch/x86/kernel/smpboot.c=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> 3 files changed, 24 insertions(+), 3 deletions(-)
> =

> Thanks,
> Fengguang
