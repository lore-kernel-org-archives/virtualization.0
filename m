From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] xen: compilation fix fo xen CPU hotplugging.
Date: Tue, 26 Aug 2008 14:30:03 +0900
Message-ID: <20080826053003.GE1496%yamahata__31677.8603163131$1219728726$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-ia64-devel@lists.xensource.com, xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch fixes compilation error on ia64.
include asm/xen/hypervisor.h instead of asm-x86/xen/hypervisor.h
use xen_pv_domain() instead of is_running_on_xen()

>   CC      drivers/xen/cpu_hotplug.o
> In file included from /linux-2.6/drivers/xen/cpu_hotplug.c:5:
> /linux-2.6/include/asm-x86/xen/hypervisor.h:44:22: error: asm/desc.h: No such file or directory
> /linux-2.6/include/asm-x86/xen/hypervisor.h:66:1: warning: "MULTI_UVMFLAGS_INDEX" redefined
> In file included from /linux-2.6/include/asm-x86/xen/hypervisor.h:52,
>                  from /linux-2.6/drivers/xen/cpu_hotplug.c:5:
> /linux-2.6/arch/ia64/include/asm/xen/hypercall.h:233:1: warning: this is the location of the previous definition
> /linux-2.6/drivers/xen/cpu_hotplug.c: In function 'setup_vcpu_hotplug_event':
> /linux-2.6/drivers/xen/cpu_hotplug.c:81: error: implicit declaration of function 'is_running_on_xen'
> make[4]: *** [drivers/xen/cpu_hotplug.o] Error 1
> make[4]: *** Waiting for unfinished jobs....

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 drivers/xen/cpu_hotplug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index 1bc0035..974f56d 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -2,7 +2,7 @@
 
 #include <xen/xenbus.h>
 
-#include <asm-x86/xen/hypervisor.h>
+#include <asm/xen/hypervisor.h>
 #include <asm/cpu.h>
 
 static void enable_hotplug_cpu(int cpu)
@@ -78,7 +78,7 @@ static int __init setup_vcpu_hotplug_event(void)
 	static struct notifier_block xsn_cpu = {
 		.notifier_call = setup_cpu_watcher };
 
-	if (!is_running_on_xen())
+	if (!xen_pv_domain())
 		return -ENODEV;
 
 	register_xenstore_notifier(&xsn_cpu);
-- 
1.6.0.rc0.42.g186458
