From: "Denis V. Lunev" <den@openvz.org>
Subject: [RFC PATCH 1/1] mshyperv: fix recognition of Hyper-V guest crash MSR's
Date: Thu,  2 Jul 2015 13:17:18 +0300
Message-ID: <1435832238-2789-1-git-send-email-den__22094.6513386027$1435835006$gmane$org@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Nick Meier <nmeier@microsoft.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

From: Andrey Smetanin <asmetanin@virtuozzo.com>

Hypervisor Top Level Functional Specification v3.1/4.0 notes that cpuid
(0x40000003) EDX's 10th bit should be used to check that Hyper-V guest
crash MSR's functionality available.

This patch should fix this recognition. Currently the code checks EAX
register instead of EDX.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Nick Meier <nmeier@microsoft.com>
CC: K. Y. Srinivasan <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 1 +
 arch/x86/kernel/cpu/mshyperv.c  | 1 +
 drivers/hv/vmbus_drv.c          | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index c163215..eebe433 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -7,6 +7,7 @@
 
 struct ms_hyperv_info {
 	u32 features;
+	u32 misc_features;
 	u32 hints;
 };
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index aad4bd8..6d172a2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -114,6 +114,7 @@ static void __init ms_hyperv_init_platform(void)
 	 * Extract the features and hints
 	 */
 	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
+	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
 	printk(KERN_INFO "HyperV: features 0x%x, hints 0x%x\n",
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index cf20400..67af13a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -841,7 +841,7 @@ static int vmbus_bus_init(int irq)
 	/*
 	 * Only register if the crash MSRs are available
 	 */
-	if (ms_hyperv.features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		atomic_notifier_chain_register(&panic_notifier_list,
 					       &hyperv_panic_block);
 	}
@@ -1110,7 +1110,7 @@ static void __exit vmbus_exit(void)
 	hv_remove_vmbus_irq();
 	tasklet_kill(&msg_dpc);
 	vmbus_free_channels();
-	if (ms_hyperv.features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		atomic_notifier_chain_unregister(&panic_notifier_list,
 						 &hyperv_panic_block);
 	}
-- 
2.1.4
