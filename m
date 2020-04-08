From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 00/26] Runtime paravirt patching
Date: Tue,  7 Apr 2020 22:02:57 -0700
Message-ID: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, vkuznets@redhat.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

A KVM host (or another hypervisor) might advertise paravirtualized
features and optimization hints (ex KVM_HINTS_REALTIME) which might
become stale over the lifetime of the guest. For instance, the
host might go from being undersubscribed to being oversubscribed
(or the other way round) and it would make sense for the guest
switch pv-ops based on that.

This lockorture splat that I saw on the guest while testing this is
indicative of the problem:

  [ 1136.461522] watchdog: BUG: soft lockup - CPU#8 stuck for 22s! [lock_torture_wr:12865]
  [ 1136.461542] CPU: 8 PID: 12865 Comm: lock_torture_wr Tainted: G W L 5.4.0-rc7+ #77
  [ 1136.461546] RIP: 0010:native_queued_spin_lock_slowpath+0x15/0x220

(Caused by an oversubscribed host but using mismatched native pv_lock_ops
on the gues.)

This series addresses the problem by doing paravirt switching at runtime.

We keep an interesting subset of pv-ops (pv_lock_ops only for now,
but PV-TLB ops are also good candidates) in .parainstructions.runtime,
while discarding the .parainstructions as usual at init. This is then
used for switching back and forth between native and paravirt mode.
([1] lists some representative numbers of the increased memory
footprint.)

Mechanism: the patching itself is done using stop_machine(). That is
not ideal -- text_poke_stop_machine() was replaced with INT3+emulation
via text_poke_bp(), but I'm using this to address two issues:
 1) emulation in text_poke() can only easily handle a small set
 of instructions and this is problematic for inlined pv-ops (and see
 a possible alternatives use-case below.)
 2) paravirt patching might have inter-dependendent ops (ex.
 lock.queued_lock_slowpath, lock.queued_lock_unlock are paired and
 need to be updated atomically.)

The alternative use-case is a runtime version of apply_alternatives()
(not posted with this patch-set) that can be used for some safe subset
of X86_FEATUREs. This could be useful in conjunction with the ongoing
late microcode loading work that Mihai Carabas and others have been
working on.

Also, there are points of similarity with the ongoing static_call work
which does rewriting of indirect calls. The difference here is that
we need to switch a group of calls atomically and given that
some of them can be inlined, need to handle a wider variety of opcodes.

To patch safely we need to satisfy these constraints:

 - No references to insn sequences under replacement on any kernel stack
   once replacement is in progress. Without this constraint we might end
   up returning to an address that is in the middle of an instruction.

 - handle inter-dependent ops: as above, lock.queued_lock_unlock(),
   lock.queued_lock_slowpath() and the rest of the pv_lock_ops are
   a good example.

 - handle a broader set of insns than CALL and JMP: some pv-ops end up
   getting inlined. Alternatives can contain arbitrary instructions.

 - locking operations can be called from interrupt handlers which means
   we cannot trivially use IPIs for flushing.

Handling these, necessitates that target pv-ops not be preemptible.
Once that is a given (for safety these need to be explicitly whitelisted
in runtime_patch()), use a state-machine with the primary CPU doing the
patching and secondary CPUs in a sync_core() loop. 

In case we hit an INT3/BP (in NMI or thread-context) we makes forward
progress by continuing the patching instead of emulating.

One remaining issue is inter-dependent pv-ops which are also executed in
the NMI handler -- patching can potentially deadlock in case of multiple
NMIs. Handle these by pushing some of this work in the NMI handler where
we know it will be uninterrupted.

