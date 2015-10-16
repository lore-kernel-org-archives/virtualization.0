From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 8/9] kvm/x86: Hyper-V synthetic interrupt controller
Date: Fri, 16 Oct 2015 10:07:52 +0300
Message-ID: <1444979273-6587-9-git-send-email-den__28763.7496403933$1444979400$gmane$org@openvz.org>
References: <1444979273-6587-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444979273-6587-1-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Andrey Smetanin <asmetanin@virtuozzo.com>

SynIC (synthetic interrupt controller) is a lapic extension,
which is controlled via MSRs and maintains for each vCPU
 - 16 synthetic interrupt "lines" (SINT's); each can be configured to
   trigger a specific interrupt vector optionally with auto-EOI
   semantics
 - a message page in the guest memory with 16 256-byte per-SINT message
   slots
 - an event flag page in the guest memory with 16 2048-bit per-SINT
   event flag areas

The host triggers a SINT whenever it delivers a new message to the
corresponding slot or flips an event flag bit in the corresponding area.
The guest informs the host that it can try delivering a message by
explicitly asserting EOI in lapic or writing to End-Of-Message (EOM)
MSR.

The userspace (qemu) triggers interrupts and receives EOM notifications
via irqfd with resampler; for that, a GSI is allocated for each
configured SINT, and irq_routing api is extended to support GSI-SINT
mapping.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>

Changes v2:
* do not use posted interrupts for Hyper-V SynIC AutoEOI vectors
* add Hyper-V SynIC vectors into EOI exit bitmap
* Hyper-V SyniIC SINT msr write logic simplified
---
 arch/x86/include/asm/kvm_host.h |  14 ++
 arch/x86/kvm/hyperv.c           | 297 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/hyperv.h           |  21 +++
 arch/x86/kvm/irq_comm.c         |  34 +++++
 arch/x86/kvm/lapic.c            |  18 ++-
 arch/x86/kvm/lapic.h            |   5 +
 arch/x86/kvm/x86.c              |  12 +-
 include/linux/kvm_host.h        |   6 +
 include/uapi/linux/kvm.h        |   8 ++
 9 files changed, 407 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 07f7cd7..dfdaf0f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -25,6 +25,7 @@
 #include <linux/pvclock_gtod.h>
 #include <linux/clocksource.h>
 #include <linux/irqbypass.h>
+#include <linux/hyperv.h>
 
 #include <asm/pvclock-abi.h>
 #include <asm/desc.h>
@@ -374,10 +375,23 @@ struct kvm_mtrr {
 	struct list_head head;
 };
 
+/* Hyper-V synthetic interrupt controller (SynIC)*/
+struct kvm_vcpu_hv_synic {
+	u64 version;
+	u64 control;
+	u64 msg_page;
+	u64 evt_page;
+	atomic64_t sint[HV_SYNIC_SINT_COUNT];
+	atomic_t sint_to_gsi[HV_SYNIC_SINT_COUNT];
+	DECLARE_BITMAP(auto_eoi_bitmap, 256);
+	DECLARE_BITMAP(vec_bitmap, 256);
+};
+
 /* Hyper-V per vcpu emulation context */
 struct kvm_vcpu_hv {
 	u64 hv_vapic;
 	s64 runtime_offset;
+	struct kvm_vcpu_hv_synic synic;
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 62cf8c9..8ff71f3 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -23,13 +23,296 @@
 
 #include "x86.h"
 #include "lapic.h"
+#include "ioapic.h"
 #include "hyperv.h"
 
 #include <linux/kvm_host.h>
+#include <asm/apicdef.h>
 #include <trace/events/kvm.h>
 
 #include "trace.h"
 
+static inline u64 synic_read_sint(struct kvm_vcpu_hv_synic *synic, int sint)
+{
+	return atomic64_read(&synic->sint[sint]);
+}
+
+static inline int synic_get_sint_vector(u64 sint_value)
+{
+	if (sint_value & HV_SYNIC_SINT_MASKED)
+		return -1;
+	return sint_value & HV_SYNIC_SINT_VECTOR_MASK;
+}
+
+static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
+				      int vector)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
+		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
+			return true;
+	}
+	return false;
+}
+
+static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
+				     int vector)
+{
+	int i;
+	u64 sint_value;
+
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
+		sint_value = synic_read_sint(synic, i);
+		if (synic_get_sint_vector(sint_value) == vector &&
+		    sint_value & HV_SYNIC_SINT_AUTO_EOI)
+			return true;
+	}
+	return false;
+}
+
+static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint, u64 data)
+{
+	int vector;
+
+	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
+	if (vector < 16)
+		return 1;
+	/*
+	 * Guest may configure multiple SINTs to use the same vector, so
+	 * we maintain a bitmap of vectors handled by synic, and a
+	 * bitmap of vectors with auto-eoi behavior.  The bitmaps are
+	 * updated here, and atomically queried on fast paths.
+	 */
+
+	atomic64_set(&synic->sint[sint], data);
+
+	if (synic_has_vector_connected(synic, vector))
+		__set_bit(vector, synic->vec_bitmap);
+	else
+		__clear_bit(vector, synic->vec_bitmap);
+
+	if (synic_has_vector_auto_eoi(synic, vector))
+		__set_bit(vector, synic->auto_eoi_bitmap);
+	else
+		__clear_bit(vector, synic->auto_eoi_bitmap);
+
+	/* Load SynIC vectors into EOI exit bitmap */
+	kvm_make_request(KVM_REQ_SCAN_IOAPIC, synic_to_vcpu(synic));
+	return 0;
+}
+
+static struct kvm_vcpu_hv_synic *synic_get(struct kvm *kvm, u32 vcpu_id)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (vcpu_id >= atomic_read(&kvm->online_vcpus))
+		return NULL;
+	vcpu = kvm_get_vcpu(kvm, vcpu_id);
+	if (!vcpu)
+		return NULL;
+
+	return vcpu_to_synic(vcpu);
+}
+
+static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
+{
+	struct kvm *kvm = vcpu->kvm;
+	int gsi, idx;
+
+	vcpu_debug(vcpu, "Hyper-V SynIC acked sint %d\n", sint);
+
+	idx = srcu_read_lock(&kvm->irq_srcu);
+	gsi = atomic_read(&vcpu_to_synic(vcpu)->sint_to_gsi[sint]);
+	if (gsi != -1)
+		kvm_notify_acked_gsi(kvm, gsi);
+	srcu_read_unlock(&kvm->irq_srcu, idx);
+}
+
+static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
+			 u32 msr, u64 data, bool host)
+{
+	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
+	int ret;
+
+	vcpu_debug(vcpu, "Hyper-V SynIC set msr 0x%x 0x%llx host %d\n",
+		   msr, data, host);
+	ret = 0;
+	switch (msr) {
+	case HV_X64_MSR_SCONTROL:
+		synic->control = data;
+		break;
+	case HV_X64_MSR_SVERSION:
+		if (!host) {
+			ret = 1;
+			break;
+		}
+		synic->version = data;
+		break;
+	case HV_X64_MSR_SIEFP:
+		if (data & HV_SYNIC_SIEFP_ENABLE)
+			if (kvm_clear_guest(vcpu->kvm,
+					    data & PAGE_MASK, PAGE_SIZE)) {
+				ret = 1;
+				break;
+			}
+		synic->evt_page = data;
+		break;
+	case HV_X64_MSR_SIMP:
+		if (data & HV_SYNIC_SIMP_ENABLE)
+			if (kvm_clear_guest(vcpu->kvm,
+					    data & PAGE_MASK, PAGE_SIZE)) {
+				ret = 1;
+				break;
+			}
+		synic->msg_page = data;
+		break;
+	case HV_X64_MSR_EOM: {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
+			kvm_hv_notify_acked_sint(vcpu, i);
+		break;
+	}
+	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+		ret = synic_set_sint(synic, msr - HV_X64_MSR_SINT0, data);
+		break;
+	default:
+		ret = 1;
+		break;
+	}
+	return ret;
+}
+
+static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata)
+{
+	int ret;
+
+	ret = 0;
+	switch (msr) {
+	case HV_X64_MSR_SCONTROL:
+		*pdata = synic->control;
+		break;
+	case HV_X64_MSR_SVERSION:
+		*pdata = synic->version;
+		break;
+	case HV_X64_MSR_SIEFP:
+		*pdata = synic->evt_page;
+		break;
+	case HV_X64_MSR_SIMP:
+		*pdata = synic->msg_page;
+		break;
+	case HV_X64_MSR_EOM:
+		*pdata = 0;
+		break;
+	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+		*pdata = atomic64_read(&synic->sint[msr - HV_X64_MSR_SINT0]);
+		break;
+	default:
+		ret = 1;
+		break;
+	}
+	return ret;
+}
+
+int synic_set_irq(struct kvm_vcpu_hv_synic *synic, u32 sint)
+{
+	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
+	struct kvm_lapic_irq irq;
+	int ret, vector;
+
+	if (sint >= ARRAY_SIZE(synic->sint))
+		return -EINVAL;
+
+	vector = synic_get_sint_vector(synic_read_sint(synic, sint));
+	if (vector < 0)
+		return -ENOENT;
+
+	memset(&irq, 0, sizeof(irq));
+	irq.dest_id = kvm_apic_id(vcpu->arch.apic);
+	irq.dest_mode = APIC_DEST_PHYSICAL;
+	irq.delivery_mode = APIC_DM_FIXED;
+	irq.vector = vector;
+	irq.level = 1;
+
+	ret = kvm_irq_delivery_to_apic(vcpu->kvm, NULL, &irq, NULL);
+	vcpu_debug(vcpu, "Hyper-V SynIC set irq ret %d\n", ret);
+	return ret;
+}
+
+int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vcpu_id, u32 sint)
+{
+	struct kvm_vcpu_hv_synic *synic;
+
+	synic = synic_get(kvm, vcpu_id);
+	if (!synic)
+		return -EINVAL;
+
+	return synic_set_irq(synic, sint);
+}
+
+void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
+{
+	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
+	int i;
+
+	vcpu_debug(vcpu, "Hyper-V SynIC send eoi vec %d\n", vector);
+
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
+		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
+			kvm_hv_notify_acked_sint(vcpu, i);
+}
+
+static int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vcpu_id, u32 sint, int gsi)
+{
+	struct kvm_vcpu_hv_synic *synic;
+
+	synic = synic_get(kvm, vcpu_id);
+	if (!synic)
+		return -EINVAL;
+
+	if (sint >= ARRAY_SIZE(synic->sint_to_gsi))
+		return -EINVAL;
+
+	atomic_set(&synic->sint_to_gsi[sint], gsi);
+	return 0;
+}
+
+void kvm_hv_irq_routing_update(struct kvm *kvm)
+{
+	struct kvm_irq_routing_table *irq_rt;
+	struct kvm_kernel_irq_routing_entry *e;
+	u32 gsi;
+
+	irq_rt = srcu_dereference_check(kvm->irq_routing, &kvm->irq_srcu,
+					lockdep_is_held(&kvm->irq_lock));
+
+	for (gsi = 0; gsi < irq_rt->nr_rt_entries; gsi++) {
+		hlist_for_each_entry(e, &irq_rt->map[gsi], link) {
+			if (e->type == KVM_IRQ_ROUTING_HV_SINT)
+				kvm_hv_set_sint_gsi(kvm, e->hv_sint.vcpu,
+						    e->hv_sint.sint, gsi);
+		}
+	}
+}
+
+static void synic_init(struct kvm_vcpu_hv_synic *synic)
+{
+	int i;
+
+	memset(synic, 0, sizeof(*synic));
+	synic->version = HV_SYNIC_VERSION_1;
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
+		atomic64_set(&synic->sint[i], HV_SYNIC_SINT_MASKED);
+		atomic_set(&synic->sint_to_gsi[i], -1);
+	}
+}
+
+void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	synic_init(vcpu_to_synic(vcpu));
+}
+
 static bool kvm_hv_msr_partition_wide(u32 msr)
 {
 	bool r = false;
@@ -226,6 +509,13 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 			return 1;
 		hv->runtime_offset = data - current_task_runtime_100ns();
 		break;
+	case HV_X64_MSR_SCONTROL:
+	case HV_X64_MSR_SVERSION:
+	case HV_X64_MSR_SIEFP:
+	case HV_X64_MSR_SIMP:
+	case HV_X64_MSR_EOM:
+	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+		return synic_set_msr(vcpu_to_synic(vcpu), msr, data, host);
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
 			    msr, data);
