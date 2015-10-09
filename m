From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/2] kvm/x86: Hyper-V synthetic interrupt controller
Date: Fri,  9 Oct 2015 16:39:47 +0300
Message-ID: <1444397988-20167-2-git-send-email-den@openvz.org>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444397988-20167-1-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Andrey Smetanin <asmetanin@virtuozzo.com>

Synic is a lapic extension, which is controlled via MSRs and maintains
for each vCPU
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
---
 arch/powerpc/kvm/mpic.c         |  18 +++
 arch/s390/kvm/interrupt.c       |  18 +++
 arch/x86/include/asm/kvm_host.h |  14 +++
 arch/x86/kvm/hyperv.c           | 266 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/hyperv.h           |  20 +++
 arch/x86/kvm/irq_comm.c         |  16 +++
 arch/x86/kvm/lapic.c            |  15 ++-
 arch/x86/kvm/lapic.h            |   5 +
 arch/x86/kvm/x86.c              |   4 +
 drivers/hv/hyperv_vmbus.h       |   5 -
 include/linux/kvm_host.h        |  12 ++
 include/uapi/linux/hyperv.h     |  12 ++
 include/uapi/linux/kvm.h        |   8 ++
 virt/kvm/arm/vgic.c             |  18 +++
 virt/kvm/eventfd.c              |  35 +++++-
 virt/kvm/irqchip.c              |  24 +++-
 16 files changed, 475 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 6249cdc..01e7fb4 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1850,3 +1850,21 @@ int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
 out:
 	return r;
 }
+
+/* Hyper-V Synic not implemented */
+int kvm_hv_set_sint(struct kvm_kernel_irq_routing_entry *e,
+		    struct kvm *kvm, int irq_source_id, int level,
+		    bool line_status)
+{
+	return -ENOTSUP;
+}
+
+int kvm_hv_get_sint_gsi(struct kvm_vcpu *vcpu, u32 sint)
+{
+	return -ENOTSUP;
+}
+
+int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vcpu_id, u32 sint, int gsi)
+{
+	return -ENOTSUP;
+}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5c2c169..7fa8d9d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2285,3 +2285,21 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 
 	return n;
 }
+
+/* Hyper-V Synic not implemented */
+int kvm_hv_set_sint(struct kvm_kernel_irq_routing_entry *e,
+		    struct kvm *kvm, int irq_source_id, int level,
+		    bool line_status)
+{
+	return -ENOTSUP;
+}
+
+int kvm_hv_get_sint_gsi(struct kvm_vcpu *vcpu, u32 sint)
+{
+	return -ENOTSUP;
+}
+
+int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vcpu_id, u32 sint, int gsi)
+{
+	return -ENOTSUP;
+}
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cdbdb55..e614a543 100644
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
 
+/* Hyper-V synthetic interrupt controller */
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
index 62cf8c9..15c3c02 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -23,13 +23,265 @@
 
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
+static bool synic_has_active_vector(struct kvm_vcpu_hv_synic *synic,
+				    int vector, int sint_to_skip, int sint_mask)
+{
+	u64 sint_value;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
+		if (i == sint_to_skip)
+			continue;
+		sint_value = synic_read_sint(synic, i);
+		if ((synic_get_sint_vector(sint_value) == vector) &&
+		    ((sint_mask == 0) || (sint_value & sint_mask)))
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
+	 * bitmap of vectors with auto-eoi behavoir.  The bitmaps are
+	 * updated here, and atomically queried on fast paths.
+	 */
+
+	if (!(data & HV_SYNIC_SINT_MASKED)) {
+		__set_bit(vector, synic->vec_bitmap);
+		if (data & HV_SYNIC_SINT_AUTO_EOI)
+			__set_bit(vector, synic->auto_eoi_bitmap);
+	} else {
+		if (!synic_has_active_vector(synic, vector, sint, 0))
+			__clear_bit(vector, synic->vec_bitmap);
+		if (!synic_has_active_vector(synic, vector, sint,
+					     HV_SYNIC_SINT_AUTO_EOI))
+			__clear_bit(vector, synic->auto_eoi_bitmap);
+	}
+
+	atomic64_set(&synic->sint[sint], data);
+	return 0;
+}
+
+static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
+			 u32 msr, u64 data, bool host)
+{
+	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
+	int ret;
+
+	vcpu_debug(vcpu, "set msr 0x%x 0x%llx host %d\n",
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
+			kvm_notify_acked_hv_sint(vcpu, i);
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
+	vcpu_debug(vcpu, "set irq ret %d\n", ret);
+	return ret;
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
+	vcpu_debug(vcpu, "synic eoi vec %d\n", vector);
+
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
+		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
+			kvm_notify_acked_hv_sint(vcpu, i);
+}
+
+int kvm_hv_get_sint_gsi(struct kvm_vcpu *vcpu, u32 sint)
+{
+	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
+	int gsi;
+
+	if (sint >= ARRAY_SIZE(synic->sint_to_gsi))
+		return -1;
+
+	gsi = atomic_read(&synic->sint_to_gsi[sint]);
+	return gsi;
+}
+
+int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vcpu_id, u32 sint, int gsi)
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
@@ -226,6 +478,13 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
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
@@ -304,6 +563,13 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
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
index c7bce55..cd3a483 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -29,4 +29,24 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
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
+
+void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
+
 #endif
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index c892289..d26baf8 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -33,6 +33,8 @@
 
 #include "lapic.h"
 
