From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 05/15] change assembly definition of paravirt_patch_site
Date: Thu, 20 Dec 2007 18:04:00 -0200
Message-ID: <1198181224677-git-send-email-gcosta@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1198181215625-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

To account for differences in x86_64, we change the macros that
create raw instances of the paravirt_patch_site struct.
We need to align 64-pointers to 64-bit boundaries, so we add an alignment
directive. Also, we need to make room for a word-sized pointer,
instead of a fixed 32-bit one

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/paravirt.h |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:07:22.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:07:25.000000000 -0800
@@ -5,6 +5,7 @@
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/page.h>
+#include <asm/asm.h>
 
 /* Bitmask of what can be clobbered: usually at least eax. */
 #define CLBR_NONE 0x0
@@ -281,7 +282,8 @@
 #define _paravirt_alt(insn_string, type, clobber)	\
 	"771:\n\t" insn_string "\n" "772:\n"		\
 	".pushsection .parainstructions,\"a\"\n"	\
-	"  .long 771b\n"				\
+	_ASM_ALIGN "\n"					\
+	_ASM_PTR " 771b\n"				\
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
 	"  .short " clobber "\n"			\
@@ -1159,17 +1161,25 @@
 
 #define PARA_PATCH(struct, off)	((PARAVIRT_PATCH_##struct + (off)) / 4)
 
-#define PARA_SITE(ptype, clobbers, ops)		\
+#define _PVSITE(ptype, clobbers, ops, word, algn)	\
 771:;						\
 	ops;					\
 772:;						\
 	.pushsection .parainstructions,"a";	\
-	 .long 771b;				\
+	 .align	algn;				\
+	 word 771b;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
 	 .short clobbers;			\
 	.popsection
 
+
+#ifdef CONFIG_X86_64
+#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
+#else
+#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .long, 4)
+#endif
+
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
 		  jmp *%cs:pv_cpu_ops+PV_CPU_iret)