@@ -304,6 +594,13 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 	case HV_X64_MSR_VP_RUNTIME:
 		data = current_task_runtime_100ns() + hv->runtime_offset;
 		break;
+	case HV_X64_MSR_SCONTROL:
+	case HV_X64_MSR_SVERSION:
+	case HV_X64_MSR_SIEFP:
+	case HV_X64_MSR_SIMP:
+	case HV_X64_MSR_EOM:
+	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+		return synic_get_msr(vcpu_to_synic(vcpu), msr, pdata);
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
 		return 1;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index c7bce55..8668612 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -29,4 +29,25 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
 bool kvm_hv_hypercall_enabled(struct kvm *kvm);
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
 
+int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vcpu_id, u32 sint);
+void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector);
+
+static inline struct kvm_vcpu_hv_synic *vcpu_to_synic(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.hyperv.synic;
+}
+
+static inline struct kvm_vcpu *synic_to_vcpu(struct kvm_vcpu_hv_synic *synic)
+{
+	struct kvm_vcpu_hv *hv;
+	struct kvm_vcpu_arch *arch;
+
+	hv = container_of(synic, struct kvm_vcpu_hv, synic);
+	arch = container_of(hv, struct kvm_vcpu_arch, hyperv);
+	return container_of(arch, struct kvm_vcpu, arch);
+}
+void kvm_hv_irq_routing_update(struct kvm *kvm);
+
+void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
+
 #endif
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index fe91f72..5e195b9 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -33,6 +33,8 @@
 
 #include "lapic.h"
 
