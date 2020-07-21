From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 18/84] KVM: svm: pass struct kvm_vcpu to set_msr_interception()
Date: Wed, 22 Jul 2020 00:08:16 +0300
Message-ID: <20200721210922.7646-19-alazar@bitdefender.com>
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
 arch/x86/kvm/svm/svm.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e16be80edd7e..dfa1a6e74bf7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -583,7 +583,8 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, unsigned msr)
 	return !!test_bit(bit_write,  &tmp);
 }
 
-static void set_msr_interception(u32 *msrpm, unsigned msr,
+static void set_msr_interception(struct kvm_vcpu *vcpu,
+				 u32 *msrpm, unsigned msr,
 				 int type, bool value)
 {
 	u8 bit_read, bit_write;
@@ -621,7 +622,7 @@ static void svm_vcpu_init_msrpm(u32 *msrpm)
 		if (!direct_access_msrs[i].always)
 			continue;
 
-		set_msr_interception(msrpm, direct_access_msrs[i].index,
+		set_msr_interception(NULL, msrpm, direct_access_msrs[i].index,
 				     MSR_TYPE_RW, 1);
 	}
 }
@@ -674,13 +675,13 @@ static void svm_enable_lbrv(struct vcpu_svm *svm)
 	u32 *msrpm = svm->msrpm;
 
 	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
-	set_msr_interception(msrpm, MSR_IA32_LASTBRANCHFROMIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTBRANCHFROMIP,
 			     MSR_TYPE_RW, 1);
-	set_msr_interception(msrpm, MSR_IA32_LASTBRANCHTOIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTBRANCHTOIP,
 			     MSR_TYPE_RW, 1);
-	set_msr_interception(msrpm, MSR_IA32_LASTINTFROMIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTINTFROMIP,
 			     MSR_TYPE_RW, 1);
-	set_msr_interception(msrpm, MSR_IA32_LASTINTTOIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTINTTOIP,
 			     MSR_TYPE_RW, 1);
 }
 
@@ -689,13 +690,13 @@ static void svm_disable_lbrv(struct vcpu_svm *svm)
 	u32 *msrpm = svm->msrpm;
 
 	svm->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
-	set_msr_interception(msrpm, MSR_IA32_LASTBRANCHFROMIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTBRANCHFROMIP,
 			     MSR_TYPE_RW, 0);
-	set_msr_interception(msrpm, MSR_IA32_LASTBRANCHTOIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTBRANCHTOIP,
 			     MSR_TYPE_RW, 0);
-	set_msr_interception(msrpm, MSR_IA32_LASTINTFROMIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTINTFROMIP,
 			     MSR_TYPE_RW, 0);
-	set_msr_interception(msrpm, MSR_IA32_LASTINTTOIP,
+	set_msr_interception(&svm->vcpu, msrpm, MSR_IA32_LASTINTTOIP,
 			     MSR_TYPE_RW, 0);
 }
 
@@ -2629,7 +2630,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 * We update the L1 MSR bit as well since it will end up
 		 * touching the MSR anyway now.
 		 */
-		set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL,
+		set_msr_interception(&svm->vcpu, svm->msrpm, MSR_IA32_SPEC_CTRL,
 				     MSR_TYPE_RW, 1);
 		break;
 	case MSR_IA32_PRED_CMD:
@@ -2645,9 +2646,9 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			break;
 
 		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
-		set_msr_interception(svm->msrpm, MSR_IA32_PRED_CMD,
+		set_msr_interception(&svm->vcpu, svm->msrpm, MSR_IA32_PRED_CMD,
 				     MSR_TYPE_R, 0);
-		set_msr_interception(svm->msrpm, MSR_IA32_PRED_CMD,
+		set_msr_interception(&svm->vcpu, svm->msrpm, MSR_IA32_PRED_CMD,
 				     MSR_TYPE_W, 1);
 		break;
 	case MSR_AMD64_VIRT_SPEC_CTRL:
