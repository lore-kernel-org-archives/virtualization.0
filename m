From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 1/5] Change vsmp compile dependency
Date: Mon, 11 Feb 2008 17:16:01 -0200
Message-ID: <1202757365-18634-1-git-send-email-gcosta__40655.4970810705$1202772379$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, shai@scalemp.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Change Makefile so vsmp_64.o object is dependent
on PARAVIRT, rather than X86_VSMP

Signed-off-by: Glauber Costa <gcosta@redhat.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalemp.com>
Acked-by: Shai Fultheim <shai@scalemp.com>
---
 arch/x86/kernel/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 21dc1a0..71a92a2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_KEXEC)		+= relocate_kernel_
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq_32.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit_32.o
-obj-$(CONFIG_X86_VSMP)		+= vsmp_64.o
+obj-$(CONFIG_PARAVIRT)		+= vsmp_64.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_MODULES)		+= module_$(BITS).o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat_32.o
-- 
1.4.2
