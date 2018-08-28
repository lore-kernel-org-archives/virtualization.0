From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 03/15] xen: link platform-pci-unplug.o only if
	CONFIG_XEN_PVHVM
Date: Tue, 28 Aug 2018 09:40:14 +0200
Message-ID: <20180828074026.820-4-jgross__9202.72231237522$1535441919$gmane$org@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

Instead of using one large #ifdef CONFIG_XEN_PVHVM in
arch/x86/xen/platform-pci-unplug.c add the object file depending on
CONFIG_XEN_PVHVM being set.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/xen/Makefile              | 2 +-
 arch/x86/xen/platform-pci-unplug.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index a964f307a266..dd2550d33b38 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -19,11 +19,11 @@ obj-y				+= mmu.o
 obj-y				+= time.o
 obj-y				+= grant-table.o
 obj-y				+= suspend.o
-obj-y				+= platform-pci-unplug.o
 
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
 obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
 obj-$(CONFIG_XEN_PVHVM)		+= suspend_hvm.o
+obj-$(CONFIG_XEN_PVHVM)		+= platform-pci-unplug.o
 
 obj-$(CONFIG_XEN_PV)		+= setup.o
 obj-$(CONFIG_XEN_PV)		+= apic.o
diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
index 33a783c77d96..3957946a6cfe 100644
--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -30,7 +30,6 @@
 #define XEN_PLATFORM_ERR_PROTOCOL -2
 #define XEN_PLATFORM_ERR_BLACKLIST -3
 
-#ifdef CONFIG_XEN_PVHVM
 /* store the value of xen_emul_unplug after the unplug is done */
 static int xen_platform_pci_unplug;
 static int xen_emul_unplug;
@@ -214,4 +213,3 @@ static int __init parse_xen_emul_unplug(char *arg)
 	return 0;
 }
 early_param("xen_emul_unplug", parse_xen_emul_unplug);
-#endif
-- 
2.16.4
