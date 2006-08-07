From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Slight cleanups for x86 ring macros (against rc3-mm2)
Date: Mon, 07 Aug 2006 14:38:41 +1000
Message-ID: <1154925522.21647.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Clean up of patch for letting kernel run other than ring 0:

a. Add some comments about the SEGMENT_IS_*_CODE() macros.
b. Add a USER_RPL macro.  (Code was comparing a value to a mask
   in some places and to the magic number 3 in other places.)
c. Add macros for table indicator field and use them.
d. Change the entry.S tests for LDT stack segment to use the macros.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Acked-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r d8064f9b5964 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Aug 07 13:30:17 2006 +1000
+++ b/arch/i386/kernel/entry.S	Mon Aug 07 14:32:11 2006 +1000
@@ -237,7 +237,7 @@ check_userspace:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	andl $(VM_MASK | SEGMENT_RPL_MASK), %eax
-	cmpl $SEGMENT_RPL_MASK, %eax
+	cmpl $USER_RPL, %eax
 	jb resume_kernel		# not returning to v8086 or userspace
 ENTRY(resume_userspace)
  	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
@@ -374,8 +374,8 @@ restore_all:
 	# See comments in process.c:copy_thread() for details.
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
-	andl $(VM_MASK | (4 << 8) | 3), %eax
-	cmpl $((4 << 8) | 3), %eax
+	andl $(VM_MASK | (SEGMENT_TI_MASK << 8) | SEGMENT_RPL_MASK), %eax
+	cmpl $((SEGMENT_LDT << 8) | USER_RPL), %eax
 	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
diff -r d8064f9b5964 include/asm-i386/ptrace.h
--- a/include/asm-i386/ptrace.h	Mon Aug 07 13:30:17 2006 +1000
+++ b/include/asm-i386/ptrace.h	Mon Aug 07 14:32:11 2006 +1000
@@ -74,11 +74,11 @@ extern void send_sigtrap(struct task_str
  */
 static inline int user_mode(struct pt_regs *regs)
 {
-	return (regs->xcs & SEGMENT_RPL_MASK) =3D=3D 3;
+	return (regs->xcs & SEGMENT_RPL_MASK) =3D=3D USER_RPL;
 }
 static inline int user_mode_vm(struct pt_regs *regs)
 {
-	return (((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >=3D =
3);
+	return ((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >=3D U=
SER_RPL;
 }
 #define instruction_pointer(regs) ((regs)->eip)
 extern unsigned long profile_pc(struct pt_regs *regs);
diff -r d8064f9b5964 include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	Mon Aug 07 13:30:17 2006 +1000
+++ b/include/asm-i386/segment.h	Mon Aug 07 14:32:11 2006 +1000
@@ -83,10 +83,9 @@
 =

 #define GDT_SIZE (GDT_ENTRIES * 8)
 =

-/*
- * Some tricky tests to match code segments after a fault
- */
+/* Matches __KERNEL_CS and __USER_CS (they must be 2 entries apart) */
 #define SEGMENT_IS_FLAT_CODE(x)  (((x) & 0xec) =3D=3D GDT_ENTRY_KERNEL_CS =
* 8)
+/* Matches PNP_CS32 and PNP_CS16 (they must be consecutive) */
 #define SEGMENT_IS_PNP_CODE(x)   (((x) & 0xf4) =3D=3D GDT_ENTRY_PNPBIOS_BA=
SE * 8)
 =

 /* Simple and small GDT entries for booting only */
@@ -118,8 +117,16 @@
  */
 #define IDT_ENTRIES 256
 =

-/* Bottom three bits of xcs give the ring privilege level */
-#define SEGMENT_RPL_MASK 0x3
+/* Bottom two bits of selector give the ring privilege level */
+#define SEGMENT_RPL_MASK	0x3
+/* Bit 2 is table indicator (LDT/GDT) */
+#define SEGMENT_TI_MASK		0x4
+
+/* User mode is privilege level 3 */
+#define USER_RPL		0x3
+/* LDT segment has TI set, GDT has it cleared */
+#define SEGMENT_LDT		0x4
+#define SEGMENT_GDT		0x0
 =

 #define get_kernel_rpl()  0
 #endif

-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
