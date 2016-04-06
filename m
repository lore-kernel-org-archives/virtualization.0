From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v5 6/6] hwmon: use smp_call_on_cpu() for dell-smm i8k
Date: Wed,  6 Apr 2016 16:17:46 +0200
Message-ID: <1459952266-3687-7-git-send-email-jgross@suse.com>
References: <1459952266-3687-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459952266-3687-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

Use the smp_call_on_cpu() function to call system management
mode on cpu 0.
Make call secure by adding get_online_cpus() to avoid e.g. suspend
resume cycles in between.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4: add call to get_online_cpus()
---
 drivers/hwmon/dell-smm-hwmon.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index c43318d..c91bf35 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -21,6 +21,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -35,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/sched.h>
+#include <linux/smp.h>
 
 #include <linux/i8k.h>
 
@@ -130,23 +132,15 @@ static inline const char *i8k_get_dmi_data(int field)
 /*
  * Call the System Management Mode BIOS. Code provided by Jonathan Buzzard.
  */
-static int i8k_smm(struct smm_regs *regs)
+static int i8k_smm_func(void *par)
 {
 	int rc;
+	struct smm_regs *regs = par;
 	int eax = regs->eax;
-	cpumask_var_t old_mask;
 
 	/* SMM requires CPU 0 */
-	if (!alloc_cpumask_var(&old_mask, GFP_KERNEL))
-		return -ENOMEM;
-	cpumask_copy(old_mask, &current->cpus_allowed);
-	rc = set_cpus_allowed_ptr(current, cpumask_of(0));
-	if (rc)
-		goto out;
-	if (smp_processor_id() != 0) {
-		rc = -EBUSY;
-		goto out;
-	}
+	if (smp_processor_id() != 0)
+		return -EBUSY;
 
 #if defined(CONFIG_X86_64)
 	asm volatile("pushq %%rax\n\t"
@@ -204,13 +198,24 @@ static int i8k_smm(struct smm_regs *regs)
 	if (rc != 0 || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
 		rc = -EINVAL;
 
-out:
-	set_cpus_allowed_ptr(current, old_mask);
-	free_cpumask_var(old_mask);
 	return rc;
 }
 
 /*
+ * Call the System Management Mode BIOS.
+ */
+static int i8k_smm(struct smm_regs *regs)
+{
+	int ret;
+
+	get_online_cpus();
+	ret = smp_call_on_cpu(0, i8k_smm_func, regs, true);
+	put_online_cpus();
+
+	return ret;
+}
+
+/*
  * Read the fan status.
  */
 static int i8k_get_fan_status(int fan)
-- 
2.6.6
