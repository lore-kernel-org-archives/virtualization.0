From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 19/84] KVM: vmx: pass struct kvm_vcpu to the intercept msr related functions
Date: Wed, 22 Jul 2020 00:08:17 +0300
Message-ID: <20200721210922.7646-20-alazar@bitdefender.com>
References: <20200721210922.7646-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200721210922.7646-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <ncitu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicușor Cîțu <ncitu@bitdefender.com>

This is preparatory patch to mediate the MSR interception between
the introspection tool and the device manager (one must not disable
the interception if the other one has enabled the interception).

Passing NULL during initialization is OK because a vCPU can be
introspected only after initialization.

Signed-off-by: Nicușor Cîțu <ncitu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/vmx/vmx.c | 74 ++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cf07db129670..ecf7fb21b812 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -342,7 +342,8 @@ module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, NULL, 0644);
 
 static bool guest_state_valid(struct kvm_vcpu *vcpu);
 static u32 vmx_segment_access_rights(struct kvm_segment *var);
-static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu,
+							  unsigned long *msr_bitmap,
 							  u32 msr, int type);
 
 void vmx_vmexit(void);
@@ -2086,7 +2087,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 * in the merging. We update the vmcs01 here for L1 as well
 		 * since it will end up touching the MSR anyway now.
 		 */
-		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap,
+		vmx_disable_intercept_for_msr(vcpu, vmx->vmcs01.msr_bitmap,
 					      MSR_IA32_SPEC_CTRL,
 					      MSR_TYPE_RW);
 		break;
@@ -2122,8 +2123,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 * vmcs02.msr_bitmap here since it gets completely overwritten
 		 * in the merging.
 		 */
-		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
-					      MSR_TYPE_W);
+		vmx_disable_intercept_for_msr(vcpu, vmx->vmcs01.msr_bitmap,
+					      MSR_IA32_PRED_CMD, MSR_TYPE_W);
 		break;
 	case MSR_IA32_CR_PAT:
 		if (!kvm_pat_valid(data))
@@ -3733,7 +3734,8 @@ void free_vpid(int vpid)
 	spin_unlock(&vmx_vpid_lock);
 }
 
-static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu,
+							  unsigned long *msr_bitmap,
 							  u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -3771,7 +3773,8 @@ static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bit
 	}
 }
 
-static __always_inline void vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
+							 unsigned long *msr_bitmap,
 							 u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -3809,13 +3812,14 @@ static __always_inline void vmx_enable_intercept_for_msr(unsigned long *msr_bitm
 	}
 }
 
-static __always_inline void vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu,
+						      unsigned long *msr_bitmap,
 			     			      u32 msr, int type, bool value)
 {
 	if (value)
-		vmx_enable_intercept_for_msr(msr_bitmap, msr, type);
+		vmx_enable_intercept_for_msr(vcpu, msr_bitmap, msr, type);
 	else
-		vmx_disable_intercept_for_msr(msr_bitmap, msr, type);
+		vmx_disable_intercept_for_msr(vcpu, msr_bitmap, msr, type);
 }
 
 static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
@@ -3833,7 +3837,8 @@ static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
 	return mode;
 }
 
-static void vmx_update_msr_bitmap_x2apic(unsigned long *msr_bitmap,
+static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu,
+					 unsigned long *msr_bitmap,
 					 u8 mode)
 {
 	int msr;
@@ -3849,11 +3854,11 @@ static void vmx_update_msr_bitmap_x2apic(unsigned long *msr_bitmap,
 		 * TPR reads and writes can be virtualized even if virtual interrupt
 		 * delivery is not in use.
 		 */
-		vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(vcpu, msr_bitmap, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_RW);
 		if (mode & MSR_BITMAP_MODE_X2APIC_APICV) {
-			vmx_enable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
-			vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_EOI), MSR_TYPE_W);
-			vmx_disable_intercept_for_msr(msr_bitmap, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W);
+			vmx_enable_intercept_for_msr(vcpu, msr_bitmap, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
+			vmx_disable_intercept_for_msr(vcpu, msr_bitmap, X2APIC_MSR(APIC_EOI), MSR_TYPE_W);
+			vmx_disable_intercept_for_msr(vcpu, msr_bitmap, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W);
 		}
 	}
 }
