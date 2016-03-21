From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 4/6] hwmon: use smp_call_sync_on_phys_cpu() for dell-smm i8k
Date: Mon, 21 Mar 2016 13:24:33 +0100
Message-ID: <1458563075-30298-5-git-send-email-jgross__16953.4856723205$1458563150$gmane$org@suse.com>
References: <1458563075-30298-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458563075-30298-1-git-send-email-jgross@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

Use the smp_call_sync_on_phys_cpu() function to call system management
mode on cpu 0.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/hwmon/dell-smm-hwmon.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index c43318d..4875462 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -130,23 +130,15 @@ static inline const char *i8k_get_dmi_data(int field)
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
@@ -204,13 +196,18 @@ static int i8k_smm(struct smm_regs *regs)
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
+	return smp_call_sync_on_phys_cpu(0, i8k_smm_func, regs);
+}
+
+/*
  * Read the fan status.
  */
 static int i8k_get_fan_status(int fan)
-- 
2.6.2