There are four main sets of patches in this series:

 1. PV-ops management (patches 1-10, 20): mostly infrastructure and
 refactoring pieces to make paravirt patching usable at runtime. For the
 most part scoped under CONFIG_PARAVIRT_RUNTIME.

 Patches 1-7, to persist part of parainstructions in memory:
  "x86/paravirt: Specify subsection in PVOP macros"
  "x86/paravirt: Allow paravirt patching post-init"
  "x86/paravirt: PVRTOP macros for PARAVIRT_RUNTIME"
  "x86/alternatives: Refactor alternatives_smp_module*
  "x86/alternatives: Rename alternatives_smp*, smp_alt_module
  "x86/alternatives: Remove stale symbols
  "x86/paravirt: Persist .parainstructions.runtime"

 Patches 8-10, develop the inerfaces to safely switch pv-ops:
  "x86/paravirt: Stash native pv-ops"
  "x86/paravirt: Add runtime_patch()"
  "x86/paravirt: Add primitives to stage pv-ops"

 Patch 20 enables switching of pv_lock_ops:
  "x86/paravirt: Enable pv-spinlocks in runtime_patch()"

 2. Non-emulated text poking (patches 11-19)

 Patches 11-13 are mostly refactoring to split __text_poke() into map,
 unmap and poke/memcpy phases with the poke portion being re-entrant
  "x86/alternatives: Remove return value of text_poke*()"
  "x86/alternatives: Use __get_unlocked_pte() in text_poke()"
  "x86/alternatives: Split __text_poke()"

 Patches 15, 17 add the actual poking state-machine:
  "x86/alternatives: Non-emulated text poking"
  "x86/alternatives: Add patching logic in text_poke_site()"

 with patches 14 and 18 containing the pieces for BP handling:
  "x86/alternatives: Handle native insns in text_poke_loc*()"
  "x86/alternatives: Handle BP in non-emulated text poking"

 and patch 19 provides the ability to use the state-machine above in an
 NMI context (fixes some potential deadlocks when handling inter-
 dependent operations and multiple NMIs):
  "x86/alternatives: NMI safe runtime patching".

 Patch 16 provides the interface (paravirt_runtime_patch()) to use the
 poking mechanism developed above and patch 21 adds a selftest:
  "x86/alternatives: Add paravirt patching at runtime"
  "x86/alternatives: Paravirt runtime selftest"

 3. KVM guest changes to be able to use this (patches 22-23,25-26):
  "kvm/paravirt: Encapsulate KVM pv switching logic"
  "x86/kvm: Add worker to trigger runtime patching"
  "x86/kvm: Guest support for dynamic hints"
  "x86/kvm: Add hint change notifier for KVM_HINT_REALTIME".

 4. KVM host changes to notify the guest of a change (patch 24):
  "x86/kvm: Support dynamic CPUID hints"

Testing:
With paravirt patching, the code is mostly stable on Intel and AMD
systems under kernbench and locktorture with paravirt toggling (with,
without synthetic NMIs) in the background.

Queued spinlock performance for locktorture is also on expected lines:
 [ 1533.221563] Writes:  Total: 1048759000  Max/Min: 0/0   Fail: 0 
 # toggle PV spinlocks

 [ 1594.713699] Writes:  Total: 1111660545  Max/Min: 0/0   Fail: 0 
 # PV spinlocks (in ~60 seconds) = 62,901,545

 # toggle native spinlocks
 [ 1656.117175] Writes:  Total: 1113888840  Max/Min: 0/0   Fail: 0 
  # native spinlocks (in ~60 seconds) = 2,228,295

The alternatives testing is more limited with it being used to rewrite
mostly harmless X86_FEATUREs with load in the background.

Patches also at:

ssh://git@github.com/terminus/linux.git alternatives-rfc-upstream-v1

Please review.

Thanks
Ankur

[1] The precise change in memory footprint depends on config options
but the following example inlines queued_spin_unlock() (which forms
the bulk of the added state). The added footprint is the size of the
.parainstructions.runtime section:

 $ objdump -h vmlinux|grep .parainstructions
 Idx Name              		Size      VMA               
 	LMA                File-off  Algn
  27 .parainstructions 		0001013c  ffffffff82895000
  	0000000002895000   01c95000  2**3
  28 .parainstructions.runtime  0000cd2c  ffffffff828a5140
  	00000000028a5140   01ca5140  2**3

  $ size vmlinux                                         
  text       data       bss        dec      hex       filename
  13726196   12302814   14094336   40123346 2643bd2   vmlinux

