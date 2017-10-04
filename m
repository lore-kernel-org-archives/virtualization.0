From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 00/13] x86/paravirt: Make pv ops code generation more closely
	match reality
Date: Wed,  4 Oct 2017 10:58:21 -0500
Message-ID: <cover.1507128293.git.jpoimboe__48344.5874335759$1509079559$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This changes the pv ops code generation to more closely match reality.

For example, instead of:

  callq  *0xffffffff81e3a400 (pv_irq_ops.save_fl)

vmlinux will now show:

  pushfq
  pop    %rax
  nop
  nop
  nop
  nop
  nop

which is what the runtime version of the code will show in most cases.

This idea was suggested by Andy Lutomirski.

The benefits are:

- For the most common runtime cases (everything except Xen and vSMP),
  vmlinux disassembly now matches what the actual runtime code looks
  like.  This improves debuggability and kernel developer sanity (a
  precious resource).

- It fixes a KASAN warning in the ORC unwinder due to objtool not
  understanding the .parainstructions stuff.

- It's hopefully a first step in simplifying paravirt patching by
  getting rid of .parainstructions, pv ops, and apply_paravirt()
  completely.  (I think Xen can be changed to set CPU feature bits to
  specify which ops it needs during early boot, then those ops can be
  patched in using early alternatives.)

For more details, see the commit log in patch 11/13.

Josh Poimboeuf (13):
  x86/paravirt: remove wbinvd() paravirt interface
  x86/paravirt: Fix output constraint macro names
  x86/paravirt: Convert native patch assembly code strings to macros
  x86/paravirt: Convert DEF_NATIVE macro to GCC extended asm syntax
  x86/paravirt: Move paravirt asm macros to paravirt-asm.h
  x86/paravirt: Clean up paravirt-asm.h
  x86/paravirt: Simplify ____PVOP_CALL()
  x86/paravirt: Clean up paravirt_types.h
  x86/asm: Convert ALTERNATIVE*() assembler macros to preprocessor
    macros
  x86/alternative: Support indirect call replacement
  x86/paravirt: Add paravirt alternatives infrastructure
  objtool: Add support for new .pv_altinstructions section
  x86/paravirt: Convert natively patched pv ops to use paravirt
    alternatives

 arch/x86/entry/entry_32.S                |  13 +-
 arch/x86/entry/entry_64.S                |  12 +-
 arch/x86/entry/entry_64_compat.S         |   9 +-
 arch/x86/entry/vdso/vdso32/system_call.S |  10 +-
 arch/x86/include/asm/alternative-asm.h   |  71 ++++-----
 arch/x86/include/asm/alternative.h       |  12 +-
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/paravirt-asm.h      | 142 ++++++++++++++++++
 arch/x86/include/asm/paravirt.h          | 174 ++++------------------
 arch/x86/include/asm/paravirt_types.h    | 243 ++++++++++++++++++++-----------
 arch/x86/include/asm/smap.h              |   4 +-
 arch/x86/include/asm/special_insns.h     |  31 +++-
 arch/x86/kernel/alternative.c            |  35 ++++-
 arch/x86/kernel/cpu/hypervisor.c         |   2 +
 arch/x86/kernel/head_64.S                |   2 +-
 arch/x86/kernel/module.c                 |  11 +-
 arch/x86/kernel/paravirt.c               |   1 -
 arch/x86/kernel/paravirt_patch_32.c      |  21 +--
 arch/x86/kernel/paravirt_patch_64.c      |  31 ++--
 arch/x86/kernel/vmlinux.lds.S            |   6 +
 arch/x86/lib/copy_page_64.S              |   2 +-
 arch/x86/lib/memcpy_64.S                 |   4 +-
 arch/x86/lib/memmove_64.S                |   3 +-
 arch/x86/lib/memset_64.S                 |   4 +-
 arch/x86/xen/enlighten_pv.c              |   3 +-
 tools/objtool/special.c                  |  10 ++
 26 files changed, 516 insertions(+), 341 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-asm.h

-- 
2.13.6