+#include "hyperv.h"
+
 static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
 			   struct kvm *kvm, int irq_source_id, int level,
 			   bool line_status)
@@ -123,6 +125,15 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 	return kvm_irq_delivery_to_apic(kvm, NULL, &irq, NULL);
 }
 
+int kvm_hv_set_sint(struct kvm_kernel_irq_routing_entry *e,
+		    struct kvm *kvm, int irq_source_id, int level,
+		    bool line_status)
+{
+	if (!level)
+		return -1;
+
+	return kvm_hv_synic_set_irq(kvm, e->hv_sint.vcpu, e->hv_sint.sint);
+}
 
 static int kvm_set_msi_inatomic(struct kvm_kernel_irq_routing_entry *e,
 			 struct kvm *kvm)
@@ -289,6 +300,11 @@ int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
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
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 944b38a..63edbec 100644
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
@@ -972,6 +968,9 @@ static int apic_set_eoi(struct kvm_lapic *apic)
 	apic_clear_isr(vector, apic);
 	apic_update_ppr(apic);
 
+	if (test_bit(vector, vcpu_to_synic(apic->vcpu)->vec_bitmap))
+		kvm_hv_synic_send_eoi(apic->vcpu, vector);
+
 	kvm_ioapic_send_eoi(apic, vector);
 	kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 	return vector;
@@ -1881,6 +1880,12 @@ int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu)
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
index 2d2c9bb..7580e9c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -958,6 +958,7 @@ static u32 emulated_msrs[] = {
 	HV_X64_MSR_RESET,
 	HV_X64_MSR_VP_INDEX,
 	HV_X64_MSR_VP_RUNTIME,
+	HV_X64_MSR_SCONTROL,
 	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
 	MSR_KVM_PV_EOI_EN,
 
@@ -2440,6 +2441,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV:
 	case KVM_CAP_HYPERV_VAPIC:
 	case KVM_CAP_HYPERV_SPIN:
+	case KVM_CAP_HYPERV_SYNIC:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
@@ -7453,6 +7455,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.pending_external_vector = -1;
 
+	kvm_hv_vcpu_init(vcpu);
+
 	return 0;
 
 fail_free_mce_banks:
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 3d70e36..3782636 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -63,9 +63,6 @@ enum hv_cpuid_function {
 /* Define version of the synthetic interrupt controller. */
 #define HV_SYNIC_VERSION		(1)
 
-/* Define the expected SynIC version. */
-#define HV_SYNIC_VERSION_1		(0x1)
-
 /* Define synthetic interrupt controller message constants. */
 #define HV_MESSAGE_SIZE			(256)
 #define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
@@ -105,8 +102,6 @@ enum hv_message_type {
 	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005
 };
 
-/* Define the number of synthetic interrupt sources. */
-#define HV_SYNIC_SINT_COUNT		(16)
 #define HV_SYNIC_STIMER_COUNT		(4)
 
 /* Define invalid partition identifier. */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9596a2f..30fac73 100644
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
@@ -822,14 +828,20 @@ struct kvm_irq_ack_notifier {
 int kvm_irq_map_gsi(struct kvm *kvm,
 		    struct kvm_kernel_irq_routing_entry *entries, int gsi);
 int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin);
+int kvm_hv_get_sint_gsi(struct kvm_vcpu *vcpu, u32 sint);
+int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vcpu_id, u32 sint, int gsi);
 
 int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 		bool line_status);
 int kvm_set_irq_inatomic(struct kvm *kvm, int irq_source_id, u32 irq, int level);
 int kvm_set_msi(struct kvm_kernel_irq_routing_entry *irq_entry, struct kvm *kvm,
 		int irq_source_id, int level, bool line_status);
+int kvm_hv_set_sint(struct kvm_kernel_irq_routing_entry *irq_entry,
+		    struct kvm *kvm, int irq_source_id, int level,
+		    bool line_status);
 bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin);
 void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin);
