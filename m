From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 23/78] KVM: x86: add .spt_fault()
Date: Fri,  7 Feb 2020 20:15:41 +0200
Message-ID: <20200207181636.1065-24-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mihai Donțu <mdontu@bitdefender.com>

This function is needed for the KVMI_EVENT_PF event.

Signed-off-by: Mihai Donțu <mdontu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/svm.c              | 9 +++++++++
 arch/x86/kvm/vmx/vmx.c          | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6094884d3015..0f25f69fc8be 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1255,6 +1255,7 @@ struct kvm_x86_ops {
 	int (*enable_direct_tlbflush)(struct kvm_vcpu *vcpu);
 
 	u64 (*fault_gla)(struct kvm_vcpu *vcpu);
+	bool (*spt_fault)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index ab9576444e6b..f908ef374617 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7358,6 +7358,14 @@ static u64 svm_fault_gla(struct kvm_vcpu *vcpu)
 	return svm->vcpu.arch.cr2 ? svm->vcpu.arch.cr2 : ~0ull;
 }
 
+static bool svm_spt_fault(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb *vmcb = get_host_vmcb(svm);
+
+	return (vmcb->control.exit_code == SVM_EXIT_NPF);
+}
+
 static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = has_svm,
 	.disabled_by_bios = is_disabled,
@@ -7504,6 +7512,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.apic_init_signal_blocked = svm_apic_init_signal_blocked,
 
 	.fault_gla = svm_fault_gla,
+	.spt_fault = svm_spt_fault,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f1df5725d06f..6f41a7b27a11 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7823,6 +7823,13 @@ static u64 vmx_fault_gla(struct kvm_vcpu *vcpu)
 	return ~0ull;
 }
 
+static bool vmx_spt_fault(struct kvm_vcpu *vcpu)
+{
+	const struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	return (vmx->exit_reason == EXIT_REASON_EPT_VIOLATION);
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -7982,6 +7989,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
 
 	.fault_gla = vmx_fault_gla,
+	.spt_fault = vmx_spt_fault,
 };
 
 static void vmx_cleanup_l1d_flush(void)
