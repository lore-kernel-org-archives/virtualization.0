From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 9/9] kvm/x86: Hyper-V kvm exit
Date: Fri, 16 Oct 2015 10:07:53 +0300
Message-ID: <1444979273-6587-10-git-send-email-den__18648.71788207$1444979398$gmane$org@openvz.org>
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

A new vcpu exit is introduced to notify the userspace of the
changes in Hyper-V SynIC configuration triggered by guest writing to the
corresponding MSRs.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtiozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virtual/kvm/api.txt |  6 ++++++
 arch/x86/include/asm/kvm_host.h   |  1 +
 arch/x86/kvm/hyperv.c             | 17 +++++++++++++++++
 arch/x86/kvm/x86.c                |  6 ++++++
 include/linux/kvm_host.h          |  1 +
 include/uapi/linux/kvm.h          | 17 +++++++++++++++++
 6 files changed, 48 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 092ee9f..86cae88 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3331,6 +3331,12 @@ the userspace IOAPIC should process the EOI and retrigger the interrupt if
 it is still asserted.  Vector is the LAPIC interrupt vector for which the
 EOI was received.
 
+		/* KVM_EXIT_HYPERV */
+                struct kvm_hyperv_exit hyperv;
+Indicates that the VCPU exits into userspace to process some tasks
+related with Hyper-V emulation. Currently used to synchronize modified
+Hyper-V SynIC state with userspace.
+
 		/* Fix the size of the union. */
 		char padding[256];
 	};
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dfdaf0f..a41d7ed 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -392,6 +392,7 @@ struct kvm_vcpu_hv {
 	u64 hv_vapic;
 	s64 runtime_offset;
 	struct kvm_vcpu_hv_synic synic;
+	struct kvm_hyperv_exit exit;
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8ff71f3..9443920 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -129,6 +129,20 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
 
+static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
+{
+	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
+	struct kvm_vcpu_hv *hv_vcpu = &vcpu->arch.hyperv;
+
+	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNIC;
+	hv_vcpu->exit.u.synic.msr = msr;
+	hv_vcpu->exit.u.synic.control = synic->control;
+	hv_vcpu->exit.u.synic.evt_page = synic->evt_page;
+	hv_vcpu->exit.u.synic.msg_page = synic->msg_page;
+
+	kvm_make_request(KVM_REQ_HV_EXIT, vcpu);
+}
+
 static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 			 u32 msr, u64 data, bool host)
 {
@@ -141,6 +155,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 	switch (msr) {
 	case HV_X64_MSR_SCONTROL:
 		synic->control = data;
+		synic_exit(synic, msr);
 		break;
 	case HV_X64_MSR_SVERSION:
 		if (!host) {
@@ -157,6 +172,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 				break;
 			}
 		synic->evt_page = data;
+		synic_exit(synic, msr);
 		break;
 	case HV_X64_MSR_SIMP:
 		if (data & HV_SYNIC_SIMP_ENABLE)
@@ -166,6 +182,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 				break;
 			}
 		synic->msg_page = data;
+		synic_exit(synic, msr);
 		break;
 	case HV_X64_MSR_EOM: {
 		int i;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 807d124..9453207 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6342,6 +6342,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = 0;
 			goto out;
 		}
+		if (kvm_check_request(KVM_REQ_HV_EXIT, vcpu)) {
+			vcpu->run->exit_reason = KVM_EXIT_HYPERV;
+			vcpu->run->hyperv = vcpu->arch.hyperv.exit;
+			r = 0;
+			goto out;
+		}
 	}
 
 	/*
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 43b0141..e38ac16 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -143,6 +143,7 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQ_HV_CRASH          27
 #define KVM_REQ_IOAPIC_EOI_EXIT   28
 #define KVM_REQ_HV_RESET          29
+#define KVM_REQ_HV_EXIT           30
 
 #define KVM_USERSPACE_IRQ_SOURCE_ID		0
 #define KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID	1
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 27ce460..6e32f75 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -154,6 +154,20 @@ struct kvm_s390_skeys {
 	__u32 flags;
 	__u32 reserved[9];
 };
+
+struct kvm_hyperv_exit {
+#define KVM_EXIT_HYPERV_SYNIC          1
+	__u32 type;
+	union {
+		struct {
+			__u32 msr;
+			__u64 control;
+			__u64 evt_page;
+			__u64 msg_page;
+		} synic;
+	} u;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -184,6 +198,7 @@ struct kvm_s390_skeys {
 #define KVM_EXIT_SYSTEM_EVENT     24
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
+#define KVM_EXIT_HYPERV           27
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -338,6 +353,8 @@ struct kvm_run {
 		struct {
 			__u8 vector;
 		} eoi;
+		/* KVM_EXIT_HYPERV */
+		struct kvm_hyperv_exit hyperv;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
2.1.4
