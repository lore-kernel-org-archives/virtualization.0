From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 27/34] KVM: x86: add .disable_ve()
Date: Wed, 22 Jul 2020 19:01:14 +0300
Message-ID: <20200722160121.9601-28-alazar@bitdefender.com>
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

This function is needed for the KVMI_VCPU_DISABLE_VE command.

Signed-off-by: Ștefan Șicleru <ssicleru@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/vmx.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4cee641af48e..54969c2e804e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1316,6 +1316,7 @@ struct kvm_x86_ops {
 	int (*control_ept_view)(struct kvm_vcpu *vcpu, u16 view, u8 visible);
 	int (*set_ve_info)(struct kvm_vcpu *vcpu, unsigned long ve_info,
 				bool trigger_vmexit);
+	int (*disable_ve)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 871cc49063d8..96aa4b7e2857 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4464,6 +4464,15 @@ static int vmx_set_ve_info(struct kvm_vcpu *vcpu, unsigned long ve_info,
 	return 0;
 }
 
+static int vmx_disable_ve(struct kvm_vcpu *vcpu)
+{
+	if (kvm_ve_supported)
+		secondary_exec_controls_clearbit(to_vmx(vcpu),
+						 SECONDARY_EXEC_EPT_VE);
+
+	return 0;
+}
+
 #define VMX_XSS_EXIT_BITMAP 0
 
 /*
@@ -8390,6 +8399,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_ept_view = vmx_set_ept_view,
 	.control_ept_view = vmx_control_ept_view,
 	.set_ve_info = vmx_set_ve_info,
+	.disable_ve = vmx_disable_ve,
 };
 
 static __init int hardware_setup(void)
