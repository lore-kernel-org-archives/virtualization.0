From: <gregkh@linuxfoundation.org>
Subject: Patch "x86/asm: Add _ASM_ARG* constants for argument registers to
	<asm/asm.h>" has been added to the 4.17-stable tree
Date: Wed, 18 Jul 2018 11:34:01 +0200
Message-ID: <1531906441207121@kroah.com>
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
To: 20180621162324.36656-3-ndesaulniers@google.com, acme@redhat.com, akataria@vmware.com, akpm@linux-foundation.org, andrea.parri@amarulasolutions.com, ard.biesheuvel@linaro.org, arnd@arndb.de, aryabinin@virtuozzo.com, astrachan@google.com, boris.ostrovsky@oracle.com, brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com, geert@linux-m68k.org, ghackmann@google.com, gregkh@linuxfoundation.org, hpa@linux.intel.com, jan.kiszka@siemens.com, jarkko.sakkinen@linux.intel.com, jgross@suse.com, joe@perches.com, jpoimboe@redhat.com, keescook@google.com, kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org, manojgupta@google.com, mawilcox@microsoft.com, michal.lkml@markovi.net, mingo@kernel.org, mjg59@google.com, mka@chromium.orgndesaulniers@google.com, peterz@infradead.org, pombredanne@nexb.com, rientjes@google.com, rostedt@goodmis.org, sedat.dilek@gmail.com, tglx@linutronix.de
Cc: stable-commits@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


This is a note to let you know that I've just added the patch titled

    x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

to the 4.17-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     x86-asm-add-_asm_arg-constants-for-argument-registers-to-asm-asm.h.patch
and it can be found in the queue-4.17 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 0e2e160033283e20f688d8bad5b89460cc5bfcc4 Mon Sep 17 00:00:00 2001
From: "H. Peter Anvin" <hpa@linux.intel.com>
Date: Thu, 21 Jun 2018 09:23:23 -0700
Subject: x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

From: H. Peter Anvin <hpa@linux.intel.com>

commit 0e2e160033283e20f688d8bad5b89460cc5bfcc4 upstream.

i386 and x86-64 uses different registers for arguments; make them
available so we don't have to #ifdef in the actual code.

Native size and specified size (q, l, w, b) versions are provided.

Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@redhat.com
Cc: akataria@vmware.com
Cc: akpm@linux-foundation.org
Cc: andrea.parri@amarulasolutions.com
Cc: ard.biesheuvel@linaro.org
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: astrachan@google.com
Cc: boris.ostrovsky@oracle.com
Cc: brijesh.singh@amd.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: geert@linux-m68k.org
Cc: ghackmann@google.com
Cc: gregkh@linuxfoundation.org
Cc: jan.kiszka@siemens.com
Cc: jarkko.sakkinen@linux.intel.com
Cc: joe@perches.com
Cc: jpoimboe@redhat.com
Cc: keescook@google.com
Cc: kirill.shutemov@linux.intel.com
Cc: kstewart@linuxfoundation.org
Cc: linux-efi@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: manojgupta@google.com
Cc: mawilcox@microsoft.com
Cc: michal.lkml@markovi.net
Cc: mjg59@google.com
Cc: mka@chromium.org
Cc: pombredanne@nexb.com
Cc: rientjes@google.com
Cc: rostedt@goodmis.org
Cc: thomas.lendacky@amd.com
Cc: tstellar@redhat.com
Cc: tweek@google.com
Cc: virtualization@lists.linux-foundation.org
Cc: will.deacon@arm.com
Cc: yamada.masahiro@socionext.com
Link: http://lkml.kernel.org/r/20180621162324.36656-3-ndesaulniers@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/asm.h |   59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -46,6 +46,65 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+#ifndef __x86_64__
+/* 32 bit */
+
+#define _ASM_ARG1	_ASM_AX
+#define _ASM_ARG2	_ASM_DX
+#define _ASM_ARG3	_ASM_CX
+
+#define _ASM_ARG1L	eax
+#define _ASM_ARG2L	edx
+#define _ASM_ARG3L	ecx
+
+#define _ASM_ARG1W	ax
+#define _ASM_ARG2W	dx
+#define _ASM_ARG3W	cx
+
+#define _ASM_ARG1B	al
+#define _ASM_ARG2B	dl
+#define _ASM_ARG3B	cl
+
+#else
+/* 64 bit */
+
+#define _ASM_ARG1	_ASM_DI
+#define _ASM_ARG2	_ASM_SI
+#define _ASM_ARG3	_ASM_DX
+#define _ASM_ARG4	_ASM_CX
+#define _ASM_ARG5	r8
+#define _ASM_ARG6	r9
+
+#define _ASM_ARG1Q	rdi
+#define _ASM_ARG2Q	rsi
+#define _ASM_ARG3Q	rdx
+#define _ASM_ARG4Q	rcx
+#define _ASM_ARG5Q	r8
+#define _ASM_ARG6Q	r9
+
+#define _ASM_ARG1L	edi
+#define _ASM_ARG2L	esi
+#define _ASM_ARG3L	edx
+#define _ASM_ARG4L	ecx
+#define _ASM_ARG5L	r8d
+#define _ASM_ARG6L	r9d
+
+#define _ASM_ARG1W	di
+#define _ASM_ARG2W	si
+#define _ASM_ARG3W	dx
+#define _ASM_ARG4W	cx
+#define _ASM_ARG5W	r8w
+#define _ASM_ARG6W	r9w
+
+#define _ASM_ARG1B	dil
+#define _ASM_ARG2B	sil
+#define _ASM_ARG3B	dl
+#define _ASM_ARG4B	cl
+#define _ASM_ARG5B	r8b
+#define _ASM_ARG6B	r9b
+
+#endif
+
 /*
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".


Patches currently in stable-queue which might be from hpa@linux.intel.com are

queue-4.17/x86-asm-add-_asm_arg-constants-for-argument-registers-to-asm-asm.h.patch
