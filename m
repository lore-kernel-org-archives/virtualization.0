From: Markus Armbruster <armbru@redhat.com>
Subject: xen: Make hvc0 the preferred console in domU
Date: Wed, 27 Feb 2008 14:56:35 +0100
Message-ID: <87zltm1p0s.fsf__1667.69420397959$1204120902$gmane$org@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: mingo@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This makes the Xen console just work.  Before, you had to ask for it
on the kernel command line with console=hvc0

Signed-off-by: Markus Armbruster <armbru@redhat.com>

---
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 49e5358..df63185 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/page-flags.h>
 #include <linux/highmem.h>
+#include <linux/console.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/physdev.h>
@@ -1209,6 +1210,9 @@ asmlinkage void __init xen_start_kernel(void)
 		? __pa(xen_start_info->mod_start) : 0;
 	boot_params.hdr.ramdisk_size = xen_start_info->mod_len;
 
+	if (!is_initial_xendomain())
+		add_preferred_console("hvc", 0, NULL);
+
 	/* Start the world */
 	start_kernel();
 }
