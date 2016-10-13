From: Renat Valiullin <rvaliullin@vmware.com>
Subject: [PATCH] x86/vmware: Skip timer_irq_works() check on VMware
Date: Thu, 13 Oct 2016 11:45:39 -0700
Message-ID: <20161013184539.GA11497@rvaliullin-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The timer_irq_works() boot check may sometimes fail in a VM, when
the Host is overcommitted or when the Guest is running nested.
Since the intended check is unnecessary on VMware's virtual
hardware, this change by-passes it.

Signed-off-by: Renat Valiullin <rvaliullin@vmware.com>
Acked-by: Alok N Kataria <akataria@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 8116057..5130985 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -27,6 +27,7 @@
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
+#include <asm/timer.h>
 #include <asm/apic.h>
 
 #define CPUID_VMWARE_INFO_LEAF	0x40000000
@@ -94,6 +95,10 @@ static void __init vmware_platform_setup(void)
 	} else {
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
+
+#ifdef CONFIG_X86_IO_APIC
+	no_timer_check = 1;
+#endif
 }
 
 /*
-- 
2.7.4
