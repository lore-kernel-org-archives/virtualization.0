From: rusty@rustcorp.com.au
Subject: [patch 02/43] lguest: fix modules oopsing in lguest guests
Date: Wed, 26 Sep 2007 16:36:20 +1000
Message-ID: <20070926063645.187987684@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lguest-module-patch-fix.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The assembly templates for lguest guest patching are in the .init.text
section.  This means that modules get patched with "cc cc cc cc" or
similar junk.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 drivers/lguest/lguest_asm.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

===================================================================
--- a/drivers/lguest/lguest_asm.S
+++ b/drivers/lguest/lguest_asm.S
@@ -22,8 +22,9 @@
 	jmp lguest_init
 
 /*G:055 We create a macro which puts the assembler code between lgstart_ and
- * lgend_ markers.  These templates end up in the .init.text section, so they
- * are discarded after boot. */
+ * lgend_ markers.  These templates are put in the .text section: they can't be
+ * discarded after boot as we may need to patch modules, too. */
+.text
 #define LGUEST_PATCH(name, insns...)			\
 	lgstart_##name:	insns; lgend_##name:;		\
 	.globl lgstart_##name; .globl lgend_##name
@@ -34,7 +35,6 @@ LGUEST_PATCH(pushf, movl lguest_data+LGU
 LGUEST_PATCH(pushf, movl lguest_data+LGUEST_DATA_irq_enabled, %eax)
 /*:*/
 
-.text
 /* These demark the EIP range where host should never deliver interrupts. */
 .global lguest_noirq_start
 .global lguest_noirq_end

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
