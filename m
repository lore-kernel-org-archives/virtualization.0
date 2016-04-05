From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v4 5/6] dcdbas: make use of smp_call_on_cpu()
Date: Tue,  5 Apr 2016 07:10:06 +0200
Message-ID: <1459833007-11618-6-git-send-email-jgross@suse.com>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459833007-11618-1-git-send-email-jgross@suse.com>
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

Use smp_call_on_cpu() to raise SMI on cpu 0.
Make call secure by adding get_online_cpus() to avoid e.g. suspend
resume cycles in between.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4: add call to get_online_cpus()
---
 drivers/firmware/dcdbas.c | 51 ++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
index 829eec8..68e1d38 100644
--- a/drivers/firmware/dcdbas.c
+++ b/drivers/firmware/dcdbas.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
+#include <linux/cpu.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -238,33 +239,14 @@ static ssize_t host_control_on_shutdown_store(struct device *dev,
 	return count;
 }
 
-/**
- * dcdbas_smi_request: generate SMI request
- *
- * Called with smi_data_lock.
- */
-int dcdbas_smi_request(struct smi_cmd *smi_cmd)
+static int raise_smi(void *par)
 {
-	cpumask_var_t old_mask;
-	int ret = 0;
+	struct smi_cmd *smi_cmd = par;
 
-	if (smi_cmd->magic != SMI_CMD_MAGIC) {
-		dev_info(&dcdbas_pdev->dev, "%s: invalid magic value\n",
-			 __func__);
-		return -EBADR;
-	}
-
-	/* SMI requires CPU 0 */
-	if (!alloc_cpumask_var(&old_mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	cpumask_copy(old_mask, &current->cpus_allowed);
-	set_cpus_allowed_ptr(current, cpumask_of(0));
 	if (smp_processor_id() != 0) {
 		dev_dbg(&dcdbas_pdev->dev, "%s: failed to get CPU 0\n",
 			__func__);
-		ret = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	/* generate SMI */
@@ -280,9 +262,28 @@ int dcdbas_smi_request(struct smi_cmd *smi_cmd)
 		: "memory"
 	);
 
-out:
-	set_cpus_allowed_ptr(current, old_mask);
-	free_cpumask_var(old_mask);
+	return 0;
+}
+/**
+ * dcdbas_smi_request: generate SMI request
+ *
+ * Called with smi_data_lock.
+ */
+int dcdbas_smi_request(struct smi_cmd *smi_cmd)
+{
+	int ret;
+
+	if (smi_cmd->magic != SMI_CMD_MAGIC) {
+		dev_info(&dcdbas_pdev->dev, "%s: invalid magic value\n",
+			 __func__);
+		return -EBADR;
+	}
+
+	/* SMI requires CPU 0 */
+	get_online_cpus();
+	ret = smp_call_on_cpu(0, true, raise_smi, smi_cmd);
+	put_online_cpus();
+
 	return ret;
 }
 
-- 
2.6.2
