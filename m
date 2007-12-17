From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 20/21] [PATCH] move i387 definitions to processor.h
Date: Mon, 17 Dec 2007 20:52:43 -0200
Message-ID: <11979320653161-git-send-email-gcosta__45893.5696668506$1197943726$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
	<11979319953427-git-send-email-gcosta@redhat.com>
	<11979320011968-git-send-email-gcosta@redhat.com>
	<1197932006634-git-send-email-gcosta@redhat.com>
	<11979320114180-git-send-email-gcosta@redhat.com>
	<11979320163651-git-send-email-gcosta@redhat.com>
	<11979320211287-git-send-email-gcosta@redhat.com>
	<11979320252102-git-send-email-gcosta@redhat.com>
	<11979320302030-git-send-email-gcosta@redhat.com>
	<11979320354186-git-send-email-gcosta@redhat.com>
	<11979320401316-git-send-email-gcosta@redhat.com>
	<11979320451308-git-send-email-gcosta@redhat.com>
	<1197932050948-git-send-email-gcosta@redhat.com>
	<11979320551036-git-send-email-gcosta@redhat.com>
	<11979320603229-git-send-email! -gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979320603229-git-send-email-gcosta@redhat.com>
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

This patch moves i387 definitions from processor_32.h and processor_64.h
to processor.h. They are different. Very different. And there's appearently
nothing we can do about it, so they're enclosed inside ifdefs.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/processor.h    |   66 ++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/processor_32.h |   49 -----------------------------
 include/asm-x86/processor_64.h |   17 ----------
 3 files changed, 66 insertions(+), 66 deletions(-)

Index: linux-2.6-x86/include/asm-x86/processor.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor.h
+++ linux-2.6-x86/include/asm-x86/processor.h
@@ -223,8 +223,74 @@ struct orig_ist {
 };
 
 #ifdef CONFIG_X86_32
+struct i387_fsave_struct {
+	long	cwd;
+	long	swd;
+	long	twd;
+	long	fip;
+	long	fcs;
+	long	foo;
+	long	fos;
+	long	st_space[20];	/* 8*10 bytes for each FP-reg = 80 bytes */
+	long	status;		/* software status information */
+};
+
+struct i387_fxsave_struct {
+	unsigned short	cwd;
+	unsigned short	swd;
+	unsigned short	twd;
+	unsigned short	fop;
+	long	fip;
+	long	fcs;
+	long	foo;
+	long	fos;
+	long	mxcsr;
+	long	mxcsr_mask;
+	long	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
+	long	xmm_space[32];	/* 8*16 bytes for each XMM-reg = 128 bytes */
+	long	padding[56];
+} __attribute__((aligned(16)));
+
+struct i387_soft_struct {
+	long	cwd;
+	long	swd;
+	long	twd;
+	long	fip;
+	long	fcs;
+	long	foo;
+	long	fos;
+	long	st_space[20];	/* 8*10 bytes for each FP-reg = 80 bytes */
+	unsigned char	ftop, changed, lookahead, no_update, rm, alimit;
+	struct info	*info;
+	unsigned long	entry_eip;
+};
+
+union i387_union {
+	struct i387_fsave_struct	fsave;
+	struct i387_fxsave_struct	fxsave;
+	struct i387_soft_struct soft;
+};
+
 # include "processor_32.h"
 #else
+struct i387_fxsave_struct {
+	u16	cwd;
+	u16	swd;
+	u16	twd;
+	u16	fop;
+	u64	rip;
+	u64	rdp;
+	u32	mxcsr;
+	u32	mxcsr_mask;
+	u32	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
+	u32	xmm_space[64];	/* 16*16 bytes for each XMM-reg = 256 bytes */
+	u32	padding[24];
+} __attribute__((aligned(16)));
+
+union i387_union {
+	struct i387_fxsave_struct	fxsave;
+};
+
 # include "processor_64.h"
 #endif
 
Index: linux-2.6-x86/include/asm-x86/processor_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_32.h
+++ linux-2.6-x86/include/asm-x86/processor_32.h
@@ -29,55 +29,6 @@ DECLARE_PER_CPU(u8, cpu_llc_id);
  */
 #define TASK_SIZE	(PAGE_OFFSET)
 
-
-struct i387_fsave_struct {
-	long	cwd;
-	long	swd;
-	long	twd;
-	long	fip;
-	long	fcs;
-	long	foo;
-	long	fos;
-	long	st_space[20];	/* 8*10 bytes for each FP-reg = 80 bytes */
-	long	status;		/* software status information */
-};
-
-struct i387_fxsave_struct {
-	unsigned short	cwd;
-	unsigned short	swd;
-	unsigned short	twd;
-	unsigned short	fop;
-	long	fip;
-	long	fcs;
-	long	foo;
-	long	fos;
-	long	mxcsr;
-	long	mxcsr_mask;
-	long	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
-	long	xmm_space[32];	/* 8*16 bytes for each XMM-reg = 128 bytes */
-	long	padding[56];
-} __attribute__ ((aligned (16)));
-
-struct i387_soft_struct {
-	long	cwd;
-	long	swd;
-	long	twd;
-	long	fip;
-	long	fcs;
-	long	foo;
-	long	fos;
-	long	st_space[20];	/* 8*10 bytes for each FP-reg = 80 bytes */
-	unsigned char	ftop, changed, lookahead, no_update, rm, alimit;
-	struct info	*info;
-	unsigned long	entry_eip;
-};
-
-union i387_union {
-	struct i387_fsave_struct	fsave;
-	struct i387_fxsave_struct	fxsave;
-	struct i387_soft_struct soft;
-};
-
 #define INIT_THREAD  {							\
 	.sp0 = sizeof(init_stack) + (long)&init_stack,			\
 	.vm86_info = NULL,						\
Index: linux-2.6-x86/include/asm-x86/processor_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_64.h
+++ linux-2.6-x86/include/asm-x86/processor_64.h
@@ -31,23 +31,6 @@
 #define TASK_SIZE_OF(child) 	((test_tsk_thread_flag(child, TIF_IA32)) ? IA32_PAGE_OFFSET : TASK_SIZE64)
 
 
-struct i387_fxsave_struct {
-	u16	cwd;
-	u16	swd;
-	u16	twd;
-	u16	fop;
-	u64	rip;
-	u64	rdp; 
-	u32	mxcsr;
-	u32	mxcsr_mask;
-	u32	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
-	u32	xmm_space[64];	/* 16*16 bytes for each XMM-reg = 256 bytes */
-	u32	padding[24];
-} __attribute__ ((aligned (16)));
-
-union i387_union {
-	struct i387_fxsave_struct	fxsave;
-};
 
 DECLARE_PER_CPU(struct orig_ist, orig_ist);