@@ -3869,7 +3874,7 @@ void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 		return;
 
 	if (changed & (MSR_BITMAP_MODE_X2APIC | MSR_BITMAP_MODE_X2APIC_APICV))
-		vmx_update_msr_bitmap_x2apic(msr_bitmap, mode);
+		vmx_update_msr_bitmap_x2apic(vcpu, msr_bitmap, mode);
 
 	vmx->msr_bitmap_mode = mode;
 }
@@ -3878,20 +3883,21 @@ void pt_update_intercept_for_msr(struct vcpu_vmx *vmx)
 {
 	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
 	bool flag = !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
+	struct kvm_vcpu *vcpu = &vmx->vcpu;
 	u32 i;
 
-	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_STATUS,
+	vmx_set_intercept_for_msr(vcpu, msr_bitmap, MSR_IA32_RTIT_STATUS,
 							MSR_TYPE_RW, flag);
-	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_BASE,
+	vmx_set_intercept_for_msr(vcpu, msr_bitmap, MSR_IA32_RTIT_OUTPUT_BASE,
 							MSR_TYPE_RW, flag);
-	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_MASK,
+	vmx_set_intercept_for_msr(vcpu, msr_bitmap, MSR_IA32_RTIT_OUTPUT_MASK,
 							MSR_TYPE_RW, flag);
-	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_CR3_MATCH,
+	vmx_set_intercept_for_msr(vcpu, msr_bitmap, MSR_IA32_RTIT_CR3_MATCH,
 							MSR_TYPE_RW, flag);
 	for (i = 0; i < vmx->pt_desc.addr_range; i++) {
-		vmx_set_intercept_for_msr(msr_bitmap,
+		vmx_set_intercept_for_msr(vcpu, msr_bitmap,
 			MSR_IA32_RTIT_ADDR0_A + i * 2, MSR_TYPE_RW, flag);
-		vmx_set_intercept_for_msr(msr_bitmap,
+		vmx_set_intercept_for_msr(vcpu, msr_bitmap,
 			MSR_IA32_RTIT_ADDR0_B + i * 2, MSR_TYPE_RW, flag);
 	}
 }
@@ -6947,18 +6953,22 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
 		goto free_pml;
 
 	msr_bitmap = vmx->vmcs01.msr_bitmap;
-	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_TSC, MSR_TYPE_R);
-	vmx_disable_intercept_for_msr(msr_bitmap, MSR_FS_BASE, MSR_TYPE_RW);
-	vmx_disable_intercept_for_msr(msr_bitmap, MSR_GS_BASE, MSR_TYPE_RW);
-	vmx_disable_intercept_for_msr(msr_bitmap, MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
-	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
-	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
-	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_IA32_TSC, MSR_TYPE_R);
+	vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_FS_BASE, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_GS_BASE, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
 	if (kvm_cstate_in_guest(vcpu->kvm)) {
-		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C1_RES, MSR_TYPE_R);
-		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C3_RESIDENCY, MSR_TYPE_R);
-		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C6_RESIDENCY, MSR_TYPE_R);
-		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C7_RESIDENCY, MSR_TYPE_R);
+		vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_CORE_C1_RES,
+					      MSR_TYPE_R);
+		vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_CORE_C3_RESIDENCY,
+					      MSR_TYPE_R);
+		vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_CORE_C6_RESIDENCY,
+					      MSR_TYPE_R);
+		vmx_disable_intercept_for_msr(NULL, msr_bitmap, MSR_CORE_C7_RESIDENCY,
+					      MSR_TYPE_R);
 	}
 	vmx->msr_bitmap_mode = 0;
 
