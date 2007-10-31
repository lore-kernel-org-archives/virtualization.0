From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 10/16] export cpu_gdt_descr
Date: Wed, 31 Oct 2007 16:14:55 -0300
Message-ID: <11938581562552-git-send-email-gcosta__19007.9412343495$1193869098$gmane$org@redhat.com>
References: <1193858101367-git-send-email-gcosta@redhat.com>
	<11938581073775-git-send-email-gcosta@redhat.com>
	<11938581133479-git-send-email-gcosta@redhat.com>
	<1193858118284-git-send-email-gcosta@redhat.com>
	<11938581242810-git-send-email-gcosta@redhat.com>
	<1193858130443-git-send-email-gcosta@redhat.com>
	<11938581351064-git-send-email-gcosta@redhat.com>
	<11938581403478-git-send-email-gcosta@redhat.com>
	<11938581451804-git-send-email-gcosta@redhat.com>
	<11938581512730-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11938581512730-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

With paravirualization, hypervisors needs to handle the gdt,
that was right to this point only used at very early
inialization code. Hypervisors (lguest being the current case)
are commonly modules, so make it an export

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/kernel/x8664_ksyms_64.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/x8664_ksyms_64.c b/arch/x86/kernel/x8664_ksyms_64.c
index 77c25b3..a005d67 100644
--- a/arch/x86/kernel/x8664_ksyms_64.c
+++ b/arch/x86/kernel/x8664_ksyms_64.c
@@ -8,6 +8,7 @@
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
+#include <asm/desc.h>
 
 EXPORT_SYMBOL(kernel_thread);
 
@@ -60,3 +61,8 @@ EXPORT_SYMBOL(init_level4_pgt);
 EXPORT_SYMBOL(load_gs_index);
 
 EXPORT_SYMBOL(_proxy_pda);
+
+#ifdef CONFIG_PARAVIRT
+/* Virtualized guests may want to use it */
+EXPORT_SYMBOL_GPL(cpu_gdt_descr);
+#endif
-- 
1.4.4.2
