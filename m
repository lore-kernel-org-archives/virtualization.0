From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 3/3] [PATCH] disable clock before rebooting.
Date: Tue, 18 Mar 2008 07:30:06 -0300
Message-ID: <12058362234130-git-send-email-gcosta__4902.9518886984$1205836892$gmane$org@redhat.com>
References: <1205836206192-git-send-email-gcosta@redhat.com>
	<1205836213477-git-send-email-gcosta@redhat.com>
	<12058362182207-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12058362182207-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Glauber Costa <gcosta@redhat.com>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch writes 0 (actually, what really matters is that the
LSB is cleared) to the system time msr before shutting down
the machine for kexec.

Without it, we can have a random memory location being written
when the guest comes back

It overrides the functions shutdown, used in the path of kernel_kexec() (sys.c)
and crash_shutdown, used in the path of crash_kexec() (kexec.c)

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kernel/kvmclock.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b999f5e..ddee040 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -22,6 +22,7 @@
 #include <asm/msr.h>
 #include <asm/apic.h>
 #include <linux/percpu.h>
+#include <asm/reboot.h>
 
 #define KVM_SCALE 22
 
@@ -143,6 +144,28 @@ static void kvm_setup_secondary_clock(void)
 	setup_secondary_APIC_clock();
 }
 
+/*
+ * After the clock is registered, the host will keep writing to the
+ * registered memory location. If the guest happens to shutdown, this memory
+ * won't be valid. In cases like kexec, in which you install a new kernel, this
+ * means a random memory location will be kept being written. So before any
+ * kind of shutdown from our side, we unregister the clock by writting anything
+ * that does not have the 'enable' bit set in the msr
+ */
+#ifdef CONFIG_KEXEC
+static void kvm_crash_shutdown(struct pt_regs *regs)
+{
+	native_write_msr_safe(MSR_KVM_SYSTEM_TIME, 0, 0);
+	native_machine_crash_shutdown(regs);
+}
+#endif
+
+static void kvm_shutdown(void)
+{
+	native_write_msr_safe(MSR_KVM_SYSTEM_TIME, 0, 0);
+	native_machine_shutdown();
+}
+
 void __init kvmclock_init(void)
 {
 	if (!kvm_para_available())
@@ -155,6 +178,10 @@ void __init kvmclock_init(void)
 		pv_time_ops.set_wallclock = kvm_set_wallclock;
 		pv_time_ops.sched_clock = kvm_clock_read;
 		pv_apic_ops.setup_secondary_clock = kvm_setup_secondary_clock;
+		machine_ops.shutdown  = kvm_shutdown;
+#ifdef CONFIG_KEXEC
+		machine_ops.crash_shutdown  = kvm_crash_shutdown;
+#endif
 		clocksource_register(&kvm_clock);
 	}
 }
-- 
1.5.0.6
