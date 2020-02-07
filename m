From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 24/78] KVM: x86: add .gpt_translation_fault()
Date: Fri,  7 Feb 2020 20:15:42 +0200
Message-ID: <20200207181636.1065-25-alazar@bitdefender.com>
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
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm.c              | 12 ++++++++++++
 arch/x86/kvm/vmx/vmx.c          |  8 ++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0f25f69fc8be..e05569a5da10 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1256,6 +1256,7 @@ struct kvm_x86_ops {
 
 	u64 (*fault_gla)(struct kvm_vcpu *vcpu);
 	bool (*spt_fault)(struct kvm_vcpu *vcpu);
+	bool (*gpt_translation_fault)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f908ef374617..38ecd86c1d58 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7366,6 +7366,17 @@ static bool svm_spt_fault(struct kvm_vcpu *vcpu)
 	return (vmcb->control.exit_code == SVM_EXIT_NPF);
 }
 
+static bool svm_gpt_translation_fault(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb *vmcb = get_host_vmcb(svm);
+
+	if (vmcb->control.exit_info_1 & PFERR_GUEST_PAGE_MASK)
+		return true;
+
+	return false;
+}
+
 static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = has_svm,
 	.disabled_by_bios = is_disabled,
@@ -7513,6 +7524,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 
 	.fault_gla = svm_fault_gla,
 	.spt_fault = svm_spt_fault,
+	.gpt_translation_fault = svm_gpt_translation_fault,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6f41a7b27a11..83f047fe6bc1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7830,6 +7830,13 @@ static bool vmx_spt_fault(struct kvm_vcpu *vcpu)
 	return (vmx->exit_reason == EXIT_REASON_EPT_VIOLATION);
 }
 
+static bool vmx_gpt_translation_fault(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.exit_qualification & EPT_VIOLATION_GVA_TRANSLATED)
+		return false;
+	return true;
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -7990,6 +7997,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 
 	.fault_gla = vmx_fault_gla,
 	.spt_fault = vmx_spt_fault,
+	.gpt_translation_fault = vmx_gpt_translation_fault,
 };
 
 static void vmx_cleanup_l1d_flush(void)
