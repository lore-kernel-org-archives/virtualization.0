From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 25/78] KVM: x86: add .control_singlestep()
Date: Fri,  7 Feb 2020 20:15:43 +0200
Message-ID: <20200207181636.1065-26-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <ncitu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicușor Cîțu <ncitu@bitdefender.com>

This function is needed for KVMI_VCPU_CONTROL_SINGLESTEP
and KVMI_EVENT_SINGLESTEP.

Signed-off-by: Nicușor Cîțu <ncitu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/vmx.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e05569a5da10..6927a6044e26 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1257,6 +1257,7 @@ struct kvm_x86_ops {
 	u64 (*fault_gla)(struct kvm_vcpu *vcpu);
 	bool (*spt_fault)(struct kvm_vcpu *vcpu);
 	bool (*gpt_translation_fault)(struct kvm_vcpu *vcpu);
+	void (*control_singlestep)(struct kvm_vcpu *vcpu, bool enable);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 83f047fe6bc1..475f5eb6c4c2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7837,6 +7837,16 @@ static bool vmx_gpt_translation_fault(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static void vmx_control_singlestep(struct kvm_vcpu *vcpu, bool enable)
+{
+	if (enable)
+		exec_controls_setbit(to_vmx(vcpu),
+			      CPU_BASED_MONITOR_TRAP_FLAG);
+	else
+		exec_controls_clearbit(to_vmx(vcpu),
+				CPU_BASED_MONITOR_TRAP_FLAG);
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -7998,6 +8008,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.fault_gla = vmx_fault_gla,
 	.spt_fault = vmx_spt_fault,
 	.gpt_translation_fault = vmx_gpt_translation_fault,
+	.control_singlestep = vmx_control_singlestep,
 };
 
 static void vmx_cleanup_l1d_flush(void)