+void kvm_notify_acked_hv_sint(struct kvm_vcpu *vcpu, u32 sint);
 void kvm_register_irq_ack_notifier(struct kvm *kvm,
 				   struct kvm_irq_ack_notifier *kian);
 void kvm_unregister_irq_ack_notifier(struct kvm *kvm,
diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
index e4c0a35..8a63ea7 100644
--- a/include/uapi/linux/hyperv.h
+++ b/include/uapi/linux/hyperv.h
@@ -395,4 +395,16 @@ struct hv_kvp_ip_msg {
 	struct hv_kvp_ipaddr_value      kvp_ip_val;
 } __attribute__((packed));
 
+/* Define the number of synthetic interrupt sources. */
+#define HV_SYNIC_SINT_COUNT		(16)
+/* Define the expected SynIC version. */
+#define HV_SYNIC_VERSION_1		(0x1)
+
+#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
+#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
+#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
+
 #endif /* _UAPI_HYPERV_H */
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
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 6bd1c9b..02fbe7f 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2527,3 +2527,21 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 {
 	return 0;
 }
+
+/* Hyper-V Synic not implemented */
+int kvm_hv_set_sint(struct kvm_kernel_irq_routing_entry *e,
+		    struct kvm *kvm, int irq_source_id, int level,
+		    bool line_status)
+{
+	return -ENOTSUP;
+}
+
+int kvm_hv_get_sint_gsi(struct kvm_vcpu *vcpu, u32 sint)
+{
+	return -ENOTSUP;
+}
+
+int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vcpu_id, u32 sint, int gsi)
+{
+	return -ENOTSUP;
+}
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index b637965..0d7b705 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -192,11 +192,19 @@ irqfd_wakeup(wait_queue_t *wait, unsigned mode, int sync, void *key)
 			irq = irqfd->irq_entry;
 		} while (read_seqcount_retry(&irqfd->irq_entry_sc, seq));
 		/* An event has been signaled, inject an interrupt */
-		if (irq.type == KVM_IRQ_ROUTING_MSI)
+		switch (irq.type) {
+		case KVM_IRQ_ROUTING_MSI:
 			kvm_set_msi(&irq, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1,
 					false);
-		else
+			break;
+		case KVM_IRQ_ROUTING_HV_SINT:
+			kvm_hv_set_sint(&irq, kvm, KVM_USERSPACE_IRQ_SOURCE_ID,
+					1, false);
+			break;
+		default:
 			schedule_work(&irqfd->inject);
+			break;
+		}
 		srcu_read_unlock(&kvm->irq_srcu, idx);
 	}
 
@@ -248,8 +256,9 @@ static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
 
 	e = entries;
 	for (i = 0; i < n_entries; ++i, ++e) {
-		/* Only fast-path MSI. */
-		if (e->type == KVM_IRQ_ROUTING_MSI)
+		/* Fast-path MSI and Hyper-V sint */
+		if (e->type == KVM_IRQ_ROUTING_MSI ||
+		    e->type == KVM_IRQ_ROUTING_HV_SINT)
 			irqfd->irq_entry = *e;
 	}
 
@@ -471,6 +480,24 @@ void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin)
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
 
+void kvm_notify_acked_hv_sint(struct kvm_vcpu *vcpu, u32 sint)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_irq_ack_notifier *kian;
+	int gsi, idx;
+
+	vcpu_debug(vcpu, "synic acked sint %d\n", sint);
+
+	idx = srcu_read_lock(&kvm->irq_srcu);
+	gsi = kvm_hv_get_sint_gsi(vcpu, sint);
+	if (gsi != -1)
+		hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
+					 link)
+			if (kian->gsi == gsi)
+				kian->irq_acked(kian);
+	srcu_read_unlock(&kvm->irq_srcu, idx);
+}
+
 void kvm_register_irq_ack_notifier(struct kvm *kvm,
 				   struct kvm_irq_ack_notifier *kian)
 {
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 716a1c4..1cf3d92 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -144,11 +144,13 @@ static int setup_routing_entry(struct kvm_irq_routing_table *rt,
 
 	/*
 	 * Do not allow GSI to be mapped to the same irqchip more than once.
-	 * Allow only one to one mapping between GSI and MSI.
+	 * Allow only one to one mapping between GSI and MSI/Hyper-V SINT.
 	 */
 	hlist_for_each_entry(ei, &rt->map[ue->gsi], link)
 		if (ei->type == KVM_IRQ_ROUTING_MSI ||
 		    ue->type == KVM_IRQ_ROUTING_MSI ||
+		    ei->type == KVM_IRQ_ROUTING_HV_SINT ||
+		    ue->type == KVM_IRQ_ROUTING_HV_SINT ||
 		    ue->u.irqchip.irqchip == ei->irqchip.irqchip)
 			return r;
 
@@ -166,6 +168,25 @@ out:
 	return r;
 }
 
+static void kvm_irq_update_hv_sint_gsi(struct kvm *kvm)
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
+						    e->hv_sint.sint,
+						    gsi);
+		}
+	}
+}
+
 int kvm_set_irq_routing(struct kvm *kvm,
 			const struct kvm_irq_routing_entry *ue,
 			unsigned nr,
@@ -219,6 +240,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
 	old = kvm->irq_routing;
 	rcu_assign_pointer(kvm->irq_routing, new);
 	kvm_irq_routing_update(kvm);
+	kvm_irq_update_hv_sint_gsi(kvm);
 	mutex_unlock(&kvm->irq_lock);
 
 	kvm_arch_irq_routing_update(kvm);
-- 
2.1.4
