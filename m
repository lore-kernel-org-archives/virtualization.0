From: Zachary Amsden <zach@vmware.com>
Subject: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Thu, 19 Apr 2007 18:53:04 -0700 (PDT)
Message-ID: <20070420015304.74394BFC@zach-dev2.vmware.com>
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

Now that paravirt-ops is a fully patched, purely functional interface,
which appropriately generates bugs when patches fail to get applied,
it need no longer be exported to modules.  Modules will be patched at
load time, and need no boot time fallback which references paravirt-ops.

Now, all traditional functionality which was inlined into modules before
is still available to modules with paravirt_ops, but there is no danger
of exporting it to rogue or non-GPL modules.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 80ddc95c2ab2 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Thu Apr 19 16:17:36 2007 -0700
+++ b/arch/i386/kernel/paravirt.c	Thu Apr 19 16:22:25 2007 -0700
@@ -353,11 +353,3 @@ struct paravirt_ops paravirt_ops = {
 
 	.startup_ipi_hook = paravirt_nop,
 };
-
-/*
- * NOTE: CONFIG_PARAVIRT is experimental and the paravirt_ops
- * semantics are subject to change. Hence we only do this
- * internal-only export of this, until it gets sorted out and
- * all lowlevel CPU ops used by modules are separately exported.
- */
-EXPORT_SYMBOL_GPL(paravirt_ops);
diff -r 80ddc95c2ab2 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Apr 19 16:17:36 2007 -0700
+++ b/include/asm-i386/paravirt.h	Thu Apr 19 16:29:56 2007 -0700
@@ -266,8 +266,16 @@ unsigned paravirt_patch_insns(void *site
  * The type number, computed in PARAVIRT_PATCH, is derived from the
  * offset into the paravirt_ops structure, and can therefore be freely
  * converted back into a structure offset.
+ *
+ * For modules, generate a bogus BUG, which leaves enough space for
+ * the patch to a direct call to be made and eliminates the need to
+ * export paravirt_ops to modules.
  */
+#ifdef MODULE
+#define PARAVIRT_CALL	"ud2a; nop; nop; nop;"
+#else
 #define PARAVIRT_CALL	"call *(paravirt_ops+%c[paravirt_typenum]*4);"
+#endif
 
 /*
  * These macros are intended to wrap calls into a paravirt_ops
