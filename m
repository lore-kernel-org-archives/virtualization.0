From: Zachary Amsden <zach@vmware.com>
Subject: [RFC, PATCH 1/5] Paravirt_ops full patching.patch
Date: Thu, 19 Apr 2007 18:52:24 -0700 (PDT)
Message-ID: <20070420015224.56315BFC@zach-dev2.vmware.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <petr@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chaz Masden <zamsden@gmail.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Add 5-argument handling for paravirt ops patching of PAE functions.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r dbe11208916f include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Apr 19 11:40:55 2007 -0700
+++ b/include/asm-i386/paravirt.h	Thu Apr 19 12:04:16 2007 -0700
@@ -308,10 +308,9 @@ unsigned paravirt_patch_insns(void *site
  * return value handling from within these macros.  This is fairly
  * cumbersome.
  *
- * There are 5 sets of PVOP_* macros for dealing with 0-4 arguments.
- * It could be extended to more arguments, but there would be little
- * to be gained from that.  For each number of arguments, there are
- * the two VCALL and CALL variants for void and non-void functions.
+ * There are 5 sets of PVOP_* macros for dealing with 0-5 arguments.
+ * For each number of arguments, there are the two VCALL and CALL
+ * variants for void and non-void functions.
  *
  * When there is a return value, the invoker of the macro must specify
  * the return type.  The macro then uses sizeof() on that type to
@@ -405,6 +404,21 @@ unsigned paravirt_patch_insns(void *site
 		    "0" ((u32)(arg1)), "1" ((u32)(arg2)),		\
 		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)))
 
+#define PVOP_CALL5(rettype, op, arg1, arg2, arg3, arg4, arg5)		\
+	__PVOP_CALL(rettype, op,					\
+		    "push %[_arg5]; push %[_arg4];",			\
+		    "lea 8(%%esp),%%esp;",				\
+		    "0" ((u32)(arg1)), "1" ((u32)(arg2)),		\
+		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)),	\
+		    [_arg5] "mr" ((u32)(arg5)))
+#define PVOP_VCALL5(op, arg1, arg2, arg3, arg4, arg5)			\
+	__PVOP_VCALL(op,						\
+		    "push %[_arg5]; push %[_arg4];",			\
+		    "lea 8(%%esp),%%esp;",				\
+		    "0" ((u32)(arg1)), "1" ((u32)(arg2)),		\
+		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)),	\
+		    [_arg5] "mr" ((u32)(arg5)))
+
 static inline int paravirt_enabled(void)
 {
 	return paravirt_ops.paravirt_enabled;
@@ -644,11 +658,11 @@ static inline void set_iopl_mask(unsigne
 
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void) {
-	paravirt_ops.io_delay();
+	PVOP_VCALL0(io_delay);
 #ifdef REALLY_SLOW_IO
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
+	PVOP_VCALL0(io_delay);
+	PVOP_VCALL0(io_delay);
+	PVOP_VCALL0(io_delay);
 #endif
 }
 
@@ -824,8 +838,7 @@ static inline void set_pte_at(struct mm_
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pteval)
 {
-	/* 5 arg words */
-	paravirt_ops.set_pte_at(mm, addr, ptep, pteval);
+	PVOP_VCALL5(mm, addr, ptep, pteval.pte_low, pteval.pte_high);
 }
 
 static inline void set_pte_atomic(pte_t *ptep, pte_t pteval)
@@ -836,8 +849,7 @@ static inline void set_pte_present(struc
 static inline void set_pte_present(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
-	/* 5 arg words */
-	paravirt_ops.set_pte_present(mm, addr, ptep, pte);
+	PVOP_VCALL5(mm, addr, ptep, pte.pte_low, pte.pte_high);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
