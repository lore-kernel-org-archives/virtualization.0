From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 01/34] KVM: x86: export .get_vmfunc_status()
Date: Wed, 22 Jul 2020 19:00:48 +0300
Message-ID: <20200722160121.9601-2-alazar@bitdefender.com>
References: <20200722160121.9601-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200722160121.9601-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Marian Rotariu <marian.c.rotariu@gmail.com>

The introspection tool uses this function to check the hardware support
for VMFUNC, which can be used either to singlestep vCPUs
on a unprotected EPT view or to use #VE in order to filter out
VM-exits caused by EPT violations.

Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
Co-developed-by: Ștefan Șicleru <ssicleru@bitdefender.com>
Signed-off-by: Ștefan Șicleru <ssicleru@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/vmx.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d96bf0e15ea2..ab6989745f9c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1300,6 +1300,7 @@ struct kvm_x86_ops {
 	bool (*spt_fault)(struct kvm_vcpu *vcpu);
 	bool (*gpt_translation_fault)(struct kvm_vcpu *vcpu);
 	void (*control_singlestep)(struct kvm_vcpu *vcpu, bool enable);
+	bool (*get_vmfunc_status)(void);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8c9ccd1ba0f0..ec4396d5f36f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7992,6 +7992,11 @@ static void vmx_control_singlestep(struct kvm_vcpu *vcpu, bool enable)
 				CPU_BASED_MONITOR_TRAP_FLAG);
 }
 
+static bool vmx_get_vmfunc_status(void)
+{
+	return cpu_has_vmx_vmfunc();
+}
+
 static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.hardware_unsetup = hardware_unsetup,
 
@@ -8133,6 +8138,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.spt_fault = vmx_spt_fault,
 	.gpt_translation_fault = vmx_gpt_translation_fault,
 	.control_singlestep = vmx_control_singlestep,
+	.get_vmfunc_status = vmx_get_vmfunc_status,
 };
 
 static __init int hardware_setup(void)