+#include "hyperv.h"
+
 static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
 			   struct kvm *kvm, int irq_source_id, int level,
 			   bool line_status)
@@ -251,6 +253,16 @@ void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
 
+static int kvm_hv_set_sint(struct kvm_kernel_irq_routing_entry *e,
+		    struct kvm *kvm, int irq_source_id, int level,
+		    bool line_status)
+{
+	if (!level)
+		return -1;
+
+	return kvm_hv_synic_set_irq(kvm, e->hv_sint.vcpu, e->hv_sint.sint);
+}
+
 int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
 			  const struct kvm_irq_routing_entry *ue)
 {
@@ -289,6 +301,11 @@ int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
 		e->msi.address_hi = ue->u.msi.address_hi;
 		e->msi.data = ue->u.msi.data;
 		break;
+	case KVM_IRQ_ROUTING_HV_SINT:
+		e->set = kvm_hv_set_sint;
+		e->hv_sint.vcpu = ue->u.hv_sint.vcpu;
+		e->hv_sint.sint = ue->u.hv_sint.sint;
+		break;
 	default:
 		goto out;
 	}
@@ -405,3 +422,20 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
 	}
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
+
+int kvm_arch_set_irq(struct kvm_kernel_irq_routing_entry *irq, struct kvm *kvm,
+		     int irq_source_id, int level, bool line_status)
+{
+	switch (irq->type) {
+	case KVM_IRQ_ROUTING_HV_SINT:
+		return kvm_hv_set_sint(irq, kvm, irq_source_id, level,
+				       line_status);
+	default:
+		return -EWOULDBLOCK;
+	}
+}
+
+void kvm_arch_irq_routing_update(struct kvm *kvm)
+{
+	kvm_hv_irq_routing_update(kvm);
+}
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index dc03a01..3132478 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "x86.h"
 #include "cpuid.h"
