From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 26/34] KVM: x86: add .set_ve_info()
Date: Wed, 22 Jul 2020 19:01:13 +0300
Message-ID: <20200722160121.9601-27-alazar@bitdefender.com>
References: <20200722160121.9601-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200722160121.9601-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Ștefan Șicleru <ssicleru@bitdefender.com>

This function is needed for the KVMI_VCPU_SET_VE_INFO command.

Signed-off-by: Ștefan Șicleru <ssicleru@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/include/asm/vmx.h      |  1 +
 arch/x86/kvm/vmx/vmx.c          | 40 +++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e89cea041ec9..4cee641af48e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1314,6 +1314,8 @@ struct kvm_x86_ops {
 	u16 (*get_ept_view)(struct kvm_vcpu *vcpu);
 	int (*set_ept_view)(struct kvm_vcpu *vcpu, u16 view);
 	int (*control_ept_view)(struct kvm_vcpu *vcpu, u16 view, u8 visible);
+	int (*set_ve_info)(struct kvm_vcpu *vcpu, unsigned long ve_info,
+				bool trigger_vmexit);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 8082158e3e96..222fe9c7f463 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -157,6 +157,7 @@ static inline int vmx_misc_mseg_revid(u64 vmx_misc)
 enum vmcs_field {
 	VIRTUAL_PROCESSOR_ID            = 0x00000000,
 	POSTED_INTR_NV                  = 0x00000002,
+	EPTP_INDEX			= 0x00000004,
 	GUEST_ES_SELECTOR               = 0x00000800,
 	GUEST_CS_SELECTOR               = 0x00000802,
 	GUEST_SS_SELECTOR               = 0x00000804,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b65bd0d144e5..871cc49063d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4425,6 +4425,45 @@ static int vmx_control_ept_view(struct kvm_vcpu *vcpu, u16 view, u8 visible)
 	return 0;
 }
 
+static int vmx_set_ve_info(struct kvm_vcpu *vcpu, unsigned long ve_info,
+				bool trigger_vmexit)
+{
+	struct page *ve_info_pg;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int idx;
+	u32 eb;
+
+	if (!kvm_ve_supported)
+		return -KVM_EOPNOTSUPP;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	ve_info_pg = kvm_vcpu_gpa_to_page(vcpu, ve_info);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	if (is_error_page(ve_info_pg))
+		return -KVM_EINVAL;
+
+	vmcs_write64(VE_INFO_ADDRESS, page_to_phys(ve_info_pg));
+
+	/* Make sure EPTP_INDEX is up-to-date before enabling #VE */
+	vmcs_write16(EPTP_INDEX, vmx->view);
+
+	/* Enable #VE mechanism */
+	secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_EPT_VE);
+
+	/* Decide if #VE exception should trigger a VM exit */
+	eb = vmcs_read32(EXCEPTION_BITMAP);
+
+	if (trigger_vmexit)
+		eb |= (1u << VE_VECTOR);
+	else
+		eb &= ~(1u << VE_VECTOR);
+
+	vmcs_write32(EXCEPTION_BITMAP, eb);
+
+	return 0;
+}
+
 #define VMX_XSS_EXIT_BITMAP 0
 
 /*
@@ -8350,6 +8389,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.get_ept_view = vmx_get_ept_view,
 	.set_ept_view = vmx_set_ept_view,
 	.control_ept_view = vmx_control_ept_view,
+	.set_ve_info = vmx_set_ve_info,
 };
 
 static __init int hardware_setup(void)
