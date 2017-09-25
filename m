From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 3/4] perf/x86: add a function to get the lbr stack
Date: Mon, 25 Sep 2017 12:44:55 +0800
Message-ID: <1506314696-4632-4-git-send-email-wei.w.wang__11897.2399658107$1506315523$gmane$org@intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com, ak@linux.intel.com, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The LBR stack MSRs are architecturally specific. The perf subsystem has
already assigned the abstracted MSR values based on the CPU architecture.

This patch enables a caller outside the perf subsystem to get the LBR
stack info. This is useful for hyperviosrs to prepare the lbr feature
for the guest.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 arch/x86/events/intel/lbr.c       | 23 +++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h | 14 ++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8a6bbac..ea547ec 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1230,3 +1230,26 @@ void intel_pmu_lbr_init_knl(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
 }
+
+/**
+ * perf_get_lbr_stack - get the lbr stack related MSRs
+ *
+ * @stack: the caller's memory to get the lbr stack
+ *
+ * Returns: 0 indicates that the lbr stack has been successfully obtained.
+ */
+int perf_get_lbr_stack(struct perf_lbr_stack *stack)
+{
+	stack->lbr_nr = x86_pmu.lbr_nr;
+	stack->lbr_tos = x86_pmu.lbr_tos;
+	stack->lbr_from = x86_pmu.lbr_from;
+	stack->lbr_to = x86_pmu.lbr_to;
+
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+		stack->lbr_info = MSR_LBR_INFO_0;
+	else
+		stack->lbr_info = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(perf_get_lbr_stack);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index f353061..c098462 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -266,7 +266,16 @@ struct perf_guest_switch_msr {
 	u64 host, guest;
 };
 
+struct perf_lbr_stack {
+	int		lbr_nr;
+	unsigned long	lbr_tos;
+	unsigned long	lbr_from;
+	unsigned long	lbr_to;
+	unsigned long	lbr_info;
+};
+
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
+extern int perf_get_lbr_stack(struct perf_lbr_stack *stack);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
 #else
@@ -276,6 +285,11 @@ static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 	return NULL;
 }
 
+static inline int perf_get_lbr_stack(struct perf_lbr_stack *stack)
+{
+	return -1;
+}
+
 static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
 	memset(cap, 0, sizeof(*cap));
-- 
2.7.4