+#include "hyperv.h"
 
 #ifndef CONFIG_X86_64
 #define mod_64(x, y) ((x) - (y) * div64_u64(x, y))
@@ -128,11 +129,6 @@ static inline int apic_enabled(struct kvm_lapic *apic)
 	(LVT_MASK | APIC_MODE_MASK | APIC_INPUT_POLARITY | \
 	 APIC_LVT_REMOTE_IRR | APIC_LVT_LEVEL_TRIGGER)
 
-static inline int kvm_apic_id(struct kvm_lapic *apic)
-{
-	return (kvm_apic_get_reg(apic, APIC_ID) >> 24) & 0xff;
-}
-
 /* The logical map is definitely wrong if we have multiple
  * modes at the same time.  (Physical map is always right.)
  */
@@ -850,7 +846,8 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 				apic_clear_vector(vector, apic->regs + APIC_TMR);
 		}
 
-		if (kvm_x86_ops->deliver_posted_interrupt)
+		if (kvm_x86_ops->deliver_posted_interrupt &&
+		    !test_bit(vector, vcpu_to_synic(vcpu)->auto_eoi_bitmap))
 			kvm_x86_ops->deliver_posted_interrupt(vcpu, vector);
 		else {
 			apic_set_irr(vector, apic);
@@ -972,6 +969,9 @@ static int apic_set_eoi(struct kvm_lapic *apic)
 	apic_clear_isr(vector, apic);
 	apic_update_ppr(apic);
 
+	if (test_bit(vector, vcpu_to_synic(apic->vcpu)->vec_bitmap))
+		kvm_hv_synic_send_eoi(apic->vcpu, vector);
+
 	kvm_ioapic_send_eoi(apic, vector);
 	kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 	return vector;
@@ -1881,6 +1881,12 @@ int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu)
 	apic_set_isr(vector, apic);
 	apic_update_ppr(apic);
 	apic_clear_irr(vector, apic);