Ankur Arora (26):
  x86/paravirt: Specify subsection in PVOP macros
  x86/paravirt: Allow paravirt patching post-init
  x86/paravirt: PVRTOP macros for PARAVIRT_RUNTIME
  x86/alternatives: Refactor alternatives_smp_module*
  x86/alternatives: Rename alternatives_smp*, smp_alt_module
  x86/alternatives: Remove stale symbols
  x86/paravirt: Persist .parainstructions.runtime
  x86/paravirt: Stash native pv-ops
  x86/paravirt: Add runtime_patch()
  x86/paravirt: Add primitives to stage pv-ops
  x86/alternatives: Remove return value of text_poke*()
  x86/alternatives: Use __get_unlocked_pte() in text_poke()
  x86/alternatives: Split __text_poke()
  x86/alternatives: Handle native insns in text_poke_loc*()
  x86/alternatives: Non-emulated text poking
  x86/alternatives: Add paravirt patching at runtime
  x86/alternatives: Add patching logic in text_poke_site()
  x86/alternatives: Handle BP in non-emulated text poking
  x86/alternatives: NMI safe runtime patching
  x86/paravirt: Enable pv-spinlocks in runtime_patch()
  x86/alternatives: Paravirt runtime selftest
  kvm/paravirt: Encapsulate KVM pv switching logic
  x86/kvm: Add worker to trigger runtime patching
  x86/kvm: Support dynamic CPUID hints
  x86/kvm: Guest support for dynamic hints
  x86/kvm: Add hint change notifier for KVM_HINT_REALTIME

 Documentation/virt/kvm/api.rst        |  17 +
 Documentation/virt/kvm/cpuid.rst      |   9 +-
 arch/x86/Kconfig                      |  14 +
 arch/x86/Kconfig.debug                |  13 +
 arch/x86/entry/entry_64.S             |   5 +
 arch/x86/include/asm/alternative.h    |  20 +-
 arch/x86/include/asm/kvm_host.h       |   6 +
 arch/x86/include/asm/kvm_para.h       |  17 +
 arch/x86/include/asm/paravirt.h       |  10 +-
 arch/x86/include/asm/paravirt_types.h | 230 ++++--
 arch/x86/include/asm/text-patching.h  |  18 +-
 arch/x86/include/uapi/asm/kvm_para.h  |   2 +
 arch/x86/kernel/Makefile              |   1 +
 arch/x86/kernel/alternative.c         | 987 +++++++++++++++++++++++---
 arch/x86/kernel/kvm.c                 | 191 ++++-
 arch/x86/kernel/module.c              |  42 +-
 arch/x86/kernel/paravirt.c            |  16 +-
 arch/x86/kernel/paravirt_patch.c      |  61 ++
 arch/x86/kernel/pv_selftest.c         | 264 +++++++
 arch/x86/kernel/pv_selftest.h         |  15 +
 arch/x86/kernel/setup.c               |   2 +
 arch/x86/kernel/vmlinux.lds.S         |  16 +
 arch/x86/kvm/cpuid.c                  |   3 +-
 arch/x86/kvm/x86.c                    |  39 +
 include/asm-generic/kvm_para.h        |  12 +
 include/asm-generic/vmlinux.lds.h     |   8 +
 include/linux/kvm_para.h              |   5 +
 include/linux/mm.h                    |  16 +-
 include/linux/preempt.h               |  17 +
 include/uapi/linux/kvm.h              |   4 +
 kernel/locking/lock_events.c          |   2 +-
 mm/memory.c                           |   9 +-
 32 files changed, 1850 insertions(+), 221 deletions(-)
 create mode 100644 arch/x86/kernel/pv_selftest.c
 create mode 100644 arch/x86/kernel/pv_selftest.h

-- 
2.20.1
