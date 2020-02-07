From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 15/78] KVM: x86: export .msr_write_intercepted()
Date: Fri,  7 Feb 2020 20:15:33 +0200
Message-ID: <20200207181636.1065-16-alazar@bitdefender.com>
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

This function will be used to test if a MSR access is already tracked.

Signed-off-by: Nicușor Cîțu <ncitu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/svm.c              | 1 +
 arch/x86/kvm/vmx/vmx.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4d43f5479c0c..8cdb6cece618 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1056,6 +1056,7 @@ struct kvm_x86_ops {
 	void (*update_bp_intercept)(struct kvm_vcpu *vcpu);
 	int (*get_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
+	bool (*msr_write_intercepted)(struct kvm_vcpu *vcpu, u32 msr);
 	u64 (*get_segment_base)(struct kvm_vcpu *vcpu, int seg);
 	void (*get_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index bf1f2bca5357..e3369562d6fe 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7353,6 +7353,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.get_msr_feature = svm_get_msr_feature,
 	.get_msr = svm_get_msr,
 	.set_msr = svm_set_msr,
+	.msr_write_intercepted = msr_write_intercepted,
 	.get_segment_base = svm_get_segment_base,
 	.get_segment = svm_get_segment,
 	.set_segment = svm_set_segment,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8709a26736d9..36dfb95ea578 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7828,6 +7828,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.get_msr_feature = vmx_get_msr_feature,
 	.get_msr = vmx_get_msr,
 	.set_msr = vmx_set_msr,
+	.msr_write_intercepted = msr_write_intercepted,
 	.get_segment_base = vmx_get_segment_base,
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