+
+	if (test_bit(vector, vcpu_to_synic(vcpu)->auto_eoi_bitmap)) {
+		apic_clear_isr(vector, apic);
+		apic_update_ppr(apic);
+	}
+
 	return vector;
 }
 
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index fde8e35d..6c64090 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -164,6 +164,11 @@ static inline int kvm_lapic_latched_init(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_has_lapic(vcpu) && test_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
 }
 
+static inline int kvm_apic_id(struct kvm_lapic *apic)
+{
+	return (kvm_apic_get_reg(apic, APIC_ID) >> 24) & 0xff;
+}
+
 bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
 
 void wait_lapic_expire(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 668a1c4..807d124 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -959,6 +959,7 @@ static u32 emulated_msrs[] = {
 	HV_X64_MSR_RESET,
 	HV_X64_MSR_VP_INDEX,
 	HV_X64_MSR_VP_RUNTIME,
+	HV_X64_MSR_SCONTROL,
 	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
 	MSR_KVM_PV_EOI_EN,
 
@@ -2441,6 +2442,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV:
 	case KVM_CAP_HYPERV_VAPIC:
 	case KVM_CAP_HYPERV_SPIN:
+	case KVM_CAP_HYPERV_SYNIC:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
@@ -6195,6 +6197,8 @@ static void process_smi(struct kvm_vcpu *vcpu)
 
 static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 {
+	u64 eoi_exit_bitmap[4];
+
 	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
 		return;
 
@@ -6205,8 +6209,10 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 	else
 		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 
-	kvm_x86_ops->load_eoi_exitmap(vcpu,
-				      (u64 *)vcpu->arch.ioapic_handled_vectors);
+	bitmap_or((ulong *)eoi_exit_bitmap, vcpu->arch.ioapic_handled_vectors,
+		  vcpu_to_synic(vcpu)->vec_bitmap, 256);
+
+	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
 }
 
 static void kvm_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
@@ -7461,6 +7467,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.pending_external_vector = -1;
 
+	kvm_hv_vcpu_init(vcpu);
+
 	return 0;
 
 fail_free_mce_banks:
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c742e79..43b0141 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -318,6 +318,11 @@ struct kvm_s390_adapter_int {
 	u32 adapter_id;
 };
 
+struct kvm_hv_sint {
+	u32 vcpu;
+	u32 sint;
+};
+
 struct kvm_kernel_irq_routing_entry {
 	u32 gsi;
 	u32 type;
@@ -331,6 +336,7 @@ struct kvm_kernel_irq_routing_entry {
 		} irqchip;
 		struct msi_msg msi;
 		struct kvm_s390_adapter_int adapter;
+		struct kvm_hv_sint hv_sint;
 	};
 	struct hlist_node link;
 };
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 03f3618..27ce460 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -831,6 +831,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
 #define KVM_CAP_SPLIT_IRQCHIP 121
 #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
+#define KVM_CAP_HYPERV_SYNIC 123
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -854,10 +855,16 @@ struct kvm_irq_routing_s390_adapter {
 	__u32 adapter_id;
 };
 
+struct kvm_irq_routing_hv_sint {
+	__u32 vcpu;
+	__u32 sint;
+};
+
 /* gsi routing entry types */
 #define KVM_IRQ_ROUTING_IRQCHIP 1
 #define KVM_IRQ_ROUTING_MSI 2
 #define KVM_IRQ_ROUTING_S390_ADAPTER 3
+#define KVM_IRQ_ROUTING_HV_SINT 4
 
 struct kvm_irq_routing_entry {
 	__u32 gsi;
@@ -868,6 +875,7 @@ struct kvm_irq_routing_entry {
 		struct kvm_irq_routing_irqchip irqchip;
 		struct kvm_irq_routing_msi msi;
 		struct kvm_irq_routing_s390_adapter adapter;
+		struct kvm_irq_routing_hv_sint hv_sint;
 		__u32 pad[8];
 	} u;
 };
-- 
2.1.4
